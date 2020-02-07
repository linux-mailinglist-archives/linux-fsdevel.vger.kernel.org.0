Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85323155C5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGRB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40197 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726901AbgBGRB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581094917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnKyslaJEYi2vmej8z10FakIQgGWGqomW+jH0AD5b90=;
        b=McIgACo7tcnTwfVXFJXMtEMgbZMY5bbpbAnglTafrHrj78FtcDChWrK8Faw3Iim4J2mtzk
        8l8Lim27JlwUygBdZ3Q91ZGikxOHN2CVN71Gwowl5x6s+Y9zoZfIvgEpq+O2ddC/5gUsgt
        QAFyoC0JnQtABbTbstecwFV06u8fZ5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-gJz5zF4zOu6tl1jFnS3N5A-1; Fri, 07 Feb 2020 12:01:54 -0500
X-MC-Unique: gJz5zF4zOu6tl1jFnS3N5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BB031084426;
        Fri,  7 Feb 2020 17:01:53 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B56C7859A5;
        Fri,  7 Feb 2020 17:01:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 46A67220A24; Fri,  7 Feb 2020 12:01:50 -0500 (EST)
Date:   Fri, 7 Feb 2020 12:01:50 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200207170150.GC11998@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org>
 <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
 <20200206074142.GB28365@infradead.org>
 <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 08:57:39AM -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > > will make changes.
> > >
> > > The problem is device-mapper. That wants to use offset to route
> > > through the map to the leaf device. If it weren't for the firmware
> > > communication requirement you could do:
> > >
> > > dax_direct_access(...)
> > > generic_dax_zero_page_range(...)
> > >
> > > ...but as long as the firmware error clearing path is required I think
> > > we need to do pass the pgoff through the interface and do the pgoff to
> > > virt / phys translation inside the ops handler.
> >
> > Maybe phys_addr_t was the wrong type - but why do we split the offset
> > into the block device argument into a pgoff and offset into page instead
> > of a single 64-bit value?
> 
> Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
> have one device relative byte-offset.

So what's the best type to represent this offset. "u64" or "phys_addr_t"
or "loff_t" or something else.  I like phys_addr_t followed by u64.

Vivek

