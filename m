Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439BB75FBBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 18:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGXQTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 12:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGXQTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9510C0;
        Mon, 24 Jul 2023 09:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12EBA61261;
        Mon, 24 Jul 2023 16:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7C5C433AB;
        Mon, 24 Jul 2023 16:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215556;
        bh=XulCW8PqNzM2OcCLzoR0BPCAAPz4heIcLDtvDb4iijU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clo6IWPO0JOhlr3CJweqW0ep4zhh9FdhFu1dcFMFSCVSvcGh++TubcqsFQWZZSXru
         FFrceWEcCQIHrZBFHoTzUvtBM44EGFZEVod1sqqUt98oLc7WR7EF6N+9/1DuGihBNF
         KsNeS+Bj3t9Te+KqW5ryacgVgsnp0g23oYYGvs9B5YsrmMbpcU3ATylR26XKcIjbWO
         dLJvoxhsCqz06EK9heCMVlCLd66Kffvd7pD+mSt8BVzLzFId9W70aZD5A4LjFbTLJS
         FkT4sHHOBbJhDHmDn5WW3I1EOL2AGfycDx11YoV4LCk9c1k8hz6WKmBlKLIqj90DuV
         mpyLhrylcQ4Pw==
Date:   Mon, 24 Jul 2023 18:19:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230724-scheren-absegnen-8c807c760ba1@brauner>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:53:32AM -0700, Linus Torvalds wrote:
> So this was a case of "too much explanations make the explanation much
> harder to follow".
> 
> I tend to enjoy your pull request explanations, but this one was just
> *way* too much.
> 
> Please try to make the point you are making a bit more salient, so
> that it's a lot easier to follow.

Sure. The thing is though that I'm not doing this because it's fun to
write a lot of text. It's simply because I want to remember how I
arrived at that conclusion. I can keep this shorter for sure. The
problem is often just what can I assume the reader knows and what they
don't.

> 
> On Mon, 24 Jul 2023 at 08:01, Christian Brauner <brauner@kernel.org> wrote:
> >
> >     [..] the
> > file_count(file) greater than one optimization was already broken and
> > that concurrent read/write/getdents/seek calls are possible in the
> > regular system call api.
> >
> > The pidfd_getfd() system call allows a caller with ptrace_may_access()
> > abilities on another process to steal a file descriptor from this
> > process.
> 
> I think the above is all you need to actually explain the problem and
> boil down the cause of the bug, and it means that the reader doesn't
> have to wade through a lot of other verbiage to figure it out.
> 
> >         if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
> > -               if (file_count(file) > 1) {
> > -                       v |= FDPUT_POS_UNLOCK;
> > -                       mutex_lock(&file->f_pos_lock);
> > -               }
> > +               v |= FDPUT_POS_UNLOCK;
> > +               mutex_lock(&file->f_pos_lock);
> >         }
> 
> Ho humm. The patch is obviously correct.
> 
> At the same time this is actually very annoying, because I played this
> very issue with the plain /proc/<pid>/fd/<xyz> interface long long
> ago, where it would just re-use the 'struct file' directly, and it was
> such a sh*t-show that I know it's much better to actually open a new
> file descriptor.
> 
> I'm not sure that "share actual 'struct file' ever was part of a
> mainline kernel". I remember having it, but it was a "last century"
> kind of thing.
> 
> The /proc interface hack was actually somewhat useful exactly because
> you'd see the file position change, but it really caused problems.
> 
> The fact that pidfd_getfd() re-introduced that garbage and I never
> realized this just annoys me no end.

SCM_RIGHTS which have existed since 2.1 or sm allow you to do the same
thing just cooperatively. If you receive a bunch of fds from another
task including sockets and so on they refer to the same struct file.

In recent kernels we also have the seccomp notifier addfd ioctl which
let's you add a file descriptor into another process which can also be
used to create shared struct files.
