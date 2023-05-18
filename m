Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D481E708606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjERQZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjERQZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 12:25:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C610F0;
        Thu, 18 May 2023 09:25:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25332b3915bso1870338a91.2;
        Thu, 18 May 2023 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684427113; x=1687019113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OEoeV57J/0OxawwJ5/H31+LNfSmNHThHZXT9PV6Sx9M=;
        b=lG5CSbD/vPo/qNZvrCq2tRsv6qf7utI+Yp/YYpRrqFy7T9zOi1nQNRTMLOR1hEde/8
         xR4EaHYV8sGYJw2iESRWV2Uyg6hBzUM6Z93L4W/M/3QpYdN9agzTlbZcGuXaK8nPq8JW
         bggoPhFcufmpQm548oJp0lE1MsH4SY3Z3EDFZpSNDN/wHWecy2c3QdvgHMMyT5jLTeIP
         mvwMyDcgvfjzR1O+8oQIasw7NcWU0IL5QG3kKQCJvmo3WKr8zpbZWttmubOmlQ2ixX46
         xg/JWBV1za/lI7a67lLlhXQNaIY2DLvWWTog1Hi3zKlMl24JM1sAOet9oAyjzIpdWKkW
         rEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684427113; x=1687019113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEoeV57J/0OxawwJ5/H31+LNfSmNHThHZXT9PV6Sx9M=;
        b=ZRxifrY3NOxWmAHE3BYIQ9YYUiaqA6muTk8NxHwIozBmTJJZWA1Yl5WTAQzbiYs0X8
         lygIlQvzk9uY3m/7Ch6kQjRLDIuKlHN3Cx0WRkEJHvP/sB5HdA25j4VO3r1GYcTM9A7M
         RnLSWmgqN4xo/u/MAlHTT2kPPi2wUACSbGh/E+MJiFFD3t/adVsQ1NPpHfOR3uSyaNXj
         xUL7W/ST5YipNITIybxiqwjBNICb7m8SOu6bbbiIa1hw4uANB6TjIdt81Nmzen6NAPAj
         +0nXPh2vBKZ2NuzXk7+2yN5nqmICOEDfgjuUrta+zjx5GQZ8WbeyHYGkmsfBigZO7WWJ
         cSww==
X-Gm-Message-State: AC+VfDzSe9aojaAZzvY1FJBPgVKoMHm+EFoOwcQLPePMM9GmccWsJkLJ
        vI6C4u8BMrh4DNzW2pOxU2ANUB15wgM=
X-Google-Smtp-Source: ACHHUZ6MYDc8BtNr/5L9P3riWlAkddElsN+puwxVj0woftZYxSlm+pZS40vIdgU6rf012NPKKhK1gw==
X-Received: by 2002:a17:90a:2e12:b0:24d:f8e6:9d4c with SMTP id q18-20020a17090a2e1200b0024df8e69d4cmr2722302pjd.49.1684427112626;
        Thu, 18 May 2023 09:25:12 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:e212])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a890300b002502161b063sm3593940pjn.54.2023.05.18.09.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:25:12 -0700 (PDT)
Date:   Thu, 18 May 2023 09:25:08 -0700
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
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 10:38:46AM +0200, Christian Brauner wrote:
> On Wed, May 17, 2023 at 09:17:36AM -0700, Alexei Starovoitov wrote:
> > On Wed, May 17, 2023 at 5:05 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > > > Adding fsdevel so we're aware of this quirk.
> > > >
> > > > So I'm not sure whether this was ever discussed on fsdevel when you took
> > > > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > > > invalid value.
> > >
> > > I've never heard of this before, and I think it is compltely
> > > unacceptable. 0 ist just a normal FD, although one that happens to
> > > have specific meaning in userspace as stdin.
> > >
> > > >
> > > > If it was discussed then great but if not then I would like to make it
> > > > very clear that if in the future you decide to introduce custom
> > > > semantics for vfs provided infrastructure - especially when exposed to
> > > > userspace - that you please Cc us.
> > >
> > > I don't think it's just the future.  We really need to undo this ASAP.
> > 
> > Christian is not correct in stating that treatment of fd==0 as invalid
> > bpf object applies to vfs fd-s.
> > The path_fd addition in this patch is really the very first one of this kind.
> > At the same time bpf anon fd-s (progs, maps, links, btfs) with fd == 0
> > are invalid and this is not going to change. It's been uapi for a long time.
> > 
> > More so fd-s 0,1,2 are not "normal FDs".
> > Unix has made two mistakes:
> > 1. fd==0 being valid fd
> > 2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.
> > 
> > The first mistake makes it hard to pass FD without an extra flag.
> > The 2nd mistake is just awful.
> > We've seen plenty of severe datacenter wide issues because some
> > library or piece of software assumes stdin/out/err.
> > Various services have been hurt badly by this "convention".
> > In libbpf we added ensure_good_fd() to make sure none of bpf objects
> > (progs, maps, etc) are ever seen with fd=0,1,2.
> > Other pieces of datacenter software enforce the same.
> > 
> > In other words fds=0,1,2 are taken. They must not be anything but
> > stdin/out/err or gutted to /dev/null.
> > Otherwise expect horrible bugs and multi day debugging.
> > 
> > Because of that, several years ago, we've decided to fix unix mistake #1
> > when it comes to bpf objects and started reserving fd=0 as invalid.
> > This patch is proposing to do the same for path_fd (normal vfs fd) when
> 
> It isn't as you now realized but I'm glad we cleared that up off-list.
> 
> > it is passed to bpf syscall. I think it's a good trade-off and fits
> > the rest of bpf uapi.
> > 
> > Everyone who's hiding behind statements: but POSIX is a standard..
> > or this is how we've been doing things... are ignoring the practical
> > situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces them.
> 
> (Prefix: Imagine me calmly writing this and in a relaxed tone.)
> 
> Just to clarify. I do think that deciding that 0 is an invalid file

We're still talking past each other.
0 is an invalid bpf object. Not file.
There is a difference.
The kernel is breaking user space by returning non-file FDs in 0,1,2.
Especially as fd = 1 and 2.
ensure_good_fd() in libbpf is a library workaround to make sure bpf objects
are not the reason for user app brekage.
I firmly believe that making kernel return socket FDs and other special FDs with fd >=3
(under new sysctl, for example) will prevent user space breakage.

And to answer Ted's question..
Yes. It's a security issue, but it's the other way around.
The kernel returning non vfs file FD in [0,1,2] range is a security issue.
I'm proposing to fix it with new sysctl or boot flag.
