Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB20FA3CBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfH3Q7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 12:59:24 -0400
Received: from verein.lst.de ([213.95.11.211]:57326 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfH3Q7Y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:59:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8315A227A8A; Fri, 30 Aug 2019 18:59:20 +0200 (CEST)
Date:   Fri, 30 Aug 2019 18:59:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20190830165920.GA28182@lst.de>
References: <20190829071312.GE11909@lst.de> <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io> <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-3-cmaiolino@redhat.com> <20190814111535.GC1885@lst.de> <7003.1566305430@warthog.procyon.org.uk> <2587.1567181871@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2587.1567181871@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 05:17:51PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > Not related to this patch, but using iov_iter with dio is trivial, what
> > is the blocker therere?
> 
> The usual: time.
> 
> The change as a whole is not actually trivial since it will involve completely
> overhauling the fscache data API and how the filesystems use it - and then
> having cachefiles perform the DIO asynchronously as per Trond's requirements
> for using fscache with NFS.

Well, doing in-kernel async I/O is actually rather trivial these days.
Take a look at the loop driver for an example.

> I also need to work out how I'm going to do data/hole detection.  Can I set,
> say, O_NOREADHOLE and then expect the DIO to stop early with a short read?  Or
> do I need to use SEEK_DATA/SEEK_HOLE in advance to define the occupied
> regions?

We'll you'd need to implement a IOCB_NOHOLE, but that wouldn't be all
that hard.  Having a READ_PLUS like interface that actually tells you
how large the hole is might be hard.
