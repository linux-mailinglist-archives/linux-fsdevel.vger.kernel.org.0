Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4585C1CD04D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 05:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgEKDPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 23:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgEKDPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 23:15:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F410C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2020 20:15:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so4118258pfx.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2020 20:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=biu5X9JLtv6WRnXKVc8xUOK25p8WSyjfbFSVrSRcQ9E=;
        b=Nw8KjYthz4ugGIkV7t+7zKTL/p5keRxvml5MguBls6kEJ9EldeSye3ObC588Q8BAk1
         PBVypmzmrpBdBzfm6v8KgM/kk6TTWzuZb3fU3mex1KLOrZEjkktJhJIoOXb4Sctg6rH3
         1uiLOHVzfAGh/1qBgXTHEQehQu7xwjJyP815o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=biu5X9JLtv6WRnXKVc8xUOK25p8WSyjfbFSVrSRcQ9E=;
        b=JEi1bL0lwnsuLpxd7aVAENVkfyWi9WLyrD985I3QGa7e1LwwGEaFqj/CjuBiWlaJYC
         2C/20fZYgymPqN2fLdBlPFRqwDkekhpcR6aAF3YyZRTjAp9IFht43zcsCLsRYQfB9K7E
         pOvk1IVpwZxkaa4i1llaAUPe/LaveCA96xF6g+Pxg602zx10bfgnEwvTsJuZbT8EEBj4
         kQ7p/deg3C2hGXQGajNvYoNUXKipIV4KlA1QtbJ4TWxQ1WJzOElT/uRORcdKSXLiDmIx
         3PrabGB8pTG3Ke/3qP/dOJQgXbg0Ej7yYwCvh+1iTy79r6kNGkHEVPIy/PMwtqwMmE8u
         EPXA==
X-Gm-Message-State: AGi0PuZhhydkJe+bqrC2+Fr6EjxrMzkAMakuoAsQU4eLPcrqk/wdQr9r
        TMqaXcHwClK+tsrrHsIzRmhnSg==
X-Google-Smtp-Source: APiQypJxhmyeJZSarW6LgvJTnaApg7gY80iM7fHvZ9PNI7Twn0eOw6d19/FzRXiOud1ybxNdArL8xA==
X-Received: by 2002:aa7:958f:: with SMTP id z15mr13543700pfj.10.1589166936598;
        Sun, 10 May 2020 20:15:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w75sm7834318pfc.156.2020.05.10.20.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 20:15:35 -0700 (PDT)
Date:   Sun, 10 May 2020 20:15:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from
 __do_execve_file
Message-ID: <202005101929.A4374D0F56@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 09, 2020 at 02:41:17PM -0500, Eric W. Biederman wrote:
> 
> Now that security_bprm_set_creds is no longer responsible for calling
> cap_bprm_set_creds, security_bprm_set_creds only does something for
> the primary file that is being executed (not any interpreters it may
> have).  Therefore call security_bprm_set_creds from __do_execve_file,
> instead of from prepare_binprm so that it is only called once, and
> remove the now unnecessary called_set_creds field of struct binprm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  fs/exec.c                  | 11 +++++------
>  include/linux/binfmts.h    |  6 ------
>  security/apparmor/domain.c |  3 ---
>  security/selinux/hooks.c   |  2 --
>  security/smack/smack_lsm.c |  3 ---
>  security/tomoyo/tomoyo.c   |  6 ------
>  6 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 765bfd51a546..635b5085050c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1635,12 +1635,6 @@ int prepare_binprm(struct linux_binprm *bprm)
>  
>  	bprm_fill_uid(bprm);
>  
> -	/* fill in binprm security blob */
> -	retval = security_bprm_set_creds(bprm);
> -	if (retval)
> -		return retval;
> -	bprm->called_set_creds = 1;
> -
>  	retval = cap_bprm_set_creds(bprm);
>  	if (retval)
>  		return retval;
> @@ -1858,6 +1852,11 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	if (retval < 0)
>  		goto out;
>  
> +	/* fill in binprm security blob */
> +	retval = security_bprm_set_creds(bprm);
> +	if (retval)
> +		goto out;
> +
>  	retval = prepare_binprm(bprm);
>  	if (retval < 0)
>  		goto out;
> 

Here I go with a Sunday night review, so hopefully I'm thinking better
than Friday night's review, but I *think* this patch is broken from
the LSM sense of the world in that security_bprm_set_creds() is getting
called _before_ the creds actually get fully set (in prepare_binprm()
by the calls to bprm_fill_uid(), cap_bprm_set_creds(), and
check_unsafe_exec()).

As a specific example, see the setting of LSM_UNSAFE_NO_NEW_PRIVS in
bprm->unsafe during check_unsafe_exec(), which must happen after
bprm_fill_uid(bprm) and cap_bprm_set_creds(bprm), to have a "true" view
of the execution privileges. Apparmor checks for this flag in its
security_bprm_set_creds() hook. Similarly do selinux, smack, etc...

The security_bprm_set_creds() boundary for LSM is to see the "final"
state of the process privileges, and that needs to happen after
bprm_fill_uid(), cap_bprm_set_creds(), and check_unsafe_exec() have all
finished.

So, as it stands, I don't think this will work, but perhaps it can still
be rearranged to avoid the called_set_creds silliness. I'll look more
this week...

-Kees

-- 
Kees Cook
