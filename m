Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C518CF2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 08:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfJHGmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 02:42:39 -0400
Received: from verein.lst.de ([213.95.11.211]:44117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbfJHGmj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:42:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 743D468B20; Tue,  8 Oct 2019 08:42:35 +0200 (CEST)
Date:   Tue, 8 Oct 2019 08:42:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH 08/11] xfs: use a struct iomap in xfs_writepage_ctx
Message-ID: <20191008064235.GB30465@lst.de>
References: <20191006154608.24738-1-hch@lst.de> <20191006154608.24738-9-hch@lst.de> <20191007215423.GB16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007215423.GB16973@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:54:24AM +1100, Dave Chinner wrote:
> > +	if (whichfork == XFS_COW_FORK)
> > +		flags |= IOMAP_F_SHARED;
> 
> That seems out of place - I don't see anywhere in this patch that
> moves/removes setting the IOMAP_F_SHARED flag. i.e this looks like a
> change of behaviour....

It is a change of representation, not behavior.  Before this patch we
used a struct xfs_bmbt_irec + int fork in xfs_writepage_ctx to hold the
current writeback extent.  We now use a iomap, which wants this flag to
have the fork information.  The fork flag is removed later when switching
to the iomap implementation to avoid extra churn.

Before Darricks reshuffling there was an extra patch making this
transition more clear:

	http://git.infradead.org/users/hch/xfs.git/commitdiff/5274577088ffcfcfbf735dcfe4153d699027caad

but since the series was turned upside down and creates the iomap code
out of the thin air all these easy to understand and verify step by
step changes to the existing xfs codebase got lost unfortunately.
