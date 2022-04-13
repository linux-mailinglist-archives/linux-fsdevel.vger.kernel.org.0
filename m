Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EAA500246
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbiDMXIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiDMXIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:08:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF92528F;
        Wed, 13 Apr 2022 16:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06A58B82792;
        Wed, 13 Apr 2022 23:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C680C385A6;
        Wed, 13 Apr 2022 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649891174;
        bh=eWoWonxCoNljYRVKhnJBW3w5BMc5SBWugMCEjTpDLok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uautVyWW7P+lnFbIYbKqQvYsgSb1d1GQNLDfUD7PP4uDY3dCRtkoxX6WprnGiGjDX
         muWyGww4K9gep2e/lBXV5QH7pCc6JtvesX0EBVAEiTZCD9aSH7nIUElYh5TxwoME8p
         4zN8t8UJIoW3og8ciJqnby5CyJtwW4azwqjMcf2s=
Date:   Wed, 13 Apr 2022 16:06:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Message-Id: <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
In-Reply-To: <1649886492.rqei1nn3vm.none@localhost>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
        <20220413211357.26938-1-alex_y_xu@yahoo.ca>
        <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
        <1649886492.rqei1nn3vm.none@localhost>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Apr 2022 18:25:53 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:

> Excerpts from Andrew Morton's message of April 13, 2022 5:27 pm:
> > On Wed, 13 Apr 2022 17:13:57 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:
> > 
> >> This restores the behavior prior to 258f669e7e88 ("mm:
> >> /proc/pid/smaps_rollup: convert to single value seq_file"), making it
> >> once again consistent with maps and smaps, and allowing patterns like
> >> awk '$1=="Anonymous:"{x+=$2}END{print x}' /proc/*/smaps_rollup to work.
> >> Searching all Debian packages for "smaps_rollup" did not find any
> >> programs which would be affected by this change.
> > 
> > Thanks.
> > 
> > 258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
> > really needed.
> > 
> > However, we need to be concerned about causing new regressions, and I
> > don't think you've presented enough information for this to be determined.
> > 
> > So please provide us with a full description of how the smaps_rollup
> > output will be altered by this patch.  Quoting example output would be
> > helpful.
> > 
> > 
> 
> Current behavior (4.19+):
> 
> $ cat /proc/2/smaps; echo $?
> 0
> $ cat /proc/2/smaps_rollup; echo $?
> cat: /proc/2/smaps_rollup: No such process
> 1
> $ strace -yP /proc/2/smaps_rollup cat /proc/2/smaps_rollup
> openat(AT_FDCWD</>, "/proc/2/smaps_rollup", O_RDONLY) = 3</proc/2/smaps_rollup>
> newfstatat(3</proc/2/smaps_rollup>, "", {st_mode=S_IFREG|0444, st_size=0, ...}, AT_EMPTY_PATH) = 0
> fadvise64(3</proc/2/smaps_rollup>, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
> read(3</proc/2/smaps_rollup>, 0x7fa475f5d000, 131072) = -1 ESRCH (No such process)
> cat: /proc/2/smaps_rollup: No such process
> close(3</proc/2/smaps_rollup>)          = 0
> +++ exited with 1 +++
> 
> Pre-4.19 and post-patch behavior:
> 
> $ cat /proc/2/smaps; echo $?
> 0
> $ cat /proc/2/smaps_rollup; echo $?
> 0
> $ strace -yP /proc/2/smaps_rollup cat /proc/2/smaps_rollup
> openat(AT_FDCWD</>, "/proc/2/smaps_rollup", O_RDONLY) = 3</proc/2/smaps_rollup>
> newfstatat(3</proc/2/smaps_rollup>, "", {st_mode=S_IFREG|0444, st_size=0, ...}, AT_EMPTY_PATH) = 0
> fadvise64(3</proc/2/smaps_rollup>, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
> read(3</proc/2/smaps_rollup>, "", 131072) = 0
> close(3</proc/2/smaps_rollup>)          = 0
> +++ exited with 0 +++

OK, thanks.

But the current behaviour is appropriate, isn't it?  An attempt to read
the maps of a process which has no maps returns -ESRCH.  Seems sensible
enough.

On the other hand, returning a zero-length read() is also appropriate.

> I agree that this type of change must be done carefully to avoid 
> introducing inadvertent regressions. However, I think this particular 
> change is highly unlikely to introduce regressions for the following 
> reasons:
> 
> 1. I cannot think of a plausible case which would be affected. The only 
>    case I can possibly imagine is a program checking whether a process 
>    is a kernel thread, but this seems like a particularly silly method. 
>    Moreover, the method is already broken on kernels before 4.14 
>    (because smaps_rollup does not exist) and before 4.19 (because 
>    smaps_rollup worked like smaps). A plausible method would be opening 
>    /proc/x/(s)maps and checking that it is empty, which some programs 
>    actually do.

Well, I suppose a poorly coded application could do something like

	if (read(fd, buf, 1000) >= 0)
		assume_buf_now_contains_data()

> 2. Research on Debian Code Search did not find any apparent cases. I also 
>    searched GitHub Code Search but found too many irrelevant results with 
>    no useful way to filter them out.

I don't think this will work very well.  smaps_rollup is the sort of
system tuning thing for which organizations will develop in-house
tooling which never get relesaed externally.

> 3. As mentioned previously, this was already the behavior between 4.14 
>    and 4.18 (inclusive).
> 

Yup.  Hm, tricky.  I'd prefer to leave it alone if possible.  How
serious a problem is this, really?  
