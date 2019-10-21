Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFDDDF86E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 01:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfJUXLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 19:11:53 -0400
Received: from 2.152.178.181.dyn.user.ono.com ([2.152.178.181]:48106 "EHLO
        pulsar.hadrons.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbfJUXLw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:11:52 -0400
X-Greylist: delayed 1396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2019 19:11:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hadrons.org
        ; s=201908; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:From:Reply-To:Subject:Content-Type:
        Content-ID:Content-Description:X-Debbugs-Cc;
        bh=lJrBNxtsP/l0O89nUuZsM0aAJUk9os7E7K7eIqjUekg=; b=noX2JWaK1jgwRBsWoeesfU0sRK
        BdXbFoOQ4z2cZROc7KK8D7S3MI/HbelZYLDuuBpLfRgBwZcD4D/nW6sMVKtnDn5CE8Y+N3Zpwzmin
        ZypX7kSQEJ5ZUVn7CKW/AmYMwAJkVoZIDw+5uXR9pqhEt8EsqNQaQtYT+YAOeGuJKQkgH0J1gBuDD
        IuskntQLIbqRbACY+i1X+B557/sfuNhacy9rdWWxUyUTZj/sHIHf7RzmU3sSbgB4UXsCiHNnC4tbg
        j+HZaHB2wabZzZLOeLzPWt8Bh8ONDg+E5aOYmBjTX4nkE9SersfnY0kXG38dcwRMgTvbXMEvwnjE9
        aNcm38tA==;
Received: from guillem by pulsar.hadrons.org with local (Exim 4.92)
        (envelope-from <guillem@hadrons.org>)
        id 1iMgWH-0004gr-3E; Tue, 22 Oct 2019 00:51:21 +0200
From:   Guillem Jover <guillem@hadrons.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>, linux-aio@kvack.org,
        Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] aio: Fix io_pgetevents() struct __compat_aio_sigset layout
Date:   Tue, 22 Oct 2019 00:51:00 +0200
Message-Id: <20191021225100.17990-1-guillem@hadrons.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191021201550.GW26530@ZenIV.linux.org.uk>
References: <20191021201550.GW26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This type is used to pass the sigset_t from userland to the kernel,
but it was using the kernel native pointer type for the member
representing the compat userland pointer to the userland sigset_t.

This messes up the layout, and makes the kernel eat up both the
userland pointer and the size into the kernel pointer, and then
reads garbage into the kernel sigsetsize. Which makes the sigset_t
size consistency check fail, and consequently the syscall always
returns -EINVAL.

This breaks both libaio and strace on 32-bit userland running on 64-bit
kernels. And there are apparently no users in the wild of the current
broken layout (at least according to codesearch.debian.org and a brief
check over github.com search). So it looks safe to fix this directly
in the kernel, instead of either letting userland deal with this
permanently with the additional overhead or trying to make the syscall
infer what layout userland used, even though this is also being worked
around in libaio to temporarily cope with kernels that have not yet
been fixed.

We use a proper compat_uptr_t instead of a compat_sigset_t pointer.

Fixes: 7a074e96dee6 ("aio: implement io_pgetevents")
Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 fs/aio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 01e0fb9ae45a..0d9a559d488c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2179,7 +2179,7 @@ SYSCALL_DEFINE5(io_getevents_time32, __u32, ctx_id,
 #ifdef CONFIG_COMPAT
 
 struct __compat_aio_sigset {
-	compat_sigset_t __user	*sigmask;
+	compat_uptr_t		sigmask;
 	compat_size_t		sigsetsize;
 };
 
@@ -2193,7 +2193,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 		struct old_timespec32 __user *, timeout,
 		const struct __compat_aio_sigset __user *, usig)
 {
-	struct __compat_aio_sigset ksig = { NULL, };
+	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
 	bool interrupted;
 	int ret;
@@ -2204,7 +2204,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
+	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
 	if (ret)
 		return ret;
 
@@ -2228,7 +2228,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 		struct __kernel_timespec __user *, timeout,
 		const struct __compat_aio_sigset __user *, usig)
 {
-	struct __compat_aio_sigset ksig = { NULL, };
+	struct __compat_aio_sigset ksig = { 0, };
 	struct timespec64 t;
 	bool interrupted;
 	int ret;
@@ -2239,7 +2239,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
+	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
 	if (ret)
 		return ret;
 
-- 
2.24.0.rc0.303.g954a862665

