Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55A933C85E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 22:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhCOVSY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 17:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhCOVRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:17:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE0C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 14:17:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x21so6094056pfa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DUr1k/Qqz3KWpr5/8/e77iHdLKltma+5t29fYrAFmQI=;
        b=S553Mer1ETZUkhiNw0TxP5F993tA5VUjS+Vs4i5CNKcVdsS+ZX8cjrpH1oDdz/Gmw3
         B9ORHP/ddVU/rNUG1cgUaKcWOUZjqDmV5Gwv8vfeh8B+yp+HzweHQYOASbX99+DYehsh
         Gcu+78Pp2kGUbKVUk6kLIGAcFw+5FMtDNb29Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DUr1k/Qqz3KWpr5/8/e77iHdLKltma+5t29fYrAFmQI=;
        b=D1zXeyAioDWQsXN7sEfMEfVwTiZQqh5Eql4NqDhHvCRiIlGlOT7qwsuGDKGthFGB8j
         afuZG9wt5+Dv6Y70tyHm8AzQXNx4+9Q/lwX6C4eqvIWEq7haO7uehFXoSyswT9xaxK8u
         xEENdVmO5G+IhB3rho5bVEltCh2Qze4D9v91lhLTuRgBl2m3CeWiUxP/x2rHhgoNFe1z
         cGQDRtT/n6wsnwV4DGnQjlKGv4zvgb+2c/lLmc8MmL7ripxBMuYdEIAf4EsOk4ueXGgV
         p3CfsEzLdPStqGFAhKHkK8ngMa26uzyBuOGbm/HB2Vkfh3x9WlGRag9TvH/z79weFYR2
         tLOw==
X-Gm-Message-State: AOAM533DKiL6UAa/Lzzz8zgwdXNKHz9FYwZmZDqm2yf8VhnHC7sLo6Kg
        zfVOootaCTdj9jUQWU5GriI1AA==
X-Google-Smtp-Source: ABdhPJzVe9wuhksN6TsIoHM9voPzo7YtxqoGcB/vIz5wE0tBTLM3puqaLRphxT+4OBrEKzYPy1aFvA==
X-Received: by 2002:a63:2318:: with SMTP id j24mr947180pgj.134.1615843070334;
        Mon, 15 Mar 2021 14:17:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gt22sm526616pjb.35.2021.03.15.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 14:17:49 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:17:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v3 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Message-ID: <202103151405.88334370F@keescook>
References: <20210311105242.874506-1-mic@digikod.net>
 <20210311105242.874506-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311105242.874506-2-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 11:52:42AM +0100, Mickaël Salaün wrote:
> [...]
> This change may not impact systems relying on other permission models
> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
> such systems may require to update their security policies.
> 
> Only the chroot system call is relaxed with this no_new_privs check; the
> init_chroot() helper doesn't require such change.
> 
> Allowing unprivileged users to use chroot(2) is one of the initial
> objectives of no_new_privs:
> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
> This patch is a follow-up of a previous one sent by Andy Lutomirski:
> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/

I liked it back when Andy first suggested it, and I still like it now.
:) I'm curious, do you have a specific user in mind for this feature?

> [...]
> @@ -546,8 +547,18 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>  	if (error)
>  		goto dput_and_out;
>  
> +	/*
> +	 * Changing the root directory for the calling task (and its future
> +	 * children) requires that this task has CAP_SYS_CHROOT in its
> +	 * namespace, or be running with no_new_privs and not sharing its
> +	 * fs_struct and not escaping its current root (cf. create_user_ns()).
> +	 * As for seccomp, checking no_new_privs avoids scenarios where
> +	 * unprivileged tasks can affect the behavior of privileged children.
> +	 */
>  	error = -EPERM;
> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
> +	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> +			!(task_no_new_privs(current) && current->fs->users == 1
> +				&& !current_chrooted()))
>  		goto dput_and_out;
>  	error = security_path_chroot(&path);
>  	if (error)

I think the logic here needs to be rearranged to avoid setting
PF_SUPERPRIV, and I find the many negations hard to read. Perhaps:

static inline int current_chroot_allowed(void)
{
	/* comment here */
	if (task_no_new_privs(current) && current->fs->users == 1 &&
	    !current_chrooted())
		return 0;

	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
		return 0;

	return -EPERM;
}

...

	error = current_chroot_allowed();
	if (error)
		goto dput_and_out;


I can't think of a way to race current->fs->users ...

-- 
Kees Cook
