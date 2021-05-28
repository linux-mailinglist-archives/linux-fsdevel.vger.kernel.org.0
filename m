Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899B5393D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 09:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhE1HL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 03:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhE1HLz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 03:11:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA2DF61184;
        Fri, 28 May 2021 07:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622185821;
        bh=twOSogob9U7tH3qyhjqMUT0yEHNVGQWQtNnmxz91UXM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sx81GL41SR7HSZiWnd6+pFuwBz/LWK5WI1c8SpKgr8e4I74BpdG8wy4TPSwPPMD6g
         noh62Cw4H1FZg+NsL98P2brMVOynLLsdhMcm6uut/bplA/2DfLQGc9AbFYJf/Nw+Pw
         toIsV6sbhT/riBTbeM+f8l+2h+A6kCbWyJGzJuMa2OYNe0h01ktr9kN4XOp20Tdosl
         GA7QDM+ZfqZPCgubB31xAEaZ3XI8GNt5tHuAdmKAdKgPGInvnABBWGfzsD+akY148R
         a6LLC0balh5WkKOH50KpTKKJeji0Nga92yeY+s2JoAQPjo9wE1GDBFYtOEqvS9RTPE
         6fUvuHS76th9Q==
Date:   Fri, 28 May 2021 16:10:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, josh@joshtriplett.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        johan@kernel.org, bhelgaas@google.com, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        hare@suse.de, jack@suse.cz, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, wangkefeng.wang@huawei.com,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org, mingo@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeyu@kernel.org
Subject: Re: [PATCH v2 0/3] init/initramfs.c: make initramfs support
 pivot_root
Message-Id: <20210528161012.c9c8e25db29df3dbc142c62e@kernel.org>
In-Reply-To: <20210525141524.3995-1-dong.menglong@zte.com.cn>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 25 May 2021 22:15:21 +0800
menglong8.dong@gmail.com wrote:

> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> As Luis Chamberlain suggested, I split the patch:
> [init/initramfs.c: make initramfs support pivot_root]
> (https://lore.kernel.org/linux-fsdevel/20210520154244.20209-1-dong.menglong@zte.com.cn/)
> into three.
> 
> The goal of the series patches is to make pivot_root() support initramfs.
> 
> In the first patch, I introduce the function ramdisk_exec_exist(), which
> is used to check the exist of 'ramdisk_execute_command' in LOOKUP_DOWN
> lookup mode.
> 
> In the second patch, I create a second mount, which is called
> 'user root', and make it become the root. Therefore, the root has a
> parent mount, and it can be umounted or pivot_root.
> 
> In the third patch, I fix rootfs_fs_type with ramfs, as it is not used
> directly any more, and it make no sense to switch it between ramfs and
> tmpfs, just fix it with ramfs to simplify the code.


This idea sounds good to me. I have tested it with MINCS container shell
script (https://github.com/mhiramat/mincs).

However, I found different issue on init_eaccess() (or symlink lookup)
with this series.

I'm using a busybox initramfs, and it makes /init as a symlink of "/sbin/init"
(absolute path)

When CONFIG_INITRAMFS_USER_ROOT=n, it booted. But CONFIG_INITRAMFS_USER_ROOT=y,
it failed to boot because it failed to find /init. If I made the /init as
a symlink of "sbin/init" (relative path), it works.

Would you have any idea?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
