Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62A52E311
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 05:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbiETDWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 23:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiETDWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 23:22:22 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256CB59334
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 20:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5XG2djODgxK7NCdJX6tBi8qRX4lnRUiUZcDTWyQq//s=; b=gR19eBwIKGnOb7Ad2yByHLZowr
        648Xpn3alQ9Rjf2hLfIwEONrjPpbEA+ziOPtVJmeFOTt+NV9qcnnY2OYyIbLprA7y4wr5pxC1VG0W
        DHk9Wf47hNc3/+BPj+D/r7m0f8dCrmfoqEpD2XSGa+P1SWfc3MeOPfkrJdRMNzHlWAnYoYrTpj8eR
        r/dLjdLwdgJFrx+cxjrP7xvpQeLInvT17ox1Sbhu4MJ9nL+kjzLq+OSivdFrfdnYdNyA2MII/WjAO
        pAydx52xpnGa5Mkob3tfze3XxQvZFzuU14IdyRvUOu3r1TGkRr0Jc/KYMzumRJfZvBpsbXjVuRdzF
        U7ws7RSg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrtDY-00GUB3-6F
        for linux-fsdevel@vger.kernel.org; Fri, 20 May 2022 03:22:20 +0000
Date:   Fri, 20 May 2022 03:22:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] m->mnt_root->d_inode->i_sb is a weird way to spell
 m->mnt_sb...
Message-ID: <YocJbOh4O/2efVjM@zeniv-ca.linux.org.uk>
References: <YocIMkS1qcPGrik0@zeniv-ca.linux.org.uk>
 <YocIiPQjR7tuYdkP@zeniv-ca.linux.org.uk>
 <YocI5jIou18bDDuy@zeniv-ca.linux.org.uk>
 <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocJDUARbpklMJgo@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395..6f5c61f4286e 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -326,7 +326,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 	char *read_name = NULL;
 	int len, status = 0;
 
-	server = NFS_SERVER(ss_mnt->mnt_root->d_inode);
+	server = NFS_SB(ss_mnt->mnt_sb);
 
 	if (!fattr)
 		return ERR_PTR(-ENOMEM);
@@ -344,7 +344,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out;
 	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
 
-	r_ino = nfs_fhget(ss_mnt->mnt_root->d_inode->i_sb, src_fh, fattr);
+	r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
 	if (IS_ERR(r_ino)) {
 		res = ERR_CAST(r_ino);
 		goto out_free_name;
-- 
2.30.2

