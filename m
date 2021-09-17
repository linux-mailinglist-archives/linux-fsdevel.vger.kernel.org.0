Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB240FC41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhIQP3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 11:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237140AbhIQP3H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:29:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53687610C7;
        Fri, 17 Sep 2021 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631892465;
        bh=ApeQnqp5tBSyqw2P59T/IpiWpP+px0+CAYiPTEWF45I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnEezXaNJyDu4RHBxsc0XtjHLGQMfbR79lyNvkDMIhMe3JWe5pQaZXAzlzfz5SINt
         4WU/7pPo6cBp5ZOSO/B6OrL7qHMecUKXmU5s7sk+FMqBV+2MmhagTTnE1hQT1PUeaQ
         Xlv7OHmN53vb9NlmxuAfxFcfvLtLG8B/fbVOUgCVIkoxjiPMDShVxOZuiTpy38MOx+
         EaBYiCsYULMmVKCk9W6ICNqg7iRbosrGokbBjSKYP8TDTrryr+tPt1AikhKhG+ba0O
         tPcWPZIxZWBXvfSzmLZo5Y0Z+eFxiSF4DDXD+cxRT3UUI/tYGCWukoVoSG27445ecq
         QhrmtVOX0k7xQ==
Date:   Fri, 17 Sep 2021 08:27:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
Message-ID: <20210917152744.GA10250@magnolia>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
 <YULuMO86NrQAPcpf@infradead.org>
 <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
 <YUSPzVG0ulHdLWn7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUSPzVG0ulHdLWn7@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:53:33PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 16, 2021 at 11:40:28AM -0700, Dan Williams wrote:
> > > That was my gut feeling.  If everyone feels 100% comfortable with
> > > zeroingas the mechanism to clear poisoning I'll cave in.  The most
> > > important bit is that we do that through a dedicated DAX path instead
> > > of abusing the block layer even more.
> > 
> > ...or just rename dax_zero_page_range() to dax_reset_page_range()?
> > Where reset == "zero + clear-poison"?
> 
> I'd say that naming is more confusing than overloading zero.

How about dax_zeroinit_range() ?

To go with its fallocate flag (yeah I've been too busy sorting out -rc1
regressions to repost this) FALLOC_FL_ZEROINIT_RANGE that will reset the
hardware (whatever that means) and set the contents to the known value
zero.

Userspace usage model:

void handle_media_error(int fd, loff_t pos, size_t len)
{
	/* yell about this for posterior's sake */

	ret = fallocate(fd, FALLOC_FL_ZEROINIT_RANGE, pos, len);

	/* yay our disk drive / pmem / stone table engraver is online */
}

> > > I'm really worried about both patartitions on DAX and DM passing through
> > > DAX because they deeply bind DAX to the block layer, which is just a bad
> > > idea.  I think we also need to sort that whole story out before removing
> > > the EXPERIMENTAL tags.
> > 
> > I do think it was a mistake to allow for DAX on partitions of a pmemX
> > block-device.
> > 
> > DAX-reflink support may be the opportunity to start deprecating that
> > support. Only enable DAX-reflink for direct mounting on /dev/pmemX
> > without partitions (later add dax-device direct mounting),
> 
> I think we need to fully or almost fully sort this out.
> 
> Here is my bold suggestions:
> 
>  1) drop no drop the EXPERMINTAL on the current block layer overload
>     at all

I don't understand this.

>  2) add direct mounting of the nvdimm namespaces ASAP.  Because all
>     the filesystem currently also need the /dev/pmem0 device add a way
>     to open the block device by the dax_device instead of our current
>     way of doing the reverse
>  3) deprecate DAX support through block layer mounts with a say 2 year
>     deprecation period
>  4) add DAX remapping devices as needed

What devices are needed?  linear for lvm, and maybe error so we can
actually test all this stuff?

> I'll volunteer to write the initial code for 2).  And I think we should
> not allow DAX+reflink on the block device shim at all.

/me has other questions about daxreflink, but I'll ask them on shiyang's
thread.

--D
