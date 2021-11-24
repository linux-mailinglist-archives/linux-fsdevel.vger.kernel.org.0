Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2EB45B731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 10:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhKXJSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 04:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235484AbhKXJSQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:18:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B46FA60462;
        Wed, 24 Nov 2021 09:15:03 +0000 (UTC)
Date:   Wed, 24 Nov 2021 10:15:00 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks: fix fcntl_getlk64/fcntl_setlk64 stub prototypes
Message-ID: <20211124091500.yi4vfi2a5e7frbqx@wittgenstein>
References: <20211123160531.93545-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123160531.93545-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 05:05:07PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My patch to rework oabi fcntl64() introduced a harmless
> sparse warning when file locking is disabled:
> 
>    arch/arm/kernel/sys_oabi-compat.c:251:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
>    arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     expected struct flock64 [noderef] __user *user
>    arch/arm/kernel/sys_oabi-compat.c:251:51: sparse:     got struct flock64 *
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse: sparse: incorrect type in argument 4 (different address spaces) @@     expected struct flock64 [noderef] __user *user @@     got struct flock64 * @@
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     expected struct flock64 [noderef] __user *user
>    arch/arm/kernel/sys_oabi-compat.c:265:55: sparse:     got struct flock64 *
> 
> When file locking is enabled, everything works correctly and the
> right data gets passed, but the stub declarations in linux/fs.h
> did not get modified when the calling conventions changed in an
> earlier patch.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 7e2d8c29ecdd ("ARM: 9111/1: oabi-compat: rework fcntl64() emulation")
> Fixes: a75d30c77207 ("fs/locks: pass kernel struct flock to fcntl_getlk/setlk")
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good. Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
