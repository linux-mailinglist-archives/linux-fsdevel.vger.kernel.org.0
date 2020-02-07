Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF290155C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGQ5v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 11:57:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44410 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGQ5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:57:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so2752989otj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DoXHMrXc9C3nIDwMKcXgxUp8VuOy5v934gcrKt8olSo=;
        b=sliBWNmuOcp/8Onk/Da5rXzPxsGMzcyjLeyWKLOvl+uXkXIsW1atOmc8S7ciDDOBCJ
         oUKpU53yvCMSBda+W0UY82HP49IXpmYy9HPEypnAnFz82TjvsEa/mpJG6MaIM5VylaRe
         v4D3JkKuFFsMb9etnbhcGKCMyq4ixze7qkLQ/POSSxAQ3sIJ4baIbU5IoE1qqZRa6ksx
         DvqvCRA0JoyDJ2loFtWunMfX187kkf3BFfANnr7bk+GrVN5eUl8FsYlQGkS5KlPFNoov
         n6cxTQSKg63cRaAeje7AuDS/GxqXjcBnprMjexZb2CK0h9IBLcE2pYojXYmZs+aN9ZBn
         mPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoXHMrXc9C3nIDwMKcXgxUp8VuOy5v934gcrKt8olSo=;
        b=nzedkQIDdLGrXFC9oIlT7dVcSQEuVpnJtqXNiRTP7mLBA+neJ2pIxhoYbYXTrqb+ov
         3ibefEPdlGcazzwGgXka//mevbApRx6DSC9WNci0ZLQMO8RDYl7DWUzYUwS0pkfH7RlL
         HWvUefSh/tu1nyQjBaAbLhwCaFbXho6qAlQP+Az7meDmnx2LQOdL84c9EUHilfSnhq6/
         als5ATx9KwbSG0WvgwDkozM/f+RQubf2MQSfutxCVFsewnEqarkjcprhGTG5d0uJWPUs
         Fu/wQXSTkCytLjr+G1Pa/LJ3I25VJcTozp1cDMceJg3UHfQ9n4lrbcFdR83FphDeiPMO
         agfA==
X-Gm-Message-State: APjAAAUkpc0ot8ZplhaeIvByfeLzLHnHOh+btH01h3XQITz4IBcaeyCo
        U/sqquIyRhTtS8c4gJiMX0dI4laHe0D3xy8iS04hOw==
X-Google-Smtp-Source: APXvYqwZEd2ifdEG5DmRy5nKYxx/U0RJ8V18sdsJ2ufK7/ON2ZEyKZ8XWshkO52/AgDVnNwawXJ5TiRbMjZ0ofXEOh4=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr215119otl.71.1581094670173;
 Fri, 07 Feb 2020 08:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20200203200029.4592-1-vgoyal@redhat.com> <20200203200029.4592-2-vgoyal@redhat.com>
 <20200205183050.GA26711@infradead.org> <20200205200259.GE14544@redhat.com>
 <CAPcyv4iY=gw86UDLqpiCtathGXRUuxOMuU=unwxzA-cm=0x+Sg@mail.gmail.com> <20200206074142.GB28365@infradead.org>
In-Reply-To: <20200206074142.GB28365@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 Feb 2020 08:57:39 -0800
Message-ID: <CAPcyv4iTBTOuKjQX3eoojLM=Eai_pfARXmzpMAtgi5OWBHXvzQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dax, pmem: Add a dax operation zero_page_range
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 11:41 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 04:40:44PM -0800, Dan Williams wrote:
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
> Maybe phys_addr_t was the wrong type - but why do we split the offset
> into the block device argument into a pgoff and offset into page instead
> of a single 64-bit value?

Oh, got it yes, that looks odd for sub-page zeroing. Yes, let's just
have one device relative byte-offset.
