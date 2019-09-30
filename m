Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC61AC1FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 13:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfI3LHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 07:07:35 -0400
Received: from verein.lst.de ([213.95.11.211]:36428 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfI3LHf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 07:07:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B590F68B20; Mon, 30 Sep 2019 13:07:31 +0200 (CEST)
Date:   Mon, 30 Sep 2019 13:07:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/19] iomap: use write_begin to read pages to unshare
Message-ID: <20190930110731.GA6987@lst.de>
References: <20190909182722.16783-1-hch@lst.de> <20190909182722.16783-7-hch@lst.de> <20190916183428.GK2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916183428.GK2229799@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 11:34:28AM -0700, Darrick J. Wong wrote:
> > -		if ((from <= poff || from >= poff + plen) &&
> > +		if (!(flags & IOMAP_WRITE_F_UNSHARE) &&
> 
> Mmm, archeology of code that I wrote originally and have forgotten
> already... :)
> 
> I think the purpose of F_UNSHARE is to mimic the behavior of the code
> that's being removed, and the old behavior is that if a user asks to
> unshare a page backed by shared extents we'll read in all the blocks
> backing the page, even if that means reading in blocks that weren't part
> of the original unshare request, right?

No.  The flag causes the code to always read the page, even if the iomap
range covers the whole block.  For normal writes that means we don't to
read the block in at all, but for unshare we absolutely must do so.
