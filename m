Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E850709179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 10:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjESINn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjESINX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 04:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E0E5E
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 01:13:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3C8760B4F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 08:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9ADC433EF;
        Fri, 19 May 2023 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684483996;
        bh=GFGdu0qCsxNJA7YGcWMDGA08p14uwMhdk+l7huHcUYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK1K/YABQqibBY2HrPkYnGYX4KvFqaf+G58ZvoVRpTVwbfaJ/M8nXHOTNp+d/Aa1V
         kGAV6Y2dW4WOI5wYJx8wzIn1ExpN2+Wa86UFAvID62vqob3D0EVet9urP2775XqT3T
         KB9yfJkXWHO/5K15Hij2eoyS2lnjB4k9zYySxUD+mcOcXFuNJ6ixwrAGgDAMDz9Jmn
         lXdosdgOAHqMqZkJdR6W2vG8uBe4iWcGkjbAdwYLk8I7NzlzhtBNCVOhKE9hYZOWKm
         uQ4cm7JEuNhki+2A/xnn/ygJWlR9HB8i9GS75AjjgjAX9r0bQPOYBPy+VwYTuVGqhe
         BPNP6HtLcvTWg==
Date:   Fri, 19 May 2023 10:13:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20230519-betiteln-fluor-6c0417842143@brauner>
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
In-Reply-To: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 09:44:33PM -0700, Alexei Starovoitov wrote:
> On Thu, May 18, 2023 at 11:57:14AM -0700, Linus Torvalds wrote:
> > That is nobody's fault but your own, and you should just admit it rather
> > than trying to double down on being wrong.
> 
> You're correct. I was indeed doubling down on that.
> Thanks for putting it straight like that.
> 
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
> 
> To explain the motivation a bit of background:
> "folly" is a core C++ library for fb apps. Like libstdc++ and a lot more.
> Until this commit in 2021:
> https://github.com/facebook/folly/commit/cc9032a0e41a0cba9aa93240c483cfceb0ff44ea
> the user could launch a new process with flag "folly::Subprocess::CLOSE".
> It's useful for the cases when child doesn't want to inherit stdin/out/err.
> There is also GLOG. google's logging library that can be configured to log to stderr.
> Both libraries are well written with the high code quality.
> In a big app multiple people use different pieces and may not be aware
> how all pieces are put together. You can guess the rest...
> Important service used a library that used another library that started a
> process with folly::Subprocess::CLOSE. That process opened network connections
> and used glog. It was "working" for some time, because sys_write() to a socket
> is a valid command, but when TCP buffers got full synchronous innocuous logging
> prevented parent from making progress.
> 
> That footgun was removed from folly in 2021, but we still see this issue from time to time.
> My point that the kernel can help here.
> Since folks don't like sysctl to control FD assignment how about something like this:
> 
> diff --git a/fs/file.c b/fs/file.c
> index 7893ea161d77..896e79433f61 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -554,9 +554,15 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>         return error;
>  }
> 
> +__weak noinline u32 get_start_fd(void)
> +{
> +       return 0;
> +}
> +/* mark it as BPF_MODIFY_RETURN to let bpf progs adjust return value */
> +
>  int __get_unused_fd_flags(unsigned flags, unsigned long nofile)
>  {
> -       return alloc_fd(0, nofile, flags);
> +       return alloc_fd(get_start_fd(), nofile, flags);

I'm sorry but I really don't think this is a good idea. We're not going
to run BPF programs in core file code. That stuff is sensitive and
complex enough as it is without having to take into account that a bpf
program can modify behavior. It's also completely unclear whether that's
safe to do as this would allow to change fd allocation across the whole
kernel.

This idea that fd 0, 1, and 2 or any other fd deserve special treatment
by the kernel needs to die; and quickly at that.
