Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6C8A5BC6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfIBRSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:18:05 -0400
Received: from verein.lst.de ([213.95.11.211]:51712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfIBRSF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:18:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D715968AFE; Mon,  2 Sep 2019 19:18:00 +0200 (CEST)
Date:   Mon, 2 Sep 2019 19:18:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 01/15] iomap: Introduce CONFIG_FS_IOMAP_DEBUG
Message-ID: <20190902171800.GA7201@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de> <20190901200836.14959-2-rgoldwyn@suse.de> <20190902162934.GA6263@lst.de> <20190902170916.GE568270@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902170916.GE568270@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 10:09:16AM -0700, Darrick J. Wong wrote:
> On Mon, Sep 02, 2019 at 06:29:34PM +0200, Christoph Hellwig wrote:
> > On Sun, Sep 01, 2019 at 03:08:22PM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > 
> > > To improve debugging abilities, especially invalid option
> > > asserts.
> > 
> > Looking at the code I'd much rather have unconditional WARN_ON_ONCE
> > statements in most places.  Including returning an error when we see
> > something invalid in most cases.
> 
> Yeah, I was thinking something like this, which has the advantage that
> the report format is familiar to XFS developers and will get picked up
> by the automated error collection stuff I put in xfstests to complain
> about any XFS assertion failures:
> 
> iomap: Introduce CONFIG_FS_IOMAP_DEBUG
> 
> To improve debugging abilities, especially invalid option
> asserts.

I'd actually just rather have more unconditional WARN_ON_ONCE calls,
including actually recovering from the situation by return an actual
error code.  That is more

	if (WARN_ON_ONCE(some_impossible_condition))
		return -EIO;
