Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A12D4BB191
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407237AbfIWJmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 05:42:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407121AbfIWJmX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:42:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 994A8AF55;
        Mon, 23 Sep 2019 09:42:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E1C71E4669; Mon, 23 Sep 2019 11:42:36 +0200 (CEST)
Date:   Mon, 23 Sep 2019 11:42:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        zhengbin <zhengbin13@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] fanotify cleanup for v5.4-rc1
Message-ID: <20190923094236.GB20367@quack2.suse.cz>
References: <20190920110017.GA25765@quack2.suse.cz>
 <CAHk-=wgr6kuKo76xcaUa-TSw83N+nbHJn9AkVJ9Zzv8b0feHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgr6kuKo76xcaUa-TSw83N+nbHJn9AkVJ9Zzv8b0feHQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting full email for Matthew and Zhengbin to have context.

On Sat 21-09-19 14:10:52, Linus Torvalds wrote:
> On Fri, Sep 20, 2019 at 4:00 AM Jan Kara <jack@suse.cz> wrote:
> >
> >   could you please pull from
> 
> Pulled and then unpulled.
> 
> This is a prime example of a "cleanup" that should never ever be done,
> and a compiler warning that is a disgrace and shouldn't happen.
> 
> This code:
> 
>         WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> 
> is obvious and makes sense. It clearly and unambiguously checks that
> 'len' is in the specified range.
> 
> In contrast, this code:
> 
>         WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
> 
> quite naturally will make a human wonder "what about negative values".
>
> Yes, it turns out that "len" is unsigned.  That isn't actually
> immediately obvious to a human, since the declaration of 'len' is 20+
> lines earlier (and even then the type doesn't say "unsigned", although
> a lot of people do recognize "size_t" as such).
> 
> In fact,  maybe some day the type will change, and the careful range
> checking means that the code continues to work correctly.

Yeah, I was also a bit undecided about this patch because the check with
"len < 0" seems more obvious. But then decided to take it because we have a
very similar WARN_ON_ONCE() at the beginning of the function
(copy_fid_to_user()) making sure "len" is large enough. But seeing your
arguments I'll just drop the patch. Thanks for review!
 
> The fact that "len" is unsigned _is_ obvious to the compiler, which
> just means that now that compiler can ignore the "< 0" thing and
> optimize it away. Great.
> 
> But that doesn't make the compiler warning valid, and it doesn't make
> the patch any better.
> 
> When it comes to actual code quality, the version that checks against
> zero is the better version.
> 
> Please stop using -Wtype-limits with compilers that are too stupid to
> understand that range checking with the type range is sane.
> 
> Compilers that think that warning for the above kind of thing is ok
> are inexcusable garbage.
> 
> And compiler writers who think that the warning is a good thing can't
> see the forest for the trees. They are too hung up on a detail to see
> the big picture.
> 
> Why/how was this found in the first place? We don't enable type-limit
> checking by default.

The report has come from a CI system run at Huawei. Not sure what exactly
they run there.

> We may have to add an explicit
> 
>    ccflags-y += $(call cc-disable-warning, type-limits)
> 
> if these kinds of patches continue to happen, which would be sad.
> There are _valid_ type limits.
> 
> But this kind of range-based check is not a valid thing to warn about,
> and we shouldn't make the kernel source code worse just because the
> compiler is doing garbage things.
> 
>               Linus

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
