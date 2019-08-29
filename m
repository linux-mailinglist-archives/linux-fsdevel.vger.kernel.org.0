Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26203A1264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfH2HNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 03:13:16 -0400
Received: from verein.lst.de ([213.95.11.211]:43699 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfH2HNP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:13:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D32A68B20; Thu, 29 Aug 2019 09:13:12 +0200 (CEST)
Date:   Thu, 29 Aug 2019 09:13:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Carlos Maiolino <cmaiolino@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20190829071312.GE11909@lst.de>
References: <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io> <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-3-cmaiolino@redhat.com> <20190814111535.GC1885@lst.de> <7003.1566305430@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7003.1566305430@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:50:30PM +0100, David Howells wrote:
> Carlos Maiolino <cmaiolino@redhat.com> wrote:
> 
> > > > +	block = page->index;
> > > > +	block <<= shift;
> > > 
> > > Can't this cause overflows?
> > 
> > Hmm, I honestly don't know. I did look at the code, and I couldn't really spot
> > anything concrete.
> 
> Maybe, though we'd have to support file sizes over 16 Exabytes for that to be
> a problem.

On 32-bit sysems page->index is a 32-bit value, so you'd overflow at
pretty normal sizes of a few TB.

> Note that bmap() is *only* used to find out if the page is present in the
> cache - and even that I'm not actually doing very well, since I really *ought*
> to check every block in the page.
> 
> I really want to replace the use of bmap entirely with iov_iter doing DIO.
> Cachefiles currently does double buffering because it works through the
> pagecache of the underlying to do actual read or write - and this appears to
> cause memory management problems.

Not related to this patch, but using iov_iter with dio is trivial, what
is the blocker therere?
