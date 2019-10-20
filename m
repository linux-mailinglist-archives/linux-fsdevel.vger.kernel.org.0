Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEAEDE0FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 01:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfJTXFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 19:05:09 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53512 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfJTXFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 19:05:08 -0400
Received: from dread.disaster.area (pa49-180-40-48.pa.nsw.optusnet.com.au [49.180.40.48])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 077CE364250;
        Mon, 21 Oct 2019 10:05:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iMKFx-0002H8-KI; Mon, 21 Oct 2019 10:05:01 +1100
Date:   Mon, 21 Oct 2019 10:05:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 0/5] fs: interface for directly reading/writing
 compressed data
Message-ID: <20191020230501.GA8080@dread.disaster.area>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <cover.1571164762.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571164762.git.osandov@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=y881pOMu+B+mZdf5UrsJdA==:117 a=y881pOMu+B+mZdf5UrsJdA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=FOH2dFAWAAAA:8 a=7-415B0cAAAA:8 a=wr0vbpaFJz5L4bqAxKYA:9
        a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 11:42:38AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hello,
> 
> This series adds an API for reading compressed data on a filesystem
> without decompressing it as well as support for writing compressed data
> directly to the filesystem. It is based on my previous series which
> added a Btrfs-specific ioctl [1], but it is now an extension to
> preadv2()/pwritev2() as suggested by Dave Chinner [2]. I've included a
> man page patch describing the API in detail. Test cases and examples
> programs are available [3].
> 
> The use case that I have in mind is Btrfs send/receive: currently, when
> sending data from one compressed filesystem to another, the sending side
> decompresses the data and the receiving side recompresses it before
> writing it out. This is wasteful and can be avoided if we can just send
> and write compressed extents. The send part will be implemented in a
> separate series, as this API can stand alone.
> 
> Patches 1 and 2 add the VFS support. Patch 3 is a Btrfs prep patch.
> Patch 4 implements encoded reads for Btrfs, and patch 5 implements
> encoded writes.
> 
> Changes from v1 [4]:
> 
> - Encoded reads are now also implemented.
> - The encoded_iov structure now includes metadata for referring to a
>   subset of decoded data. This is required to handle certain cases where
>   a compressed extent is truncated, hole punched, or otherwise sliced up
>   and Btrfs chooses to reflect this in metadata instead of decompressing
>   the whole extent and rewriting the pieces. We call these "bookend
>   extents" in Btrfs, but any filesystem supporting transparent encoding
>   is likely to have a similar concept.

Where's the in-kernel documentation for this API? You're encoding a
specific set of behaviours into the user API, so this needs a whole
heap of documentation in the generic code to describe how it works
so that other filesystems implementing have a well defined guideline
to what they need to support.

Also, I don't see any test code for this - can you please add
support for RWF_ENCODED to xfs_io and write a suite of unit tests
for fstests that exercise the user API fully?  Given our history of
screwing up new user APIs, this absolutely should not be merged
until there is a full set of generic unit tests written and reviewed
for it and support has been added to fsstress, fsx, and other test
utilities to fuzz and stress the implementation as part of normal
day-to-day filesystem development...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
