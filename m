Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0719A4E40A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbiCVOQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiCVOQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93E88B3A;
        Tue, 22 Mar 2022 07:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67895615F4;
        Tue, 22 Mar 2022 14:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADADC36AE3;
        Tue, 22 Mar 2022 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958439;
        bh=thdTSvnL9t+JNdyQt+BDJ6gQRdqq5+/Toh6CWdLwPrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4iqNxzxUA+Lxuc/Hl4RTlfJcY6o0f+36/FrNLqyaG22yGIgoQkbnKqBqZTMZml/k
         Py0vOYrPpF+7p4oQUkKvhBJgEcLuSi4jmsL3T9WxYF2nr3zkdr+FmluPPgp42DAjPq
         +udqC0ljqpKX6EFsEF2ZvPA5k7HIs/zyGBuGXTVo7ybjAFytw1z3Fn2B1k9VhTd+2m
         3wJCL69wZovOvQf9mB7mIUaiM+W2kHLVM043rqaO+BRmuzoaVXEep+0Eb3JXEWxzSg
         fo8HXAkCon/jUMVIemnZQvXrWjQD553gq5Zcr8O1KgabfTOZKszXlb3X3XiwZdVNYR
         23mzorelD5TYg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 43/51] ceph: disable copy offload on encrypted inodes
Date:   Tue, 22 Mar 2022 10:13:08 -0400
Message-Id: <20220322141316.41325-44-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have an encrypted inode, then the client will need to re-encrypt
the contents of the new object. Disable copy offload to or from
encrypted inodes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 00e6a5bc37c8..ba17288b1db3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2522,6 +2522,10 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		return -EOPNOTSUPP;
 	}
 
+	/* Every encrypted inode gets its own key, so we can't offload them */
+	if (IS_ENCRYPTED(src_inode) || IS_ENCRYPTED(dst_inode))
+		return -EOPNOTSUPP;
+
 	if (len < src_ci->i_layout.object_size)
 		return -EOPNOTSUPP; /* no remote copy will be done */
 
-- 
2.35.1

