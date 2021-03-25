Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AC4348BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 09:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCYIjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 04:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCYIjc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E09619FC;
        Thu, 25 Mar 2021 08:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616661572;
        bh=Nn2Jcv819TwFo7idy1EDIUI0hC6JZl8FR/VnF46+dAs=;
        h=From:To:Cc:Subject:Date:From;
        b=fzjB58/mMkdetAG2DUodmx4z/aTXZVCCOgbCoBg6lr22xv5inJelHrVOkfaPIoqEo
         01ki6HAF5IujAtG7PBgmeaXXFXjieEgqgUejpn0ap1Nc5585jhhRfeqrq6yTRLbMxB
         DyFfXeAz1T7gU5y6vEf1EHG1PTVVWEqwVowEiHdEXv8PYHxe8ebojBPojcs/c4Zc68
         MwqDSKJbMZOXyGV3gXFXc2YgGd9177VDwmyi7COXtXUBj7sollk2EjYNklzMko5jv3
         E0yYcEBixhgB3c6+JjgdrWEpn4g6ClvcH+3ZUiezGfEfmE+HrTul5pcOwelchn4o8Q
         uRhbjEcaD3L2A==
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] fanotify_user: use upper_32_bits() to verify mask
Date:   Thu, 25 Mar 2021 09:37:43 +0100
Message-Id: <20210325083742.2334933-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=rV9DYAGqrBf84r/PvZ7PvFiRieUiTS332qKv+sF3M/Q=; m=u8tAo1c2Johpj/6wlhfYIK/O9fj5xWHs290nbl91tJA=; p=0i8coRLdVQPAx3eF5AqlJR9QPc2ttbnOFB0cU2euChg=; g=0279421931c80ebb10d6b34605ab0d3d166d0bfc
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYFxLYQAKCRCRxhvAZXjcog/lAPwMZQ8 eCaX8/fs1p5JKDfagK35WK9xrGpXk5SV+nvxp/AEApnZF/kCXAL1T+opmSPt71VlVXVatn7dRT2YY gZDfNAs=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

I don't see an obvious reason why the upper 32 bit check needs to be
open-coded this way. Switch to upper_32_bits() which is more idiomatic and
should conceptually be the same check.

Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9e0c1afac8bd..d5683fa9d495 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1126,7 +1126,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		 __func__, fanotify_fd, flags, dfd, pathname, mask);
 
 	/* we only use the lower 32 bits as of right now. */
-	if (mask & ((__u64)0xffffffff << 32))
+	if (upper_32_bits(mask))
 		return -EINVAL;
 
 	if (flags & ~FANOTIFY_MARK_FLAGS)

base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
-- 
2.27.0

