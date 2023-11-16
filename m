Return-Path: <linux-fsdevel+bounces-2968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19707EE4BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FB71C20A61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3607D3A8E8;
	Thu, 16 Nov 2023 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEYl1/fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649419E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 07:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700150007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXSR/5dGYSLLIzkrUqlSUZEGpATfuh7Jb7sNeswoiGc=;
	b=QEYl1/fwUTqW9eUdnPb38MKuyWkZ5wqyK65U9a6ERHOr6zyUIJsYFW6XIF8xdMGBUeW7OY
	nLd+AJx6ZnFPPh9eCvGrV9A9KRkJGyfsmfozau02ZnAzZG6BEfSrOlkiz7wtrBkj2L2z+l
	Pp45tHGsk9ZOC1WAcMAwmE7lxI7pni8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-tVT4BDpqNDOIyaQdbQ-Cdg-1; Thu,
 16 Nov 2023 10:53:24 -0500
X-MC-Unique: tVT4BDpqNDOIyaQdbQ-Cdg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19A543C0F36D;
	Thu, 16 Nov 2023 15:53:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4D1A0492BFE;
	Thu, 16 Nov 2023 15:53:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY
Date: Thu, 16 Nov 2023 15:53:12 +0000
Message-ID: <20231116155312.156593-6-dhowells@redhat.com>
In-Reply-To: <20231116155312.156593-1-dhowells@redhat.com>
References: <20231116155312.156593-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Mark a superblock that is for for an R/O or Backup volume as SB_RDONLY when
mounting it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index e95fb4cb4fcd..a01a0fb2cdbb 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -407,8 +407,10 @@ static int afs_validate_fc(struct fs_context *fc)
 			return PTR_ERR(volume);
 
 		ctx->volume = volume;
-		if (volume->type != AFSVL_RWVOL)
+		if (volume->type != AFSVL_RWVOL) {
 			ctx->flock_mode = afs_flock_mode_local;
+			fc->sb_flags |= SB_RDONLY;
+		}
 	}
 
 	return 0;


