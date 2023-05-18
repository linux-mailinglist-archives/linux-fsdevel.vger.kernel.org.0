Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72737087C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjERS0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 14:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERS0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 14:26:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F5BF;
        Thu, 18 May 2023 11:26:39 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae6dce19f7so6226625ad.3;
        Thu, 18 May 2023 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684434399; x=1687026399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWJXc7G0MWkFSTiwi0lFS63FsGdyAJlX1L0z6Z40xC4=;
        b=nVZiEPpHGaIX4K5vDHmXqA2QZaTJrh79h2IxSCP3qqBIKfnWeeGkdFoD1VyXqYbqVp
         eLAY4kL4F+oCdLAMSyCCWFI+AVZp0UTa4+teeqfXlQCdahcZtXRO91loP7hbUs5/eqBk
         3tiIwdmWcdRqFq4DdeF24adt99b4jDuFewj9Fr44wlPxd9TVShiIqDMJ026pViv+nOZW
         QpeeHmh0662Hcx59oqKAw5QpKPx4wwWzvbdi3eBFR8T8eSZi5ak4SGRIyZEQBh/W7yUL
         enlwJNDgcAlb6IC0z/UB5/BQuB8PFi+QL73dzzHm94HjBZ9glMOmRoro3qKs2y6jrJ9I
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434399; x=1687026399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWJXc7G0MWkFSTiwi0lFS63FsGdyAJlX1L0z6Z40xC4=;
        b=Xj3Eumt0mTC0mal86CKl9hzB5pATVgW9FJUDms5GjQqzwX0XSY6XYWcYHOer1E3Ehz
         dIBlMpZNFl75xDBXgeN/0ou08oteNFj4qveJOSlXc1AyJlbdtw2nuba9sqeoEWTsLwJY
         0siHMl38pjW16cHvPeG/xOVb/KCrqQNfvz7GCQBWauBKt98EDn8ZW4JRBUijH1hmImuH
         VKulCMfS74KkuO1cYzpbxMDI0koTTPp9lmnHJ5pBtGXFZGpq9k6bCszAgbbeeU3YbN6z
         +8KJmddhCvL9mW89N4YOVaLXXVBzGBcRENVVFGjJdmpVlSCFF3h/F3aLkQhij6rtUcGu
         BSbg==
X-Gm-Message-State: AC+VfDx+tZ82lUiHtsbbRSVcryw1DUWrzJ/nBldsTyggm/c9OFOzFNu5
        gRawGUkiHfG/CncLf67OSYA=
X-Google-Smtp-Source: ACHHUZ6G6bXeNybeyKnZjBE9S2/XNW8nPaZ0iCiCwvEobvcqhn+ONkD7elQf9ZAvA1K+5v7+DjEhDw==
X-Received: by 2002:a17:902:e889:b0:1aa:f536:b1e2 with SMTP id w9-20020a170902e88900b001aaf536b1e2mr4138455plg.62.1684434398683;
        Thu, 18 May 2023 11:26:38 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:e212])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001ac84f87b1dsm1765915plf.155.2023.05.18.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:26:38 -0700 (PDT)
Date:   Thu, 18 May 2023 11:26:35 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 07:20:29PM +0200, Christian Brauner wrote:
> On Thu, May 18, 2023 at 09:25:08AM -0700, Alexei Starovoitov wrote:
> > On Thu, May 18, 2023 at 10:38:46AM +0200, Christian Brauner wrote:
> > > On Wed, May 17, 2023 at 09:17:36AM -0700, Alexei Starovoitov wrote:
> > > > On Wed, May 17, 2023 at 5:05 AM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > > > > > Adding fsdevel so we're aware of this quirk.
> > > > > >
> > > > > > So I'm not sure whether this was ever discussed on fsdevel when you took
> > > > > > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > > > > > invalid value.
> > > > >
> > > > > I've never heard of this before, and I think it is compltely
> > > > > unacceptable. 0 ist just a normal FD, although one that happens to
> > > > > have specific meaning in userspace as stdin.
> > > > >
> > > > > >
> > > > > > If it was discussed then great but if not then I would like to make it
> > > > > > very clear that if in the future you decide to introduce custom
> > > > > > semantics for vfs provided infrastructure - especially when exposed to
> > > > > > userspace - that you please Cc us.
> > > > >
> > > > > I don't think it's just the future.  We really need to undo this ASAP.
> > > > 
> > > > Christian is not correct in stating that treatment of fd==0 as invalid
> > > > bpf object applies to vfs fd-s.
> > > > The path_fd addition in this patch is really the very first one of this kind.
> > > > At the same time bpf anon fd-s (progs, maps, links, btfs) with fd == 0
> > > > are invalid and this is not going to change. It's been uapi for a long time.
> > > > 
> > > > More so fd-s 0,1,2 are not "normal FDs".
> > > > Unix has made two mistakes:
> > > > 1. fd==0 being valid fd
> > > > 2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.
> > > > 
> > > > The first mistake makes it hard to pass FD without an extra flag.
> > > > The 2nd mistake is just awful.
> > > > We've seen plenty of severe datacenter wide issues because some
> > > > library or piece of software assumes stdin/out/err.
> > > > Various services have been hurt badly by this "convention".
> > > > In libbpf we added ensure_good_fd() to make sure none of bpf objects
> > > > (progs, maps, etc) are ever seen with fd=0,1,2.
> > > > Other pieces of datacenter software enforce the same.
> > > > 
> > > > In other words fds=0,1,2 are taken. They must not be anything but
> > > > stdin/out/err or gutted to /dev/null.
> > > > Otherwise expect horrible bugs and multi day debugging.
> > > > 
> > > > Because of that, several years ago, we've decided to fix unix mistake #1
> > > > when it comes to bpf objects and started reserving fd=0 as invalid.
> > > > This patch is proposing to do the same for path_fd (normal vfs fd) when
> > > 
> > > It isn't as you now realized but I'm glad we cleared that up off-list.
> > > 
> > > > it is passed to bpf syscall. I think it's a good trade-off and fits
> > > > the rest of bpf uapi.
> > > > 
> > > > Everyone who's hiding behind statements: but POSIX is a standard..
> > > > or this is how we've been doing things... are ignoring the practical
> > > > situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces them.
> > > 
> > > (Prefix: Imagine me calmly writing this and in a relaxed tone.)
> > > 
> > > Just to clarify. I do think that deciding that 0 is an invalid file
> 
> descriptor
> 
> > 
> > We're still talking past each other.
> > 0 is an invalid bpf object. Not file.
> > There is a difference.
> 
> You cut of a word above. I can't follow your argument.
> File descriptor numbers are free to refer to whatever we want.
> They don't care about what type of object they refer to and they
> better not.

User space cares what they refer to.
Unix made integer FD into broken abstraction.
regular files need one set of syscalls to work with such 'integer FDs'.
sockets need another set of syscalls.
All other anon-inodes need another set of syscalls.
While user space sees an integer without type and that a root cause of the bugs.
And that's particularly bad for integers 0,1,2 where user space assumes that
regular files are behind them.

Imagine C++ project where base class is called 'FD' while children
implement their own access methods that don't overlap with each other.
Now one application passes this 'FD' class to another.
That other app can only do trial and error to figure out what it got.
Any user space developer would reject such class hierarchy design,
but kernel folks are so proud of this broken abstraction.
FDs are not special.. POSIX is the standard... Right.
That's why user space keeps their workarounds, because kernel folks
are not empathic to user space needs.
