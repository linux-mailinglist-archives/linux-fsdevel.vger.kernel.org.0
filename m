Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0F1F4BC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 05:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFJDdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 23:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:33:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CCEC05BD1E;
        Tue,  9 Jun 2020 20:33:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so294897pjb.5;
        Tue, 09 Jun 2020 20:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NNmiKN+12Bn903XT64iN1kEN8paNhlgdT5DkSuq7ja4=;
        b=T0FbzoxldQ6/5sIsbNhtC5QFKn4GvLox4uYSz6yMRw//60V6ysLiDGUD6MaQuqwAdz
         /zgSl6qUvSqfqHE8dTT9VGen51juMJ7gCjRnZbZs1XGrDOWbG4jKhK2/ZK1CXVQHQJNf
         fi8Cn+OPst6uXXTVElvJ60r6CuDrphbQ/kDMNxvinlZZ+P7/lCnCsSj6QOueNP8MK7SH
         psuZn532nmdf2sAlx/miTlxR+QDrzlvnxfMXK/PuCJa3pvp4svn/MjS4LGUpLT9x1faN
         v5Bg1nW5WUgvTAjSv6mFA4XDVTUs9MX/NJM9m3Ve+TC6lkVs1zGM1tRNSoF876HhEhli
         uQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNmiKN+12Bn903XT64iN1kEN8paNhlgdT5DkSuq7ja4=;
        b=alJLoknGGkkT3dbJ45O3NT9zf3GFAyt4LklUvr6lvEpJzyMIIUetvJYxaTPjsMEUUZ
         9UautWZHy+upJdXGUG+w0twBhxhMtPnyX6hoz2ydZGp+5/frj2gZ/wnMewfmg1V7lNa5
         Tt6Ut+rz78+hUHzUTHvXpy0Y1ycE5r7/G2CExi2LT2n4jciquUHImeLMz/6cg9nBKybu
         ligtU0p38qo6hb3rYJRtl5gmJbQcsPeXwAfb4kTbeaxMs0HFcUwsMYK5sgHxM7E9Fd2R
         n/SndrMOJZZjbVpacaWNEtsKgSK+ZplgAFlLpGeW/APW0wEvQsazkvLASvMbV5B5cEMv
         755g==
X-Gm-Message-State: AOAM530u8gEjiUj+XeSaiLp8DRfmY10+SPAICjVon9vlKIdZEB/RVS2B
        ntMYrhexYcByQ2mEvLc4New=
X-Google-Smtp-Source: ABdhPJw56cIy3nKUta3GP5Vf2BM7vzWLrhPGzgsWNSmqLPNSHvBNK3Iv0pcIutrJMODC7h28kJn5Pg==
X-Received: by 2002:a17:90a:5c85:: with SMTP id r5mr1020691pji.40.1591759979906;
        Tue, 09 Jun 2020 20:32:59 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id v186sm11258445pfv.54.2020.06.09.20.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 20:32:59 -0700 (PDT)
Date:   Tue, 9 Jun 2020 20:32:56 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200610033256.xkv5a7l6vtb2jiox@ast-mbp.dhcp.thefacebook.com>
References: <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
 <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
 <ddabab93-4660-3a46-8b05-89385e292b75@i-love.sakura.ne.jp>
 <20200609223214.43db3orsyjczb2dd@ast-mbp.dhcp.thefacebook.com>
 <6a8b284f-461e-11b5-9985-6dc70012f774@i-love.sakura.ne.jp>
 <20200610000546.4hh4n53vaxc4hypi@ast-mbp.dhcp.thefacebook.com>
 <1be571d2-c517-d7a7-788e-3bcc07afa858@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be571d2-c517-d7a7-788e-3bcc07afa858@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:08:20PM +0900, Tetsuo Handa wrote:
> On 2020/06/10 9:05, Alexei Starovoitov wrote:
> > I think you're still missing that usermode_blob is completely fs-less.
> > It doesn't need any fs to work.
> 
> fork_usermode_blob() allows usage like fork_usermode_blob("#!/bin/sh").
> A problem for LSMs is not "It doesn't need any fs to work." but "It can access any fs and
> it can issue arbitrary syscalls.".
> 
> LSM modules switch their security context upon execve(), based on available information like
> "What is the !AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
> "What is the AT_SYMLINK_NOFOLLOW pathname for the requested program passed to execve()?",
> "What are argv[]/envp[] for the requested program passed to execve()?", "What is the inode's
> security context passed to execve()?" etc. And file-less execve() request (a.k.a.
> fork_usermode_blob()) makes pathname information (which pathname-based LSMs depend on)
> unavailable.
> 
> Since fork_usermode_blob() can execute arbitrary code in userspace, fork_usermode_blob() can
> allow execution of e.g. statically linked HTTP server and statically linked DBMS server, without
> giving LSM modules a chance to understand the intent of individual file-less execve() request.
> If many different statically linked programs were executed via fork_usermode_blob(), how LSM
> modules can determine whether a syscall from a file-less process should be permitted/denied?

What you're saying is tomoyo doesn't trust kernel modules that are built-in
as part of vmlinux and doesn't trust vmlinux build.
I cannot really comprehend that since it means that tomoyo doesn't trust itself.

> By the way, TOMOYO LSM wants to know meaningful AT_SYMLINK_NOFOLLOW pathname and !AT_SYMLINK_NOFOLLOW
> pathname, and currently there is no API for allow obtaining both pathnames atomically. But that is a
> different problem, for what this mail thread is discussing would be whether we can avoid file-less
> execve() request (i.e. get rid of fork_usermode_blob()).

tomoyo does path name resolution as a string and using that for security?
I'm looking at tomoyo_realpath*() and tomoyo_pathcmp(). Ouch.
Path based security is anti pattern of security.
I didn't realize tomoyo so broken.
