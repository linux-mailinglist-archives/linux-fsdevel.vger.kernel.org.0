Return-Path: <linux-fsdevel+bounces-70191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16973C9354D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 01:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B0284E23B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46918DF80;
	Sat, 29 Nov 2025 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQBQc5rq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54348143C61
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 00:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764376824; cv=none; b=ixaMXK0qY2kAsnExDrjTrw4bDZtKbdngVWprhlVaV49PfqI0770Pki0fygc285/gBQj4V8JEYBeuSg4oMI/Oe58wWLM82ka89QzqEQcLs11m6Ett9WZSOb3qgjuX0JkyzLYLzFMsxcFcGGduqRYyKLCurDjZz5X61SI0IVa/soI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764376824; c=relaxed/simple;
	bh=CwXUO/ECiRkJTAnPgPPBjvGkDLsmgjF30ncj9dPTggQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=LjoGPvyW5fFM0+Ncgp4rnh8eJVg4pkycGup1EzonX1M4Sddg6qrV8+xZ2Wul8wOfk4IdTDLXf/1PbUWkMiGuzYcTcyamBITMiBiTon9WIZ/c27d1VjEibi0xGQc/bNDwXZCtyc7LAokLnUZRFNHHGWbJMY6saS52hFEwVccJHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQBQc5rq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764376821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ef9v6cwLTmDFTh7X6DP1tPfCuN0JRueNpWIdSc2115Y=;
	b=TQBQc5rqnzjK0smhh9TENbRdyKwAFhFOnSMIrL6ZYuWDVtRDIaxldQ4sZJqSRwna+33y8M
	b9MSxejvWp55m7JgDyRHdVCIj1pr1piYmY8eAGXeaXDcq7u7p/3ySiJoGlopEB8rstdfNQ
	SdzYxcUZ+CXZypBj/IepNhBqXb4g2Dw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-aN9lw2v9OryYBO8CY7QIDg-1; Fri,
 28 Nov 2025 19:40:18 -0500
X-MC-Unique: aN9lw2v9OryYBO8CY7QIDg-1
X-Mimecast-MFC-AGG-ID: aN9lw2v9OryYBO8CY7QIDg_1764376816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AC881956089;
	Sat, 29 Nov 2025 00:40:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2C7518004A3;
	Sat, 29 Nov 2025 00:40:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantra <pc@manguebit.org>,
    torvalds@linux-foundation.org,
    syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs: Fix uninit var in afs_alloc_anon_key()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1205720.1764376811.1@warthog.procyon.org.uk>
Date: Sat, 29 Nov 2025 00:40:11 +0000
Message-ID: <1205721.1764376811@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix an uninitialised variable (key) in afs_alloc_anon_key() by setting it
to cell->anonymous_key.  Without this change, the error check may return a
false failure with a bad error number.

Most of the time this is unlikely to happen because the first encounter
with afs_alloc_anon_key() will usually be from (auto)mount, for which all
subsequent operations must wait - apart from other (auto)mounts.  Once the
call->anonymous_key is allocated, all further calls to afs_request_key()
will skip the call to afs_alloc_anon_key() for that cell.

Fixes: d27c71257825 ("afs: Fix delayed allocation of a cell's anonymous key")
Reported-by: Paulo Alcantra <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: syzbot+41c68824eefb67cdf00c@syzkaller.appspotmail.com
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/security.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/security.c b/fs/afs/security.c
index ff8830e6982f..55ddce94af03 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -26,7 +26,8 @@ static int afs_alloc_anon_key(struct afs_cell *cell)
 	struct key *key;
 
 	mutex_lock(&afs_key_lock);
-	if (!cell->anonymous_key) {
+	key = cell->anonymous_key;
+	if (!key) {
 		key = rxrpc_get_null_key(cell->key_desc);
 		if (!IS_ERR(key))
 			cell->anonymous_key = key;


