Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD18649763F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 00:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiAWXDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 18:03:37 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:55247 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240391AbiAWXDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:03:36 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2169362C1FD;
        Mon, 24 Jan 2022 10:03:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nBltU-003QSN-Tk; Mon, 24 Jan 2022 10:03:32 +1100
Date:   Mon, 24 Jan 2022 10:03:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v10 0/5] add support for direct I/O with fscrypt using
 blk-crypto
Message-ID: <20220123230332.GL59729@dread.disaster.area>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <YekdnxpeunTGfXqX@infradead.org>
 <20220120171027.GL13540@magnolia>
 <YenIcshA706d/ziV@sol.localdomain>
 <20220120210027.GQ13540@magnolia>
 <20220120220414.GH59729@dread.disaster.area>
 <Yenm1Ipx87JAlyXg@sol.localdomain>
 <20220120235755.GI59729@dread.disaster.area>
 <20220121023603.GH13563@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121023603.GH13563@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61eddec6
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=ja5ArhmkF978jRwlfB8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 06:36:03PM -0800, Darrick J. Wong wrote:
> On Fri, Jan 21, 2022 at 10:57:55AM +1100, Dave Chinner wrote:
> Sure.  How's this?  I couldn't think of a real case of directio
> requiring different alignments for pos and bytecount, so the only real
> addition here is the alignment requirements for best performance.
> 
> struct statx {
> ...
> 	/* 0x90 */
> 	__u64	stx_mnt_id;
> 
> 	/* Memory buffer alignment required for directio, in bytes. */
> 	__u32	stx_dio_mem_align;

	__32	stx_mem_align_dio;

(for consistency with suggestions below)

> 
> 	/* File range alignment required for directio, in bytes. */
> 	__u32	stx_dio_fpos_align_min;

"fpos" is not really a user term - "offset" is the userspace term for
file position, and it's much less of a random letter salad if it's
named that way. Also, we don't need "min" in the name; the
description of the field in the man page can give all the gory
details about it being the minimum required alignment.

	__u32	stx_offset_align_dio;

> 
> 	/* 0xa0 */
> 
> 	/* File range alignment needed for best performance, in bytes. */
> 	__u32	stx_dio_fpos_align_opt;

This is a common property of both DIO and buffered IO, so no need
for it to be dio-only property.

	__u32	stx_offset_align_optimal;

> 
> 	/* Maximum size of a directio request, in bytes. */
> 	__u32	stx_dio_max_iosize;

Unnecessary, it will always be the syscall max IO size, because the
internal DIO code will slice and dice it down to the max sizes the
hardware supports.

> #define STATX_DIRECTIO	0x00001000U	/* Want/got directio geometry */
> 
> How about that?

Mostly seems reasonable at a first look.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
