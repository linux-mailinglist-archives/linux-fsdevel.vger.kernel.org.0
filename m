Return-Path: <linux-fsdevel+bounces-39144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D1DA109AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FF91888E91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3015534B;
	Tue, 14 Jan 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/uyMz5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB9153BF7
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865975; cv=none; b=UOT0JMlzSzEH+7T33hirgfaEfzPlcqkDbrqP9ZmCdjLy7pYKX48TuwyTg+c6Q3GR6bMHc5n5cIIjE9DwrPvAm+urJcjPTd1DZR2RVPRFfD9JiV2g6h6BNTOXfRUB0mU1ShE2AdTRoDjgMqEu2PD3SHESHf5kamuOOAMomGQOWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865975; c=relaxed/simple;
	bh=H6u6PObGRiaU21SRB9pZtn82Uvg9ghZLRugGvD8f4Ok=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=AYP/5qO7vpWwfa5M83oM04X/mS+vUIAWk/unPmkB5Y4SeOmXvRsVOCCqPQlufFzQwkZWq4riXirCVSx1kgAWPz7SaIK1Yco7lfDMCSCubni3Rn+DJTWbtG5xTwBzE868dQxFMHkw9woXqCuXQZJjxzffXnTJKCnEeD1SgArDuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/uyMz5c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736865972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8A6YuvBKTv5YENaFeR9jq3ZL4bi2GBPoerT1MT+3jBA=;
	b=S/uyMz5c2AMYMDt4R8bCEICx2cQZKmc53FEptAd8N6mXR1Drd5lXMDjuU4nRZwvqPAO452
	+k7AcbbZkfmxeJdD+5UUBAx29lLw6dG7VGq6MJtvAUUtyORd2QU0O4r7EDH7fR/HYULqoz
	LcQtmmCpB84onC+2ARzHSeaB4eeFds0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-UWB2M65vOa-KacqKbIL9Wg-1; Tue,
 14 Jan 2025 09:46:09 -0500
X-MC-Unique: UWB2M65vOa-KacqKbIL9Wg-1
X-Mimecast-MFC-AGG-ID: UWB2M65vOa-KacqKbIL9Wg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E3991953950;
	Tue, 14 Jan 2025 14:46:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77E6419560AD;
	Tue, 14 Jan 2025 14:46:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <109540.1736865963.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2025 14:46:03 +0000
Message-ID: <109541.1736865963@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Fix a pair of bugs in the fallback handling for the YFS.RemoveFile2 RPC
call:

 (1) Fix the abort code check to also look for RXGEN_OPCODE.  The lack of
     this masks the second bug.

 (2) call->server is now not used for ordinary filesystem RPC calls that
     have an operation descriptor.  Fix to use call->op->server instead.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" conc=
ept")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/yfsclient.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 024227aba4cd..362845f9aaae 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -666,8 +666,9 @@ static int yfs_deliver_fs_remove_file2(struct afs_call=
 *call)
 static void yfs_done_fs_remove_file2(struct afs_call *call)
 {
 	if (call->error =3D=3D -ECONNABORTED &&
-	    call->abort_code =3D=3D RX_INVALID_OPERATION) {
-		set_bit(AFS_SERVER_FL_NO_RM2, &call->server->flags);
+	    (call->abort_code =3D=3D RX_INVALID_OPERATION ||
+	     call->abort_code =3D=3D RXGEN_OPCODE)) {
+		set_bit(AFS_SERVER_FL_NO_RM2, &call->op->server->flags);
 		call->op->flags |=3D AFS_OPERATION_DOWNGRADE;
 	}
 }


