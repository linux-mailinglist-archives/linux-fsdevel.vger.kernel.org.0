Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C9593BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 07:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfF1Fvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 01:51:46 -0400
Received: from verein.lst.de ([213.95.11.210]:45164 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbfF1Fvq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:51:46 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 41F6268CEE; Fri, 28 Jun 2019 07:51:43 +0200 (CEST)
Date:   Fri, 28 Jun 2019 07:51:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] xfs: allow merging ioends over append boundaries
Message-ID: <20190628055143.GB27187@lst.de>
References: <20190627104836.25446-1-hch@lst.de> <20190627104836.25446-8-hch@lst.de> <20190627182309.GP5171@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182309.GP5171@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:23:09AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 27, 2019 at 12:48:30PM +0200, Christoph Hellwig wrote:
> > There is no real problem merging ioends that go beyond i_size into an
> > ioend that doesn't.  We just need to move the append transaction to the
> > base ioend.  Also use the opportunity to use a real error code instead
> > of the magic 1 to cancel the transactions, and write a comment
> > explaining the scheme.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reading through this patch, I have a feeling it fixes the crash that
> Zorro has been seeing occasionally with generic/475...

So you think for some reason the disk i_size changes underneath and thus
the xfs_ioend_is_append misfired vs the actual transaction allocations?
I didn't even think of that, but using the different checks sure sounds
dangerous.  So yes, we'd either need to backport my patch, or at least
replace the checks in xfs_ioend_can_merge with direct checks of
io_append_trans.
