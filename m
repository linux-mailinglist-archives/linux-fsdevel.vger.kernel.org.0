Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88881D97C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgESN3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 09:29:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESN3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 09:29:53 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jb2JJ-0001zu-98; Tue, 19 May 2020 13:29:33 +0000
Date:   Tue, 19 May 2020 15:29:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Message-ID: <20200519132931.3b7yugfv2ajry6y7@wittgenstein>
References: <20200518055457.12302-1-keescook@chromium.org>
 <20200518055457.12302-2-keescook@chromium.org>
 <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
 <CAG48ez1FspvvypJSO6badG7Vb84KtudqjRk1D7VyHRm06AiEbQ@mail.gmail.com>
 <20200518144627.sv5nesysvtgxwkp7@wittgenstein>
 <87blmk3ig4.fsf@x220.int.ebiederm.org>
 <87mu64uxq1.fsf@igel.home>
 <87sgfwuoi3.fsf@x220.int.ebiederm.org>
 <87eergunqs.fsf@igel.home>
 <87ftbwun0h.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftbwun0h.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 07:28:46AM -0500, Eric W. Biederman wrote:
> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > On Mai 19 2020, Eric W. Biederman wrote:
> >
> >> I am wondering if there are source trees for libc4 or libc5 around
> >> anywhere that we can look at to see how usage of uselib evolved.
> >
> > libc5 is available from archive.debian.org.
> >
> > http://archive.debian.org/debian-archive/debian/pool/main/libc/libc/libc_5.4.46.orig.tar.gz
> 
> Interesting.
> 
> It appears that the old a.out code to make use of uselib remained in
> the libc5 sources but it was all conditional on the being compiled not
> to use ELF.
> 
> libc5 did provide a wrapper for the uselib system call.
> 
> It appears glibc also provides a wrapper for the uselib system call
> named: uselib@GLIBC_2.2.5.
> 
> I don't see a glibc header file that provides a declaration for uselib
> though.
> 
> So the question becomes did anyone use those glibc wrappers.

The only software I could find was ski, the ia64 instruction set
emulator, which apparently used to make use of this and when glibc
removed they did:

#define uselib(libname) syscall(__NR_uselib, libname)

but they only define it for the sake of the internal syscall list they
maintain so not actively using it. I just checked, ski is available on
Fedora 31 and Fedora has USELIB disabled.
Codesearch on Debian yields no users that actively use the syscall for
anything.

Christian
