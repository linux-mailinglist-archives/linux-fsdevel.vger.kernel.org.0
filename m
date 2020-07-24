Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5906D22BACF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgGXAMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 20:12:51 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56654 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbgGXAMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:12:51 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E3DF072CCDC;
        Fri, 24 Jul 2020 03:12:48 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id B5F297CFF73; Fri, 24 Jul 2020 03:12:48 +0300 (MSK)
Date:   Fri, 24 Jul 2020 03:12:48 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     =?utf-8?B?w4Frb3M=?= Uzonyi <uzonyi.akos@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/nsfs.c: fix ioctl support of compat processes
Message-ID: <20200724001248.GC25522@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to Documentation/driver-api/ioctl.rst, in order to support
32-bit user space running on a 64-bit kernel, each subsystem or driver
that implements an ioctl callback handler must also implement the
corresponding compat_ioctl handler.  The compat_ptr_ioctl() helper can
be used in place of a custom compat_ioctl file operation for drivers
that only take arguments that are pointers to compatible data
structures.

In case of NS_* ioctls only NS_GET_OWNER_UID accepts an argument, and
this argument is a pointer to uid_t type, which is universally defined
to __kernel_uid32_t.

This change fixes compat strace --pidns-translation.

Note: when backporting this patch to stable kernels, commit
"compat_ioctl: add compat_ptr_ioctl()" is needed as well.

Reported-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
Cc: stable@vger.kernel.org # v4.9+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..a00236bffa2c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 static const struct file_operations ns_file_operations = {
 	.llseek		= no_llseek,
 	.unlocked_ioctl = ns_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)

-- 
ldv
