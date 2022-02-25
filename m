Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96E44C51C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbiBYW4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 17:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYW4j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:56:39 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45881EF354;
        Fri, 25 Feb 2022 14:56:04 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 73FEF10E20E2;
        Sat, 26 Feb 2022 09:56:01 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nNjVI-00GQUL-9I; Sat, 26 Feb 2022 09:56:00 +1100
Date:   Sat, 26 Feb 2022 09:56:00 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Byron Stanoszek <gandalf@winds.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220225225600.GO3061737@dread.disaster.area>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
 <3ce45c23-2721-af6e-6cd7-648dc399597@winds.org>
 <YhfzUc8afuoQkx/U@casper.infradead.org>
 <257dc4a9-dfa0-327e-f05a-71c0d9742e98@winds.org>
 <20220225132300.GC18720@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225132300.GC18720@1wt.eu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62195e83
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=_MjYSGqaCGpKE7YW:21 a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=i9EhDj85i3cWi9GefWwA:9 a=CjuIK1q_8ugA:10 a=aebnku51ZD03SSuSuSm5:22
        a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 02:23:00PM +0100, Willy Tarreau wrote:
> On Fri, Feb 25, 2022 at 08:10:22AM -0500, Byron Stanoszek wrote:
> > On Thu, 24 Feb 2022, Matthew Wilcox wrote:
> > > On Wed, Feb 23, 2022 at 09:48:26AM -0500, Byron Stanoszek wrote:
> > > > For what it's worth, I have a number of production servers still using
> > > > Reiserfs, which I regularly maintain by upgrading to the latest Linux kernel
> > > > annually (mostly to apply security patches). I figured this filesystem would
> > > > still be available for several more years, since it's not quite y2038k yet.
> > > 
> > > Hey Byron, thanks for sharing your usage.
> > > 
> > > It's not entirely clear to me from your message whether you're aware
> > > that our annual LTS release actually puts out new kernels every week (or
> > > sometimes twice a week), and upgrades to the latest version are always
> > > recommended.  Those LTS kernels typically get five years of support in
> > > total; indeed we just retired the v4.4 series earlier this month which
> > > was originally released in January 2016, so it got six years of support.
> > > 
> > > If we dropped reiserfs from the kernel today (and thanks to Edward, we
> > > don't have to), you'd still be able to use a v5.15 based kernel with
> > > regular updates until 2028.  If we drop it in two years, that should
> > > take you through to 2030.  Is that enough for your usage?
> > 
> > I'm aware of the LTS releases, but I hadn't thought about them in relation to
> > this issue. That's a good point, and so it sounds like I have nothing to worry
> > about.
> 
> This just makes me think that instead of speaking about deprecation in
> terms of version, speaking in terms of dates might be more suitable, as
> it should help discouraging distros or products shipping LTS kernels
> from enabling such deprecated features: when you're told the features
> will disappear after, say, 5.20, some might think "OK 5.20 is the last
> one and it happens to be LTS so I get the feature for 6 extra years
> after it's EOL".

This is exactly why the XFS deprecation schedules are dated while
the actual removals record kernel releases. If it gets released in
a kernel, then it technically is supported for the life of that
kernel, even if it is a LTS kernel and the functionality no long
exists upstream.

That is, we know that once we've removed something from upstream,
it's still going to be actively used in LTS kernels based on kernels
that still have that functionality. Same goes for enterprise
kernels. Hence deprecation policies need to first acknowledge the
typical "no regressions" policies for LTS kernels...

With that in mind, this is why we've already deprecated non-y2038k
compliant functionality in XFS so that enterprise kernels can mark
it deprecated in their next major (N + 1) release which will be
supported for 10 years. They can then remove that support it in the
N+2 major release after that (which is probably at least 5 years
down the track) so that the support window for non-compliant
functionality does not run past y2038k.

We chose this specifically because most of the XFS developers are
also responsible for maintaining enterprise distro kernels, and so
we always thinking about how we are going to maintain the upstream
code we release today because it will have a 10-15 year active
support life.  This is also why the deprecation notice in
Documentation/admin-guide/xfs.rst has this caveat:

	Note: Distributors may choose to withdraw V4 format support earlier than
	the dates listed above.

Distros might chose to remove deprecated functionality immediately
rather than rely on, say, LTS kernel support for functionality that
upstream developers are clearly not focussing their efforts on
developing further.

Hence we have to acknowledge that fact that once upstream has
deprecated a feature, it's up to distros to decide how they want to
handle long term support for that feature. The upstream LTS kernel
maintainers are going to have to decide on their own policy, too,
because we cannot bind upstream maintenance decisions on random
individual downstream support constraints. Downstream has to choose
for itself how it handles upstream deprecation notices but, that
said, upstream developers also need to listen to downstream distro
support and deprecation requirements...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
