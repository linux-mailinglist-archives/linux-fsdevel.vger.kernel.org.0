Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5550D241220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 23:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgHJVKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 17:10:54 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:35768 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726547AbgHJVKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:10:54 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 924DAD5B48A;
        Tue, 11 Aug 2020 07:10:47 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k5F49-0007Rd-HC; Tue, 11 Aug 2020 07:10:45 +1000
Date:   Tue, 11 Aug 2020 07:10:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        dan.j.williams@intel.com, hch@lst.de, rgoldwyn@suse.de,
        qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
Message-ID: <20200810211045.GL2114@dread.disaster.area>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807133857.GC17456@casper.infradead.org>
 <9673ed3c-9e42-3d01-000b-b01cda9832ce@cn.fujitsu.com>
 <20200810111657.GL17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200810111657.GL17456@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=_uXmcX_QWSfgQcGZoHUA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:16:57PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 10, 2020 at 04:15:50PM +0800, Ruan Shiyang wrote:
> > 
> > 
> > On 2020/8/7 下午9:38, Matthew Wilcox wrote:
> > > On Fri, Aug 07, 2020 at 09:13:28PM +0800, Shiyang Ruan wrote:
> > > > This patchset is a try to resolve the problem of tracking shared page
> > > > for fsdax.
> > > > 
> > > > Instead of per-page tracking method, this patchset introduces a query
> > > > interface: get_shared_files(), which is implemented by each FS, to
> > > > obtain the owners of a shared page.  It returns an owner list of this
> > > > shared page.  Then, the memory-failure() iterates the list to be able
> > > > to notify each process using files that sharing this page.
> > > > 
> > > > The design of the tracking method is as follow:
> > > > 1. dax_assocaite_entry() associates the owner's info to this page
> > > 
> > > I think that's the first problem with this design.  dax_associate_entry is
> > > a horrendous idea which needs to be ripped out, not made more important.
> > > It's all part of the general problem of trying to do something on a
> > > per-page basis instead of per-extent basis.
> > > 
> > 
> > The memory-failure needs to track owners info from a dax page, so I should
> > associate the owner with this page.  In this version, I associate the block
> > device to the dax page, so that the memory-failure is able to iterate the
> > owners by the query interface provided by filesystem.
> 
> No, it doesn't need to track owner info from a DAX page.  What it needs to
> do is ask the filesystem.

Just to add to this: the owner tracking that is current done deep
inside the DAX code needs to be moved out to the owner of the dax
device. That may be the dax device itself, or it may be a filesystem
like ext4 or XFS. Initially, nothing will be able to share pages and
page owner tracking should be done on the page itself as the DAX
code currently does.

Hence when a page error occurs, the device owner is called with the
page and error information, and the dax device or filesystem can
then look up the page owner (via mapping/index pointers) and run the
Die Userspace Die functions instead of running this all internally
in the DAX code.

Once the implementation is abstracted and controlled by the device
owner, then we can start working to change the XFS implementation to
support shared pages....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
