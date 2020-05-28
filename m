Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276701E6AF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 21:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406413AbgE1T3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 15:29:35 -0400
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:55222 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406289AbgE1T3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 15:29:34 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 15:29:33 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id F0BBE1816084F;
        Thu, 28 May 2020 19:22:18 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E2F38AE562;
        Thu, 28 May 2020 19:22:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2525:2553:2561:2564:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3834:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:4823:5007:6119:6691:9025:9110:10004:10226:10400:10848:11232:11658:11914:12043:12050:12297:12555:12663:12679:12740:12760:12895:13439:14181:14659:14721:21080:21221:21324:21451:21627:21740:21788:30003:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: whip46_381349b26d5d
X-Filterd-Recvd-Size: 3543
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 May 2020 19:22:09 +0000 (UTC)
Message-ID: <f68b7797aa73452d99508bdaf2801b3d141e7a69.camel@perches.com>
Subject: Re: clean up kernel_{read,write} & friends v2
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Date:   Thu, 28 May 2020 12:22:08 -0700
In-Reply-To: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
References: <20200528054043.621510-1-hch@lst.de>
         <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-05-28 at 11:51 -0700, Linus Torvalds wrote:
> On Wed, May 27, 2020 at 10:40 PM Christoph Hellwig <hch@lst.de> wrote:
> > this series fixes a few issues and cleans up the helpers that read from
> > or write to kernel space buffers, and ensures that we don't change the
> > address limit if we are using the ->read_iter and ->write_iter methods
> > that don't need the changed address limit.
> 
> Apart from the "please don't mix irrelevant whitespace changes with
> other changes" comment, this looks fine to me.
> 
> And a rant related to that change: I'm really inclined to remove the
> checkpatch check for 80 columns entirely, but it shouldn't have been
> triggering for old lines even now.
> 
> Or maybe make it check for something more reasonable, like 100 characters.
> 
> I find it ironic and annoying how "checkpatch" warns about that silly
> legacy limit, when checkpatch itself then on the very next few lines
> has a line that is 124 columns wide

Yeah.  perl ain't c.

And this discussion has been had many times.

Here's one from 2009
https://lkml.org/lkml/2009/12/15/490

Another from 2012
https://lkml.org/lkml/2012/2/5/141

Line lengths checks are normally pretty silly.

Hard limits at 80 really don't work well, especially with
some of the 25+ character length identifiers used today.

I think a line length warning at 132 is generally reasonable
but it could depend on complexity and identifier lengths.

> And yes, that 124 character line has a good reason for it. But that's
> kind of the point. There are lots of perfectly fine reasons for longer
> lines.
> 
> I'd much rather check for "no deep indentation" or "no unnecessarily
> complex conditionals" or other issues that are more likely to be
> _real_ problems.

That deep indentation test already exists at 6 tabs.
Maybe it should be 5 instead.  Or maybe even 4, but
that's a pretty easy to need and common use case.

Tab depth use in the kernel is more or less

$ git grep -Poh '^\t+(if|do|while|for|switch)\b' | \
  sed -r 's/\w+//g' | \
  awk '{print length($0);}' | \
  sort | uniq -c | sort -rn
 903993 1
 339059 2
  89334 3
  18216 4
   3282 5
    605 6
    148 7
     36 8
      4 9
      1 10

> But do we really have 80x25 terminals any more that
> we'd care about?

trivial btw: VT100s were 80x24 or 132x24, PCs were 80x25


