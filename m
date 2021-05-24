Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847F738F523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 23:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhEXVtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 17:49:24 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:38460 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhEXVtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 17:49:23 -0400
Received: by mail-pj1-f41.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so12028701pjb.3;
        Mon, 24 May 2021 14:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrqHjXQRC4M7qVgUSaWTrcOaZ1f9fw7G33qll6nxKv8=;
        b=ThCRpB1vTjEbTL6AMIbSYUGrXyCho/AQAUdJgiZkzRyEvMIwjk2Ck/kkx/+3J0d8CZ
         3UqyasmRqAU4ZCRLvKeaQDjmgR03PY3toc6yk/8fp16hrmrmMm/mDor6Zdv0l6o9JNr3
         7yZY6WIaySv3w/vkgTmQT5haUWTSuvFREnBaknHtrMpbytCgrS4HxnYjf75H07AI1vO0
         TkdI/n8lU7PedkukKuE/epfojRaONpsB55suIm+R64tMvqVPwWzM1AeI1W0abNYLLxhH
         beqIZoIZFjtkHueup0DkMcNA+wkespjWHlyS8a2ooT/qSPrZDbj5Ek8nN3KdgnRLPZVp
         jniQ==
X-Gm-Message-State: AOAM533ZA6TNiwYIUI1BYx84My1ptsH3fnq4qvGf3NhVC5pgL3n9qTmx
        +sjyQ2uE4U2tzbaakQoDltM=
X-Google-Smtp-Source: ABdhPJy7c3nmY3mIYoQwpZ7K0jTIgE4TuQ8XojwxWbEhn/bMSrw/g1FIT8YUEUsDqk1/Mr798I4U5A==
X-Received: by 2002:a17:90a:8a07:: with SMTP id w7mr26982435pjn.192.1621892873290;
        Mon, 24 May 2021 14:47:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m1sm8545842pgd.78.2021.05.24.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 14:47:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 95210401AD; Mon, 24 May 2021 21:47:51 +0000 (UTC)
Date:   Mon, 24 May 2021 21:47:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
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
Subject: Re: [PATCH 3/3] init/do_mounts.c: fix rootfs_fs_type with ramfs
Message-ID: <20210524214751.GZ4332@42.do-not-panic.com>
References: <20210522113155.244796-1-dong.menglong@zte.com.cn>
 <20210522113155.244796-4-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522113155.244796-4-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 07:31:55PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> As for the existence of 'user root' which is introduced in previous
> patch, 'rootfs_fs_type', which is used as the root of mount tree,
> is not used directly any more. So it make no sense to switch it
> between ramfs and tmpfs, just fix it with ramfs to simplify the
> code.
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 943cb58846fb..6d1253f75bb0 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -689,24 +689,8 @@ void __init init_user_rootfs(void)
>  	}
>  }
>  
> -static bool is_tmpfs;
> -static int rootfs_init_fs_context(struct fs_context *fc)
> -{
> -	if (IS_ENABLED(CONFIG_TMPFS) && is_tmpfs)
> -		return shmem_init_fs_context(fc);
> -
> -	return ramfs_init_fs_context(fc);
> -}
> -
>  struct file_system_type rootfs_fs_type = {

Then why not also just rename rootfs_fs_type to ram_rootfs_fs_type to
make this even clearer now?

>  	.name		= "rootfs",
> -	.init_fs_context = rootfs_init_fs_context,
> +	.init_fs_context = ramfs_init_fs_context,
>  	.kill_sb	= kill_litter_super,
>  };

  Luis
