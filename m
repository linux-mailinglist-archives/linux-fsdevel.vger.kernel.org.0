Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C338D97090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 05:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfHUDz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 23:55:58 -0400
Received: from 2.152.176.113.dyn.user.ono.com ([2.152.176.113]:36802 "EHLO
        pulsar.hadrons.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfHUDz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 23:55:57 -0400
X-Greylist: delayed 1074 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 23:55:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hadrons.org
        ; s=201908; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Y/aHT4MYLaye6HK+sQi6zX4qI4fkCoiILg3MznRvPso=; b=msEuF30t8SwyqIY71h/bo34ebC
        oZgNFChUPgMS3OvuOXcpTZj434SxKIDn31LeeZZ16jQM/wECsWgZPrbYIY3Ruwal8Q0MBvFlxl8sr
        INOGtofV2CcTLl3bMFJsUPIFo7Rs160RCYu6za+5LvaDKJt3sLL2mHBw+SvqwIgdkrRA/pw4KYVpK
        6c8to36xOCQQjKBrfL+lSAcBFALvcZCoOB87gqeqw/395wwrgI847+IXHmGyBJgoVVMtAJQo2I3AH
        zrCNcfdbUiN4UGGqxMCBfscx6DGpxb1YA740zKnHBNB2pt7PkiHo6GjCIbKVeynPvJ14gQR9DYDIy
        M0PbxzrQ==;
Received: from guillem by pulsar.hadrons.org with local (Exim 4.92)
        (envelope-from <guillem@hadrons.org>)
        id 1i0HSK-0003gy-H2; Wed, 21 Aug 2019 05:38:40 +0200
From:   Guillem Jover <guillem@hadrons.org>
To:     linux-aio@kvack.org
Cc:     Christoph Hellwig <hch@lst.de>, Jeff Moyer <jmoyer@redhat.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aio: Fix io_pgetevents() struct __compat_aio_sigset layout
Date:   Wed, 21 Aug 2019 05:38:20 +0200
Message-Id: <20190821033820.14155-1-guillem@hadrons.org>
X-Mailer: git-send-email 2.20.1
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
userland pointer and the size members into the kernel pointer, and
then reads garbage into the kernel sigsetsize. Which makes the sigset_t
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

Fixes: 7a074e96 ("aio: implement io_pgetevents")
Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 fs/aio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 01e0fb9ae45a..056f291bc66f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2179,7 +2179,7 @@ SYSCALL_DEFINE5(io_getevents_time32, __u32, ctx_id,
 #ifdef CONFIG_COMPAT
 
 struct __compat_aio_sigset {
-	compat_sigset_t __user	*sigmask;
+	compat_uptr_t		sigmask;
 	compat_size_t		sigsetsize;
 };
 
@@ -2204,7 +2204,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
+	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
 	if (ret)
 		return ret;
 
@@ -2239,7 +2239,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
 	if (usig && copy_from_user(&ksig, usig, sizeof(ksig)))
 		return -EFAULT;
 
-	ret = set_compat_user_sigmask(ksig.sigmask, ksig.sigsetsize);
+	ret = set_compat_user_sigmask(compat_ptr(ksig.sigmask), ksig.sigsetsize);
 	if (ret)
 		return ret;
 
-- 
2.23.0

