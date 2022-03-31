Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389774EDD22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiCaPfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbiCaPeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:34:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A02241E7;
        Thu, 31 Mar 2022 08:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A505B82176;
        Thu, 31 Mar 2022 15:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498C3C340ED;
        Thu, 31 Mar 2022 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648740711;
        bh=UXiDDVeGTVjm8ywNCoQxrtFttrz2S+n2g9AqTlEy6Vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8pT8tzWS++aiuvB8RssNXsETgO2+U1Q3FNaILwFuCR4E+vxhy0gAHIP8dJzmLY33
         6QlItvIZoMhelpQkN+7adcCf6uceVzdwDsGLTBOZMRHw5b0XnPLssRBoeGQmnhKxUm
         HzD30OqYBF69CpExHOb4MP/9XrYnhBGjoGVWXWzZ191mQAgz5iIa0raZRVB2CRxEDX
         fXm5y4gBA3/lelOmReXs+6ViBptQHkR/70+i5sSm36Nf2GXYSvFbei9En+VRs+blLB
         oQNUdTs9fA/t9geGOQyty0lEun6mDJsb8OGowpGP6gnO09/1JyzmdTWtR+s8y8zYKM
         V2mh4E5qHFGow==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, lhenriques@suse.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 21/54] ceph: set DCACHE_NOKEY_NAME in atomic open
Date:   Thu, 31 Mar 2022 11:30:57 -0400
Message-Id: <20220331153130.41287-22-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331153130.41287-1-jlayton@kernel.org>
References: <20220331153130.41287-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Atomic open can act as a lookup if handed a dentry that is negative on
the MDS. Ensure that we set DCACHE_NOKEY_NAME on the dentry in
atomic_open, if we don't have the key for the parent. Otherwise, we can
end up validating the dentry inappropriately if someone later adds a
key.

Reviewed-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Luís Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5832dcea2d8c..f9f7dc4c902d 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -760,6 +760,13 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
 	ihold(dir);
+	if (IS_ENCRYPTED(dir)) {
+		if (!fscrypt_has_encryption_key(dir)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_NOKEY_NAME;
+			spin_unlock(&dentry->d_lock);
+		}
+	}
 
 	if (flags & O_CREAT) {
 		struct ceph_file_layout lo;
-- 
2.35.1

