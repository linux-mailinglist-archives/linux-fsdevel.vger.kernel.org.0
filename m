Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2B1F6109
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 06:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgFKElG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 00:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgFKElF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:41:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B40C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 21:41:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id p20so4830956iop.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2020 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MxSp8mta6jBvTYFbwackP1K8RxAUSlCcOAqiVie0bw=;
        b=MDFxEkZa/5Mq83/7d4Lt1ekQ/A34Ql3/RJa0V/k91Bitp1BGn1pGrE5jsgisPEKudC
         ziTuoTflNCIgLqaGfObN9cM0O3+H7vttsX5p49I0bc6789Aqd4GoUlwnjngvGDnCyTUv
         hG9UYF5UpUQOH3TtUilPJ1w3Uo+AMjPgKfOa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MxSp8mta6jBvTYFbwackP1K8RxAUSlCcOAqiVie0bw=;
        b=C0IQ+p6aOpF4/2ooQlrVNTNhKaRwyjl9r27Dtzw7sa49oFFpr0R55t2vIU+4kUyC2K
         /6Xycn/LUORjFX88a1o8U3pAirXdZuk8jmczFOfUTZYFLlSPltiRpL/XY38HbWv2VE3I
         g4igthHbnSgYbP7nfukfJ7lo/R3IgygWuOSeCpEvVLBPoJ9A/tGeP2XZNv6JrZLQBzoS
         7pJiYn7Nq7Z1Ih7YxIqOcr/zjGzl4N+SFzAGfXqdI+sc+xzOMvbO5XtMJl8EjOpBIY2l
         L9dJ0I8QoGnNCm7PwXcwDU37Cb/A4OtPzfUZ1DWGwDCNsCJOq1HRXoLW0SmrSC6+ZzNc
         pMzA==
X-Gm-Message-State: AOAM530R0ZSzbrv4VC0BacgrO+gGXE2/F26E9/WAtte2gc1sLKJFiE/s
        Rb4HCXirfOrnGMlc+pxR+Ioivg==
X-Google-Smtp-Source: ABdhPJxJ4jSClabJaMyX4gCcJYnwf1gDwRM0VggMkQUJzZf+t+4OsZtvLAkyxcmjqsc7Z9N3bPSCZg==
X-Received: by 2002:a02:9999:: with SMTP id a25mr1494213jal.129.1591850464347;
        Wed, 10 Jun 2020 21:41:04 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h14sm981506ilo.10.2020.06.10.21.41.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jun 2020 21:41:03 -0700 (PDT)
Date:   Thu, 11 Jun 2020 04:41:02 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        John Fastabend <john.r.fastabend@intel.com>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <20200611044101.GA5909@ircssh-2.c.rugged-nimbus-611.internal>
References: <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
 <202006091235.930519F5B@keescook>
 <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
 <202006092227.D2D0E1F8F@keescook>
 <20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal>
 <202006101953.899EFB53@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006101953.899EFB53@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 07:59:55PM -0700, Kees Cook wrote:
> 
> Yeah, that seems reasonable. Here's the diff for that part:
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 7b6028b399d8..98bf19b4e086 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -118,7 +118,6 @@ struct seccomp_notif_resp {
>  
>  /**
>   * struct seccomp_notif_addfd
> - * @size: The size of the seccomp_notif_addfd datastructure
>   * @id: The ID of the seccomp notification
>   * @flags: SECCOMP_ADDFD_FLAG_*
>   * @srcfd: The local fd number
> @@ -126,7 +125,6 @@ struct seccomp_notif_resp {
>   * @newfd_flags: The O_* flags the remote FD should have applied
>   */
>  struct seccomp_notif_addfd {
> -	__u64 size;
>  	__u64 id;
>  	__u32 flags;
>  	__u32 srcfd;
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3c913f3b8451..00cbdad6c480 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1297,14 +1297,9 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
>  	struct seccomp_notif_addfd addfd;
>  	struct seccomp_knotif *knotif;
>  	struct seccomp_kaddfd kaddfd;
> -	u64 size;
>  	int ret;
>  
> -	ret = get_user(size, &uaddfd->size);
> -	if (ret)
> -		return ret;
> -
> -	ret = copy_struct_from_user(&addfd, sizeof(addfd), uaddfd, size);
> +	ret = copy_from_user(&addfd, uaddfd, sizeof(addfd));
>  	if (ret)
>  		return ret;
>  
> 
Looks good to me. If we ever change the size of this struct, we can do the work 
then to copy_struct_from_user.

> > 
> > ----
> > +#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
> > +						struct seccomp_notif_addfd)
> > 
> > Lastly, what I believe to be a small mistake, it should be SECCOMP_IOW, based on 
> > the documentation in ioctl.h -- "_IOW means userland is writing and kernel is 
> > reading."
> 
> Oooooh. Yeah; good catch. Uhm, that means SECCOMP_IOCTL_NOTIF_ID_VALID
> is wrong too, yes? Tycho, Christian, how disruptive would this be to
> fix? (Perhaps support both and deprecate the IOR version at some point
> in the future?)
I think at a minimum we should change the uapi, and accept both (for now). Maybe 
a pr_warn_once telling people not to use the old one.

I can do the patch, if you want. 
> 
> Diff for just addfd's change:
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 7b6028b399d8..98bf19b4e086 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -146,7 +144,7 @@ struct seccomp_notif_addfd {
>  						struct seccomp_notif_resp)
>  #define SECCOMP_IOCTL_NOTIF_ID_VALID	SECCOMP_IOR(2, __u64)
>  /* On success, the return value is the remote process's added fd number */
> -#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOR(3,	\
> +#define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3,	\
>  						struct seccomp_notif_addfd)
>  
>  #endif /* _UAPI_LINUX_SECCOMP_H */
> 
> -- 
> Kees Cook
Looks good. Thank you.
