Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBD45A722
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbhKWQIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 11:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238658AbhKWQIo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:08:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA5CE60F21;
        Tue, 23 Nov 2021 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637683535;
        bh=kth/bsQMZ0ipVClvNJxa8fvnr1WPNxoP76x6HcKXq+k=;
        h=From:To:Cc:Subject:Date:From;
        b=kiX3eWM7kKzzBHTf/yp8SiapZ6zETnaIHFMnvJNKYsK+c7TU72PcQW6MPHqU0Gfie
         jNAFWIQ6VBPYRLSsHnXEGDKzPdvqXpozHL8U7q9cFqX+QNFrN17dvYZPXrfBvBN6aV
         rRBpXKU5HhvHNMvZocwXsvFKeREjC6nXRvsCWGHkBpxAEXnOqycEVM82uMrjaCyzn8
         as7LWvg6xfqjkV3dyWQNJfA0G9GaAQQUElYkTf5j4VDHv8iLEhB9lJ/w2nnFxBM5pO
         MqvJEspVFkGtUemOgMQUxA/5Lp5xiTsP/c7ogBavrv4YXtEh3PHBsv8v3pgfz8hBim
         qKfJdoPMZjS8g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/locks: fix fcntl_getlk64/fcntl_setlk64 stub prototypes
Date:   Tue, 23 Nov 2021 17:05:07 +0100
Message-Id: <20211123160531.93545-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

My patch to rework oabi fcntl64() introduced a harmless
sparse warning when file locking is disabled:

   arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
   arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     expected struct flock64 [noderef] __user *user
   arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     got struct flock64 *
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     expected struct flock64 [noderef] __user *user
   arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     got struct flock64 *

When file locking is enabled, everything works correctly and the
right data gets passed, but the stub declarations in linux/fs.h
did not get modified when the calling conventions changed in an
earlier patch.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 7e2d8c29ecdd ("ARM: 9111/1: oabi-compat: rework fcntl64() emulation")
Fixes: a75d30c77207 ("fs/locks: pass kernel struct flock to fcntl_getlk/setlk")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..698d92567841 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1220,13 +1220,13 @@ static inline int fcntl_setlk(unsigned int fd, struct file *file,
 
 #if BITS_PER_LONG == 32
 static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
-				struct flock64 __user *user)
+				struct flock64 *user)
 {
 	return -EINVAL;
 }
 
 static inline int fcntl_setlk64(unsigned int fd, struct file *file,
-				unsigned int cmd, struct flock64 __user *user)
+				unsigned int cmd, struct flock64 *user)
 {
 	return -EACCES;
 }
-- 
2.29.2

