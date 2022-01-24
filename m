Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A97497D51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 11:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiAXKka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 05:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiAXKkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:40:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FAC061744;
        Mon, 24 Jan 2022 02:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5B709CE1085;
        Mon, 24 Jan 2022 10:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD521C340E1;
        Mon, 24 Jan 2022 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643020821;
        bh=YP3rpOMueEM82W9W/1RDTqqRSLU6FQT/DQxpUNNwtOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AO682VwdKPveky60qNAVT4BjLT3p5LbEA0/U1l2vCG7W0OdyDN2gVoXEk0EoAaSzn
         J2usjIuVnFr/PqE+a/7qwP7OfUzBIW7VBjvIaqIOblte/aMsN20KCII7s07o4YoXje
         gA8dAyxv5aRKRaoQ/y5uxCxti4GX/dNBOfz/l+yWwU6/vSE7Bwxgitdym14MuJeKog
         yZxC/Y4pDBS4Mvb34ib82ynUkxGy6lHb4NFY6c2Q0wNwsQy66x7yUolcDWy8ZmRVxW
         7IwBHC45OB2hItlIFm0z+iBUvy9LgzLIUFfHk5Q41mzpK6+TXlJdHzth8oWJisPzQg
         wfOF5ti9pAMUw==
Date:   Mon, 24 Jan 2022 11:40:12 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
Message-ID: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
References: <20220124003342.1457437-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220124003342.1457437-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 23, 2022 at 04:33:41PM -0800, Tong Zhang wrote:
> We should unregister the table upon module unload otherwise something
> horrible will happen when we load binfmt_misc module again. Also note
> that we should keep value returned by register_sysctl_mount_point() and
> release it later, otherwise it will leak.
> 
> reproduce:
> modprobe binfmt_misc
> modprobe -r binfmt_misc
> modprobe binfmt_misc
> modprobe -r binfmt_misc
> modprobe binfmt_misc
> 
> [   18.032038] Call Trace:
> [   18.032108]  <TASK>
> [   18.032169]  dump_stack_lvl+0x34/0x44
> [   18.032273]  __register_sysctl_table+0x6f4/0x720
> [   18.032397]  ? preempt_count_sub+0xf/0xb0
> [   18.032508]  ? 0xffffffffc0040000
> [   18.032600]  init_misc_binfmt+0x2d/0x1000 [binfmt_misc]
> [   18.042520] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
> modprobe: can't load module binfmt_misc (kernel/fs/binfmt_misc.ko): Cannot allocate memory
> [   18.063549] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
> [   18.204779] BUG: unable to handle page fault for address: fffffbfff8004802
> 
> Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>  fs/binfmt_misc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index ddea6acbddde..614aedb8ab2e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -817,12 +817,16 @@ static struct file_system_type bm_fs_type = {
>  };
>  MODULE_ALIAS_FS("binfmt_misc");
>  
> +static struct ctl_table_header *binfmt_misc_header;
> +
>  static int __init init_misc_binfmt(void)
>  {
>  	int err = register_filesystem(&bm_fs_type);
>  	if (!err)
>  		insert_binfmt(&misc_format);
> -	if (!register_sysctl_mount_point("fs/binfmt_misc")) {
> +
> +	binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> +	if (!binfmt_misc_header) {

The fix itself is obviously needed.

However, afaict the previous patch introduced another bug and this patch
right here doesn't fix it either.

Namely, if you set CONFIG_SYSCTL=n and CONFIG_BINFMT_MISC={y,m}, then
register_sysctl_mount_point() will return NULL causing modprobe
binfmt_misc to fail. However, before 3ba442d5331f ("fs: move binfmt_misc
sysctl to its own file") loading binfmt_misc would've succeeded even if
fs/binfmt_misc wasn't created in kernel/sysctl.c. Afaict, that goes for
both CONFIG_SYSCTL={y,n} since even in the CONFIG_SYSCTL=y case the
kernel would've moved on if creating the sysctl header would've failed.
And that makes sense since binfmt_misc is mountable wherever, not just
at fs/binfmt_misc.

All that indicates that the correct fix here would be to simply:

binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");

without checking for an error. That should fully restore the old
behavior.

>  		pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
>  		return -ENOMEM;
>  	}
> @@ -831,6 +835,7 @@ static int __init init_misc_binfmt(void)
>  
>  static void __exit exit_misc_binfmt(void)
>  {
> +	unregister_sysctl_table(binfmt_misc_header);
>  	unregister_binfmt(&misc_format);
>  	unregister_filesystem(&bm_fs_type);
>  }
> -- 
> 2.25.1
> 
