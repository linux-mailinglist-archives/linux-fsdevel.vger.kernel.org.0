Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E4C4F4D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582017AbiDEXlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573597AbiDETXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED174EA31;
        Tue,  5 Apr 2022 12:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B3BB616C5;
        Tue,  5 Apr 2022 19:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707FC385A5;
        Tue,  5 Apr 2022 19:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186478;
        bh=SRirXv6SjAaxHj9D42MDkbHJyqzjojeWbzUc3GlPdFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMJ9UC+uMVUgQ9XDVmV67ithHJZhOUeNimcvXXlRYJv7dSBOr8tDIzQVPFOHSmuQz
         D9EfAD4BsUZYE9K36AoPR5uE8d8Cr7sFXI1oKvBr2uBGxNij1ICRH/FXWpmvcPDzHZ
         ZFFJ1gIvj3iZGUZoTcosy9SJpxqgX2LYrbhaclW+I8DuThSkuIJYeFtS6atPBr+CFl
         uqrVKYolaomVNhdyb7phcSqnKK2i9QxK3DSSKE+3mkhrDoQ3RH+M9+cwrA61JizQ7b
         2ou149hHAvxKOJUL3cUNtUNog5ROmrLOZfpqjIGcavFIUxXjkKtGLa32zulA/28X/E
         f3vGHJ2sTEqAg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 50/59] ceph: disable fallocate for encrypted inodes
Date:   Tue,  5 Apr 2022 15:20:21 -0400
Message-Id: <20220405192030.178326-51-jlayton@kernel.org>
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

...hopefully, just for now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 175a59277726..f74563e11058 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2207,6 +2207,9 @@ static long ceph_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EOPNOTSUPP;
 
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
-- 
2.35.1

