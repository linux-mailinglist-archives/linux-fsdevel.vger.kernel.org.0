Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44E1DC09A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgETUxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgETUxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 16:53:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBEC05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 13:53:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so850747plv.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fja1DANsh1Dd+F7/qBgWbRzdM+vuuOGWY8oeqn+8/aU=;
        b=aPbnHWV+DrbPPSsrBqaBDyyFjXZ0cF7oE0GCeKbrs+bc/z3niL1RWVkhjjlu4L3KaM
         95/x7L+8CS4PeocMrSQ6ORl5nsdI7xeCqNPcJ9rkVL6s3c59wsIqQBw0/IjaxlvRkB9i
         je9S68nV1hWzhPKREBxg3/ry9g/27wIsqgwts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fja1DANsh1Dd+F7/qBgWbRzdM+vuuOGWY8oeqn+8/aU=;
        b=B1MaxopsElk7vqkFQ4OsNv3NOFiwhCURSu5PXM3gbOkRf9eeaawPiNUKt//FrPcCSe
         3QHHgjMIUpb+yh+eIqobpjNuH7tl01A5r1lx/cIkUquh9X4up9bDWLReqgrCaPQzqOhJ
         MqfGwtRG8SfhQxpZZRc00vVxRE6a3rgRKK1YRMjpxb6+M3vCkSKcM12P5W96y03sEqR5
         uXSpbFGUydXUEeS4MeGO3trb5xhePt95TkUkQNouAsR0qHb1sGWGnptzYbMuJEjbDH+R
         bejpZJGR3oME0e682NSV99TGVWk7IfNFzg7IHyZR4cHmAqDT9BlTHRyMqjzahxp1MaKr
         HJLw==
X-Gm-Message-State: AOAM532qanFf7PILZL5CBnxZ10jkqToMJOnuPrzYvw2HSFxTq+uPb5L1
        q5CLz2tZ2W4A54Gzbeo+snq/OQ==
X-Google-Smtp-Source: ABdhPJxh3ms0KdO5Xo719QvxDHhSD6ey31fVUe6JmpxdSjo/5/PhFLNfx/A+SVUMZLqTFGj256i4Hg==
X-Received: by 2002:a17:902:7c81:: with SMTP id y1mr6573886pll.236.1590008000758;
        Wed, 20 May 2020 13:53:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n10sm2902329pfd.192.2020.05.20.13.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 13:53:19 -0700 (PDT)
Date:   Wed, 20 May 2020 13:53:18 -0700
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
Subject: Re: [PATCH v2 3/8] exec: Convert security_bprm_set_creds into
 security_bprm_repopulate_creds
Message-ID: <202005201353.6D3B1FD0BF@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
 <202005191111.9B389D33@keescook>
 <875zcrpx1g.fsf@x220.int.ebiederm.org>
 <202005191211.97BCF9DA@keescook>
 <87wo56gxv5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo56gxv5.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 03:22:38PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, May 19, 2020 at 02:03:23PM -0500, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> 
> >> > On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
> >> >> [...]
> >> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> >> >> index d1217fcdedea..8605ab4a0f89 100644
> >> >> --- a/include/linux/binfmts.h
> >> >> +++ b/include/linux/binfmts.h
> >> >> @@ -27,10 +27,10 @@ struct linux_binprm {
> >> >>  	unsigned long argmin; /* rlimit marker for copy_strings() */
> >> >>  	unsigned int
> >> >>  		/*
> >> >> -		 * True if most recent call to cap_bprm_set_creds
> >> >> +		 * True if most recent call to security_bprm_set_creds
> >> >>  		 * resulted in elevated privileges.
> >> >>  		 */
> >> >> -		cap_elevated:1,
> >> >> +		active_secureexec:1,
> >> >
> >> > Also, I'd like it if this comment could be made more verbose as well, for
> >> > anyone trying to understand the binfmt execution flow for the first time.
> >> > Perhaps:
> >> >
> >> > 		/*
> >> > 		 * Must be set True during the any call to
> >> > 		 * bprm_set_creds hook where the execution would
> >> > 		 * reuslt in elevated privileges. (The hook can be
> >> > 		 * called multiple times during nested interpreter
> >> > 		 * resolution across binfmt_script, binfmt_misc, etc).
> >> > 		 */
> >> Well it is not during but after the call that it becomes true.
> >> I think most recent covers the case of multiple calls.
> >
> > I'm thinking of an LSM writing reading these comments to decide what
> > they need to do to the flags, so it's a direction to them to set it to
> > true if they have determined that privilege was gained. (Though in
> > theory, this is all moot since only the commoncap hook cares.)
> 
> The comments for an LSM writer are in include/linux/lsm_hooks.h
> 
>  * @bprm_repopulate_creds:
>  *	Assuming that the relevant bits of @bprm->cred->security have been
>  *	previously set, examine @bprm->file and regenerate them.  This is
>  *	so that the credentials derived from the interpreter the code is
>  *	actually going to run are used rather than credentials derived
>  *	from a script.  This done because the interpreter binary needs to
>  *	reopen script, and may end up opening something completely different.
>  *	This hook may also optionally check permissions (e.g. for
>  *	transitions between security domains).
>  *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
>  *	request libc enable secure mode.
>  *	@bprm contains the linux_binprm structure.
>  *	Return 0 if the hook is successful and permission is granted.
> 
> I hope that is detailed enough.
> 
> I will leave the rest of the comments for the maintainer of the code.
> 
> I really don't think we should duplicate the prescriptive comments in
> multiple locations.

Okay, that's fair enough. Thanks!

-- 
Kees Cook
