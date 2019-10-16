Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22DFD8A8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbfJPIKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 04:10:14 -0400
Received: from verein.lst.de ([213.95.11.211]:59621 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391446AbfJPIKN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:10:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6964768B20; Wed, 16 Oct 2019 10:10:09 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:10:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] iomap: lift the xfs writeback code to iomap
Message-ID: <20191016081009.GA24284@lst.de>
References: <20191015154345.13052-1-hch@lst.de> <20191015154345.13052-10-hch@lst.de> <20191015220721.GC16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015220721.GC16973@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:07:21AM +1100, Dave Chinner wrote:
> > +/*
> > + * We implement an immediate ioend submission policy here to avoid needing to
> > + * chain multiple ioends and hence nest mempool allocations which can violate
> > + * forward progress guarantees we need to provide. The current ioend we are
> > + * adding blocks to is cached on the writepage context, and if the new block
> 
> adding pages to ... , and if the new block mapping

So reviewing this comment I disagree with the change.  We add on a per-
block basis to the ioend, not a per-page one.  Similar for the second 
one it is the block that needs to append (which is defined by the
mapping, but still..).
