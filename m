Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292EB155C45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 17:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGQ66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 11:58:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39766 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGQ66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:58:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so2787501oty.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bcluL/nyB0VjYEVoSs9KiwWiRD7Dbfw+/1BJdMrk04=;
        b=koBQP5WFRdSccDvp8kq2R42mnRkVSz3AyEe+njywG0w25vOKocmUHBP+hhLRJbJPdV
         0siW4MN0Ch+0FlKEr/DxZY99CjNRC7VHWffcP7dfudqLHPN9Q5Wu8iNYSlF1lU46puto
         OVuO38Dt/HpQ2iZ4EDkORmi3QCOdf7JJ44hG97VxluV4ZGqD43xbP5lSmYG4tGn/wJn5
         f4i0YoJsxhpEHzx1HI87Zqg/Tnjpm88GCg1KjwJrNfvQxIjj73oSpYB6a1eEwMMfwBvm
         ZDOY3DatxhU42dRREAiQTreFD1Fur5YS5E7AvCRiaruCk/fbmKQzxr5vSkrI3Kyr1Vok
         tlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bcluL/nyB0VjYEVoSs9KiwWiRD7Dbfw+/1BJdMrk04=;
        b=W0jOGul2LeMxC7oRfoZ1Yn88fauhNmzcmYedjkMheQrsEfK2fsuyWffDPGuheecbgj
         hlDhrNzkRLd+BgYDQGvzLEhdUTOLZYFTZziOtRiIuVbUfg6LdYmGQOdrLoJn+KKUdYQP
         5/YX+Gm7yS5a/4rMI5uinzzV6ERq4yX3/WBM1Cz0ut0q1bvBeu6+m2BNiYWl3ZL/cVTy
         MAf5hRMOUTAwnMBRiJVDpgBk7f7v7IJkz2rymG5NS79GtB3IOZeBXhmcex/EfQvM7hph
         7q5iyClFXU9JjqVbBEkn1XqHDF/25smiVPSbGvWzBUy3lfGEfeEQoq3OdFu/TJUn6RRS
         AViA==
X-Gm-Message-State: APjAAAX8r4syQaLFFDFoVI3NJlmPuXZhtRNWiqdK//DVW22/Jy+sfNBF
        1ZE4xFGUopWJiQUyuslKrsiL4CAkaqls7m9fUUgH1g==
X-Google-Smtp-Source: APXvYqw/6C4HAwNxaZVrwpTLMDnDTG++NB0iw0IEYHejzh7To9hof2jrUWdeK9OYAkgfD9kJ++NgZCvHPVbY0ouBQlw=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr251422otq.126.1581094737435;
 Fri, 07 Feb 2020 08:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com> <20200206143443.GB12036@redhat.com>
In-Reply-To: <20200206143443.GB12036@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Feb 2020 08:58:45 -0800
Message-ID: <CAPcyv4j_SN3cyeVfkVQBEniGBZ+XgmCx3ezBJ_KwiUpawaq40g@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 6:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > On Wed, Feb 5, 2020 at 12:03 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 10:30:50AM -0800, Christoph Hellwig wrote:
> > > > > +   /*
> > > > > +    * There are no users as of now. Once users are there, fix dm code
> > > > > +    * to be able to split a long range across targets.
> > > > > +    */
> > > >
> > > > This comment confused me.  I think this wants to say something like:
> > > >
> > > >       /*
> > > >        * There are now callers that want to zero across a page boundary as of
> > > >        * now.  Once there are users this check can be removed after the
> > > >        * device mapper code has been updated to split ranges across targets.
> > > >        */
> > >
> > > Yes, that's what I wanted to say but I missed one line. Thanks. Will fix
> > > it.
> > >
> > > >
> > > > > +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> > > > > +                               unsigned int offset, size_t len)
> > > > > +{
> > > > > +   int rc = 0;
> > > > > +   phys_addr_t phys_pos = pgoff * PAGE_SIZE + offset;
> > > >
> > > > Any reason not to pass a phys_addr_t in the calling convention for the
> > > > method and maybe also for dax_zero_page_range itself?
> > >
> > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > will make changes.
> >
> > The problem is device-mapper. That wants to use offset to route
> > through the map to the leaf device. If it weren't for the firmware
> > communication requirement you could do:
> >
> > dax_direct_access(...)
> > generic_dax_zero_page_range(...)
> >
> > ...but as long as the firmware error clearing path is required I think
> > we need to do pass the pgoff through the interface and do the pgoff to
> > virt / phys translation inside the ops handler.
>
> Hi Dan,
>
> Drivers can easily convert offset into dax device (say phys_addr_t) to
> pgoff and offset into page, isn't it?

It's not a phys_addr_t it's a 64-bit device relative offset.
