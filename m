Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC0139C69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 23:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgAMW1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 17:27:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMW1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SxeMrcw8VfwoTo9Q+GzAW5ii85Q073aK0lgVbFxIoE4=; b=fX/j+1OwGRaQw1c6OulAfDSmc
        vF070DKVrwwzQje2r/Ium//k5I3u9hwozV+Xoa4216mfL+YrUwXzxsJrQMDOIkCkCRw5Ct9LS8p9j
        AkAjnyuhUi4vpw7Nm8PKBgtAmM3TlMP2BA/2l7bdHal6njOrB193U4SxKHpSIDARKyrB+ONzZiDnw
        UKf2El+WNSNNn16tg9v+RbOknmcaG4kM7NeLckDlBDewswSWtw1XrqnB81tsyErYzirIttekNgVrP
        70YlWvPwuqWdZ0zE8jKHMy+LTiuwvl9eWBFZZmsN2It2mJmUiFmrAsaTbjPEeLnvksPaRvmoyTS77
        HMOmJcTMg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir8Aq-0006Ri-Nz; Mon, 13 Jan 2020 22:27:04 +0000
Date:   Mon, 13 Jan 2020 14:27:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chris Mason <clm@fb.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200113222704.GC18216@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
 <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:14:26PM -0700, Jens Axboe wrote:
> On 1/13/20 3:10 PM, Matthew Wilcox wrote:
> > On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
> >> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
> >>> On Mon, Jan 13, 2020 at 06:00:52PM +0000, Chris Mason wrote:
> >>>> This is true, I didn't explain that part well ;)  Depending on 
> >>>> compression etc we might end up poking the xarray inside the actual IO 
> >>>> functions, but the main difference is that btrfs is building a single 
> >>>> bio.  You're moving the plug so you'll merge into single bio, but I'd 
> >>>> rather build 2MB bios than merge them.
> >>>
> >>> Why don't we store a bio pointer inside the plug?  You're opencoding that,
> >>> iomap is opencoding that, and I bet there's a dozen other places where
> >>> we pass a bio around.  Then blk_finish_plug can submit the bio.
> >>
> >> Plugs aren't necessarily a bio, they can be callbacks too.
> > 
> > I'm thinking something as simple as this:
>
> It's a little odd imho, the plugging generally collect requests. Sounds
> what you're looking for is some plug owner private data, which just
> happens to be a bio in this case?
> 
> Is this over repeated calls to some IO generating helper? Would it be
> more efficient if that helper could generate the full bio in one go,
> instead of piecemeal?

The issue is around ->readpages.  Take a look at how iomap_readpages
works, for example.  We're under a plug (taken in mm/readahead.c),
but we still go through the rigamarole of keeping a pointer to the bio
in ctx.bio and passing ctx around so that we don't end up with many
fragments which have to be recombined into a single bio at the end.

I think what I want is a bio I can reach from current, somehow.  And the
plug feels like a natural place to keep it because it's basically saying
"I want to do lots of little IOs and have them combined".  The fact that
the iomap code has a bio that it precombines fragments into suggests to
me that the existing antifragmentation code in the plugging mechanism
isn't good enough.  So let's make it better by storing a bio in the plug
and then we can get rid of the bio in the iomap code.
