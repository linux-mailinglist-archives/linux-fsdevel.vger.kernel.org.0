Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2770D74E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjEWIZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbjEWIYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:50 -0400
X-Greylist: delayed 1134 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 01:22:10 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21662108;
        Tue, 23 May 2023 01:22:10 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id B4A95E8022C;
        Tue, 23 May 2023 09:49:49 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id F147716006B; Tue, 23 May 2023 09:49:48 +0200 (CEST)
Date:   Tue, 23 May 2023 09:49:48 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <ZGxwHO2MRNK9gYxB@gardel-login>
References: <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner>
 <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
 <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Do, 18.05.23 21:44, Alexei Starovoitov (alexei.starovoitov@gmail.com) wrote:

> > The 0/1/2 file descriptors are not at all special. They are a shell
> > pipeline default, nothing more. They are not the argument your think they
> > are, and you should stop trying to make them an argument.
>
> I'm well aware that any file type is allowed to be in FDs 0,1,2 and
> some user space is using it that way, like old inetd:
> https://github.com/guillemj/inetutils/blob/master/src/inetd.c#L428
> That puts the same socket into 0,1,2 before exec-ing new process.
>
> My point that the kernel has to assist user space instead of
> stubbornly sticking to POSIX and saying all FDs are equal.
>
> Most user space developers know that care should be taken with FDs 0,1,2,
> but it's still easy to make a mistake.

If I look at libbpf, which supposedly gets the fd handling right I
can't find any hint it actually moves the fds it gets from open() to
an fd > 2, though?

i.e. the code that invokes open() calls in the libbpf codebase happily
just accepts an fd < 2, including fd == 0, and this is then later
passed back into the kernel in various bpf() syscall invocations,
which should refuse it, no? So what's going on there?

I did find this though:

<snip>
	new_fd = open("/", O_RDONLY | O_CLOEXEC);
	if (new_fd < 0) {
		err = -errno;
		goto err_free_new_name;
	}

	new_fd = dup3(fd, new_fd, O_CLOEXEC);
	if (new_fd < 0) {
		err = -errno;
		goto err_close_new_fd;
	}
</snip>

(This is from libbpf.c, bpf_map__reuse_fd(), i.e. https://github.com/libbpf/libbpf/blob/master/src/libbpf.c)

Not sure what's going on here, what is this about? you allocate an fd
you then immediately replace? Is this done to move the fd away from
fd=0?  but that doesn't work that way, in case fd 0 is closed when
entering this function.

Or is this about dup'ping with O_CLOEXEC?

Please be aware that F_DUPFD_CLOEXEC exists, which allows you to
easily move some fd above some treshold, *and* set O_CLOEXEC at the
same time. In the systemd codebase we call this frequently for code
that ends up being loaded in arbitrary processes (glibc NSS modules,
PAM modules), in order to ensure we get out of the fd < 3 territory
quickly.

(btw, if you do care about O_CLOEXEC – which is great – then you also
want to replace a bunch of fopen(…, "r") with fopen(…, "re") in your
codebase)

Lennart
