Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4816224AB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 02:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHTACc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 20:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgHTAC3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80B67207FB;
        Thu, 20 Aug 2020 00:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881748;
        bh=TEnAfCRFKqzWR8b/LmW6mBYUZ01Boo0wZb54NQoT21g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaiPBI+54rorIEfUk/tFGfMDLX0FgB/pIxRl/9xEwxTRnTvAskUlurxXCWyrhwxVg
         4Ld6m6zZcuabFZYna1KM8aW8tfvaUC6ZHWGJLFqXF27J4J32JIZIF0VRYdHS0UPkEm
         GAt1z2N41q6W7Glyo9RiPZBquA8SHRkV9/LITJSY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 24/24] fs/signalfd.c: fix inconsistent return codes for signalfd4
Date:   Wed, 19 Aug 2020 20:01:55 -0400
Message-Id: <20200820000155.215089-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000155.215089-1-sashal@kernel.org>
References: <20200820000155.215089-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit a089e3fd5a82aea20f3d9ec4caa5f4c65cc2cfcc ]

The kernel signalfd4() syscall returns different error codes when called
either in compat or native mode.  This behaviour makes correct emulation
in qemu and testing programs like LTP more complicated.

Fix the code to always return -in both modes- EFAULT for unaccessible user
memory, and EINVAL when called with an invalid signal mask.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Link: http://lkml.kernel.org/r/20200530100707.GA10159@ls3530.fritz.box
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/signalfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c3..5b78719be4455 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -314,9 +314,10 @@ SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
 {
 	sigset_t mask;
 
-	if (sizemask != sizeof(sigset_t) ||
-	    copy_from_user(&mask, user_mask, sizeof(mask)))
+	if (sizemask != sizeof(sigset_t))
 		return -EINVAL;
+	if (copy_from_user(&mask, user_mask, sizeof(mask)))
+		return -EFAULT;
 	return do_signalfd4(ufd, &mask, flags);
 }
 
@@ -325,9 +326,10 @@ SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 {
 	sigset_t mask;
 
-	if (sizemask != sizeof(sigset_t) ||
-	    copy_from_user(&mask, user_mask, sizeof(mask)))
+	if (sizemask != sizeof(sigset_t))
 		return -EINVAL;
+	if (copy_from_user(&mask, user_mask, sizeof(mask)))
+		return -EFAULT;
 	return do_signalfd4(ufd, &mask, 0);
 }
 
-- 
2.25.1

