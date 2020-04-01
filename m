Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBA519AC76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732652AbgDANPS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 09:15:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45431 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732252AbgDANPR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585746916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uDWi3WDn1B2QwOc9496H7TM03TtVTOftspl14cHOSNA=;
        b=fnAWd0nZ5JhFxvGEfPidinIhR8Boee2TcBLJCMGVOa1f3kQSnCWGqWH+11XHC3F1OdBx5o
        wy7Pg9ThR65K2mRctPrjtokZyTfuSHQnQNG5GMLFOt99V08F7CpkXJJmhI+iz082Buit8B
        DJCDJHOfvxiMGfw6SfHb/3O/iT0AWBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-C-GpJADTMS21MbxEZWGp5g-1; Wed, 01 Apr 2020 09:15:13 -0400
X-MC-Unique: C-GpJADTMS21MbxEZWGp5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8799D100DFC1;
        Wed,  1 Apr 2020 13:15:11 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-83.rdu2.redhat.com [10.10.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF9985C1D5;
        Wed,  1 Apr 2020 13:15:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 269EF220005; Wed,  1 Apr 2020 09:15:08 -0400 (EDT)
Date:   Wed, 1 Apr 2020 09:15:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Christoph Hellwig <hch@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
Message-ID: <20200401131508.GA3434@redhat.com>
References: <20200218214841.10076-1-vgoyal@redhat.com>
 <20200218214841.10076-5-vgoyal@redhat.com>
 <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:38:16PM -0700, Dan Williams wrote:
> On Tue, Feb 18, 2020 at 1:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Add a dax operation zero_page_range, to zero a range of memory. This will
> > also clear any poison in the range being zeroed.
> >
> > As of now, zeroing of up to one page is allowed in a single call. There
> > are no callers which are trying to zero more than a page in a single call.
> > Once we grow the callers which zero more than a page in single call, we
> > can add that support. Primary reason for not doing that yet is that this
> > will add little complexity in dm implementation where a range might be
> > spanning multiple underlying targets and one will have to split the range
> > into multiple sub ranges and call zero_page_range() on individual targets.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  drivers/dax/super.c   | 19 +++++++++++++++++++
> >  drivers/nvdimm/pmem.c | 10 ++++++++++
> >  include/linux/dax.h   |  3 +++
> >  3 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> > index 0aa4b6bc5101..c912808bc886 100644
> > --- a/drivers/dax/super.c
> > +++ b/drivers/dax/super.c
> > @@ -344,6 +344,25 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
> >  }
> >  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
> >
> > +int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len)
> > +{
> > +       if (!dax_alive(dax_dev))
> > +               return -ENXIO;
> > +
> > +       if (!dax_dev->ops->zero_page_range)
> > +               return -EOPNOTSUPP;
> 
> This seems too late to be doing the validation. It would be odd for
> random filesystem operations to see this error. I would move the check
> to alloc_dax() and fail that if the caller fails to implement the
> operation.
> 
> An incremental patch on top to fix this up would be ok. Something like
> "Now that all dax_operations providers implement zero_page_range()
> mandate it at alloc_dax time".

Hi Dan,

Ok, I will send an incremental patch for this.

BTW, I have posted V6 of this patch series and you might want to look
at that instead of V5.

https://lore.kernel.org/linux-fsdevel/20200228163456.1587-1-vgoyal@redhat.com/

Vivek

