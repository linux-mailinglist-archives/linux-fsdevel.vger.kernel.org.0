Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52907114A66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 02:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfLFBQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 20:16:48 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58365 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfLFBQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:16:48 -0500
Received: from dread.disaster.area (pa49-179-150-192.pa.nsw.optusnet.com.au [49.179.150.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C329D3A2755;
        Fri,  6 Dec 2019 12:16:42 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1id2Eb-0007KL-00; Fri, 06 Dec 2019 12:16:41 +1100
Date:   Fri, 6 Dec 2019 12:16:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Daniel Phillips <daniel@phunq.net>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Message-ID: <20191206011640.GQ2695@dread.disaster.area>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
 <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
 <20191204234106.GC5641@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204234106.GC5641@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=ZXpxJgW8/q3NVgupyyvOCQ==:117 a=ZXpxJgW8/q3NVgupyyvOCQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=ySfo2T4IAAAA:8 a=7-415B0cAAAA:8 a=M2SG4f-PYqfBwsbvji4A:9
        a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 04, 2019 at 06:41:06PM -0500, Theodore Y. Ts'o wrote:
> On Wed, Dec 04, 2019 at 11:31:50AM -0700, Andreas Dilger wrote:
> > One important use case that we have for Lustre that is not yet in the
> > upstream ext4[*] is the ability to do parallel directory operations.
> > This means we can create, lookup, and/or unlink entries in the same
> > directory concurrently, to increase parallelism for large directories.
> > 
> > 
> > [*] we've tried to submit the pdirops patch a couple of times, but the
> > main blocker is that the VFS has a single directory mutex and couldn't
> > use the added functionality without significant VFS changes.
> > Patch at https://git.whamcloud.com/?p=fs/lustre-release.git;f=ldiskfs/kernel_patches/patches/rhel8/ext4-pdirop.patch;hb=HEAD
> >
> 
> The XFS folks recently added support for parallel directory operations
> into the VFS, for the benefit of XFS has this feature.

The use of shared i_rwsem locking on the directory inode during
lookup/pathwalk allows for concurrent lookup/readdir operations on
a single directory. However, the parent dir i_rwsem is still held
exclusive for directory modifications like create, unlink, etc.

IOWs, the VFS doesn't allow for concurrent directory modification
right now, and that's going to be the limiting factor no matter what
you do with internal filesystem locking.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
