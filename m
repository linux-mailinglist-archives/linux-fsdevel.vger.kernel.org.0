Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3A435F02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJUK3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 06:29:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60850 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJUK3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:29:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F68E1FDAC;
        Thu, 21 Oct 2021 10:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634812050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l4CmcbGiUE6TXiVFsiIAM6k/VKLp51ANmkDrpUZ63zM=;
        b=Oiz0jiaU6hvj8nGCH0fSGOeSVxcZ3yhiH1vQ50E9ah7NBk++5F4jTXDNyIw8OjY0obZlse
        kmOn2cth6FQ+neI9GqDJlBE0h9K0ld/iMeT3SYYlfCewsN2ZLvBfQ+V7aE0sq/h4eEetKc
        qEwk9rRZPvOi2K54lSywbbjGw4QbhWY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3C8AEA3B85;
        Thu, 21 Oct 2021 10:27:30 +0000 (UTC)
Date:   Thu, 21 Oct 2021 12:27:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
References: <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163481121586.17149.4002493290882319236@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 21:13:35, Neil Brown wrote:
> On Thu, 21 Oct 2021, Uladzislau Rezki wrote:
> > On Wed, Oct 20, 2021 at 05:00:28PM +0200, Uladzislau Rezki wrote:
> > > >
> > > > On Wed 20-10-21 16:29:14, Uladzislau Rezki wrote:
> > > > > On Wed, Oct 20, 2021 at 4:06 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > [...]
> > > > > > As I've said I am OK with either of the two. Do you or anybody have any
> > > > > > preference? Without any explicit event to wake up for neither of the two
> > > > > > is more than just an optimistic retry.
> > > > > >
> > > > > From power perspective it is better to have a delay, so i tend to say
> > > > > that delay is better.
> > > >
> > > > I am a terrible random number generator. Can you give me a number
> > > > please?
> > > >
> > > Well, we can start from one jiffy so it is one timer tick: schedule_timeout(1)
> > > 
> > A small nit, it is better to replace it by the simple msleep() call: msleep(jiffies_to_msecs(1));
> 
> I disagree.  I think schedule_timeout_uninterruptible(1) is the best
> wait to sleep for 1 ticl
> 
> msleep() contains
>   timeout = msecs_to_jiffies(msecs) + 1;
> and both jiffies_to_msecs and msecs_to_jiffies might round up too.
> So you will sleep for at least twice as long as you asked for, possible
> more.

That was my thinking as well. Not to mention jiffies_to_msecs just to do
msecs_to_jiffies right after which seems like a pointless wasting of
cpu cycle. But maybe I was missing some other reasons why msleep would
be superior.
-- 
Michal Hocko
SUSE Labs
