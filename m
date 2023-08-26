Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857DB7893CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Aug 2023 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjHZE20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Aug 2023 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjHZE17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:27:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714210EF;
        Fri, 25 Aug 2023 21:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zOtYRmM1KcMu/qkHPeaVQPqZfOz66WB0I6DdOTbH94I=; b=RL3iWIn8BOjeCtIa1/n/WGGC3T
        n9KamSR2jkO18DM9kvSNHCT6NsFHJ/5s3GmXhmtnweKexmiGQtLsH2D8EDSJ1Ez8YQEMXUj8KZP5W
        ci2LMbfAT1T759nQLSJLPtvt3TmnRVvxhlatXL8X36eBmAs1E3L6bP6csg1q53TQt7Uloaqav0PLa
        WTDLC0uTGgtY0BQXbCjew02NPEccT1Q4dySFud4SaQ48cWTkhy0WRkCfk2/LgShJODm74J7w3SD6M
        R3CHdG3CNCshkTcGTGX6xSJ0OfXRRaltOgP6p3S5irbmfNIfTC7JQpK4HzHxkfiOHTB0kFe69GGO+
        xNwdfd2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qZktq-0011VR-2Y;
        Sat, 26 Aug 2023 04:27:50 +0000
Date:   Sat, 26 Aug 2023 05:27:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
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
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230826042750.GP3390869@ZenIV>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 09:44:33PM -0700, Alexei Starovoitov wrote:

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
>  }
> 
> Then we can enforce fd >= 3 for a certain container or for a particular app.

[an extremely belated reply - had been net.dead since mid-May, just got to
that thread]

As far as I'm concerned, the main conclusion is that BPF handling of file
descriptors needs a fairly hostile code review, regarding the interactions
with dup2(), shared descriptor tables, SCM_RIGHTS, etc.  Rationale:
demonstrated utter lack of clue about the nature of file descriptors,
along with a weird mental model of how they are used, complete with
"if they are used not in the way we expect, let's shove a hook
somewhere to enforce The Right Way(tm)".  Will do...
