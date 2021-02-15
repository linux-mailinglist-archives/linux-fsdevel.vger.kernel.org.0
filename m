Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6DC31BDE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBOP4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 10:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231941AbhBOPtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613404065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TH+EmW0Z3G3B5IjmekyvNoLfQJD+b1qi0smOJeyhcrg=;
        b=DKxfGSIqzPyCzEKbdhJzAVDaVcHxX0quBA0SCa1dfY3TnfrYrKCAVeS6TzUAZJwo5S+PJb
        PLATdzxrhg0sdfFEQAVnAla0GoIf2CSCWpNsDMwN54nZbXOOx0ot4yiUdZlQlI3wHsI/fb
        X+Ea/6yPgVw9n3cMzHeWsJHSx3HDrf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-m35r-LzbOHqme42xeCq7nw-1; Mon, 15 Feb 2021 10:47:44 -0500
X-MC-Unique: m35r-LzbOHqme42xeCq7nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B4C80197D;
        Mon, 15 Feb 2021 15:47:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94A355B697;
        Mon, 15 Feb 2021 15:47:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/33] afs: Print the operation debug_id when logging an
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
Date:   Mon, 15 Feb 2021 15:47:37 +0000
Message-ID: <161340405772.1303470.3877167548944248214.stgit@warthog.procyon.org.uk>
In-Reply-To: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
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
---

 fs/afs/inode.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 48edd8d724d2..0bc7273100b8 100644
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


