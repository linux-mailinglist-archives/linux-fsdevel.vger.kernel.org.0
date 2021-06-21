Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAC3AEB7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 16:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUOhV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 10:37:21 -0400
Received: from verein.lst.de ([213.95.11.211]:42224 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhFUOhU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:37:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F22FC68BFE; Mon, 21 Jun 2021 16:35:02 +0200 (CEST)
Date:   Mon, 21 Jun 2021 16:35:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <20210621143501.GA3789@lst.de>
References: <YM/hZgxPM+2cP+I7@zeniv-ca.linux.org.uk> <20210621135958.GA1013@lst.de> <YNCcG97WwRlSZpoL@casper.infradead.org> <20210621140956.GA1887@lst.de> <YNCfUoaTNyi4xiF+@casper.infradead.org> <20210621142235.GA2391@lst.de> <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNCjDmqeomXagKIe@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:32:46PM +0000, Al Viro wrote:
> 	I'd rather have a single helper for those checks, rather than
> open-coding IS_SYNC() + IOCB_DSYNC in each, for obvious reasons...

Yes, I think something like:

static inline bool iocb_is_sync(struct kiocb *iocb)
{
	return (iocb->ki_flags & IOCB_DSYNC) ||
		S_SYNC(iocb->ki_filp->f_mapping->host);
}

should do the job.
