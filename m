Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA625180929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 21:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCJU37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 16:29:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20491 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgCJU37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583872198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0k5j5BAO6+j561EWRZLgyRnG3Sw+2DCMIk63U5xiOW4=;
        b=Nu7DPCsGkvNerfeeAtIqUYusdDVdROxNqplz7/tzu9m4o5FhQ8FJnADV8D256iOu/WJ7fK
        UurcRsELkafDhnaUFYcznaxkd0bc5Zd5D1wZE1QAVfw3nWe0DlGhycVQqREKVfjgqb7Klz
        A9b7Q2TMkiHF6GTauAJIOMcmgh/AoFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-w0BHEEh_N8eJI055Y3zOFQ-1; Tue, 10 Mar 2020 16:29:56 -0400
X-MC-Unique: w0BHEEh_N8eJI055Y3zOFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464561005514;
        Tue, 10 Mar 2020 20:29:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA87A1001DC2;
        Tue, 10 Mar 2020 20:29:46 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7345D22021D; Tue, 10 Mar 2020 16:29:46 -0400 (EDT)
Date:   Tue, 10 Mar 2020 16:29:46 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 02/20] dax: Create a range version of
 dax_layout_busy_page()
Message-ID: <20200310202946.GE38440@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-3-vgoyal@redhat.com>
 <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310151906.GA670549@iweiny-DESK2.sc.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:19:07AM -0700, Ira Weiny wrote:
> On Wed, Mar 04, 2020 at 11:58:27AM -0500, Vivek Goyal wrote:
> >  
> > +	/* If end == 0, all pages from start to till end of file */
> > +	if (!end) {
> > +		end_idx = ULONG_MAX;
> > +		len = 0;
> 
> I find this a bit odd to specify end == 0 for ULONG_MAX...
> 
> >  }
> > +EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
> > +
> > +/**
> > + * dax_layout_busy_page - find first pinned page in @mapping
> > + * @mapping: address space to scan for a page with ref count > 1
> > + *
> > + * DAX requires ZONE_DEVICE mapped pages. These pages are never
> > + * 'onlined' to the page allocator so they are considered idle when
> > + * page->count == 1. A filesystem uses this interface to determine if
> > + * any page in the mapping is busy, i.e. for DMA, or other
> > + * get_user_pages() usages.
> > + *
> > + * It is expected that the filesystem is holding locks to block the
> > + * establishment of new mappings in this address_space. I.e. it expects
> > + * to be able to run unmap_mapping_range() and subsequently not race
> > + * mapping_mapped() becoming true.
> > + */
> > +struct page *dax_layout_busy_page(struct address_space *mapping)
> > +{
> > +	return dax_layout_busy_page_range(mapping, 0, 0);
> 
> ... other functions I have seen specify ULONG_MAX here.  Which IMO makes this
> call site more clear.

I think I looked at unmap_mapping_range() where holelen=0 implies till the
end of file and followed same pattern.

But I agree that LLONG_MAX (end is of type loff_t) is probably more
intuitive. I will change it.

Vivek

