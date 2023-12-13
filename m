Return-Path: <linux-fsdevel+bounces-5870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D0811374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B071C2108F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598528E22;
	Wed, 13 Dec 2023 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GADnPW3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC7318C
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702475429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3fXIPXuGexzb3JH5UnibU+knvRn4aWjn9nvZHgRZUg=;
	b=GADnPW3Cy0ClzmJar+0LThjUWiT15VbNFZGyPoHnzEYyD4rBlS7D1MupX4NZBhUDHsG0nP
	C0x4UH1Xe3fudBdp9n6EMFEGTMzvQZYaM5HLbzkfUv1AM+DM16+dGBfKXsix2X2u7F5XxQ
	QU1VNDllgHXtGJiW9LZ9844pDvgaZR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-csY2hgwvOb-vxy8PjmHO1w-1; Wed, 13 Dec 2023 08:50:26 -0500
X-MC-Unique: csY2hgwvOb-vxy8PjmHO1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFC178828C6;
	Wed, 13 Dec 2023 13:50:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2160E1C060B1;
	Wed, 13 Dec 2023 13:50:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/40] afs: Handle the VIO and UAEIO aborts explicitly
Date: Wed, 13 Dec 2023 13:49:34 +0000
Message-ID: <20231213135003.367397-13-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

When processing the result of a call, handle the VIO and UAEIO abort
specifically rather than leaving it to a default case.  Rather than
erroring out unconditionally, see if there's another server if the volume
has more than one server available, otherwise return -EREMOTEIO.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

Notes:
    Changes
    =======
    ver #2)
     - Treat UAEIO as VIO too.

 fs/afs/rotate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/afs/rotate.c b/fs/afs/rotate.c
index 13ec8ffa911a..0829933f4d9a 100644
--- a/fs/afs/rotate.c
+++ b/fs/afs/rotate.c
@@ -330,6 +330,13 @@ bool afs_select_fileserver(struct afs_operation *op)
 
 			goto restart_from_beginning;
 
+		case UAEIO:
+		case VIO:
+			op->error = -EREMOTEIO;
+			if (op->volume->type != AFSVL_RWVOL)
+				goto next_server;
+			goto failed;
+
 		case VDISKFULL:
 		case UAENOSPC:
 			/* The partition is full.  Only applies to RWVOLs.


