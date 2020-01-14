Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891E5139EB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 02:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgANBBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 20:01:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgANBBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q1T/kDYJScgPBVdiW6AHznKBMH3nnxOq7ZMmglnT2hw=; b=IEgnpqRPWJJYQTMHZlh71PWOW
        fzTTOmkXZh7QiwXiaQuqLE3M2xHTQROFBog9g5DuoQ+lZL/FHq9oBvb7HJ+wyYxfvpmFstG1dl1jx
        kkWVmzHioSHK+syDLLwmCxwDUeN7TFEA3WY3Ksvrqg8PPqpSc5KqIR0eSIsaD+6lIMB5JvMtRwzxD
        c0XQviim4dv203M+2Ly4VSANe4sFpPr2Sg5gW6MzeAWGf58Yj4ekTRlK8eo2cVuigfoR5fuuJNTYt
        1lfOcsYQmiiPha88rIepnmaeZHZy3gXtShsDpQq3pASCJeV3EPTmqxaPanCqY/bTkXjFX/Gl6Tm47
        wutFHjWUg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irAaO-0003DV-Vm; Tue, 14 Jan 2020 01:01:36 +0000
Date:   Mon, 13 Jan 2020 17:01:36 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC 0/8] Replacing the readpages a_op
Message-ID: <20200114010136.GA25922@bombadil.infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
 <6CA4CD96-0812-4261-8FF9-CD28AA2EC38A@fb.com>
 <20200113174008.GB332@bombadil.infradead.org>
 <15C84CC9-3196-441D-94DE-F3FD7AC364F0@fb.com>
 <20200113215811.GA18216@bombadil.infradead.org>
 <910af281-4e2b-3e5d-5533-b5ceafd59665@kernel.dk>
 <20200113221047.GB18216@bombadil.infradead.org>
 <1b94e6b6-29dc-2e90-d1ca-982accd3758c@kernel.dk>
 <20200113222704.GC18216@bombadil.infradead.org>
 <F1FD3E8B-AC7E-48AB-99CD-E5D8E71851EE@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F1FD3E8B-AC7E-48AB-99CD-E5D8E71851EE@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:34:16PM +0000, Chris Mason wrote:
> On 13 Jan 2020, at 17:27, Matthew Wilcox wrote:
> > On Mon, Jan 13, 2020 at 03:14:26PM -0700, Jens Axboe wrote:
> >> On 1/13/20 3:10 PM, Matthew Wilcox wrote:
> >>> On Mon, Jan 13, 2020 at 03:00:40PM -0700, Jens Axboe wrote:
> >>>> On 1/13/20 2:58 PM, Matthew Wilcox wrote:
> >>>>> Why don't we store a bio pointer inside the plug?  You're 
> >>>>> opencoding that,
> >>>>> iomap is opencoding that, and I bet there's a dozen other places 
> >>>>> where
> >>>>> we pass a bio around.  Then blk_finish_plug can submit the bio.
> >>>>
> >>>> Plugs aren't necessarily a bio, they can be callbacks too.
> >>
> >> It's a little odd imho, the plugging generally collect requests. 
> >> Sounds
> >> what you're looking for is some plug owner private data, which just
> >> happens to be a bio in this case?
> >>
> >> Is this over repeated calls to some IO generating helper? Would it be
> >> more efficient if that helper could generate the full bio in one go,
> >> instead of piecemeal?
> >
> > The issue is around ->readpages.  Take a look at how iomap_readpages
> > works, for example.  We're under a plug (taken in mm/readahead.c),
> > but we still go through the rigamarole of keeping a pointer to the bio
> > in ctx.bio and passing ctx around so that we don't end up with many
> > fragments which have to be recombined into a single bio at the end.
> >
> > I think what I want is a bio I can reach from current, somehow.  And 
> > the
> > plug feels like a natural place to keep it because it's basically 
> > saying
> > "I want to do lots of little IOs and have them combined".  The fact 
> > that
> > the iomap code has a bio that it precombines fragments into suggests 
> > to
> > me that the existing antifragmentation code in the plugging mechanism
> > isn't good enough.  So let's make it better by storing a bio in the 
> > plug
> > and then we can get rid of the bio in the iomap code.
> 
> Both btrfs and xfs do this, we have a bio that we pass around and build 
> and submit.  We both also do some gymnastics in writepages to avoid 
> waiting for the bios we've been building to finish while we're building 
> them.
> 
> I love the idea of the plug api having a way to hold that for us, but 
> sometimes we really are building the bios, and we don't want the plug to 
> let it go if we happen to schedule.

The plug wouldn't have to let the bio go.  I appreciate the plug does let
requests go on context switch, but it wouldn't have to let the bio go.
This bio is being stored on the stack, just as now, so it's still there.
