Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4C153C54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 01:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBFAk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 19:40:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39547 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFAk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:40:57 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so3875602oty.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 16:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wKAh9wuYiuc5W6sTWogwjdscmPsuVFsTNX4yHQsFIQ=;
        b=ldEkAgr+NcpWdcJk25F86nfxNKZtEH+jI9I9Rl0qVXtcuA9BPt77zEVCLoEN5Pbeol
         fHRD2E+B6ohnU2qzDz4q3NM7cYCa+RYlPygijcI8ic5lpPVVL7v5clOaMgcHwD0ho1hA
         LJsiC8J8IecPG3PeqXkAJ5bGXGV8bguP2795Q/z5zOF0HVknVy2gkJju2zWumZDaX6az
         jTuhKaBPZ8Tn02AWfKm+kWtHIHwwE9gCyzGxtNJIe2gS9eDWbwVU7wfYqkcZciaNpdWx
         7lq9mFWmRI385KNZTtMQ/0zZAzATJ/eJ49ZglHTOYr8wGch8GBFt7G0YjjN5tRH23+rV
         8ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wKAh9wuYiuc5W6sTWogwjdscmPsuVFsTNX4yHQsFIQ=;
        b=Uzu0LI1TyNFInpwUVurxeTs1EmlNQ10+vcfdhE+Crbzm0V1FHfZ+7eqlXnhzt7c++R
         TGFWiUQxZsvJlia4Zm6mVxVlXsBgi6fppZg8WCrlSmWFa4nWd/9w2zLSDHp4UFI/DCqr
         1zB2Eb6c9pAUQFqvOh2ctNVFeymq+HXNRypG+ElpvushVdLhoBCCRsF74sFN3Zag+tO9
         lsodRnWV9lJZJurgXxQlnutJJQ5HRf0MzHWJFoU4t/OOWJMAWW0KJQPwbqDDNZBwbq5B
         mPnagez7V/parECl3CKga9MNZebz4XDAPFQwv+XR2l+IJX4r9ZWdqzbtwiJRq8ckfcDu
         6AKg==
X-Gm-Message-State: APjAAAXyWnjlc62KxJGT8UdnE0UL43iuxGbUINl+nYWY25919mhZBmEU
        mbrMfrEp+Z1hKqdlrTucWllkhEY4joE+jOHx4lH1fA==
X-Google-Smtp-Source: APXvYqyKZ7yhH4qQ9POMbzWU+GRmK/2Uv1thD8dauL6GIvGQJ18ctO/qrHQMqFzNWYo5JVYYzySS+tO87KVxX3Ho1aw=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr29141169otk.363.1580949655787;
 Wed, 05 Feb 2020 16:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
In-Reply-To: <20200205200259.GE14544@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 16:40:44 -0800
Message-ID: <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Feb 05, 2020 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > > +   /*
> > > +    * There are no users as of now. Once users are there, fix dm code
> > > +    * to be able to split a long range across targets.
> > > +    */
> >
> > This comment confused me.  I think this wants to say something like:
> >
> >       /*
> >        * There are now callers that want to zero across a page boundary as of
> >        * now.  Once there are users this check can be removed after the
> >        * device mapper code has been updated to split ranges across targets.
> >        */
>
> Yes, that's what I wanted to say but I missed one line. Thanks. Will fix
> it.
>
> >
> > > +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > +                               unsigned int offset, size_t len)
> > > +{
> > > +   int rc = 0;
> > > +   phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> >
> > Any reason not to pass a phys_addr_t in the calling convention for the
> > method and maybe also for dax_zero_page_range itself?
>
> I don't have any reason not to pass phys_addr_t. If that sounds better,
> will make changes.

The problem is device-mapper. That wants to use offset to route
through the map to the leaf device. If it weren't for the firmware
communication requirement you could do:

dax_direct_access(...)
generic_dax_zero_page_range(...)

...but as long as the firmware error clearing path is required I think
we need to do pass the pgoff through the interface and do the pgoff to
virt / phys translation inside the ops handler.
