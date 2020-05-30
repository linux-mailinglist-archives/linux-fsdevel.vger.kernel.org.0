Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F27E1E8DFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 07:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgE3FSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 01:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3FST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 01:18:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB1C08C5CA
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 22:18:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so2343738pjb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=71WmNwcuw4Xg/QtLiV/Z4mvkYZh8EUIAu1c6BBuire8=;
        b=TyhKxJ9tPifKoTHxSEagRVhqas7fM1MEeAgGrkhWHKPL9yUlvhsivNdPLRfR+JGK7f
         XOUDpIFZQOvGztv82Huvq2+ALoBMz40On9fOJ5YCB8jny1/2GEDnSU5T6eSPoCLEMHbU
         36LLyJIf1Pz2etYgvBl8VA698Qq5uuBcG+22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=71WmNwcuw4Xg/QtLiV/Z4mvkYZh8EUIAu1c6BBuire8=;
        b=C3rvJO9szjh3pim7oM1AuD2+I0FNWusLsHck22dtFOg2ekhs1QqkNoNDCxRTxpV0CJ
         Cjib15v/Tru1mah4SQuhTTKwE70uhehXVMjWuzTiekDr3Tpa0HlbFCMdO+JBheIaytBk
         AsBY9hubB4NJ7cdIIpP6h0PcOAE8fwXkwIDL8sEHTTm8zRKnMA4qenUiOKI5/Ge8DfqI
         Zyy6Qq/jgdeLmDcK4rUUfg4atOQvux0vAZGUVKm9DibZKadsmtARU2DTSyXPPYifZ3xq
         b4M1Yb+E1YyV1xmVHwu/uUsLW7saFgmkL/uBNahNIGyWcc8neooO4Q/Iu4238MEhf66s
         TvzQ==
X-Gm-Message-State: AOAM530dKLZRITxBV2H06g/IvIrXuOv1A+GmWNhz3yW9bjBo6g4k4PDE
        kEWL9830Oz5pMC2JyAbVHQwxnQ==
X-Google-Smtp-Source: ABdhPJxTSb0HViCDyY+Hvx1EPpZxOJ6QNl9ZqQS8q8BMh+oUpSpNP/TnYYqRKg5NgqGKFSmwR0Kzkw==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr12106962pll.281.1590815897391;
        Fri, 29 May 2020 22:18:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 62sm8474202pfe.93.2020.05.29.22.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:18:16 -0700 (PDT)
Date:   Fri, 29 May 2020 22:18:15 -0700
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
Subject: Re: [PATCH 2/2] exec: Compute file based creds only once
Message-ID: <202005292216.6D96F7D@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <871rn2r8m6.fsf_-_@x220.int.ebiederm.org>
 <202005291406.52E27AF8@keescook>
 <875zcenlsm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zcenlsm.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 10:28:41PM -0500, Eric W. Biederman wrote:
> The range-diff winds up being:
> 1:  c9258ef4879b ! 1:  a7868323c263 exec: Add a per bprm->file version of per_clear
>     @@ Commit message
>      
>          History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
>          Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
>     +    Reviewed-by: Kees Cook <keescook@chromium.org>
>          Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>      
>       ## fs/exec.c ##
>     @@ include/linux/lsm_hooks.h
>        *	transitions between security domains).
>        *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
>        *	request libc enable secure mode.
>     -+ *	The hook must set @bprm->pf_per_clear to the personality flags that
>     -+ *	should be cleared from current->personality.
>     ++ *	The hook must add to @bprm->pf_per_clear any personality flags that
>     ++ * 	should be cleared from current->personality.
>        *	@bprm contains the linux_binprm structure.
>        *	Return 0 if the hook is successful and permission is granted.
>        * @bprm_check_security:
> 2:  e6f20c69b96e ! 2:  56305aa9b6fa exec: Compute file based creds only once
>     @@ Commit message
>          secureity attribute and derive capabilities from the fact the
>          user had uid 0 has been added.
>      
>     +    Reviewed-by: Kees Cook <keescook@chromium.org>
>          Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>      
>       ## fs/binfmt_misc.c ##
>     @@ include/linux/lsm_hooks.h
>      + *	between security domains).
>      + *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
>        *	request libc enable secure mode.
>     -- *	The hook must set @bprm->pf_per_clear to the personality flags that
>     -+ *	The hook must set @bprm->per_clear to the personality flags that
>     -  *	should be cleared from current->personality.
>     +- *	The hook must add to @bprm->pf_per_clear any personality flags that
>     ++ *	The hook must add to @bprm->per_clear any personality flags that
>     +  * 	should be cleared from current->personality.
>        *	@bprm contains the linux_binprm structure.
>        *	Return 0 if the hook is successful and permission is granted.

Awesome; thanks!

> > The cap_ambient_invariant_ok() test is needlessly repeated: it doesn't
> > examine securebits, and nonroot_raised_pE appears to have no
> > side-effects.
> >
> > One of those can be dropped, yes?
> 
> That is what it looks like to me.

Okay, cool. I was worried I was missing something in the mess of tiny
helper calls. :)

> I hope that when the dust clears the function can become a
> straightforward implementation of the capability equations.
> We will see.

Yeah, this looks better and better every day! I'm glad you're able to
dig through all of this.

-- 
Kees Cook
