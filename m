Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1AB1D02E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 01:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgELXI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgELXI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 19:08:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC4C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 16:08:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y18so317780pfl.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jPUDzmB2RaJE7QxC+Esx131H9VCB1o/rpPVErIJAzJU=;
        b=aJ1pbMalItbAlYJJhzgzjRditf99BLgKT5bBvaX/wxrv2Egf5htQlaV8IS0drwDdL2
         kKzuKpfK7N2zwzVJb4CmKxatoFDZeT8D5E/BZhkUyPgfD8q67s3KYVFgJJUt26w7AtXn
         Kxyyz6+IR2xq2F4UCtqDh0TEH1Cnvaq8Hgi4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jPUDzmB2RaJE7QxC+Esx131H9VCB1o/rpPVErIJAzJU=;
        b=ckobMF2vGS7bNGAwqD/BmZAo4KEFLlObGZOS0GmA55m1G3KKj6V10VqsBdaCQ8mmBj
         rf/zTyWo79KPfkw8Yy3uHNcyYpvZ2YWeUpUCxvfWBa34cEE3UvUuXDlgNZzppdjUUXiq
         3ERZBa+yma1kdguPmj0TvJakrJ55cgZHGrLz19WbOk8PHJq12PpE/59LZsNEJixLYRmi
         8XQS+MxF0Q+qm2oRSWBt/YJ4oYuDEwh0k2wteTJHXJZiYqFfyRprLY5wgwMO4g/0BAF9
         Yw2CZ5x0PDRGucIIxv7IuhZysVSkP17wyjVbp797j5oTggUdEAf/IInAHME6EQzDa+UJ
         yDyQ==
X-Gm-Message-State: AGi0Pua1PrS3v+xTpJ2egyvaT4P4Ujz68uwpI5q5UZ3Aq0J+dfjEhjkT
        /BscKA/KzDg4D+XeVSbuDT8LOw==
X-Google-Smtp-Source: APiQypLLWAJW1HvgvZ0iqC9QnHJCwq3TvpniPdwZEBT4rt6mOv1kkAEUxE7vJtCl1JaHryixnIxWUg==
X-Received: by 2002:aa7:9ac9:: with SMTP id x9mr22349121pfp.304.1589324938284;
        Tue, 12 May 2020 16:08:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15sm1778377pgv.5.2020.05.12.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:08:57 -0700 (PDT)
Date:   Tue, 12 May 2020 16:08:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
Message-ID: <202005121606.5575978B@keescook>
References: <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
 <202005121218.ED0B728DA@keescook>
 <87lflwq4hu.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lflwq4hu.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 03:31:57PM -0500, Eric W. Biederman wrote:
> >> It is possible although unlikely for userspace to find the file
> >> descriptor without consulting AT_EXECFD so just to be conservative I
> >> think we should install the file descriptor in begin_new_exec even if
> >> the next interpreter does not support AT_EXECFD.
> >
> > I think universally installing the fd needs to be a distinct patch --
> > it's going to have a lot of consequences, IMO. We can certainly deal
> > with them, but I don't think it should be part of this clean-up series.
> 
> I meant generically installing the fd not universally installing it.
> 
> >> I am still working on how to handle recursive binfmts but I suspect it
> >> is just a matter of having an array of struct files in struct
> >> linux_binprm.
> >
> > If install is left if binfmt_misc, then the recursive problem goes away,
> > yes?
> 
> I don't think leaving the install in binfmt_misc is responsible at this
> point.

I'm nearly certain the answer is "yes", but I wonder if we should stop
for a moment and ask "does anything still use MISC_FMT_OPEN_BINARY ? It
looks like either "O" or "C" binfmt_misc registration flag. My installed
binfmts on Ubuntu don't use them...

I'm currently pulling a list of all the packages in Debian than depend
on the binfmt-support package and checking their flags.

-- 
Kees Cook
