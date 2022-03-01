Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19284C87C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiCAJXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiCAJXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:23:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF47AE7B;
        Tue,  1 Mar 2022 01:22:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15785B81855;
        Tue,  1 Mar 2022 09:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0972C340EE;
        Tue,  1 Mar 2022 09:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646126559;
        bh=ZpG11DD4kp9h4/beH993WEeMr4LguyKwWCvtJOaP/8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnDeyLB9EgfvQl+AhT8DrwEAFMRcAPKHtHDA+fV+HVqwv7K95N7zFGRi+C02gLXXw
         s5r1eCRjv7MhkHR4z/ahqeB4jJXrLfkNGguy50QZ/En2FgqadneXBA/W5x/T5mJGUK
         gqzit1E5G3zEbf4tWBZE6EuDHtjxx4Bqvr8hMJLK4eTzgfIPTERMFMriwGyEHBL4hM
         kA0sp8o7K59oEvKW5QRUZoDcuIpYLoKYoNwfP7S8LvVV3vaxjZ9JZX05FD4O8oeJ5U
         oMQUkxOfqnivmB4BXGvg8TLkEcLrCa9882/+SJGvQewS9fD6KBH/lWHDiRbD1BqHN2
         nb4eVLfQxbbEQ==
Date:   Tue, 1 Mar 2022 10:22:32 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
Message-ID: <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
References: <20220228215935.748017-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228215935.748017-1-mic@digikod.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:59:35PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
> ACC_MODE() for real"), we lost an open flags consistency check.  Opening
> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ |
> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0.
> 
> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
> respectively FMODE_WRITE, and return an EBADF error if it is absent.
> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a file
> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this safe
> behavior.

That specific part seems a bit risky at first glance. Given that the
patch referenced is from 2009 this means we've been allowing O_WRONLY |
O_RDWR to succeed for almost 13 years now.

> 
> To make it consistent with ACC_MODE(), this patch also changes
> OPEN_FMODE() to return FMODE_READ | FMODE_WRITE for O_WRONLY | O_RDWR.
> This may help protect from potential spurious issues.
> 
> This issue could result in inconsistencies with AppArmor, Landlock and
> SELinux, but the VFS checks would still forbid read and write accesses.
> Tomoyo uses the ACC_MODE() transformation which is correct, and Smack
> doesn't check the file mode.  Filesystems using OPEN_FMODE() should also
> be protected by the VFS checks.
> 
> Fixes: 5300990c0370 ("Sanitize f_flags helpers")
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Steve French <sfrench@samba.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220228215935.748017-1-mic@digikod.net
> ---
>  fs/file_table.c    | 3 +++
>  include/linux/fs.h | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 7d2e692b66a9..b936f69525d0 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -135,6 +135,9 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
>  	struct file *f;
>  	int error;
>  
> +	if ((flags & O_ACCMODE) == O_ACCMODE)
> +		return ERR_PTR(-EINVAL);
> +
>  	f = kmem_cache_zalloc(filp_cachep, GFP_KERNEL);
>  	if (unlikely(!f))
>  		return ERR_PTR(-ENOMEM);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e2d892b201b0..83bc5aaf1c41 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3527,8 +3527,9 @@ int __init list_bdev_fs_names(char *buf, size_t size);
>  #define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
>  
>  #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
> -#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
> -					    (flag & __FMODE_NONOTIFY)))
> +#define OPEN_FMODE(flag) ((__force fmode_t)( \
> +			(((flag + 1) & O_ACCMODE) ?: O_ACCMODE) | \
> +			(flag & __FMODE_NONOTIFY)))
>  
>  static inline bool is_sxid(umode_t mode)
>  {
> 
> base-commit: 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3
> -- 
> 2.35.1
> 
