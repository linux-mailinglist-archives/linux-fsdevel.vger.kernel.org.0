Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46481D5517
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEOPuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEOPuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:50:19 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1905C05BD0B
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:50:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so1012290plz.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=maNQlt0vCXUutQdGjL8vBhpeTRE+KVofJhs1eAnXh6g=;
        b=XbNk7MuQ57Rts4Z0qNTKjgNqv1OpA6t+Nc11jH0CcE5DjXS7oVuq2I56+d2MDC75jJ
         nDjDvlSzADQw/PQCIl8/DxXmgfrveGmE6Hw9eY461U1BxfLAfoewmC1zHAQ7NjHaBVwq
         48yzco9HijnVPOEH6uI2cCSke9LuzsUIGaAQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=maNQlt0vCXUutQdGjL8vBhpeTRE+KVofJhs1eAnXh6g=;
        b=nkHvu3tRYRMiIkxQPP6ut8Pzwmiq8fn/L3KOJDmBChB9QPWmbsQB4upCOvxcipdbpY
         LipNjL9F5Vj0x58T1ZkTnHfRYiFAJ6I68cOP7Dbh9uEzx7fGNrvwPS9Crl1tR/YOZ8Py
         DTjgxyzy2wvuPd2LiByruCYQ/16NqLvZ59hfHg80S3/c3fY9MklAGkRWjAGvZnd5omIf
         wEJLV+BDanNbqgO2EgRQ6oq9Oye/qex3RmEfD3ssNu8J1bZnXCyqKyhd6KJ53uAR/Js3
         jK2pX7hisf7fNzxElhp7rRwe9wkiwCJJfaGGk3u7I+Sdn11BD52BJhjq3rJW+0R8O108
         VpJQ==
X-Gm-Message-State: AOAM531JmEFO69rtYNRoLWUeHo3tdvwcNhNb4BcGBfC30Z8bTJzk/L/b
        HTnUvWpqXi8JLy5TdwS8PyjAZw==
X-Google-Smtp-Source: ABdhPJzV9V5xkT+PRgcjtkcfzF74hfXgdSbJTDs6Pij7aSIOh0B9fva/6CPrsQhWRfBllA/W9iJm5Q==
X-Received: by 2002:a17:90a:5584:: with SMTP id c4mr459126pji.51.1589557818127;
        Fri, 15 May 2020 08:50:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b24sm2247218pfi.4.2020.05.15.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:50:17 -0700 (PDT)
Date:   Fri, 15 May 2020 08:50:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to
 enforce noexec mounts or file exec through O_MAYEXEC)
Message-ID: <202005150847.2B1ED8F81@keescook>
References: <202005131525.D08BFB3@keescook>
 <202005132002.91B8B63@keescook>
 <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
 <202005140830.2475344F86@keescook>
 <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
 <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
 <202005142343.D580850@keescook>
 <87a729wpu1.fsf@oldenburg2.str.redhat.com>
 <202005150732.17C5EE0@keescook>
 <87r1vluuli.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1vluuli.fsf@oldenburg2.str.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 04:43:37PM +0200, Florian Weimer wrote:
> * Kees Cook:
> 
> > On Fri, May 15, 2020 at 10:43:34AM +0200, Florian Weimer wrote:
> >> * Kees Cook:
> >> 
> >> > Maybe I've missed some earlier discussion that ruled this out, but I
> >> > couldn't find it: let's just add O_EXEC and be done with it. It actually
> >> > makes the execve() path more like openat2() and is much cleaner after
> >> > a little refactoring. Here are the results, though I haven't emailed it
> >> > yet since I still want to do some more testing:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
> >> 
> >> I think POSIX specifies O_EXEC in such a way that it does not confer
> >> read permissions.  This seems incompatible with what we are trying to
> >> achieve here.
> >
> > I was trying to retain this behavior, since we already make this
> > distinction between execve() and uselib() with the MAY_* flags:
> >
> > execve():
> >         struct open_flags open_exec_flags = {
> >                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> >                 .acc_mode = MAY_EXEC,
> >
> > uselib():
> >         static const struct open_flags uselib_flags = {
> >                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
> >                 .acc_mode = MAY_READ | MAY_EXEC,
> >
> > I tried to retain this in my proposal, in the O_EXEC does not imply
> > MAY_READ:
> 
> That doesn't quite parse for me, sorry.
> 
> The point is that the script interpreter actually needs to *read* those
> files in order to execute them.

I think I misunderstood what you meant (Mickaël got me sorted out
now). If O_EXEC is already meant to be "EXEC and _not_ READ nor WRITE",
then yes, this new flag can't be O_EXEC. I was reading the glibc
documentation (which treats it as a permission bit flag, not POSIX,
which treats it as a complete mode description).

-- 
Kees Cook
