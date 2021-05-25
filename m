Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFF390808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEYRp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:45:28 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48705 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhEYRp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:45:28 -0400
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4E2F940005;
        Tue, 25 May 2021 17:43:42 +0000 (UTC)
Date:   Tue, 25 May 2021 10:43:41 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        bhelgaas@google.com, masahiroy@kernel.org,
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
Message-ID: <YK03TRIlXOpvM0Br@localhost>
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525141524.3995-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 10:15:21PM +0800, menglong8.dong@gmail.com wrote:
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

This looks much better, thank you; this addresses all my concerns with
v1. I appreciate having the config option to control this as well.
