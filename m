Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177702AEA8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 08:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKKHzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 02:55:47 -0500
Received: from verein.lst.de ([213.95.11.211]:39061 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgKKHzq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:55:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C12F867373; Wed, 11 Nov 2020 08:55:43 +0100 (CET)
Date:   Wed, 11 Nov 2020 08:55:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] seq_file: add seq_read_iter
Message-ID: <20201111075543.GA22916@lst.de>
References: <20201104082738.1054792-1-hch@lst.de> <20201104082738.1054792-2-hch@lst.de> <20201110213253.GV3576660@ZenIV.linux.org.uk> <20201110213511.GW3576660@ZenIV.linux.org.uk> <20201110232028.GX3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110232028.GX3576660@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20:28PM +0000, Al Viro wrote:
> On Tue, Nov 10, 2020 at 09:35:11PM +0000, Al Viro wrote:
> > On Tue, Nov 10, 2020 at 09:32:53PM +0000, Al Viro wrote:
> > 
> > > AFAICS, not all callers want that semantics, but I think it's worth
> > > a new primitive.  I'm not saying it should be a prereq for your
> > > series, but either that or an explicit iov_iter_revert() is needed.
> > 
> > Seeing that it already went into mainline, it needs a followup fix.
> > And since it's not -stable fodder (AFAICS), I'd rather go with
> > adding a new primitive...
> 
> Any objections to the following?
> 
> Fix seq_read_iter() behaviour on full pipe
> 
> generic_file_splice_read() will purge what we'd left in pipe in case
> of error; it will *not* do so in case of short write, so we must make
> sure that reported amount of data stored by ->read_iter() matches the
> reality.
> 
> It's not a rare situation (and we already have it open-coded in at least
> one place), so let's introduce a new primitive - copy_to_iter_full().
> Similar to copy_from_iter_full(), it returns true if we had been able
> to copy everything we'd been asked to and false otherwise.  Iterator
> is advanced only on success.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks ok to me.
