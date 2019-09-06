Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8FAB372
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfIFHq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 03:46:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42955 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728590AbfIFHq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:46:59 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id AFFBF43E333;
        Fri,  6 Sep 2019 17:46:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i68xK-0006ZH-Kb; Fri, 06 Sep 2019 17:46:54 +1000
Date:   Fri, 6 Sep 2019 17:46:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: add ioctl for directly writing compressed data
Message-ID: <20190906074654.GM7777@dread.disaster.area>
References: <cover.1567623877.git.osandov@fb.com>
 <8eae56abb90c0fe87c350322485ce8674e135074.1567623877.git.osandov@fb.com>
 <20190905021012.GL7777@dread.disaster.area>
 <8acbff04-aee0-9f88-b2cd-a85bb7b94df8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acbff04-aee0-9f88-b2cd-a85bb7b94df8@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=FOH2dFAWAAAA:8 a=7-415B0cAAAA:8 a=vmlKb14kAB5wCteP1LsA:9
        a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:16:37PM +0200, Johannes Thumshirn wrote:
> On 05/09/2019 04:10, Dave Chinner wrote:
> > On Wed, Sep 04, 2019 at 12:13:26PM -0700, Omar Sandoval wrote:
> >> From: Omar Sandoval <osandov@fb.com>
> >>
> >> This adds an API for writing compressed data directly to the filesystem.
> >> The use case that I have in mind is send/receive: currently, when
> >> sending data from one compressed filesystem to another, the sending side
> >> decompresses the data and the receiving side recompresses it before
> >> writing it out. This is wasteful and can be avoided if we can just send
> >> and write compressed extents. The send part will be implemented in a
> >> separate series, as this ioctl can stand alone.
> >>
> >> The interface is essentially pwrite(2) with some extra information:
> >>
> >> - The input buffer contains the compressed data.
> >> - Both the compressed and decompressed sizes of the data are given.
> >> - The compression type (zlib, lzo, or zstd) is given.
> > 
> > So why can't you do this with pwritev2()? Heaps of flags, and
> > use a second iovec to hold the decompressed size of the previous
> > iovec. i.e.
> > 
> > 	iov[0].iov_base = compressed_data;
> > 	iov[0].iov_len = compressed_size;
> > 	iov[1].iov_base = NULL;
> > 	iov[1].iov_len = uncompressed_size;
> > 	pwritev2(fd, iov, 2, offset, RWF_COMPRESSED_ZLIB);
> > 
> > And you don't need to reinvent pwritev() with some whacky ioctl that
> > is bound to be completely screwed up is ways not noticed until
> > someone else tries to use it...
> > 
> > I'd also suggest atht if we are going to be able to write compressed
> > data directly, then we should be able to read them as well directly
> > via preadv2()....
> 
> 
> While I'm with you on this from a design PoV, one question remains:
> What to do with the file systems that do not support compression?

EINVAL.

> Currently there's only a kernel global check for known RWF_* flags in
> kiocb_set_rw_flags().

That's really an implementation detail, there's lots of ways of
doing it, probably a superblock feature flag would be the easiest
way to specify support for a filesystem supporting direct read/write
of compressed data.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
