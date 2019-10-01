Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067E1C2D7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 08:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfJAG0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 02:26:10 -0400
Received: from verein.lst.de ([213.95.11.211]:42661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfJAG0K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:26:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2EC1168B20; Tue,  1 Oct 2019 08:26:07 +0200 (CEST)
Date:   Tue, 1 Oct 2019 08:26:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] xfs: fill out the srcmap in iomap_begin
Message-ID: <20191001062605.GA3596@lst.de>
References: <20190909182722.16783-1-hch@lst.de> <20190909182722.16783-13-hch@lst.de> <20190918175228.GE2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918175228.GE2229799@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:52:28AM -0700, Darrick J. Wong wrote:
> TBH I've been wondering for a while now if it would make more sense to
> do this in iomap_apply (and the open-coded versions in dax.c):
> 
> 	struct iomap srcmap = { .type = IOMAP_HOLE };
> 
> in the iomap_apply function (and change the "if (!srcmap.type)" checks
> to "if (srcmap.type != IOMAP_HOLE)").  That would get rid of the weird
> situation where iomap.h doesn't define an iomap type name corresponding
> to 0 but clearly it has some special meaning because the iomap code
> changes behavior based on that.
> 
> It also strikes me as weird that for the @imap parameter, type == 0
> would be considered a coding error but for @srcmap, we use type == 0 to
> mean "no mapping" but we don't do that for @srcmap.type == IOMAP_HOLE.
> 
> I mention that because, if some ->iomap_begin function returns
> IOMAP_HOLE then iomap_apply will pass the (hole) srcmap as the second
> parameter to the ->actor function.  When that happens, iomap_write_begin
> call will try to fill in the rest of the page from @srcmap (which is
> hole), not the @iomap (which might not be a hole) which seems wrong.

I've renumber IOMAP_HOLE and initialized all the maps to it, that seems
like a nice improvement.

> As for this function, if we made the above change, then the conditional
> becomes unneccessary -- we know this is a COW write, so we call
> xfs_bmbt_to_iomap on both mappings and exit.  No need for special
> casing.

OTOH I can't really agree to this.  We now do pointless extra work
for a common case, which also seems a little confusing.  It also goes
again the future direction where at least for some cases I want to
avoid the imap lookup entirely if we don't need it.
