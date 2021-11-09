Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0768044A69B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbhKIGHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 01:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhKIGHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 01:07:20 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0068CC061766
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Nov 2021 22:04:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p18so18936215plf.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Nov 2021 22:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVge1Iw2DLICm/edhKMuLv0kwlblMX536VglZLVGuRY=;
        b=0y9m/3Tm3ZPhkRfOO6g6G8z3si/DzsgoP/MCPFixBiyqHbS5GCigEp/dxfNfAseuxS
         xThX8p4IEReKP+5oxM6JzYGIeRyClmu/fx6c5Rx+NDh3ZfmAXahyg+B0H8EoEGRZElbf
         YGDSosivvUKzfEReFxYNIPktibOlqP0MH+sG6GINqABRAZqmPBABbEWU9mnCx2uqUvjn
         vsaInhxhJX8T0ab9HkmF6f4okUnSUBvkCjzj7VDW63dScslQ3yBjiipLTGyDwHa0VayU
         4Z4YaHdEJZqVrovaz24ifQc0maLsszlZ3AxdC8bbzM8uN1EXsV/QYBf/NjWXNGmSE3dZ
         9OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVge1Iw2DLICm/edhKMuLv0kwlblMX536VglZLVGuRY=;
        b=Pn6S5A9nA0r8cYzQyWL+VUHkBkXBXpVGlBBUhnhyrKfg/bEPj057+uQMvZGG+PKVgI
         RfHwhiqVZMX1+LYLHRWIHA5QwUOaY7T0tOT6BRdA1/t8KkLd72Bwv79WugMy4vEoRCtY
         M0icjl2PVUkgQEycxfrU9zbiqwXqMI1gLrFhuJgO/oLIPIJBg7RtnPcGPkLh+8wtCZvR
         Q5imPXULj00Ih/vkxBLJd135gsFbMdpya29pPWYBNZ6kOjF6S5X2D+70VV4buMGFnZgF
         0gzA5uGWQrUj9WepZlAijpP6TIncg2urirUIhqP5iV8k8HimZGlfPnDe2yI6/yrY2G+A
         29Zw==
X-Gm-Message-State: AOAM533WlxIr0/W+7eEwHfOLOMSGWs+kunVF7Q7AgVbNjARv/1NDIX1d
        rBbl1KJ52vlG6MMwbB9DKJgfTaCt1eWxcnNiVcc90g==
X-Google-Smtp-Source: ABdhPJwCtlqgnkTVyH3ATYZHBwvXcSX7T/CMSvZ7vKetQyo9w+pCKsHLoVtp5/ayV5vOuQEKSBrDKVvV/RcSnLRvGBk=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr4381475pjb.93.1636437874506;
 Mon, 08 Nov 2021 22:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20211106011638.2613039-1-jane.chu@oracle.com> <20211106011638.2613039-2-jane.chu@oracle.com>
 <CAPcyv4jcgFxgoXFhWL9+BReY8vFtgjb_=Lfai-adFpdzc4-35Q@mail.gmail.com>
 <63f89475-7a1f-e79e-7785-ba996211615b@oracle.com> <20211109052640.GG3538886@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20211109052640.GG3538886@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 8 Nov 2021 22:04:23 -0800
Message-ID: <CAPcyv4j-EHz9Eg4UmD8v2-mPgNgE0uJSG_Wr2fzJsU-+Em6umw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dax: Introduce normal and recovery dax operation modes
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
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

On Mon, Nov 8, 2021 at 9:26 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Mon, Nov 08, 2021 at 09:02:29PM +0000, Jane Chu wrote:
> > On 11/6/2021 9:48 AM, Dan Williams wrote:
> > > On Fri, Nov 5, 2021 at 6:17 PM Jane Chu <jane.chu@oracle.com> wrote:
> > >>
> > >> Introduce DAX_OP_NORMAL and DAX_OP_RECOVERY operation modes to
> > >> {dax_direct_access, dax_copy_from_iter, dax_copy_to_iter}.
> > >> DAX_OP_NORMAL is the default or the existing mode, and
> > >> DAX_OP_RECOVERY is a new mode for data recovery purpose.
> > >>
> > >> When dax-FS suspects dax media error might be encountered
> > >> on a read or write, it can enact the recovery mode read or write
> > >> by setting DAX_OP_RECOVERY in the aforementioned APIs. A read
> > >> in recovery mode attempts to fetch as much data as possible
> > >> until the first poisoned page is encountered. A write in recovery
> > >> mode attempts to clear poison(s) in a page-aligned range and
> > >> then write the user provided data over.
> > >>
> > >> DAX_OP_NORMAL should be used for all non-recovery code path.
> > >>
> > >> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> > > [..]
> > >> diff --git a/include/linux/dax.h b/include/linux/dax.h
> > >> index 324363b798ec..931586df2905 100644
> > >> --- a/include/linux/dax.h
> > >> +++ b/include/linux/dax.h
> > >> @@ -9,6 +9,10 @@
> > >>   /* Flag for synchronous flush */
> > >>   #define DAXDEV_F_SYNC (1UL << 0)
> > >>
> > >> +/* dax operation mode dynamically set by caller */
> > >> +#define        DAX_OP_NORMAL           0
> > >
> > > Perhaps this should be called DAX_OP_FAILFAST?
> >
> > Sure.
> >
> > >
> > >> +#define        DAX_OP_RECOVERY         1
> > >> +
> > >>   typedef unsigned long dax_entry_t;
> > >>
> > >>   struct dax_device;
> > >> @@ -22,8 +26,8 @@ struct dax_operations {
> > >>           * logical-page-offset into an absolute physical pfn. Return the
> > >>           * number of pages available for DAX at that pfn.
> > >>           */
> > >> -       long (*direct_access)(struct dax_device *, pgoff_t, long,
> > >> -                       void **, pfn_t *);
> > >> +       long (*direct_access)(struct dax_device *, pgoff_t, long, int,
> > >
> > > Would be nice if that 'int' was an enum, but I'm not sure a new
> > > parameter is needed at all, see below...
> >
> > Let's do your suggestion below. :)
> >
> > >
> > >> +                               void **, pfn_t *);
> > >>          /*
> > >>           * Validate whether this device is usable as an fsdax backing
> > >>           * device.
> > >> @@ -32,10 +36,10 @@ struct dax_operations {
> > >>                          sector_t, sector_t);
> > >>          /* copy_from_iter: required operation for fs-dax direct-i/o */
> > >>          size_t (*copy_from_iter)(struct dax_device *, pgoff_t, void *, size_t,
> > >> -                       struct iov_iter *);
> > >> +                       struct iov_iter *, int);
> > >
> > > I'm not sure the flag is needed here as the "void *" could carry a
> > > flag in the pointer to indicate that is a recovery kaddr.
> >
> > Agreed.
>
> Not sure if this is implied but I would like some macros or other helper
> functions to check these flags hidden in the addresses.
>
> For me I'm a bit scared about having flags hidden in the address like this
> because I can't lead to some confusions IMO.
>
> But if we have some macros or other calls which can make this more obvious of
> what is going on I think that would help.

You could go further and mark it as an 'unsigned long __bitwise' type
to get the compiler to help with enforcing accessors to strip off the
flag bits.
