Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036674F4D06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445711AbiDEXhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573574AbiDETW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0A483AF;
        Tue,  5 Apr 2022 12:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1A48CE1FB7;
        Tue,  5 Apr 2022 19:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851C8C385A1;
        Tue,  5 Apr 2022 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186456;
        bh=QSQJwXnQ26aopltanKUAuklulNeW880EC3N09Fc3UKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PULmi/MSmvm3KcMyeoe4q7YjAY098w+k3YDDbZvoCb07KoISMwzAzmUIRz696LhBs
         pYSQPt9mNUe61J+L5+HTXwFeXVJbeZ8l/tA8ymKxDPWtszKcck5fFTpWfZ3uO3vhSV
         rRifdEkJqKR/4Tt7DTGtZoYUFVQDL9yOU8/tXEIEzU0yKWZ2okSz/pdAis59+28Rlq
         RoyKD479znZzAwV1WWeSdclRsEH6LHjCLZ3feSK5jCP/sM2tXxBA7oG/jsuxOZSCO3
         uP2zzNYUGUnii1yr7Zwv+YXS9c8gVocK35GWnqe6fwKupAErvZuhdhcBm0zMfbdDnf
         iI/a6kQk4aBDw==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 26/59] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Tue,  5 Apr 2022 15:19:57 -0400
Message-Id: <20220405192030.178326-27-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a dentry which represents a no-key name, then we need to test
whether the parent directory's encryption key has since been added.  Do
that before we test anything else about the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 897f8618151b..caf2547c3fe1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1709,6 +1709,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dir, *inode;
 	struct ceph_mds_client *mdsc;
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	if (flags & LOOKUP_RCU) {
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
@@ -1721,8 +1725,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset);
+	dout("d_revalidate %p '%pd' inode %p offset 0x%llx nokey %d\n", dentry,
+	     dentry, inode, ceph_dentry(dentry)->offset, !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
-- 
2.35.1

