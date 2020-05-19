Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0BC1DA362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESVR2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESVR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 17:17:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C44C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 14:17:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so420029pgm.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cz7ypDwiQcY75biLKEJQMmwCg/gVg2A/D/by2yCpR7U=;
        b=hpwirQ0Xs1SorucIF2v9uRq9u46loiYGcq4NK3JplwhSqVwyhavNf0YBGEMwX0Bma4
         0qiabCHNEWCuGkSTjRhFXEwKkHxrDYGRFoHjGzsfnqLEIv9+DK/ZHc5YRuhfY23dKBN2
         AHQMsFVocsK8Gz4nmxoV8PjJo6Hfj0jub8qS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cz7ypDwiQcY75biLKEJQMmwCg/gVg2A/D/by2yCpR7U=;
        b=XLT1wMspTK23qkWpTJ54AnHRpG/4x+xV8/EAlubltQGqDC3DCqE/RFK6vDZwenlaIZ
         WtUt5XhaTIMtW5SDRtILqKLJWmTXgIDiUaoNiWfozRVCXG0PWZ8yYEuwgUO5a9KEFvKP
         DXq8soKA0b77sfDG7B4ry6882hqVoUJ84fFaPkHQ6YyBSajFqYUyAXlsBE+lUHLtq70b
         01MnQd+qgFOTS/5iGuLmQmTlT/gN40sqYT8z+r4LzKifm9eG7pfq4Ks6sMaMo36cqBWo
         N5vw/UUJTewxUVMJDdN5FUaUg8d1syMwQSSnr3GZJRdjqXogr36/AYaHdxSvcY9+I4JF
         tGaQ==
X-Gm-Message-State: AOAM533hGLpz9MFuKoI6MZZDvNsoiLvtkBWTFDkJHTePE3kN73onmqDs
        jA3wBuoSGzn5KEcSpt0GQRIkkA==
X-Google-Smtp-Source: ABdhPJxbEob6J6f6hJy0GeqN5fD4zEgoeNcFb9XU7fUpXsQJwNl9Ou6crVqMvKvg1aajIHr6QDJ0Ww==
X-Received: by 2002:a62:7c94:: with SMTP id x142mr1036481pfc.155.1589923044367;
        Tue, 19 May 2020 14:17:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p62sm334352pfb.93.2020.05.19.14.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:17:23 -0700 (PDT)
Date:   Tue, 19 May 2020 14:17:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 0/4] Relocate execve() sanity checks
Message-ID: <202005191342.97EE972E3@keescook>
References: <20200518055457.12302-1-keescook@chromium.org>
 <87a724t153.fsf@x220.int.ebiederm.org>
 <202005190918.D2BD83F7C@keescook>
 <87o8qjstyw.fsf@x220.int.ebiederm.org>
 <202005191052.0A6B1D5843@keescook>
 <87sgfvrckr.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgfvrckr.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 01:42:28PM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, May 19, 2020 at 12:41:27PM -0500, Eric W. Biederman wrote:
> >> Kees Cook <keescook@chromium.org> writes:
> >> > and given the LSM hooks, I think the noexec check is too late as well.
> >> > (This is especially true for the coming O_MAYEXEC series, which will
> >> > absolutely need those tests earlier as well[1] -- the permission checking
> >> > is then in the correct place: during open, not exec.) I think the only
> >> > question is about leaving the redundant checks in fs/exec.c, which I
> >> > think are a cheap way to retain a sense of robustness.
> >> 
> >> The trouble is when someone passes through changes one of the permission
> >> checks for whatever reason (misses that they are duplicated in another
> >> location) and things then fail in some very unexpected way.
> >
> > Do you think this series should drop the "late" checks in fs/exec.c?
> > Honestly, the largest motivation for me to move the checks earlier as
> > I've done is so that other things besides execve() can use FMODE_EXEC
> > during open() and receive the same sanity-checking as execve() (i.e the
> > O_MAYEXEC series -- the details are still under discussion but this
> > cleanup will be needed regardless).
> 
> I think this series should drop the "late" checks in fs/exec.c  It feels
> less error prone, and it feels like that would transform this into
> something Linus would be eager to merge because series becomes a cleanup
> that reduces line count.

Yeah, that was my initial sense too. I just started to get nervous about
removing the long-standing exec sanity checks. ;)

> I haven't been inside of open recently enough to remember if the
> location you are putting the check fundamentally makes sense.  But the
> O_MAYEXEC bits make a pretty strong case that something of the sort
> needs to happen.

Right. I *think* it's correct place for now, based on my understanding
of the call graph (which is why I included it in the commit logs).

> I took a quick look but I can not see clearly where path_noexec
> and the regular file tests should go.
> 
> I do see that you have code duplication with faccessat which suggests
> that you haven't put the checks in the right place.

Yeah, I have notes on the similar call sites (which I concluded, perhaps
wrongly) to ignore:

do_faccessat()
    user_path_at(dfd, filename, lookup_flags, &path);
    if (acc_mode & MAY_EXEC .... path_noexec()
    inode_permission(inode, mode | MAY_ACCESS);

This appears to be strictly advisory, and the path_noexec() test is
there to, perhaps, avoid surprises when doing access() then fexecve()?
I would note, however, that that path-based LSMs appear to have no hook
in this call graph at all. I was expecting a call like:

	security_file_permission(..., mode | MAY_ACCESS)

but I couldn't find one (or anything like it), so only
inode_permission() is being tested (which means also the existing
execve() late tests are missed, and the newly added S_ISREG() test from
do_dentry_open() is missed).


prctl_set_mm_exe_file()
    err = -EACCESS;
    if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
        goto exit;
    err = inode_permission(inode, MAY_EXEC);

This is similar (no path-based LSM hooks present, only inode_permission()
used for permission checking), but it is at least gated by CAP_SYS_ADMIN.


And this bring me to a related question from my review: does
dentry_open() intentionally bypass security_inode_permission()? I.e. it
calls vfs_open() not do_open():

openat2(dfd, char * filename, open_how)
    build_open_flags(open_how, open_flags)
    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
                may_open(path, acc_mode, open_flag)
                    inode_permission(inode, MAY_OPEN | acc_mode)
                        security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
                        if (unlikely(f->f_flags & FMODE_EXEC && !S_ISREG(inode->i_mode))) ...
                        security_file_open(f)
                                /* path-based LSMs check for open here
				 * and use FMODE_* flags to determine how a file
                                 * is being opened. */
                        open()

vs

dentry_open(path, flags, cred)
        f = alloc_empty_file(flags, cred);
        vfs_open(path, f);

I would expect dentry_open() to mostly duplicate a bunch of
path_openat(), but it lacks the may_open() call, etc.

I really got the feeling that there was some new conceptual split needed
inside do_open() where the nameidata details have been finished, after
we've gained the "file" information, but before we've lost the "path"
information. For example, may_open(path, ...) has no sense of "file",
though it does do the inode_permission() call.

Note also that may_open() is used in do_tmpfile() too, and has a comment
implying it needs to be checking only a subset of the path details. So
I'm not sure how to split things up.

So, that's why I put the new checks just before the may_open() call in
do_open(): it's the most central, positions itself correctly for dealing
with O_MAYEXEC, and doesn't appear to make any existing paths worse.

> I am wondering if we need something distinct to request the type of the
> file being opened versus execute permissions.

Well, this is why I wanted to centralize it -- the knowledge of how a
file is going to be used needs to be tested both by the core VFS
(S_ISREG, path_noexec) and the LSMs. Things were inconsistent before.

> All I know is being careful and putting the tests in a good logical
> place makes the code more maintainable, whereas not being careful
> results in all kinds of sharp corners that might be exploitable.
> So I think it is worth digging in and figuring out where those checks
> should live.  Especially so that code like faccessat does not need
> to duplicate them.

I think this is the right place with respect to execve(), though I think
there are other cases that could use to be improved (or at least made
more consistent).

-Kees

-- 
Kees Cook
