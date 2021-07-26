Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D303D5564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhGZHjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 03:39:18 -0400
Received: from verein.lst.de ([213.95.11.211]:44281 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233376AbhGZHjQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:39:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFDB567373; Mon, 26 Jul 2021 10:19:42 +0200 (CEST)
Date:   Mon, 26 Jul 2021 10:19:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 16/27] iomap: switch iomap_bmap to use iomap_iter
Message-ID: <20210726081942.GD14853@lst.de>
References: <20210719103520.495450-1-hch@lst.de> <20210719103520.495450-17-hch@lst.de> <20210719170545.GF22402@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719170545.GF22402@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 10:05:45AM -0700, Darrick J. Wong wrote:
> >  	bno = 0;
> > -	ret = iomap_apply(inode, pos, blocksize, 0, ops, &bno,
> > -			  iomap_bmap_actor);
> > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > +		if (iter.iomap.type != IOMAP_MAPPED)
> > +			continue;
> 
> There isn't a mapped extent, so return 0 here, right?

We can't just return 0, we always need the final iomap_iter() call
to clean up in case a ->iomap_end method is supplied.  No for bmap
having and needing one is rather theoretical, but people will copy
and paste that once we start breaking the rules.
