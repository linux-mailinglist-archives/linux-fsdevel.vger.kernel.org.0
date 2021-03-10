Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60433444C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhCJQ6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 11:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233606AbhCJQ61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615395507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+I2KUsaliMtYnZ9KwnlNFY8IkAMksOA42zhMc7qaDY=;
        b=Flkp7jOMziJKVXdVtYryQmyeZR6hzw9Iu0dOf/Ek2rxQIzCdcQak9EQsHyaHy+SrB2kx3O
        bO7izhZxdFfqOffbSelthtFHsBWzyA9L/OD1rhAkS9nv3jWy7Tsj2BPdzMnNgU90OtA+M/
        dyNYydZXtLuE29S6CKLqYHsR+O+ZgGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-F2ZpZ4aaOu6N43_bnjHlsA-1; Wed, 10 Mar 2021 11:58:24 -0500
X-MC-Unique: F2ZpZ4aaOu6N43_bnjHlsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F28271005D4E;
        Wed, 10 Mar 2021 16:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-152.rdu2.redhat.com [10.10.118.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27BEB5D6D7;
        Wed, 10 Mar 2021 16:58:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 17/28] afs: Print the operation debug_id when logging an
 unexpected data version
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Mar 2021 16:58:16 +0000
Message-ID: <161539549628.286939.15234870409714613954.stgit@warthog.procyon.org.uk>
In-Reply-To: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Print the afs_operation debug_id when logging an unexpected change in the
data version.  This allows the logged message to be matched against
tracelines.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/160588528377.3465195.2206051235095182302.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118146111.1232039.11398082422487058312.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161042180.2537118.2471333561661033316.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340405772.1303470.3877167548944248214.stgit@warthog.procyon.org.uk/ # v3
---

 fs/afs/inode.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 48519ee00eef..af6556bb3d6a 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -215,11 +215,12 @@ static void afs_apply_status(struct afs_operation *op,
 
 	if (vp->dv_before + vp->dv_delta != status->data_version) {
 		if (test_bit(AFS_VNODE_CB_PROMISED, &vnode->flags))
-			pr_warn("kAFS: vnode modified {%llx:%llu} %llx->%llx %s\n",
+			pr_warn("kAFS: vnode modified {%llx:%llu} %llx->%llx %s (op=%x)\n",
 				vnode->fid.vid, vnode->fid.vnode,
 				(unsigned long long)vp->dv_before + vp->dv_delta,
 				(unsigned long long)status->data_version,
-				op->type ? op->type->name : "???");
+				op->type ? op->type->name : "???",
+				op->debug_id);
 
 		vnode->invalid_before = status->data_version;
 		if (vnode->status.type == AFS_FTYPE_DIR) {


