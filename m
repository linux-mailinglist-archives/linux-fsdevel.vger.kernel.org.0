Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA0ED9070
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392819AbfJPMIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389612AbfJPMIR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2024987642;
        Wed, 16 Oct 2019 12:08:17 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D6B19C68;
        Wed, 16 Oct 2019 12:08:14 +0000 (UTC)
Date:   Wed, 16 Oct 2019 08:08:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] iomap: lift the xfs writeback code to iomap
Message-ID: <20191016120813.GA40434@bfoster>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-10-hch@lst.de>
 <20191015220721.GC16973@dread.disaster.area>
 <20191016074836.GB23696@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016074836.GB23696@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 16 Oct 2019 12:08:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:48:36AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 16, 2019 at 09:07:21AM +1100, Dave Chinner wrote:
...
> > > +/*
> > > + * Submit the bio for an ioend. We are passed an ioend with a bio attached to
> > > + * it, and we submit that bio. The ioend may be used for multiple bio
> > > + * submissions, so we only want to allocate an append transaction for the ioend
> > > + * once.  In the case of multiple bio submission, each bio will take an IO
> > 
> > This needs to be changed to describe what wpc->ops->submit_ioend()
> > is used for rather than what XFS might use this hook for.
> 
> True.  The real documentation now is in the header near the ops defintion,
> but I'll update this one to make more sense as well.
> 
> > > +static int
> > > +iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
> > > +		int error)
> > > +{
> > > +	ioend->io_bio->bi_private = ioend;
> > > +	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
> > > +
> > > +	if (wpc->ops->submit_ioend)
> > > +		error = wpc->ops->submit_ioend(ioend, error);
> > 
> > I'm not sure that "submit_ioend" is the best name for this method,
> > as it is a pre-bio-submission hook, not an actual IO submission
> > method. "prepare_ioend_for_submit" is more descriptive, but probably
> > too long. wpc->ops->prepare_submit(ioend, error) reads pretty well,
> > though...
> 
> Not a huge fan of that name either, but Brian complained.  Let's hold
> a popular vote for a name and see if we have a winner.
> 

Just to recall, I suggested something like ->pre_submit_ioend() back in
v5. Short of that, I asked for extra comments to clearly document
semantics which I believe Christoph added to the header, and I acked (it
looks like the handful of R-B tags I sent were all dropped btw...? Have
all of those patches changed?).

To give my .02 on the naming thing, I care about functional clarity more
than aesthetics. In that regard, ->submit_ioend() reads like a
submission hook and thus sounds rather confusing to me when I don't see
it actually submit anything. ->pre_submit_ioend(), ->prepare_ioend() or
->prepare_submission() all clearly indicate semantics to me, so I'm good
with any of those over ->submit_ioend(). :)

Brian

> As for the grammar comments - all this is copied over as-is.  I'll add
> another patch to fix that up.
> 
