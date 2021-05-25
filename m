Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2244D38F75D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 03:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhEYBJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 21:09:40 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:60437 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEYBJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:39 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E20D2D8704;
        Tue, 25 May 2021 01:02:40 +0000 (UTC)
Received: (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B7D4BC0004;
        Tue, 25 May 2021 01:02:06 +0000 (UTC)
Date:   Mon, 24 May 2021 18:02:04 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     menglong8.dong@gmail.com
Cc:     mcgrof@kernel.org, viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, joe@perches.com, dong.menglong@zte.com.cn,
        masahiroy@kernel.org, jack@suse.cz, axboe@kernel.dk, hare@suse.de,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, brho@google.com,
        f.fainelli@gmail.com, wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, glider@google.com, pmladek@suse.com,
        ebiederm@xmission.com, jojing64@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] init/main.c: introduce function ramdisk_exec_exist()
Message-ID: <YKxMjPOrHfb1uaA+@localhost>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-2-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522113155.244796-2-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 07:31:53PM +0800, menglong8.dong@gmail.com wrote:
> Introduce the function ramdisk_exec_exist, which is used to check
> the exist of 'ramdisk_execute_command'.
> 
> It can do absolute path and relative path check. For relative path,
> it will ignore '/' and '.' in the start of
> 'ramdisk_execute_command'.

> --- a/init/main.c
> +++ b/init/main.c
> @@ -1522,6 +1522,21 @@ void __init console_on_rootfs(void)
>  	fput(file);
>  }
>  
> +bool __init ramdisk_exec_exist(bool absolute)
> +{
> +	char *tmp_command = ramdisk_execute_command;
> +
> +	if (!tmp_command)
> +		return false;
> +
> +	if (!absolute) {
> +		while (*tmp_command == '/' || *tmp_command == '.')
> +			tmp_command++;

As far as I can tell, this will break if the user wants to use
".mybinary" or ".mydir/mybinary" as the name of their init program.

For that matter, it would break "...prog" or "...somedir/prog", which
would be strange but not something the kernel should prevent.

I don't think this code should be attempting to recreate
relative-to-absolute filename resolution.
