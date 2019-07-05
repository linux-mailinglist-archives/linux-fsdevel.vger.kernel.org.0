Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3F460C07
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGEUCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:02:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43740 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfGEUCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:02:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so4719404pgv.10;
        Fri, 05 Jul 2019 13:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8Uj2TrxMvX9FMZc0qIgrfsrFsHthGELHTkxlQxnkf8=;
        b=PWCtZQW6fTr0iUKXggptIBXHYHWR5oFCYhzHDo3JJn4dwDQXOCdDdHPnHSB/ix1mdZ
         l0lKI6YaHLLwLYZxCAsglZ8p8f6pyeFGophvT5g+mB5vRAIVKxQO6/tYzaZFhkslGX+k
         LIFJLJXU0/hQ75DBw5WovnLnDdxQu7DwCcO/lF0vL/dg6P6Vm/5M9P//c/timnb7UOX/
         2GPC30kW2X788fZ86abTe/uViE/eeRo6cIR5Jd8hxUU2f1wO+i4m3DYUIeTMpYGbNTeF
         TBaEXWhFfPNkHDfNGwFpIzSGmvTCdg7Fww7PUNlsjo+UFH2YbYe+hCjzzaMCC/p/RK5r
         xW1A==
X-Gm-Message-State: APjAAAUfXw9RURb8syL8UagSBUdKlcf3fzvBiJN+7gsvyfC14Xf/ekV0
        aJvXhhx+0bVQoaxB4tguYPA=
X-Google-Smtp-Source: APXvYqyJG3mTorxX3XFRdW7UrvsJCMFWBq38zgWQTER5lzb182pfPi87fC1YdCbeF+ZDpqMCrnIggQ==
X-Received: by 2002:a65:4507:: with SMTP id n7mr7021343pgq.86.1562356940742;
        Fri, 05 Jul 2019 13:02:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l4sm6256039pff.50.2019.07.05.13.02.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:02:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BA9A640190; Fri,  5 Jul 2019 20:02:18 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:02:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Radoslaw Burny <rburny@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jsperbeck@google.com
Subject: Re: [PATCH v2] fs: Fix the default values of i_uid/i_gid on
 /proc/sys inodes.
Message-ID: <20190705200218.GZ19023@42.do-not-panic.com>
References: <20190705163021.142924-1-rburny@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705163021.142924-1-rburny@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Please re-state the main fix in the commit log, not just the subject.

Also, this does not explain why the current values are and the impact to
systems / users. This would help in determine and evaluating if this
deserves to be a stable fix.

On Fri, Jul 05, 2019 at 06:30:21PM +0200, Radoslaw Burny wrote:
> This also fixes a problem where, in a user namespace without root user
> mapping, it is not possible to write to /proc/sys/kernel/shmmax.

This does not explain why that should be possible and what impact this
limitation has.

> The problem was introduced by the combination of the two commits:
> * 81754357770ebd900801231e7bc8d151ddc00498: fs: Update
>   i_[ug]id_(read|write) to translate relative to s_user_ns
>     - this caused the kernel to write INVALID_[UG]ID to i_uid/i_gid
>     members of /proc/sys inodes if a containing userns does not have
>     entries for root in the uid/gid_map.
This is 2014 commit merged as of v4.8.

> * 0bd23d09b874e53bd1a2fe2296030aa2720d7b08: vfs: Don't modify inodes
>   with a uid or gid unknown to the vfs
>     - changed the kernel to prevent opens for write if the i_uid/i_gid
>     field in the inode is invalid

This is a 2016 commit merged as of v4.8 as well...

So regardless of the dates of the commits, are you saying this is a
regression you can confirm did not exist prior to v4.8? Did you test
v4.7 to confirm?

> This commit fixes the issue by defaulting i_uid/i_gid to
> GLOBAL_ROOT_UID/GID.

Why is this right?

> Note that these values are not used for /proc/sys
> access checks, so the change does not otherwise affect /proc semantics.
> 
> Tested: Used a repro program that creates a user namespace without any
> mapping and stat'ed /proc/$PID/root/proc/sys/kernel/shmmax from outside.
> Before the change, it shows the overflow uid, with the change it's 0.

Why is the overflow uid bad for user experience? Did you test prior to
v4.8, ie on v4.7 to confirm this is indeed a regression?

You'd want then to also ammend in the commit log a Fixes:  tag with both
commits listed. If this is a stable fix (criteria yet to be determined),
then we'd need a stable tag.

  Luis

> Signed-off-by: Radoslaw Burny <rburny@google.com>
> ---
> Changelog since v1:
> - Updated the commit title and description.
> 
>  fs/proc/proc_sysctl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c74570736b24..36ad1b0d6259 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -499,6 +499,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  
>  	if (root->set_ownership)
>  		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
> +	else {
> +		inode->i_uid = GLOBAL_ROOT_UID;
> +		inode->i_gid = GLOBAL_ROOT_GID;
> +	}
>  
>  	return inode;
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
