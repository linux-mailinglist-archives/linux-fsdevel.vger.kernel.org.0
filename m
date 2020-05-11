Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726E31CE7CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgEKVzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgEKVzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:55:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A596C05BD09
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:55:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so5359247pfn.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N2k3VluFVmqb0Md48Vp4lnUitQu5LwJqg2jgZWuBL9c=;
        b=JEzt9vSq/OK6SQi7DpkzAtwK38cH/0tMbEx2UaeIBcMAouECDmTJVeSPnA0bBKE+Ck
         F8zI0p1T1rt+EGdoMyVb7LnCDsLEuCQzbdVJXI3sOwN3+ZYFFLYPmtHKe6xkbZVsHgYq
         hmdaAdjKvcW39mx29cCbIMwsMM/z1+9FimibY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N2k3VluFVmqb0Md48Vp4lnUitQu5LwJqg2jgZWuBL9c=;
        b=QLVN8cTdP2JuiV6mkHd2WUvl441LCh0q5+vX+0WF7WqU4UPRTjPPdYcaX0jlv8yXBj
         lmqjfQ0N8ATRh+T/jO/cwin6ND3C9A+Tz+3EYv44lzbtseb8ulnUBEX4ej+gMYkSIbcH
         /3c4Ah+7NcRTHR+YPB0tuhSl6kaXQwzDzONoRY13w4WWMvUXkjuF5eN+rr3JCmX/Sc4f
         0f1tZ1spm8W+WwuosLP9ipbpb4gSAfhUygsVaUlCWp35LV0RKc5b+Ypn1eIx/XmrRmk2
         8F5+Oi2ZfXeS5VjKdaPdMr5LPDnvJdNNmlctEl+88JZG+voZxuuS07Qdh/CRFGbgqW9+
         XFpA==
X-Gm-Message-State: AGi0PubOiBbPLmgFUsHWQhEkCQt2zV0JVwQgqJGo9bM6H8uhaOoA8r83
        JOJujx9a1fI9rTh27bDO8XfGdA==
X-Google-Smtp-Source: APiQypKEU8uN11yf9TYnC1AEFHrcRWAEoANjLMpB+C7dngKCeCborR02BBGhCXD93tuGZL6Mn0zQIA==
X-Received: by 2002:a63:6d86:: with SMTP id i128mr9934914pgc.432.1589234129533;
        Mon, 11 May 2020 14:55:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j35sm8731698pgl.74.2020.05.11.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:55:28 -0700 (PDT)
Date:   Mon, 11 May 2020 14:55:27 -0700
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
Message-ID: <202005111428.B094E3B76A@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgg6v8we.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 09:33:21AM -0500, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> Wouldn't this change cause
> >>
> >>         if (fd_binary > 0)
> >>                 ksys_close(fd_binary);
> >>         bprm->interp_flags = 0;
> >>         bprm->interp_data = 0;
> >>
> >> not to be called when "Search for the interpreter" failed?
> >
> > Good catch. We seem to have some subtle magic wrt the fd_binary file
> > descriptor, which depends on the recursive behavior.
> 
> Yes.  I Tetsuo I really appreciate you noticing this.  This is exactly
> the kind of behavior I am trying to flush out and keep from being
> hidden.
> 
> > I'm not seeing how to fix it cleanly with the "turn it into a loop".
> > Basically, that binfmt_misc use-case isn't really a tail-call.
> 
> I have reservations about installing a new file descriptor before
> we process the close on exec logic and the related security modules
> closing file descriptors that your new credentials no longer give
> you access to logic.

Hm, this does feel odd. In looking at this, it seems like this file
never gets close-on-exec set, and doesn't have its flags changed from
its original open:
                .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
only the UMH path through exec doesn't explicitly open a file by name
from what I can see, so we'll only have these flags.

> I haven't yet figured out how opening a file descriptor during exec
> should fit into all of that.
> 
> What I do see is that interp_data is just a parameter that is smuggled
> into the call of search binary handler.  And the next binary handler
> needs to be binfmt_elf for it to make much sense, as only binfmt_elf
> (and binfmt_elf_fdpic) deals with BINPRM_FLAGS_EXECFD.
> 
> So I think what needs to happen is to rename bprm->interp_data to
> bprm->execfd, remove BINPRM_FLAGS_EXECFD and make closing that file
> descriptor free_bprm's responsiblity.

Yeah, I would agree. As far as the close handling, I don't think there
is a difference here: it interp_data was closed on the binfmt_misc.c
error path, and in the new world it would be the exec error path -- both
would be under the original credentials.

> I hope such a change will make it easier to see all of the pieces that
> are intereacting during exec.

Right -- I'm not sure which piece should "consume" bprm->execfd though,
which I think is what you're asking next...

> I am still asking: is the installation of that file descriptor useful if
> it is not exported passed to userspace as an AT_EXECFD note?
> 
> I will dig in and see what I can come up with.

Should binfmt_misc do the install, or can the consuming binfmt do it?
i.e. when binfmt_elf sees bprm->execfd, does it perform the install
instead?

-- 
Kees Cook
