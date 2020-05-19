Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12961DA0C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 21:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgESTOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESTOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 15:14:42 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93702C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:14:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n18so357809pfa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 12:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hzUIWpf2COJGu10K9zNA4alrQYEQDf2ZxnZ+vLrtLOs=;
        b=J2dvXZG++NKRPJGTT7H8hZxKOiRbCEO0NPkYH8e/WSip7ia/fghW2ryML++SjOJivD
         3w4qWG541m3+I4jObP3wmuFMPB6X5nmJME2bH+SHtK8tKuI0yUnXdUfBJUsLrs/srBs5
         1T83uq+SrW/TDwqo2A0Q+jIRCayxBiQhfcJ0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hzUIWpf2COJGu10K9zNA4alrQYEQDf2ZxnZ+vLrtLOs=;
        b=awUvp5vpUM5HXKQM00erAr05u7T0K55TTQMHGQLf6m7/Sk0WsdTze7ux2XOh6XO4ot
         GmUdxkJbEFtJ1dh6nTVP+lT7uxOfHp24WJa23MZG5NlKHoR8yYtNxZMjO129KM0zZm50
         9mR/K1KQdk0T3Ieuq9rJ6oTRo4VhotU1uZHzj4TnZg3vmXUolhdyfsjYie0wbcbTqfgY
         evozEUnwi6YpmxZMZvAlrgyMXNX8tjrQv23TojFgCZxstXbv09XB6ZEcrwVt+FX/kKJU
         BApji4pyQ5gQAUbVKNaY9xgE0h5kITCD9pivGYimy00lp1wwsyHcnbNIWT/sXWQuuqDM
         gZ5g==
X-Gm-Message-State: AOAM530jvZmcuYWLhMv5mCoPEG8u4+Ng9r1iSPdxMc01NvrtjbW9x3Ky
        4a1kHZZ1eaNUvKWmPAhM2BlREQ==
X-Google-Smtp-Source: ABdhPJwti/qBt30q0tzc1ytgag0FAtjpL1Zx0HGmxi2XXuFmfXwbUXXIhiOcrt59HkCR+E7SMGiUSA==
X-Received: by 2002:a63:546:: with SMTP id 67mr704972pgf.364.1589915682040;
        Tue, 19 May 2020 12:14:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3sm261612pjs.17.2020.05.19.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:14:41 -0700 (PDT)
Date:   Tue, 19 May 2020 12:14:40 -0700
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
Message-ID: <202005191211.97BCF9DA@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87o8qkzrxp.fsf_-_@x220.int.ebiederm.org>
 <202005191111.9B389D33@keescook>
 <875zcrpx1g.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zcrpx1g.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 02:03:23PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Mon, May 18, 2020 at 07:31:14PM -0500, Eric W. Biederman wrote:
> >> [...]
> >> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> >> index d1217fcdedea..8605ab4a0f89 100644
> >> --- a/include/linux/binfmts.h
> >> +++ b/include/linux/binfmts.h
> >> @@ -27,10 +27,10 @@ struct linux_binprm {
> >>  	unsigned long argmin; /* rlimit marker for copy_strings() */
> >>  	unsigned int
> >>  		/*
> >> -		 * True if most recent call to cap_bprm_set_creds
> >> +		 * True if most recent call to security_bprm_set_creds
> >>  		 * resulted in elevated privileges.
> >>  		 */
> >> -		cap_elevated:1,
> >> +		active_secureexec:1,
> >
> > Also, I'd like it if this comment could be made more verbose as well, for
> > anyone trying to understand the binfmt execution flow for the first time.
> > Perhaps:
> >
> > 		/*
> > 		 * Must be set True during the any call to
> > 		 * bprm_set_creds hook where the execution would
> > 		 * reuslt in elevated privileges. (The hook can be
> > 		 * called multiple times during nested interpreter
> > 		 * resolution across binfmt_script, binfmt_misc, etc).
> > 		 */
> Well it is not during but after the call that it becomes true.
> I think most recent covers the case of multiple calls.

I'm thinking of an LSM writing reading these comments to decide what
they need to do to the flags, so it's a direction to them to set it to
true if they have determined that privilege was gained. (Though in
theory, this is all moot since only the commoncap hook cares.)

> I think having the loop explicitly in the code a few patches
> later makes it clear that there is a loop dealing with interpreters.
> 
> Conciseness has a virtue in that it is easy to absorb.  Seeing
> active says most recent and secureexec does not is enough to ask
> questions and look at the code.

I still think a hint about the nature of nested exec resolution would be
nice in here somewhere, especially given that this value is zeroed
before each call to the hook.

-- 
Kees Cook
