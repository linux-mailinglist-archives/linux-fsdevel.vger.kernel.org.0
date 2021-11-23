Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6045A7ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 17:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhKWQha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 11:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239055AbhKWQhM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:37:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 383FF60F5B;
        Tue, 23 Nov 2021 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637685244;
        bh=meASmp6mQ1xHTUatHBSHXw5wlRdPPSfqSM2u9uQ8uzA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kgkOLbJ7pDZ5OB5ay2V8+9zrH1qPn6ivk5dgbVkXBQmDFQ9jiDUQunzLsCgg703bJ
         59+Re2dI8am+D+ZK8ak4U4nJIYytKuXwDwLemPOhRQjPcCPUM4pvaZPzxH1fesMO6N
         dmrF9OgyE3OzKpDUNx8YcPd1yRQn2gbxuc7p+tytv0ecHX2itCIMLyYkl5vbLcDRNH
         5PIeCZfLk7WHbP30ldugdywdBHmAdhqBOdjyfG6wiaf0mxdu+Xy/sjcfPW9EZJneKK
         lWnpUp0T0sl/8i0frWftVGQWAADVrFBOf9/JSOwaHSmPLSwFJ7Eqxar3iXbsnrL1OC
         OI4WdaqoBTuXA==
Message-ID: <d42a74e22f8b0056a812b88c09a0e484d5db3987.camel@kernel.org>
Subject: Re: [PATCH] fs/locks: fix fcntl_getlk64/fcntl_setlk64 stub
 prototypes
From:   Jeff Layton <jlayton@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Nov 2021 11:34:02 -0500
In-Reply-To: <20211123160531.93545-1-arnd@kernel.org>
References: <20211123160531.93545-1-arnd@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-11-23 at 17:05 +0100, Arnd Bergmann wrote:
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
>  include/linux/fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1cb616fc1105..698d92567841 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1220,13 +1220,13 @@ static inline int fcntl_setlk(unsigned int fd, struct file *file,
>  
>  #if BITS_PER_LONG == 32
>  static inline int fcntl_getlk64(struct file *file, unsigned int cmd,
> -				struct flock64 __user *user)
> +				struct flock64 *user)
>  {
>  	return -EINVAL;
>  }
>  
>  static inline int fcntl_setlk64(unsigned int fd, struct file *file,
> -				unsigned int cmd, struct flock64 __user *user)
> +				unsigned int cmd, struct flock64 *user)
>  {
>  	return -EACCES;
>  }

Thanks Arnd. I'll pull this in for v5.17. Let me know if it needs to go
in sooner.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
