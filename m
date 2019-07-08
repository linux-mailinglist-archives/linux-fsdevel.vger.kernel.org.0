Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304F9625F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfGHQTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 12:19:15 -0400
Received: from verein.lst.de ([213.95.11.211]:34828 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbfGHQTP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:19:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B33B3227A81; Mon,  8 Jul 2019 18:19:12 +0200 (CEST)
Date:   Mon, 8 Jul 2019 18:19:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: RFC: use the iomap writepage path in gfs2
Message-ID: <20190708161912.GA10233@lst.de>
References: <20190701215439.19162-1-hch@lst.de> <20190708000103.GH7689@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708000103.GH7689@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:01:03AM +1000, Dave Chinner wrote:
> Ok, this doesn't look too bad from the iomap perspective, though it
> does raise more questions. :)
> 
> gfs2 now has two iopaths, right? One that uses bufferheads for
> journalled data, and the other that uses iomap? That seems like it's
> only a partial conversion - what needs to be done to iomap and gfs2
> to support the journalled data path so there's a single data IO
> path?

gfs2 always had to very different writeback I/O paths, including a copy
and pasted versiom of write_cache_pages for journaled data, they just
diverge a little bit more now. In the longer run I'd also like to add
journaled data support to iomap for use with XFS, and then also switch
gfs2 to it. 
