Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8B29C643
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1826009AbgJ0SPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:15:07 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:41087 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825966AbgJ0SO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:14:57 -0400
Received: by mail-oo1-f67.google.com with SMTP id n2so551687ooo.8;
        Tue, 27 Oct 2020 11:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yMJ8Y1/qT3nPE/qUQDD1UxaPPEXuSovGtgYNPCUSSwM=;
        b=XkcWS4YWNm9Q4KpE5ShotbOLiXVfteFBmuCYv0GBmd6KFKdVwLVzeg8yyU+LSGQQSp
         qL3NpEinnWWbFnTkdLX43q59sP28hp9AVKuSH0rWje9zzbL2jo8BUUzDJGdpnsktPfR+
         4gACda/JrvqXaWDzlh4YfANdM/G+XckORgjZoLXfrw1RM/wab/kGYVTuSJv2FDptCju+
         2UInxX/NNX3iLLiyRjWcXmPQf7ZkvESydMf0e49ysAjaRzgBl9N7luhxVSmS6cxDWJSP
         o0SHVndQQDwEVuKaykbQrxTPGJ2BVudTq5Csl1n2oWb155hw1J9hTEca+jIxWOIaE06h
         bogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yMJ8Y1/qT3nPE/qUQDD1UxaPPEXuSovGtgYNPCUSSwM=;
        b=kpt70y3GHVKFkIz/KFwHUeryXeV5rOXdQvyMOPCaOc269GCzSZIV/eaMWV2jfrLyDr
         +/auEJZ3Z0ceaI6jDWVbHZMC8mIxhwfiyTDbmj/n+YTjyigCDqkuPfcqPbb2RAMbkkiY
         MtjB/iC9OKdJSLLHs2K96xWygUbW+hNa/Hk/i2UBFK/v/wpWYQVA05OGBCL8dGa27LwF
         nNkF4HuvVaJLs2+EWzrweHTGoHuc4CP9kTxysCAJO2I12q5mkGCSLYy01TlFs/KJVfDY
         3PQ2thCuT5awEl9n1LTIGgTaczaaFrVa/FvcPohx83cjFAITxBj6NP+qHoqicSm29SX7
         sGKQ==
X-Gm-Message-State: AOAM531mwvQwNqZmUWuiceBbiUQO/HFSJBOT4I6MI5yjVKPYHpjayu6F
        AKIeN4Om2vLL49i0aFb50jHltsGfSw8inSZJcTgjHMUXTwM=
X-Google-Smtp-Source: ABdhPJwvO6DHnUVTV1Fm+Pi62zWuspDXcYpgHcTw80dT0DZdafDAVACytkN6V8bY9IVXDjBupAuSIeXlL7BF2EEkFAc=
X-Received: by 2002:a4a:a447:: with SMTP id w7mr2749245ool.42.1603822496311;
 Tue, 27 Oct 2020 11:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNuy+Q1F9rT8NJKX+Wgnp2JEROHwCdzu0pmOuWdeRe1iDg@mail.gmail.com>
In-Reply-To: <CAFqZXNuy+Q1F9rT8NJKX+Wgnp2JEROHwCdzu0pmOuWdeRe1iDg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 27 Oct 2020 14:14:45 -0400
Message-ID: <CAEjxPJ4jJDwBiDS0Sv_3e2N3kFBP=oH3-mkry0PFsphhtZw9AA@mail.gmail.com>
Subject: Re: selinux_file_permission() on pipes/pseudo-files - performance issue
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Hello,
>
> It has been reported to me that read/write syscalls on a pipe created
> via the pipe(2) family of syscalls spend a large percentage of time in
> avc_lookup() via selinux_file_permission(). This is specific to pipes
> (and also accept(2)'d sockets, I think) because these pipe fds are
> created using alloc_file_pseudo() as opposed to do_dentry_open(),
> which means that the security_file_open() hook is never called on
> them.
>
> In SELinux, this means that in selinux_file_permission() the
> read/write permission is always revalidated, leading to suboptimal
> performance, because SELinux re-checks the read/write perms of an open
> file only if the subject/target label or policy is different from when
> these permissions were checked during selinux_file_open().
>
> So I decided to try and see what would happen if I add a
> security_file_open() call to alloc_file(). This worked well for pipes
> - all domains that call pipe(2) seem to already have the necessary
> permissions to pass the open check, at least in Fedora policy - but I
> got lots of denials from accept(2), which also calls alloc_file()
> under the hood to create the new socket fd. The problem there is that
> programs usually call only recvmsg(2)/sendmsg(2) on fds returned by
> accept(2), thereby avoiding read/write checks on sock_file, which
> means that the domains don't normally have such permissions. Only
> programs that open actual socket files on the filesystem would
> unavoidably need read/write (or so I think), yet they wouldn't need
> them for the subsequent recvmsg(2)/sendmsg(2) calls.
>
> So I'm wondering if anyone has any idea how this could be fixed
> (optimized) without introducing regressions or awkward exceptions in
> the code. At this point, I don't see any way to do it regression-free
> without either adding a new hook or changing security_file_open() to
> distinguish between do_dentry_open() and alloc_file() + calling it
> from both places...

I don't think you want to reuse security_file_open() here.
There is an existing security_file_alloc() hook called on
__alloc_file(), but we have no inode information there so it cannot
cache the inode SID or perform any check on it.  You could potentially
lift that hook to all of the callers after the file has been
populated, or introduce a new hook in alloc_file() as you said.
Wondering though why this has never come up before if it is a
significant overhead in real workloads.  Earlier concerns about the
overhead on open files led to commit
788e7dd4c22e6f41b3a118fd8c291f831f6fddbb which introduced what later
became security_file_open().  But seemingly pipes/sockets weren't a
concern there.
