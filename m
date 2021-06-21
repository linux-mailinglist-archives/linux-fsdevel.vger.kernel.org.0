Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF93AEB1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUOYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:24:52 -0400
Received: from verein.lst.de ([213.95.11.211]:42173 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFUOYv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:24:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D01A68B05; Mon, 21 Jun 2021 16:22:35 +0200 (CEST)
Date:   Mon, 21 Jun 2021 16:22:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20210621142235.GA2391@lst.de>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk> <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org> <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCfUoaTNyi4xiF+@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 03:16:50PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 21, 2021 at 04:09:56PM +0200, Christoph Hellwig wrote:
> > On Mon, Jun 21, 2021 at 03:03:07PM +0100, Matthew Wilcox wrote:
> > > i suggested that to viro last night, and he pointed out that ioctl(S_SYNC)
> > 
> > Where would that S_SYNC ioctl be implemented?
> 
> xfs_diflags_to_iflags(
>         if (xflags & FS_XFLAG_SYNC)
>                 flags |= S_SYNC;
> 
> (mutatis mutandi per filesystem)


Ok, your description above wasn't very exact.

Anyway, that at least doesn't go out to the superblock.  But if Al
dislikes it we can also make generic_sync_file and friends check
IS_SYNC() again.  Having a single flag is kinda nice as it avoids
stupid errors, but if we actually have a performance problem here
(do we have any data on that?) just going back to the old way would
seem like the simplest fix.
