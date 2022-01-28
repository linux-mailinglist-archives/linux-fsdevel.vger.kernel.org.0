Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE349EFDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbiA1Ago (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 19:36:44 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40146 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbiA1Ago (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:36:44 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id B288D10C5191;
        Fri, 28 Jan 2022 11:36:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nDFFp-0051pf-5M; Fri, 28 Jan 2022 11:36:41 +1100
Date:   Fri, 28 Jan 2022 11:36:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] NFSD: Fix NFSv4 SETATTR's handling of large file
 sizes
Message-ID: <20220128003641.GK59715@dread.disaster.area>
References: <164329914731.5879.7791856151631542523.stgit@bazille.1015granger.net>
 <164329971128.5879.15718457509790221509.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164329971128.5879.15718457509790221509.stgit@bazille.1015granger.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=61f33a9a
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=evYJbCMsSUYqYQwoNxoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:08:31AM -0500, Chuck Lever wrote:
> iattr::ia_size is a loff_t. decode_fattr4() dumps a full u64 value
> in there. If that value is larger than S64_MAX, then ia_size has
> underflowed.
> 
> In this case the negative size is passed through to the VFS and
> underlying filesystems. I've observed XFS behavior: it returns
> EIO but still attempts to access past the end of the device.

What attempts to access beyond the end of the device? A file offset
is not a disk offset, and the filesystem cannot allocate blocks for
IO that are outside the device boundaries. So I don't understand how
setting an inode size of >LLONGMAX can cause the filesystem to
access blocks outside the range it can allocate and map IO to. If
this falls through to trying to access data outside the range the
filesystem is allowed to access then we've got a bug that needs to
be fixed.

Can you please clarify the behaviour that is occurring here (stack
traces demonstrating the IO path that leads to access past the end
of device would be useful) so we can look into this further?

> IOW it assumes the caller has already sanity-checked the value.

Every filesystem assumes that the iattr that is passed to ->setattr
by notify_change() has been sanity checked and the parameters are
within the valid VFS supported ranges, not just XFS. Perhaps this
check should be in notify_change, not in the callers?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
