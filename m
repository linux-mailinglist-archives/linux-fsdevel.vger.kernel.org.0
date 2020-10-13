Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B1928CAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403869AbgJMJWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 05:22:48 -0400
Received: from foss.arm.com ([217.140.110.172]:50208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390781AbgJMJWs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:22:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EF431B;
        Tue, 13 Oct 2020 02:22:47 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 486B93F66B;
        Tue, 13 Oct 2020 02:22:46 -0700 (PDT)
Date:   Tue, 13 Oct 2020 10:22:43 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
Message-ID: <20201013092240.GI32292@arm.com>
References: <20201012220620.124408-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012220620.124408-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 13, 2020 at 12:06:20AM +0200, Linus Walleij wrote:
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
> 
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.
> 
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
> 
>   #define FD_32BIT_MODE 2
> 
>   int main(int argc, char** argv) {
>     DIR* dir;
>     int err;
>     int fd;
> 
>     dir = opendir("/boot");
>     fd = dirfd(dir);
>     err = fcntl(fd, F_SETFD, FD_32BIT_MODE);
>     if (err) {
>       printf("fcntl() failed! err=%d\n", err);
>       return 1;
>     }
>     printf("dir=%p\n", dir);
>     printf("readdir(dir)=%p\n", readdir(dir));
>     printf("errno=%d: %s\n", errno, strerror(errno));
>     return 0;
>   }
> 
> This can be pretty hard to test since C libraries and linux
> userspace security extensions aggressively filter the parameters
> that are passed down and allowed to commit into actual system
> calls.
> 
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://bugs.launchpad.net/qemu/+bug/1805913
> Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v3 RESEND 1:
> - Resending during the v5.10 merge window to get attention.
> ChangeLog v2->v3:
> - Realized that I also have to clear the flag correspondingly
>   if someone ask for !FD_32BIT_MODE after setting it the
>   first time.
> ChangeLog v1->v2:
> - Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
>   instead of a new fcntl operation, there is already a fcntl
>   operation to set random flags.
> - Sorry for taking forever to respin this patch :(
> ---
>  fs/fcntl.c                       | 7 +++++++
>  include/uapi/asm-generic/fcntl.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 19ac5baad50f..6c32edc4099a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>  		break;
>  	case F_GETFD:
>  		err = get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> +		/* Report 32bit file system mode */
> +		if (filp->f_mode & FMODE_32BITHASH)
> +			err |= FD_32BIT_MODE;
>  		break;
>  	case F_SETFD:
>  		err = 0;
>  		set_close_on_exec(fd, arg & FD_CLOEXEC);
> +		if (arg & FD_32BIT_MODE)
> +			filp->f_mode |= FMODE_32BITHASH;
> +		else
> +			filp->f_mode &= ~FMODE_32BITHASH;

This seems inconsistent?  F_SETFD is for setting flags on a file
descriptor.  Won't setting a flag on filp here instead cause the
behaviour to change for all file descriptors across the system that are
open on this struct file?  Compare set_close_on_exec().

I don't see any discussion on whether this should be an F_SETFL or an
F_SETFD, though I see F_SETFD was Ted's suggestion originally.

[...]

Cheers
---Dave
