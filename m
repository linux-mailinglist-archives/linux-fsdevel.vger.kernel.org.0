Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EE319C7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 11:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhBLKRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 05:17:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:48806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLKRF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:17:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5EA2AD62;
        Fri, 12 Feb 2021 10:16:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 57E801E62E4; Fri, 12 Feb 2021 11:16:23 +0100 (CET)
Date:   Fri, 12 Feb 2021 11:16:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, kernel@pengutronix.de,
        Jan Kara <jack@suse.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 0/2] quota: Add mountpath based quota support
Message-ID: <20210212101623.GU19070@quack2.suse.cz>
References: <20210211153024.32502-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211153024.32502-1-s.hauer@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-02-21 16:30:21, Sascha Hauer wrote:
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
> 
> Changes since (implicit) v1:
> - Ignore second path argument to Q_QUOTAON. With this quotactl_path() can
>   only do the Q_QUOTAON operation on filesystems which use hidden inodes
>   for quota metadata storage
> - Drop unnecessary quotactl_cmd_onoff() check

Thanks modulo the 0-day complains and the small nit discussed the patches
and manpage update look good to me.

								Honza

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
>  fs/quota/quota.c                            | 49 +++++++++++++++++++++
>  include/linux/syscalls.h                    |  2 +
>  include/uapi/asm-generic/unistd.h           |  4 +-
>  kernel/sys_ni.c                             |  1 +
>  22 files changed, 74 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
