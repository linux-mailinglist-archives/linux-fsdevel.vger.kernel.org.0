Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD65159297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBKPLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 10:11:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58124 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728643AbgBKPLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581433889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xWrVwmVPWaQjEiPR8xrbcdO9jipuXVef6xbTXqC/E5c=;
        b=TYHbyn27Y9xOA0ItZjopCSWRr6zIyE9EI470NwnqAHcdkI5pGEZXtd/DYj8eP/H8eQLZHS
        FqS915vBrc6Fy9HlI8rIngS4TA2nmOtrPGqtmCwM2VRsmC2ajrCSgdOgauzYh9kpylp5Vz
        tHJLFNHnN4L/v6Wjc+3cS4wCJiCm8jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-JdHOYAdvPNyeRD3JB0pOGA-1; Tue, 11 Feb 2020 10:11:22 -0500
X-MC-Unique: JdHOYAdvPNyeRD3JB0pOGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F7A1005514;
        Tue, 11 Feb 2020 15:11:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-123-66.rdu2.redhat.com [10.10.123.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97B6C26FDB;
        Tue, 11 Feb 2020 15:11:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 48F50220A24; Tue, 11 Feb 2020 10:11:14 -0500 (EST)
Date:   Tue, 11 Feb 2020 10:11:14 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, dm-devel@redhat.com,
        vishal.l.verma@intel.com, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 4/7] s390,dcssblk,dax: Add dax zero_page_range
 operation to dcssblk driver
Message-ID: <20200211151114.GA8590@redhat.com>
References: <20200207202652.1439-1-vgoyal@redhat.com>
 <20200207202652.1439-5-vgoyal@redhat.com>
 <20200210215315.27b7e310@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210215315.27b7e310@thinkpad>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 10, 2020 at 09:53:15PM +0100, Gerald Schaefer wrote:
> On Fri,  7 Feb 2020 15:26:49 -0500
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Add dax operation zero_page_range for dcssblk driver.
> > 
> > CC: linux-s390@vger.kernel.org
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/s390/block/dcssblk.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index 63502ca537eb..331abab5d066 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -57,11 +57,28 @@ static size_t dcssblk_dax_copy_to_iter(struct dax_device *dax_dev,
> >  	return copy_to_iter(addr, bytes, i);
> >  }
> >  
> > +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev, u64 offset,
> > +				       size_t len)
> > +{
> > +	long rc;
> > +	void *kaddr;
> > +	pgoff_t pgoff = offset >> PAGE_SHIFT;
> > +	unsigned page_offset = offset_in_page(offset);
> > +
> > +	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
> 
> Why do you pass only 1 page as nr_pages argument for dax_direct_access()?
> In some other patch in this series there is a comment that this will
> currently only be used for one page, but support for more pages might be
> added later. Wouldn't it make sense to rather use something like
> PAGE_ALIGN(page_offset + len) >> PAGE_SHIFT instead of 1 here, so that
> this won't have to be changed when callers will be ready to use it
> with more than one page?
> 
> Of course, I guess then we'd also need some check on the return value
> from dax_direct_access(), i.e. if the returned available range is
> large enough for the requested range.

I left it at 1 page because that's the current limitation of this
interface and there are no callers which are zeroing across page
boundaries.

I prefer to keep it this way and modify it when we are extending this
interface to allow zeroing across page boundaries. Because even if I add
that logic, I can't test it.

But if you still prefer to change it, I am open to make that change.

Thanks
Vivek

