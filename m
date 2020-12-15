Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89BF2DB6F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 00:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgLOXMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 18:12:43 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43648 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726414AbgLOXLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:11:18 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1941F3C3F8B;
        Wed, 16 Dec 2020 10:10:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kpJSY-004N5L-QJ; Wed, 16 Dec 2020 10:10:22 +1100
Date:   Wed, 16 Dec 2020 10:10:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201215231022.GL632069@dread.disaster.area>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
 <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=1WtExyGbPUdzLH7rxhUA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:05:07AM -0800, Jane Chu wrote:
> On 12/15/2020 3:58 AM, Ruan Shiyang wrote:
> > Hi Jane
> > 
> > On 2020/12/15 上午4:58, Jane Chu wrote:
> > > Hi, Shiyang,
> > > 
> > > On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
> > > > This patchset is a try to resolve the problem of tracking shared page
> > > > for fsdax.
> > > > 
> > > > Change from v1:
> > > >    - Intorduce ->block_lost() for block device
> > > >    - Support mapped device
> > > >    - Add 'not available' warning for realtime device in XFS
> > > >    - Rebased to v5.10-rc1
> > > > 
> > > > This patchset moves owner tracking from dax_assocaite_entry() to pmem
> > > > device, by introducing an interface ->memory_failure() of struct
> > > > pagemap.  The interface is called by memory_failure() in mm, and
> > > > implemented by pmem device.  Then pmem device calls its ->block_lost()
> > > > to find the filesystem which the damaged page located in, and call
> > > > ->storage_lost() to track files or metadata assocaited with this page.
> > > > Finally we are able to try to fix the damaged data in filesystem and do
> > > 
> > > Does that mean clearing poison? if so, would you mind to elaborate
> > > specifically which change does that?
> > 
> > Recovering data for filesystem (or pmem device) has not been done in
> > this patchset...  I just triggered the handler for the files sharing the
> > corrupted page here.
> 
> Thanks! That confirms my understanding.
> 
> With the framework provided by the patchset, how do you envision it to
> ease/simplify poison recovery from the user's perspective?

At the moment, I'd say no change what-so-ever. THe behaviour is
necessary so that we can kill whatever user application maps
multiply-shared physical blocks if there's a memory error. THe
recovery method from that is unchanged. The only advantage may be
that the filesystem (if rmap enabled) can tell you the exact file
and offset into the file where data was corrupted.

However, it can be worse, too: it may also now completely shut down
the filesystem if the filesystem discovers the error is in metadata
rather than user data. That's much more complex to recover from, and
right now will require downtime to take the filesystem offline and
run fsck to correct the error. That may trash whatever the metadata
that can't be recovered points to, so you still have a uesr data
recovery process to perform after this...

> And how does it help in dealing with page faults upon poisoned
> dax page?

It doesn't. If the page is poisoned, the same behaviour will occur
as does now. This is simply error reporting infrastructure, not
error handling.

Future work might change how we correct the faults found in the
storage, but I think the user visible behaviour is going to be "kill
apps mapping corrupted data" for a long time yet....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
