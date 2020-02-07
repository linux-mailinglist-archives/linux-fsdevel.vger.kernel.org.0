Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5410155C93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgBGRGo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:06:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37035 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGRGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:06:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id q84so2663980oic.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 09:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeTa1kMSEl3fLJZjvubhBF7lLU+TSysbdNVa6LXQMGs=;
        b=xOuwqNiXcHB10xcosisChgV9ONSo/c2Qus/rR544MZlBpD5Ay7hfJC9WVKAzaAd+7f
         U/ogZnw+r/oWo8eLbbH1uz2FRsW4ncL3QQaYOXB5tMGUNUgy9QHudVLVGzSGf8tXQiLG
         G6FWY4st3CWg8CfeGHSGW+U0i4wcqLAm7c9T7Azgx+NnGbBA+0LfgBRgJ8ftSQl4fhml
         Ib9zZx/YscmftDwtkfPV4UTOHlsHGOZr/rD9r64BmBjyAr0bHE9Q0BvufvvHXSJLVzc9
         NuNjDbXAE4Jh3nBxliXXwfSgHCDqAqeTlhhwOsS2lluLxXV//IML04qYltBOcwek/+nD
         vPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeTa1kMSEl3fLJZjvubhBF7lLU+TSysbdNVa6LXQMGs=;
        b=qp+MwN/jFMEY96Mhasm26T85g8JoUNiGc3H2k8zUd3pqSBgALaFNlQiQqWsB5DeM39
         fzkDy1L4e/pbwrQQP6vzC+yG3SbAxwjMRr2x1RZEaJe7RGI4YUBL1Ul6y9ykg/ks8pAV
         c/NZ7EfGkg4A6bgQ+8fW3BZRsnR77OEM4AncW/prvv8x78Z0vEPZTAysFsV+RF6aZu7I
         gp8zuJsjKH7XIlcrwcrSBCusoBAzAghKaGsGlL2kZuhbwRFZh6Z9ENKg78vOlMFp8ijR
         3Jn/S1cLy9awmZp+x8ue38jawsrH2YXRM+Ec6wqdSW7FDC6UOCxSS5nQXFyRPChYQs8V
         R98w==
X-Gm-Message-State: APjAAAWzsU5aSOYHKZ/okMuLWc3F2BGeHbKC5cmQ8r4XY5In/P+UVt7F
        8B7WABZg5L8KBqTwwzVLcgzgjNGSvDk3I0GKcwgn0A==
X-Google-Smtp-Source: APXvYqyM78u7JQAugFgv5zZBfNuG8N7zn04ejIqfum6zEtPcj48HqoBLg00kLaeSxn3H7xzZslVIa+EkM26FbgU/wvs=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr2851359oij.0.1581095203775;
 Fri, 07 Feb 2020 09:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com>
 <20200206074142.GB28365@infradead.org> <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
 <20200207170150.GC11998@redhat.com>
In-Reply-To: <20200207170150.GC11998@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Feb 2020 09:06:32 -0800
Message-ID: <CAPcyv4g8jUhaKXhoh-1cvE4oi2v0JQcLrnFUW9zsRiC4F-7-zQ@mail.gmail.com>
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

On Fri, Feb 7, 2020 at 9:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Feb 07, 2020 at 08:57:39AM -0800, Dan Williams wrote:
> > On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
> > > > > I don't have any reason not to pass phys_addr_t. If that sounds better,
> > > > > will make changes.
> > > >
> > > > The problem is device-mapper. That wants to use offset to route
> > > > through the map to the leaf device. If it weren't for the firmware
> > > > communication requirement you could do:
> > > >
> > > > dax_direct_access(...)
> > > > generic_dax_zero_page_range(...)
> > > >
> > > > ...but as long as the firmware error clearing path is required I think
> > > > we need to do pass the pgoff through the interface and do the pgoff to
> > > > virt / phys translation inside the ops handler.
> > >
> > > Maybe phys_addr_t was the wrong type - but why do we split the offset
> > > into the block device argument into a pgoff and offset into page instead
> > > of a single 64-bit value?
> >
> > Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
> > have one device relative byte-offset.
>
> So what's the best type to represent this offset. "u64" or "phys_addr_t"
> or "loff_t" or something else.  I like phys_addr_t followed by u64.

Let's make it u64.

phys_addr_t has already led to confusion in this thread because the
first question I ask when I read it is "why call ->direct_access() to
do the translation when you already have the physical address?".
