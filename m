Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB03A167E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhFIOFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 10:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237357AbhFIOFQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC87B61364;
        Wed,  9 Jun 2021 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623247401;
        bh=2N2MM8Q/I1AZhJk9l8eS0M2bQk0hz+u7pEqJVI7Ab2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PhnCk9BTnCeW/6EbRgorOow6/fuJERuswsbrzHyFvfWsj3y1zxzuXc6MUiDJowm2B
         j7Vc8TOw69B0lrdAEUdUNN2blYI+3FI/WIMuB3VwFb0mniXUzcye6mwZhUw816e1PD
         vqaCH/IrmOqO5lSfpL5CaEo0FS9714VDOgZGZ+kqi24D3ax9cfMzSjSlfzTliGLwJS
         gDE3u7vaibKVlQ3C/svq1eOoopaT/APsLXC6FSPkxci2tzq4piY7v/MjSxTCdBsxHW
         YZdwUiH1Fb5FMNIhZaA/2UDHD/esv74GArUrFeRUbvkSHzkPbPnPf/9iW6JnITM363
         jnvGCNN3MsTqQ==
Date:   Wed, 9 Jun 2021 23:03:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     christian.brauner@ubuntu.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, dong.menglong@zte.com.cn, jack@suse.cz,
        hare@suse.de, axboe@kernel.dk, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        brho@google.com, f.fainelli@gmail.com, palmerdabbelt@google.com,
        wangkefeng.wang@huawei.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, glider@google.com,
        pmladek@suse.com, johannes.berg@intel.com, ebiederm@xmission.com,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, arnd@arndb.de, chris@chrisdown.name,
        mingo@kernel.org, bhelgaas@google.com, josh@joshtriplett.org
Subject: Re: [PATCH v6 0/2] init/initramfs.c: make initramfs support
 pivot_root
Message-Id: <20210609230312.54f3f0ba9bb2ce93b9f5c4a3@kernel.org>
In-Reply-To: <20210605034447.92917-1-dong.menglong@zte.com.cn>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  5 Jun 2021 11:44:45 +0800
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

Hi,

I have tested this series on qemu with shell script container on initramfs.
It works for me!

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> 
> Changes since V5:
> 
> Remove the third patch and make it combined with the second one.
> 
> 
> Changes since V4:                                                                                                                                                     
>                                                                                                                                                                       
> Do some more code cleanup for the second patch, include:                                                                                                              
> - move 'ramdisk_exec_exist()' to 'init.h'                                                                                                                             
> - remove unnecessary struct 'fs_rootfs_root'                                                                                                                          
> - introduce 'revert_mount_rootfs()'                                                                                                                                   
> - [...]                                                                                                                                                               
> 
> 
> Changes since V3:
> 
> Do a code cleanup for the second patch, as Christian Brauner suggested:
> - remove the concept 'user root', which seems not suitable.
> - introduce inline function 'check_tmpfs_enabled()' to avoid duplicated
>   code.
> - rename function 'mount_user_root' to 'prepare_mount_rootfs'
> - rename function 'end_mount_user_root' to 'finish_mount_rootfs'
> - join 'init_user_rootfs()' with 'prepare_mount_rootfs()'
> 
> Changes since V2:
> 
> In the first patch, I use vfs_path_lookup() in init_eaccess() to make the
> path lookup follow the mount on '/'. After this, the problem reported by
> Masami Hiramatsu is solved. Thanks for your report :/
> 
> 
> Changes since V1:
> 
> In the first patch, I add the flag LOOKUP_DOWN to init_eaccess(), to make
> it support the check of filesystem mounted on '/'.
> 
> In the second patch, I control 'user root' with kconfig option
> 'CONFIG_INITRAMFS_USER_ROOT', and add some comments, as Luis Chamberlain
> suggested.
> 
> In the third patch, I make 'rootfs_fs_type' in control of
> 'CONFIG_INITRAMFS_USER_ROOT'.
> 
> 
> 
> Menglong Dong (2):
>   init/do_mounts.c: create second mount for initramfs
>   init/do_mounts.c: fix rootfs_fs_type with ramfs
> 
>  include/linux/init.h |   4 ++
>  init/do_mounts.c     | 101 ++++++++++++++++++++++++++++++++++++++++---
>  init/do_mounts.h     |  16 ++++++-
>  init/initramfs.c     |   8 ++++
>  usr/Kconfig          |  10 +++++
>  5 files changed, 131 insertions(+), 8 deletions(-)
> 
> -- 
> 2.32.0.rc0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
