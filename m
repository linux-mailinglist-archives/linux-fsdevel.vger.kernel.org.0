Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571B9320EAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 01:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBVAUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 19:20:18 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:32782 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhBVAUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 19:20:17 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 7A2C1FA99D4;
        Mon, 22 Feb 2021 11:19:31 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lDywk-00FroM-Qj; Mon, 22 Feb 2021 11:19:30 +1100
Date:   Mon, 22 Feb 2021 11:19:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210222001930.GA4626@dread.disaster.area>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
 <YC/jYW/K9krbfnfl@mit.edu>
 <df225e6c-b70d-fb2d-347c-55efa910cfdd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df225e6c-b70d-fb2d-347c-55efa910cfdd@gmx.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=IkcTkHD0fZMA:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=4nK5NWoZmdbISTPU9iQA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 20, 2021 at 07:10:14AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/2/20 上午12:12, Theodore Ts'o wrote:
> > On Fri, Feb 19, 2021 at 08:37:30AM +0800, Qu Wenruo wrote:
> > > So it means the 32bit archs are already 2nd tier targets for at least
> > > upstream linux kernel?
> > 
> > At least as far as btrfs is concerned, anyway....
> 
> I'm afraid that would be the case.
> 
> But I'm still interested in how other fses handle such problem.

Refuse to mount >16TB on 32 bit, 4kB page systems.  And set the max
file offset for such systems to 16TB so sparse files can't be larger
than what the kernel supports. See xfs_sb_validate_fsb_count() call
and the file offset checks against MAX_LFS_FILESIZE in
xfs_fs_fill_super()...

FWIW, XFS has been doing this for roughly 20 years now - >16TB on 32
bit machines was an issue for XFS way back at the turn of the
century...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
