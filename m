Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B384AAEA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfIEWoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 18:44:08 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48353 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbfIEWoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:44:08 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2D13836142E;
        Fri,  6 Sep 2019 08:44:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i60Tz-00031P-Qh; Fri, 06 Sep 2019 08:44:03 +1000
Date:   Fri, 6 Sep 2019 08:44:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/9] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20190905224403.GK1119@dread.disaster.area>
References: <20190830165920.GA28182@lst.de>
 <20190829071312.GE11909@lst.de>
 <20190820115731.bed7gwfygk66nj43@pegasus.maiolino.io>
 <20190808082744.31405-1-cmaiolino@redhat.com>
 <20190808082744.31405-3-cmaiolino@redhat.com>
 <20190814111535.GC1885@lst.de>
 <7003.1566305430@warthog.procyon.org.uk>
 <2587.1567181871@warthog.procyon.org.uk>
 <28402.1567212357@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28402.1567212357@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=yx1zXdAvrB0BR2aM9G4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 31, 2019 at 01:45:57AM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > We'll you'd need to implement a IOCB_NOHOLE, but that wouldn't be all
> > that hard.  Having a READ_PLUS like interface that actually tells you
> > how large the hole is might be hard.
> 
> Actually, that raises another couple of questions:
> 
>  (1) Is a filesystem allowed to join up two disjoint blocks of data with a
>      block of zeros to make a single extent?  If this happens, I'll see the
>      inserted block of zeros to be valid data.

Yes.

>  (2) Is a filesystem allowed to punch out a block of valid zero data to make a
>      hole?  This would cause me to refetch the data.

Yes.

Essentially, assumptions that filesystems will not change the file
layout even if the data does not change are invalid. copy-on-write,
deduplication, speculative preallocation, etc mean the file layout
can change even if the file data itself is not directly modified.

If you want to cache physical file layout information and be
notified when they may change, then that's what layout leases are
for....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
