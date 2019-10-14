Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C73BD61E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 14:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfJNMBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 08:01:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:51370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730300AbfJNMBz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 08:01:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0D73BC1F;
        Mon, 14 Oct 2019 12:01:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7FF3DA7E3; Mon, 14 Oct 2019 14:02:04 +0200 (CEST)
Date:   Mon, 14 Oct 2019 14:02:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        viro@ZenIV.linux.org.uk, jack@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fs: use READ_ONCE/WRITE_ONCE with the i_size helpers
Message-ID: <20191014120204.GO2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        viro@ZenIV.linux.org.uk, jack@suse.cz, linux-btrfs@vger.kernel.org
References: <20191011202050.8656-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011202050.8656-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:20:50PM -0400, Josef Bacik wrote:
> I spent the last few weeks running down a weird regression in btrfs we
> were seeing in production.  It turned out to be introduced by
> 62b37622718c, which took the following
> 
> loff_t isize = i_size_read(inode);
> 
> actual_end = min_t(u64, isize, end + 1);
> 
> and turned it into
> 
> actual_end = min_t(u64, i_size_read(inode), end + 1);
> 
> The problem here is that the compiler is optimizing out the temporary
> variables used in __cmp_once, so the resulting assembly looks like this
> 
> 498             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff814b08c1 <+145>:   48 8b 44 24 28  mov    0x28(%rsp),%rax
>    0xffffffff814b08c6 <+150>:   48 39 45 50     cmp    %rax,0x50(%rbp)
>    0xffffffff814b08ca <+154>:   48 89 c6        mov    %rax,%rsi
>    0xffffffff814b08cd <+157>:   48 0f 46 75 50  cmovbe 0x50(%rbp),%rsi
> 
> as you can see we read the value of the inode to compare, and then we
> read it a second time to assign it.
> 
> This code is simply an optimization, so there's no locking to keep
> i_size from changing, however we really need min_t to actually return
> the minimum value for these two values, which it is failing to do.
> 
> We've reverted that patch for now to fix the problem, but it's only a
> matter of time before the compiler becomes smart enough to optimize out
> the loff_t isize intermediate variable as well.

The cleanup patch proably made it more likely but otherwise does not fix
the problem so you got lucky with reverting it.

I'll repeat what I sent as reply to the btrfs patch https://patchwork.kernel.org/patch/11185435/ ,
addin the temporary variable is still not entirely correct and depends
on the compiler.

This patch adding READ_ONCE to i_size_read is IMHO the only safe way, as
the accessors are intended for unlocked use and for that
READ_ONCE/WRITE_ONCE are a must, per LKMM (linux kernel memody model). I
slightly wonder why this hasn't been so since long ago.

> Instead we want to make it explicit that i_size_read() should only read
> the value once.  This will keep this class of problem from happening in
> the future, regardless of what the compiler chooses to do.  With this
> change we get the following assembly generated for this code
> 
> 491             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff8148f625 <+149>:   48 8b 44 24 20  mov    0x20(%rsp),%rax
> 
> ./include/linux/compiler.h:
> 199             __READ_ONCE_SIZE;
>    0xffffffff8148f62a <+154>:   4c 8b 75 50     mov    0x50(%rbp),%r14
> 
> fs/btrfs/inode.c:
> 491             actual_end = min_t(u64, i_size_read(inode), end + 1);
>    0xffffffff8148f62e <+158>:   49 39 c6        cmp    %rax,%r14
>    0xffffffff8148f631 <+161>:   4c 0f 47 f0     cmova  %rax,%r14
> 
> and this works out properly, we only read the value once and so we won't
> trip over this problem again.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

And CC: stable too.

Reviewed-by: David Sterba <dsterba@suse.com>

> ---
>  include/linux/fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e0d909d35763..0e3f887e2dc5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -863,7 +863,7 @@ static inline loff_t i_size_read(const struct inode *inode)
>  	preempt_enable();
>  	return i_size;
>  #else
> -	return inode->i_size;
> +	return READ_ONCE(inode->i_size);

Regarding the other ways to access i_size, preempt_enable() are compiler
barriers, so this should be safe without explicit READ_ONCE.
