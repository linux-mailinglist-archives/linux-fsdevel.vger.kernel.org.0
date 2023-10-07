Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4B7BC3DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 03:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJGBmR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 21:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGBmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:42:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D4BB6;
        Fri,  6 Oct 2023 18:42:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFA2C433C8;
        Sat,  7 Oct 2023 01:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696642934;
        bh=m1cney+VqQksYh8PdDgJV250HPsweKXskydfNeuLCcc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hn48Tey8/9FwRsTKApLZaQaUVztBkuQAclDAKWmXy1DEKyw8VTnfuZAJqH/k6mSV3
         cHx9gbpZRKDE5F/zJuseuuYyOVXHhOzqMf1BxssmjsmIaFczzj8wVkb+UwMJGY11ak
         cSV3rpThoCs8TSga1RFSeFrlIIFIsgfa+x6jV2u1uYH80BwW4O9srJ6f8rcpZdnE6I
         b4/YpS1JptfFVeMWCQTP35nKq9EQ7bWRA1EwGEByHJZeVdQD/Mz++pJs0aaSsoqUBE
         sIuryISse1uf0p2u6eCG8RhBPtCwL/ZFHFdpSkNb9siRFO9qVcb+pX2Du8P+F5stz+
         rCqnMZGf0xspg==
Date:   Sat, 7 Oct 2023 10:42:09 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bootconfig 2/3] fs/proc: Add boot loader arguments as
 comment to /proc/bootconfig
Message-Id: <20231007104209.e6950a657f07831c95a0a1de@kernel.org>
In-Reply-To: <55067c09-9ec6-452a-a6db-30b8a8d08485@paulmck-laptop>
References: <6ea609a4-12e3-4266-8816-b9fca1f1f21c@paulmck-laptop>
        <20231005171747.541123-2-paulmck@kernel.org>
        <20231006175948.14df07948d8c6a4a46473c13@kernel.org>
        <55067c09-9ec6-452a-a6db-30b8a8d08485@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Oct 2023 09:52:30 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Oct 06, 2023 at 05:59:48PM +0900, Masami Hiramatsu wrote:
> > On Thu,  5 Oct 2023 10:17:46 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > show all kernel boot parameters, both those supplied by the boot loader
> > > and those embedded in the kernel image.  This works well for those who
> > > just want to see all of the kernel boot parameters, but is not helpful to
> > > those who need to see only those parameters supplied by the boot loader.
> > > This is especially important when these parameters are presented to the
> > > boot loader by automation that might gather them from diverse sources.
> > > It is also useful when booting the next kernel via kexec(), in which
> > > case it is necessary to supply only those kernel command-line arguments
> > > from the boot loader, and most definitely not those that were embedded
> > > into the current kernel.
> > > 
> > > Therefore, add comments to /proc/bootconfig of the form:
> > > 
> > > 	# Parameters from bootloader:
> > > 	# root=UUID=ac0f0548-a69d-43ca-a06b-7db01bcbd5ad ro quiet ...
> > > 
> > > The second added line shows only those kernel boot parameters supplied
> > > by the boot loader.
> > 
> > Thanks for update it.
> > 
> > This looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thank you!
> 
> And thank you!  I take this as meaning that I should push these three
> commits for the upcoming v6.7 merge window.  Please let me know if I
> should be doing something else.

I have my bootconfig branch, so I think I should pick this and push it
to the next window. Does it work?

Thank you,

> 
> 							Thanx, Paul
> 
> > > Link: https://lore.kernel.org/all/CAHk-=wjpVAW3iRq_bfKnVfs0ZtASh_aT67bQBG11b4W6niYVUw@mail.gmail.com/
> > > Link: https://lore.kernel.org/all/20230731233130.424913-1-paulmck@kernel.org/
> > > Co-developed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Arnd Bergmann <arnd@kernel.org>
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > > ---
> > >  fs/proc/bootconfig.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> > > index 2e244ada1f97..902b326e1e56 100644
> > > --- a/fs/proc/bootconfig.c
> > > +++ b/fs/proc/bootconfig.c
> > > @@ -62,6 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
> > >  				break;
> > >  			dst += ret;
> > >  		}
> > > +		if (ret >= 0 && boot_command_line[0]) {
> > > +			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> > > +				       boot_command_line);
> > > +			if (ret > 0)
> > > +				dst += ret;
> > > +		}
> > >  	}
> > >  out:
> > >  	kfree(key);
> > > -- 
> > > 2.40.1
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
