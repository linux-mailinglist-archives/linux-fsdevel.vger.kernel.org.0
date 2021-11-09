Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA744B2D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbhKISvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbhKISvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 13:51:50 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298ADC061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Nov 2021 10:49:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c126so262051pfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Nov 2021 10:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bp0YO5sOM+lpNoi642x1FUr5VchwTC78oq/dL28lzk=;
        b=0Q1ubUOlWM8Iug6rvhIAFjz7MaLu3MQqTHHXXNFaAN3qobCKUeard5v3w6hQexzI6j
         EQcZDkHYWqy9mWUon0Sw5zW0RErSz2I0osX0CHUN1ykL/BCN5ucRl32GT2O6dYVhRDx+
         DIx0Bq3GMoEu4GQuOAoCsyqrJqRNG5y2MVJRbJCthUwPi140VN85CTlRi+CQIGmDkuoJ
         o4YlTHfCQyJ4T21m/SW8rbNEAXwp16xbZ8UL7OpvPbBafjrbOh4FjIMKgETwtEC4fnjk
         Wxk5Ja7eZ0ILW/8jehkfJvL5xHHWw8sddDBe/kDwglw+DIpJultHbe9pcAc33W5VFQaI
         j5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bp0YO5sOM+lpNoi642x1FUr5VchwTC78oq/dL28lzk=;
        b=SdTEaR1bkRnvROjIVlKsNjThU2oHRMqduVoNIBno/0Ds4iG1vxYwzb4AceP+t7tBgO
         tzSOTm6R/7ArIiaXVyM68wQsJC4ORICRT6bmONBtvgOSguainWlimvnQqJ3p6pzDJ8sY
         PJ66G+4tTKaRex180WVsuq7dZDSBMWtHkHcpw+9yjaTlcudbpGjn6CrP9SWNaM4hw/P5
         XYE/0VtrnVgri2ipTUZ2re8niX0hQuICSVhyhqf0nr77hWyT14axaAxBpg3zIWxM2Zso
         ilO0OJE+dbAZfd/VsaSsp8zNhLZysZBalBYQLlPGde2qd39GGtbsISnyJFgdWIrZYsAg
         WBQA==
X-Gm-Message-State: AOAM531gzO4pc3OOT5NA997kld5DEx5jXUjH9QXGSPOS+HYNFGybPF5l
        MPdfGTevlfGcqFJj6Lr6uKjEhyjFp2sgkHq1iqnCzQ==
X-Google-Smtp-Source: ABdhPJxiswkGl2pVIvWWZ6aSVUFazaiZRuYEfrTL3uF2sZNR2Ly4HeMeR//UR5dITrLxDj1E3LTcAsgeWYlO0yGvWG4=
X-Received: by 2002:a05:6a00:1a51:b0:4a0:3c1:4f45 with SMTP id
 h17-20020a056a001a5100b004a003c14f45mr4740999pfv.86.1636483741722; Tue, 09
 Nov 2021 10:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20211106011638.2613039-1-jane.chu@oracle.com> <20211106011638.2613039-3-jane.chu@oracle.com>
 <YYoi2JiwTtmxONvB@infradead.org>
In-Reply-To: <YYoi2JiwTtmxONvB@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Nov 2021 10:48:51 -0800
Message-ID: <CAPcyv4hQrUEhDOK-Ys1_=Sxb8f+GJZvpKZHTUPKQvVMaMe8XMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jane Chu <jane.chu@oracle.com>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 8, 2021 at 11:27 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Nov 05, 2021 at 07:16:38PM -0600, Jane Chu wrote:
> >  static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
> >               void *addr, size_t bytes, struct iov_iter *i, int mode)
> >  {
> > +     phys_addr_t pmem_off;
> > +     size_t len, lead_off;
> > +     struct pmem_device *pmem = dax_get_private(dax_dev);
> > +     struct device *dev = pmem->bb.dev;
> > +
> > +     if (unlikely(mode == DAX_OP_RECOVERY)) {
> > +             lead_off = (unsigned long)addr & ~PAGE_MASK;
> > +             len = PFN_PHYS(PFN_UP(lead_off + bytes));
> > +             if (is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512, len)) {
> > +                     if (lead_off || !(PAGE_ALIGNED(bytes))) {
> > +                             dev_warn(dev, "Found poison, but addr(%p) and/or bytes(%#lx) not page aligned\n",
> > +                                     addr, bytes);
> > +                             return (size_t) -EIO;
> > +                     }
> > +                     pmem_off = PFN_PHYS(pgoff) + pmem->data_offset;
> > +                     if (pmem_clear_poison(pmem, pmem_off, bytes) !=
> > +                                             BLK_STS_OK)
> > +                             return (size_t) -EIO;
> > +             }
> > +     }
>
> This is in the wrong spot.  As seen in my WIP series individual drivers
> really should not hook into copying to and from the iter, because it
> really is just one way to write to a nvdimm.  How would dm-writecache
> clear the errors with this scheme?
>
> So IMHO going back to the separate recovery method as in your previous
> patch really is the way to go.  If/when the 64-bit store happens we
> need to figure out a good way to clear the bad block list for that.

I think we just make error management a first class citizen of a
dax-device and stop abstracting it behind a driver callback. That way
the driver that registers the dax-device can optionally register error
management as well. Then fsdax path can do:

        rc = dax_direct_access(..., &kaddr, ...);
        if (unlikely(rc)) {
                kaddr = dax_mk_recovery(kaddr);
                dax_direct_access(..., &kaddr, ...);
                return dax_recovery_{read,write}(..., kaddr, ...);
        }
        return copy_{mc_to_iter,from_iter_flushcache}(...);

Where, the recovery version of dax_direct_access() has the opportunity
to change the page permissions / use an alias mapping for the access,
dax_recovery_read() allows reading the good cachelines out of a
poisoned page, and dax_recovery_write() coordinates error list
management and returning a poison page to full write-back caching
operation when no more poisoned cacheline are detected in the page.
