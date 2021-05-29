Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFAE3949F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 May 2021 04:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE2C2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 22:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhE2C2Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 22:28:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F2A361090;
        Sat, 29 May 2021 02:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622255209;
        bh=aEwQ7gtW8SBWhXtpPyxd8abH3bVt9Pdwm73a/Rj59xU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoouXyVE/uSO4rw0qMk4O9Vj9DsO74HDrd8wD3yoSnWI8RT5MBB2H3/OZTDekq4M9
         YaDYwBQC4nu4SB4gY6egVmcA0YZy8nn4E9X5gAqYpeVS0PqGv9AghovRWKzPhXcJhg
         8DDXeMvsnTFxVHQ1Gwj9WeVefMVT6vXqsuLfMVLFNztapYmEL4hSrWgxy5by/eHV8J
         cKm/mjXVtA71arJnrtjy6pvv3U8zY7k3bZu9SmtaH3ZVWpXki8WJ5lj9dQADlX1cBR
         JtJoLs+LnRCC0vn3OLERJMFax7ovPGr90249HSeK7eY3Ll8nnVlHJ69DhHGWlXvCCi
         SfUlxbMWZSyvA==
Date:   Sat, 29 May 2021 11:26:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, josh@joshtriplett.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        johan@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        dong.menglong@zte.com.cn, joe@perches.com, axboe@kernel.dk,
        jack@suse.cz, hare@suse.de, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org, neilb@suse.de,
        akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v3 0/3] init/initramfs.c: make initramfs support
 pivot_root
Message-Id: <20210529112638.b3a9ec5475ca8e4f51648ff0@kernel.org>
In-Reply-To: <20210528143802.78635-1-dong.menglong@zte.com.cn>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Menglong,

On Fri, 28 May 2021 22:37:59 +0800
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
> 
> 
> Changes since V2:
> 
> In the first patch, I use vfs_path_lookup() in init_eaccess() to make the
> path lookup follow the mount on '/'. After this, the problem reported by
> Masami Hiramatsu is solved. Thanks for your report :/

Thank you for the fix, I confirmed that the issue has been solved with this.

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

Regards,


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
> Menglong Dong (3):
>   init/main.c: introduce function ramdisk_exec_exist()
>   init/do_cmounts.c: introduce 'user_root' for initramfs
>   init/do_mounts.c: fix rootfs_fs_type with ramfs
> 
>  fs/init.c            |  11 ++++-
>  include/linux/init.h |   5 ++
>  init/do_mounts.c     | 109 +++++++++++++++++++++++++++++++++++++++++++
>  init/do_mounts.h     |  18 ++++++-
>  init/initramfs.c     |  10 ++++
>  init/main.c          |   7 ++-
>  usr/Kconfig          |  10 ++++
>  7 files changed, 166 insertions(+), 4 deletions(-)
> 
> -- 
> 2.32.0.rc0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
