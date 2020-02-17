Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D7161550
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 15:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgBQO7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 09:59:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729248AbgBQO7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581951582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UNCbovktaqjETKbtlqusP4KbCu7EGtn032nkswZFQ6s=;
        b=TqMJmZy11zSL7Y2utIQWLb8u2wUbuPbYfh5fRC1JEMwJiILPDbHI7MbJBIxAeVk9D0gzKb
        buPxmoc0iDcqSbbVbShpao+d6VZqjaGcUtDTEGWD/y+e/UkaziQ2UemJkkpyBWHO5Go9cK
        KKwQbcZoPxutqwl67m3L7arBAQjRMcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-8JrtxLhgOQmWmAS5XMWQhA-1; Mon, 17 Feb 2020 09:59:38 -0500
X-MC-Unique: 8JrtxLhgOQmWmAS5XMWQhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B7DF8017DF;
        Mon, 17 Feb 2020 14:59:37 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04B8B10016DA;
        Mon, 17 Feb 2020 14:59:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 62C472257D2; Mon, 17 Feb 2020 09:59:33 -0500 (EST)
Date:   Mon, 17 Feb 2020 09:59:33 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH v3 2/7] pmem: Enable pmem_do_write() to deal with
 arbitrary ranges
Message-ID: <20200217145933.GA24816@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-3-vgoyal@redhat.com>
 <20200217132309.GC14490@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217132309.GC14490@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:23:09AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 07, 2020 at 03:26:47PM -0500, Vivek Goyal wrote:
> > Currently pmem_do_write() is written with assumption that all I/O is
> > sector aligned. Soon I want to use this function in zero_page_range()
> > where range passed in does not have to be sector aligned.
> > 
> > Modify this function to be able to deal with an arbitrary range. Which
> > is specified by pmem_off and len.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/nvdimm/pmem.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > index 9ad07cb8c9fc..281fe04d25fd 100644
> > --- a/drivers/nvdimm/pmem.c
> > +++ b/drivers/nvdimm/pmem.c
> > @@ -154,15 +154,23 @@ static blk_status_t pmem_do_read(struct pmem_device *pmem,
> >  
> >  static blk_status_t pmem_do_write(struct pmem_device *pmem,
> >  			struct page *page, unsigned int page_off,
> > -			sector_t sector, unsigned int len)
> > +			u64 pmem_off, unsigned int len)
> >  {
> >  	blk_status_t rc = BLK_STS_OK;
> >  	bool bad_pmem = false;
> > -	phys_addr_t pmem_off = sector * 512 + pmem->data_offset;
> > -	void *pmem_addr = pmem->virt_addr + pmem_off;
> > -
> > -	if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> > -		bad_pmem = true;
> > +	phys_addr_t pmem_real_off = pmem_off + pmem->data_offset;
> > +	void *pmem_addr = pmem->virt_addr + pmem_real_off;
> > +	sector_t sector_start, sector_end;
> > +	unsigned nr_sectors;
> > +
> > +	sector_start = DIV_ROUND_UP(pmem_off, SECTOR_SIZE);
> > +	sector_end = (pmem_off + len) >> SECTOR_SHIFT;
> > +	if (sector_end > sector_start) {
> > +		nr_sectors = sector_end - sector_start;
> > +		if (unlikely(is_bad_pmem(&pmem->bb, sector_start,
> > +					 nr_sectors << SECTOR_SHIFT)))
> > +			bad_pmem = true;
> 
> I don't think an unlikely annotation makes much sense for assigning
> a boolean value to a flag variable.

Ok, will get rid if this unlikely() instance.

> 
> > +		/*
> > +		 * Pass sector aligned offset and length. That seems
> > +		 * to work as of now. Other finer grained alignment
> > +		 * cases can be addressed later if need be.
> > +		 */
> 
> This comment seems pretty scary.  What other cases can you think of?

Currently firmware seems to have restrictions on alignment of size and
offset of poisoned memory being cleared.

drivers/nvdimm/bus.c

nvdimm_clear_poison()
{
...
	clear_err_unit = ars_cap.clear_err_unit;
	        mask = clear_err_unit - 1;
        if ((phys | len) & mask)
                return -ENXIO;
...
}

On the system I was testing clear_err_unit is 256. If I pass in offset
and len values which are not aligned to 256, I get errors.

So if a caller passes in a random offset and range, I clear poison
only on the part of the range which is aligned to 1 << SECTOR_SHIFT. Any
portion of the range left in the beginning or at the end, does not clear
poison.

Current code also clears poison on secotr boundaries only. One can go
the extra mile and query "clear_err_unit" and if it is less than
SECTOR_SIZE, then possibly clear the poison on range of memory which
is not sector aligned but clear_err_unit aligned.

But this retains existing functionality and is not a regression w.r.t
we are already doing. Querying "clear_err_unit" acting accordingly is
an improvement if one needs it.

Hence, I don't think this is something to be concerned about.

Thanks
Vivek

