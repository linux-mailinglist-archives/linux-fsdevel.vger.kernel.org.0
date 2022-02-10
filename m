Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F824B0423
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 05:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiBJEDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 23:03:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBJEDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:03:06 -0500
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66C817643;
        Wed,  9 Feb 2022 20:03:06 -0800 (PST)
Received: from dread.disaster.area (pa49-180-69-7.pa.nsw.optusnet.com.au [49.180.69.7])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C995852CBBA;
        Thu, 10 Feb 2022 15:03:05 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nI0fg-00ACyj-Bx; Thu, 10 Feb 2022 15:03:04 +1100
Date:   Thu, 10 Feb 2022 15:03:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20220210040304.GM59729@dread.disaster.area>
References: <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
 <Yenm1Ipx87JAlyXg@sol.localdomain>
 <20220120235755.GI59729@dread.disaster.area>
 <20220121023603.GH13563@magnolia>
 <20220123230332.GL59729@dread.disaster.area>
 <YgMUa2Cdr/QoMTPh@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgMUa2Cdr/QoMTPh@sol.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62048e7a
        a=NB+Ng1P8A7U24Uo7qoRq4Q==:117 a=NB+Ng1P8A7U24Uo7qoRq4Q==:17
        a=IkcTkHD0fZMA:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=txpYLRzjzDLeYr1fpcUA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:10:03PM -0800, Eric Biggers wrote:
> On Mon, Jan 24, 2022 at 10:03:32AM +1100, Dave Chinner wrote:
> > > 
> > > 	/* 0xa0 */
> > > 
> > > 	/* File range alignment needed for best performance, in bytes. */
> > > 	__u32	stx_dio_fpos_align_opt;
> > 
> > This is a common property of both DIO and buffered IO, so no need
> > for it to be dio-only property.
> > 
> > 	__u32	stx_offset_align_optimal;
> > 
> 
> Looking at this more closely: will stx_offset_align_optimal actually be useful,
> given that st[x]_blksize already exists?

Yes, because....

> From the stat(2) and statx(2) man pages:
> 
> 	st_blksize
> 		This field  gives  the  "preferred"  block  size  for  efficient
> 		filesystem I/O.
> 
> 	stx_blksize
> 		The "preferred" block size for efficient filesystem I/O.  (Writ‐
> 		ing  to  a file in smaller chunks may cause an inefficient read-
> 		modify-rewrite.)

... historically speaking, this is intended to avoid RMW cycles for
sub-block and/or sub-PAGE_SIZE write() IOs. i.e. the practical
definition of st_blksize is the *minimum* IO size the needed to
avoid page cache RMW cycles.

However, XFS has a "-o largeio" mount option, that sets this value
to internal optimal filesytsem alignment values such as stripe unit
or even stripe width (-o largeio,swalloc). THis means it can be up
to 2GB (maybe larger?) in size.

THe problem with this is that many applications are not prepared to
see a value of, say, 16MB in st_blksize rather than 4096 bytes. An
example of such problems are applications sizing their IO buffers as
a multiple of st_blksize - we've had applications fail because they
try to use multi-GB sized IO buffers as a result of setting
st_blksize to the filesystem/storage idea of optimal IO size rather
than PAGE_SIZE.

Hence, we can't really change the value of st_blksize without
risking random breakage in userspace. hence the practical definition
of st_blksize is the *minimum* IO size that avoids RMW cycles for an
individual write() syscall, not the most efficient IO size.

> File offsets aren't explicitly mentioned, but I think it's implied they should
> be a multiple of st[x]_blksize, just like the I/O size.  Otherwise, the I/O
> would obviously require reading/writing partial blocks.

Of course it implies aligned file offsets - block aligned IO is
absolutely necessary for effcient filesystem IO. It has for pretty
much the entire of unix history...

> So, the proposed stx_offset_align_optimal field sounds like the same thing to
> me.  Is there anything I'm misunderstanding?
>
> Putting stx_offset_align_optimal behind the STATX_DIRECTIO flag would also be
> confusing if it would apply to both direct and buffered I/O.

So just name the flag STATX_IOALIGN so that it can cover generic,
buffered specific and DIO specific parameters in one hit. Simple,
yes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
