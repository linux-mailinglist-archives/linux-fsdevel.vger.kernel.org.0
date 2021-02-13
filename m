Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22EC31A8E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 01:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBMAnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 19:43:00 -0500
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:38212 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229718AbhBMAm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 19:42:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 94826183F96AD;
        Sat, 13 Feb 2021 00:42:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6691:7522:7576:7652:7914:10004:10400:10848:10967:11232:11658:11783:11914:12043:12262:12297:12438:12555:12679:12740:12895:13095:13161:13181:13229:13439:13894:14096:14097:14181:14659:14721:21080:21324:21433:21451:21611:21627:21795:30003:30030:30034:30051:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: eggs62_5c0b6cc27625
X-Filterd-Recvd-Size: 3191
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Feb 2021 00:42:16 +0000 (UTC)
Message-ID: <daf1eeca2d1176bbd53a1f84b5289addb6381814.camel@perches.com>
Subject: Re: [PATCH] proc: Convert S_<FOO> permission uses to octal
From:   Joe Perches <joe@perches.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Feb 2021 16:42:15 -0800
In-Reply-To: <m1ft20zw3j.fsf@fess.ebiederm.org>
References: <85ff6fd6b26aafdf6087666629bad3acc29258d8.camel@perches.com>
         <m1im6x0wtv.fsf@fess.ebiederm.org>
         <20210212221918.GA2858050@casper.infradead.org>
         <m1ft20zw3j.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-02-12 at 17:48 -0600, Eric W. Biederman wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > On Fri, Feb 12, 2021 at 04:01:48PM -0600, Eric W. Biederman wrote:
> > > Perhaps we can do something like:
> > > 
> > > #define S_IRWX 7
> > > #define S_IRW_ 6
> > > #define S_IR_X 5
> > > #define S_IR__ 4
> > > #define S_I_WX 3
> > > #define S_I_W_ 2
> > > #define S_I__X 1
> > > #define S_I___ 0
> > > 
> > > #define MODE(TYPE, USER, GROUP, OTHER) \
> > > 	(((S_IF##TYPE) << 9) | \
> > >          ((S_I##USER)  << 6) | \
> > >          ((S_I##GROUP) << 3) | \
> > >          (S_I##OTHER))
> > > 
> > > Which would be used something like:
> > > MODE(DIR, RWX, R_X, R_X)
> > > MODE(REG, RWX, R__, R__)
> > > 
> > > Something like that should be able to address the readability while
> > > still using symbolic constants.
> > 
> > I think that's been proposed before.
> 
> I don't think it has ever been shot down.  Just no one care enough to
> implement it.

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Aug 2016 16:58:29 -0400
Message-ID: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com> (raw)

[ So I answered similarly to another patch, but I'll just re-iterate
and change the subject line so that it stands out a bit from the
millions of actual patches ]

On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> S_IRCRP | S_IROTH (*). Please don't do this.

Absolutely. It's *much* easier to parse and understand the octal
numbers, while the symbolic macro names are just random line noise and
hard as hell to understand. You really have to think about it.

So we should rather go the other way: convert existing bad symbolic
permission bit macro use to just use the octal numbers.

The symbolic names are good for the *other* bits (ie sticky bit, and
the inode mode _type_ numbers etc), but for the permission bits, the
symbolic names are just insane crap. Nobody sane should ever use them.
Not in the kernel, not in user space.


