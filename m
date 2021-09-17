Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC640F86D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbhIQM7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbhIQM7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B5C061574;
        Fri, 17 Sep 2021 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Um4Uw6AWMgVorPtp96yufuS1WecBa1mqjtkAlbtYeGI=; b=md72ZrUpSFHruswBaqaFU7lRC+
        L7wB824poyC9ApIwwu+MCAEK9/02CrbCtyYfP7wUq073ueYVu5gyJQzRUuY2TeAjEBzg2oF+MxikC
        KUaGfH98tsTnXYxc4mVcNlnK+ysUm9vinJYCMTvnp1AVv24wqCJd1PYfK54jJ/3B6DUARhC1C50Na
        XR6fNru+F+6dXesMNYqTQ4eZ+utlfAzDg9qbj0fcT4L4GWtQCxEkpMKOcNO1zJkKF5Ib++kPArcYa
        TIk63kf4QaWOnJ/3O6wFdJT9zaRq962JoainVYKiVPfRPyQPwZqG6ICRASwBj8jcU4jrNLI+c/w1e
        cP8FJzMQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRDMz-000Fp6-Gq; Fri, 17 Sep 2021 12:53:56 +0000
Date:   Fri, 17 Sep 2021 13:53:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <YUSPzVG0ulHdLWn7@infradead.org>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
 <YULuMO86NrQAPcpf@infradead.org>
 <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 11:40:28AM -0700, Dan Williams wrote:
> > That was my gut feeling.  If everyone feels 100% comfortable with
> > zeroingas the mechanism to clear poisoning I'll cave in.  The most
> > important bit is that we do that through a dedicated DAX path instead
> > of abusing the block layer even more.
> 
> ...or just rename dax_zero_page_range() to dax_reset_page_range()?
> Where reset == "zero + clear-poison"?

I'd say that naming is more confusing than overloading zero.

> > I'm really worried about both patartitions on DAX and DM passing through
> > DAX because they deeply bind DAX to the block layer, which is just a bad
> > idea.  I think we also need to sort that whole story out before removing
> > the EXPERIMENTAL tags.
> 
> I do think it was a mistake to allow for DAX on partitions of a pmemX
> block-device.
> 
> DAX-reflink support may be the opportunity to start deprecating that
> support. Only enable DAX-reflink for direct mounting on /dev/pmemX
> without partitions (later add dax-device direct mounting),

I think we need to fully or almost fully sort this out.

Here is my bold suggestions:

 1) drop no drop the EXPERMINTAL on the current block layer overload
    at all
 2) add direct mounting of the nvdimm namespaces ASAP.  Because all
    the filesystem currently also need the /dev/pmem0 device add a way
    to open the block device by the dax_device instead of our current
    way of doing the reverse
 3) deprecate DAX support through block layer mounts with a say 2 year
    deprecation period
 4) add DAX remapping devices as needed

I'll volunteer to write the initial code for 2).  And I think we should
not allow DAX+reflink on the block device shim at all.
