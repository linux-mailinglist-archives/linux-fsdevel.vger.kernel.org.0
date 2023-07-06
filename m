Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D174A25F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjGFQlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 12:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGFQlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:41:17 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0361A173F
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 09:40:58 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bd77424c886so1098711276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1688661657; x=1691253657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9GE3hSd67E8eCq4M6r1SzwMp8TikzZJ0WrTWmk8JY8=;
        b=C56pyVvHUKnRboK4oYfSTmfvZcM3eRzvJgDafsdBsYX/TaPSUgYxT8itXzyr1fyaQo
         jqoRAKjee5LWrfiJogxPRMiohgSxpDFrYlip5kDFnrEvb7EgzPpXohZy9EUKYan5fKVp
         +xtyuh6uKi2SggAxKjAuiQnKgPDqC+TZGwcworQnERC+Mi+vbjkMFb9g6xGzypfZ6sPs
         Fk9R38bF5FepOSRgS4+0Zhg/8Thzr7zOAQ0LO1UDIGRin+ZYSvxJABHV+jczl1Y5zKnd
         UdW/Ez8kF6mAUiE+RtvjfWtW7jAVfxwmhpeAlmW+Tgh4B7rhlwtjPk01bn8uJ5k2Nlrc
         lzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661657; x=1691253657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9GE3hSd67E8eCq4M6r1SzwMp8TikzZJ0WrTWmk8JY8=;
        b=eyRQuoSwhoW+CChvw2Hp923ja/xGFzFBxz8/Gq+k6WfjNwwSmw/pW6WGgbr8k2Bmla
         my+PW4kpUk6+qVM0SfnaF2MG79xlpuWcv0J+DQmHdLdU4CJOdw7jKHorGWPAf+3/wWY2
         wf2qf7wOCG0A4PmNsPoa+iwyjvrMpPwU41cwtU5HbzId8VRe+5gGeF+5FnQRV38eT6Ra
         iUJkqFHF82DvDEptF+XEoeAsLzkZVghJ6lCS3QSbqYe9yUUajs+paX5QbRgb/hyi0lV6
         ha7FCzLpJqYdFPFBOUGXxWVG0TwlOkw45PSGhs9leT9ppEvfhKPLFQ5msnrDe+sbJW/U
         Eodw==
X-Gm-Message-State: ABy/qLYZINooXakLb1989D4gFb1gA8WXLTpQfTyEq0ktSaqiHBWlQJTH
        S+ocfP6FIaxAA+duQ3wxKeDmYw==
X-Google-Smtp-Source: APBJJlFjJUZiCn5H4tSF9ULQzki4mS6ibQnMRCsPD1OEN2sycygBgn5CV067fR8xSFFAsBCyHoswLA==
X-Received: by 2002:a25:ac2:0:b0:c60:5fa5:c0b0 with SMTP id 185-20020a250ac2000000b00c605fa5c0b0mr3262678ybk.19.1688661656888;
        Thu, 06 Jul 2023 09:40:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b8-20020a5b0088000000b00c6135ffd2fcsm410897ybp.15.2023.07.06.09.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:40:56 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:40:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        djwong@kernel.org, dchinner@redhat.com, sandeen@redhat.com,
        willy@infradead.org, tytso@mit.edu, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230706164055.GA2306489@perftesting>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706155602.mnhsylo3pnief2of@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 11:56:02AM -0400, Kent Overstreet wrote:
> On Mon, Jun 26, 2023 at 05:47:01PM -0400, Kent Overstreet wrote:
> > Hi Linus,
> > 
> > Here it is, the bcachefs pull request. For brevity the list of patches
> > below is only the initial part of the series, the non-bcachefs prep
> > patches and the first bcachefs patch, but the diffstat is for the entire
> > series.
> > 
> > Six locks has all the changes you suggested, text size went down
> > significantly. If you'd still like this to see more review from the
> > locking people, I'm not against them living in fs/bcachefs/ as an
> > interim; perhaps Dave could move them back to kernel/locking when he
> > starts using them or when locking people have had time to look at them -
> > I'm just hoping for this to not block the merge.
> > 
> > Recently some people have expressed concerns about "not wanting a repeat
> > of ntfs3" - from what I understand the issue there was just severe
> > buggyness, so perhaps showing the bcachefs automated test results will
> > help with that:
> > 
> >   https://evilpiepirate.org/~testdashboard/ci
> > 
> > The main bcachefs branch runs fstests and my own test suite in several
> > varations, including lockdep+kasan, preempt, and gcov (we're at 82% line
> > coverage); I'm not currently seeing any lockdep or kasan splats (or
> > panics/oopses, for that matter).
> > 
> > (Worth noting the bug causing the most test failures by a wide margin is
> > actually an io_uring bug that causes random umount failures in shutdown
> > tests. Would be great to get that looked at, it doesn't just affect
> > bcachefs).
> > 
> > Regarding feature status - most features are considered stable and ready
> > for use, snapshots and erasure coding are both nearly there. But a
> > filesystem on this scale is a massive project, adequately conveying the
> > status of every feature would take at least a page or two.
> > 
> > We may want to mark it as EXPERIMENTAL for a few releases, I haven't
> > done that as yet. (I wouldn't consider single device without snapshots
> > to be experimental, but - given that the number of users and bug reports
> > is about to shoot up, perhaps I should...).
> 
> Restarting the discussion after the holiday weekend, hoping to get
> something more substantive going:
> 
> Hoping to get:
>  - Thoughts from people who have been following bcachefs development,
>    and people who have looked at the code
>  - Continuation of the LSF discussion - maybe some people could repeat
>    here what they said there (re: code review, iomap, etc.)
>  - Any concerns about how this might impact the rest of the kernel, or
>    discussion about what impact merging a new filesystem is likely to
>    have on other people's work
> 
> AFAIK the only big ask that hasn't happened yet is better documentation:
> David Howells wanted (better) a man page, which is definitely something
> that needs to happen but it'll be some months before I'm back to working
> on documentation - I'm happy to share my current list of priorities if
> that would be helpful.
> 
> In the meantime, the Latex principles of operation is reasonably up to
> date (and I intend to greatly expand the sections on on disk data
> structures, I think that'll be great reference documentation for
> developers getting up to speed on the code)
> 
> https://bcachefs.org/bcachefs-principles-of-operation.pdf
> 
> I feel that bcachefs is in a pretty mature state at this point, but it's
> also _huge_, which is a bit different than e.g. the btrfs merger; it's
> hard to know where to start to get a meaninful discussion/review process
> going.
> 
> Patch bombing the mailing list with 90k loc is clearly not going to be
> productive, which is why I've been trying to talk more about development
> process and status - but all suggestions and feedback are welcome.

I've been watching this from the sidelines sort of busy with other things, but I
realize that comments I made at LSFMMBPF have been sort of taken as the gospel
truth and I want to clear some of that up.

I said this at LSFMMBPF, and I haven't said it on list before so I'll repeat it
here.

I'm of the opinion that me and any other outsider reviewing the bcachefs code in
bulk is largely useless.  I could probably do things like check for locking
stuff and other generic things.

You have patches that are outside of fs/bcachefs.  Get those merged and then do
a pull with just fs/bcachefs, because again posting 90k loc is going to be
unwieldy and the quality of review just simply will not make a difference.

Alternatively rework your code to not have any dependencies outside of
fs/bcachefs.  This is what btrfs did.  That merge didn't touch anything outside
of fs/btrfs.

This merge attempt has gone off the rails, for what appears to be a few common
things.

1) The external dependencies.  There's a reason I was really specific about what
I said at LSFMMBPF, both this year and in 2022.  Get these patches merged first,
the rest will be easier.  You are burning a lot of good will being combative
with people over these dependencies.  This is not the hill to die on.  You want
bcachefs in the kernel and to get back to bcachefs things.  Make the changes you
need to make to get these dependencies in, or simply drop the need for them and
come back to it later after bcachefs is merged.

2) We already have recent examples of merge and disappear.  Yes of course you've
been around for a long time, you aren't the NTFS developers.  But as you point
out it's 90k of code.  When btrfs was merged there were 3 large contributors,
Chris, myself, and Yanzheng.  If Chris got hit by a bus we could still drive the
project forward.  Can the same be said for bachefs?  I know others have chimed
in and done some stuff, but as it's been stated elsewhere it would be good to
have somebody else in the MAINTAINERS file with you.

I am really, really wanting you to succeed here Kent.  If the general consensus
is you need to have some idiot review fs/bcachefs I will happily carve out some
time and dig in.

At this point however it's time to be pragmatic.  Stop dying on every hill, it's
not worth it.  Ruthlessly prioritize and do what needs to be done to get this
thing merged.  Christian saying he's almost ready to stop replying should be a
wakeup call that your approach is not working.  Thanks,

Josef
