Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16E154646
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBFOev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:34:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgBFOeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580999690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q96osyoFE6MDAYmksdUx62XK0qXSrPhY82lgZlCCHPg=;
        b=eLEe3kY9SDFhl9CFE7iBLNOIGv3hcXq5aLQTUpQx/5o44aRNysHfcPy7jmXnvq2DNhz2IQ
        5PVT3xib831z7enDtKioHWb6RC7T3eawTkMaVXM792z+2aCsafHMUwLWLisKSO4knSCR8+
        zqGkjuqH+F/c7poAMs3V3T3yKLBcf0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-69_fBUTJOnuI4O45hP3NQQ-1; Thu, 06 Feb 2020 09:34:47 -0500
X-MC-Unique: 69_fBUTJOnuI4O45hP3NQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D35211083E95;
        Thu,  6 Feb 2020 14:34:46 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B50089F00;
        Thu,  6 Feb 2020 14:34:44 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D3A482202E9; Thu,  6 Feb 2020 09:34:43 -0500 (EST)
Date:   Thu, 6 Feb 2020 09:34:43 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200206143443.GB12036@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Feb 05, 2020 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > > > +   /*
> > > > +    * There are no users as of now. Once users are there, fix dm code
> > > > +    * to be able to split a long range across targets.
> > > > +    */
> > >
> > > This comment confused me.  I think this wants to say something like:
> > >
> > >       /*
> > >        * There are now callers that want to zero across a page boundary as of
> > >        * now.  Once there are users this check can be removed after the
> > >        * device mapper code has been updated to split ranges across targets.
> > >        */
> >
> > Yes, that's what I wanted to say but I missed one line. Thanks. Will fix
> > it.
> >
> > >
> > > > +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > > +                               unsigned int offset, size_t len)
> > > > +{
> > > > +   int rc = 0;
> > > > +   phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> > >
> > > Any reason not to pass a phys_addr_t in the calling convention for the
> > > method and maybe also for dax_zero_page_range itself?
> >
> > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > will make changes.
> 
> The problem is device-mapper. That wants to use offset to route
> through the map to the leaf device. If it weren't for the firmware
> communication requirement you could do:
> 
> dax_direct_access(...)
> generic_dax_zero_page_range(...)
> 
> ...but as long as the firmware error clearing path is required I think
> we need to do pass the pgoff through the interface and do the pgoff to
> virt / phys translation inside the ops handler.

Hi Dan,

Drivers can easily convert offset into dax device (say phys_addr_t) to
pgoff and offset into page, isn't it?

pgoff_t = phys_addr_t/PAGE_SIZE;
offset = phys_addr_t & (PAGE_SIZE - 1);

And pgoff can easily be converted into sectors which dm/md can use for
mapping and come up with pgoff in target device.

Anyway, I am fine with anything.

Thanks
Vivek

