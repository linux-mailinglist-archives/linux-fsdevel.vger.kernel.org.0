Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1C1CFE3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 21:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgELTZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 15:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbgELTZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 15:25:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98033C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:25:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so9883185pjt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zuvKbkxXexDFgEr1pGnuiyt05zDdT11JeOxs67G6etM=;
        b=QrgzGmWQtElD5mjDu3W8wIpwV1hy6zO5D4IGwwOsKgvGqbaM7TGjkewco9AYTSGXlv
         dWsAVSyFtoNXZ/+C554O1raxb4PYKxPNEq4eBRLvewfg2sLpL6VawYdI7rYRn9aSZHkd
         3QqRZuo0mp94NP4bIrrxWUWlYjP41OnHwnU2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zuvKbkxXexDFgEr1pGnuiyt05zDdT11JeOxs67G6etM=;
        b=hEHXoearuJ8kYkiAxIAtwunsAmltDm64HHf1VbJhghoh6W1l6kkXzYa5EnzQkQ2fYO
         oCuaR49s2fToMzTBtHcZbdJJI4SjcZ5qi8Ovnv0d9T6gPipjYylmnRFLKzl/eCDrYK+X
         m16wSJNyuuQHGJ3Nq4mL0D+b9sS3b0PvO2QFT2pAJoyWP1l6RwA35DF66kIhrO388HGS
         K+wtzEgyDZssLUy18lyBiafcYCYQvzFNfYsMLos3CBTxMO54CF18djfrhD5C+MmhZoBV
         a8eaE4KhdleWltMQkWuQb6bm23hxuBj7ivYGmps5aYUg3BvWewM9s5fT2wd47Lg4C3UJ
         3feQ==
X-Gm-Message-State: AGi0PubGnb0XsxYIpHazw6REzqQbDvMbl/v4+l2JYefq/M+P5b9jTYHd
        doenkHtuVhfc3nUSIwoJEQTKCw==
X-Google-Smtp-Source: APiQypLJuiWQRFv5kofh3l2xnXnOJoCBvEnuis0K48GEmJut0JZfFKUjUksikIwYvKq/qZ8mSMhu+g==
X-Received: by 2002:a17:902:103:: with SMTP id 3mr21731839plb.325.1589311526054;
        Tue, 12 May 2020 12:25:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm12789369pfo.27.2020.05.12.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:25:25 -0700 (PDT)
Date:   Tue, 12 May 2020 12:25:24 -0700
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
Message-ID: <202005121218.ED0B728DA@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kslq9jm.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 01:42:53PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > Should binfmt_misc do the install, or can the consuming binfmt do it?
> > i.e. when binfmt_elf sees bprm->execfd, does it perform the install
> > instead?
> 
> I am still thinking about this one, but here is where I am at.  At a
> practical level passing the file descriptor of the script to interpreter
> seems like something we should encourage in the long term.  It removes
> races and it is cheaper because then the interpreter does not have to
> turn around and open the script itself.

Yeah, this does sounds pretty good, though I have concerns about doing
it for a process that isn't expecting it. I've seen a lot of bad code
make assumptions about initial fd numbers. :(

> Strictly speaking binfmt_misc should not need to close the file
> descriptor in binfmt_misc because we have already unshared the files
> struct and reset_files_struct should handle restoring it.

If I get what you mean, I agree. The error case is fine.

> Calling fd_install in binfmt_misc still seems wrong, as that exposes
> the new file descriptor to user space with the old creds.

I haven't dug into the details here -- is there a real risk here? The
old creds are what opened the file originally for the exec. Are you
thinking about executable-but-not-readable files?

> It is possible although unlikely for userspace to find the file
> descriptor without consulting AT_EXECFD so just to be conservative I
> think we should install the file descriptor in begin_new_exec even if
> the next interpreter does not support AT_EXECFD.

I think universally installing the fd needs to be a distinct patch --
it's going to have a lot of consequences, IMO. We can certainly deal
with them, but I don't think it should be part of this clean-up series.

> I am still working on how to handle recursive binfmts but I suspect it
> is just a matter of having an array of struct files in struct
> linux_binprm.

If install is left if binfmt_misc, then the recursive problem goes away,
yes?

-- 
Kees Cook
