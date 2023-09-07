Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA801797ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbjIGRxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239373AbjIGRxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:53:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC581171C;
        Thu,  7 Sep 2023 10:52:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D749C4339A;
        Thu,  7 Sep 2023 16:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694104441;
        bh=1rA76M1gNfenw+XkkpPAQfgJBEGVBm9PuOG7uc/Jkm8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ch5oAfNfwuXOaXDTxKt6lI5yl8T5rJQFAVT0NRgVHrWXuy+QZU0CvU05eqlS1E4He
         s2ooWMNuNKWz1qOxnh935WS3Keaz1kNDahl/G8ezv0mXx7kvmrn1FLffFLxUuHetAw
         wXJAb5qu9K7uHtRdRxpp8pVoas0c3zr6rzoEya/ObjKGGuxAlvsn10n4ZXjNdPFwZw
         9fpAcRYcHFZI1TY3+iTLudZIiXk49F/Gwm+jFBF8BLjzNMX0SUCRY3We5Exs1x8AW7
         4G1RqnI/2bxSqXM1IJE75CL5gaB29mooRiQ/qpsv1Lr6h6DjZIpDs1hp/wX0WXqykk
         1JMOqekpDaZsg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Thu, 07 Sep 2023 12:33:48 -0400
Subject: [PATCH 2/2] fs: don't update the atime if existing atime is newer
 than "now"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230907-ctime-fixes-v1-2-3b74c970d934@kernel.org>
References: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
In-Reply-To: <20230907-ctime-fixes-v1-0-3b74c970d934@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1rA76M1gNfenw+XkkpPAQfgJBEGVBm9PuOG7uc/Jkm8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk+ft24KZSXjqnylLBtdm3crreHjPaKA2NTl+Vq
 1+dgCFXBRKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPn7dgAKCRAADmhBGVaC
 FZPuD/98kwCV1M6EJYg97zAUpyxuVXP0vI6qklYlW6dZ+wrkPLkeaE2VOlbz4dwJjIVfn3S85A/
 Gou8Lq8ahPqTJ+DcVi1DD9Iv9FCYKqqRGIAv8aXwA4sNlRjCJyPqe2U+m3ZnW7tYp+zIbLyWyIo
 eC3q0GwVb/abjQZxfouOavamZVfB4uFA4ZkrSYcUNf3yypt23ZUhqBPpoH1rPVSIh0boAJ+7x/A
 uDbu7bGbpLHdL29/9jRcTaFXk3k85ucNJhOLkUAjip+xvOWl3KQSI0XScOPhcFGbcDwhaNNhFwl
 x6oT/gqmu3JpLpXGd+GWZy6mGVhCjMaXjMf2pMfyYwPnvKfwuzC2Ot8bW24Lo2QvB8xK4yeTogm
 j1TkOajtQPZWU54of+7DAxyc0j968X1PnP70DDPzYAh6CgIKNVFviTJw3Zx/thblA9w8wCOq7cL
 PMpvoWzyAI2K1uB0Di6iZFDYJJIxDdiOqsi+fcLicpK4BIXo1m0W4kKcL/L/1wuyX2n+dvaYIf/
 eKF22UqKB5kJuHcwaNqvIUcPxnurhNxpXVpFH83nPgOMBPUhLkDPW/JEFcFV6M+LPz/qqNYC8Pq
 HYmgpuegUySatx1qqO7IyH4sCZaZWp35VOce4X9C/Nfkq0aumlnyVInlTiN4v+ueko9qD2Ni6B8
 DLz4wdBuZW80C+A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's possible for the atime to be updated with a fine-grained timestamp
and then later get an update that uses a coarse-grained timestamp which
makes the atime appear to go backward.

Fix this by only updating the atime if "now" is later than the current
value.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 54237f4242ff..cf4726b7f4b5 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1905,7 +1905,7 @@ int inode_update_timestamps(struct inode *inode, int flags)
 	}
 
 	if (flags & S_ATIME) {
-		if (!timespec64_equal(&now, &inode->i_atime)) {
+		if (timespec64_compare(&inode->i_atime, &now) < 0) {
 			inode->i_atime = now;
 			updated |= S_ATIME;
 		}
@@ -1991,7 +1991,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 	if (!relatime_need_update(mnt, inode, now))
 		return false;
 
-	if (timespec64_equal(&inode->i_atime, &now))
+	if (timespec64_compare(&inode->i_atime, &now) >= 0)
 		return false;
 
 	return true;

-- 
2.41.0

