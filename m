Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5033D30A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhCPL30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 07:29:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhCPL3S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5112AC1D;
        Tue, 16 Mar 2021 11:29:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5799B1F2C4C; Tue, 16 Mar 2021 12:29:16 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:29:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/2] quota: Add mountpath based quota support
Message-ID: <20210316112916.GA23532@quack2.suse.cz>
References: <20210304123541.30749-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304123541.30749-1-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 04-03-21 13:35:38, Sascha Hauer wrote:
> Current quotactl syscall uses a path to a block device to specify the
> filesystem to work on which makes it unsuitable for filesystems that
> do not have a block device. This series adds a new syscall quotactl_path()
> which replaces the path to the block device with a mountpath, but otherwise
> behaves like original quotactl.
> 
> This is done to add quota support to UBIFS. UBIFS quota support has been
> posted several times with different approaches to put the mountpath into
> the existing quotactl() syscall until it has been suggested to make it a
> new syscall instead, so here it is.
> 
> I'm not posting the full UBIFS quota series here as it remains unchanged
> and I'd like to get feedback to the new syscall first. For those interested
> the most recent series can be found here: https://lwn.net/Articles/810463/

Thanks. I've merged the two patches into my tree and will push them to
Linus for the next merge window.

								Honza

> 
> Changes since v2:
> - Rebase on v5.12-rc1
> - replace mountpath.dentry->d_inode->i_sb with mountpath.mnt->mnt_sb
> - fix wrong macro usage in arch/x86/entry/syscalls/syscall_32.tbl
> - +Cc linux-api@vger.kernel.org
> 
> Changes since (implicit) v1:
> - Ignore second path argument to Q_QUOTAON. With this quotactl_path() can
>   only do the Q_QUOTAON operation on filesystems which use hidden inodes
>   for quota metadata storage
> - Drop unnecessary quotactl_cmd_onoff() check
> 
> Sascha Hauer (2):
>   quota: Add mountpath based quota support
>   quota: wire up quotactl_path
> 
>  arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
>  arch/arm/tools/syscall.tbl                  |  1 +
>  arch/arm64/include/asm/unistd.h             |  2 +-
>  arch/arm64/include/asm/unistd32.h           |  2 +
>  arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
>  arch/s390/kernel/syscalls/syscall.tbl       |  1 +
>  arch/sh/kernel/syscalls/syscall.tbl         |  1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
>  fs/quota/quota.c                            | 49 +++++++++++++++++++--
>  include/linux/syscalls.h                    |  2 +
>  include/uapi/asm-generic/unistd.h           |  4 +-
>  kernel/sys_ni.c                             |  1 +
>  22 files changed, 71 insertions(+), 5 deletions(-)
> 
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
