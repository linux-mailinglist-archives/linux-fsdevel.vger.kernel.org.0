Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6AA500455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 04:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiDNCfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiDNCfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:35:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222AA517E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 19:32:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s137so3540397pgs.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 19:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSNIpToEpKx9C/PikZnCWZV0FikRekKMo16pPMd1DpA=;
        b=LGvyFYmBi//2J872dwC4BWvIgavMY42bnfS/6eXxFjyQAxgAIQmx/fj2cZ5NGgLQJ0
         Vj71Y/5rxksooccCGRxuVyYKJy0Vi/ysD/idUzToiZUWPz9xP526Vjd43hTc3P20brja
         hMzCaQeubXgiZec4rGfcnX6iqTHx06cDAqA4Xh7ssUrCqd9mXR9fnvZnt4QoZ2Se3lPk
         g8nY1MnrV2CVGmaTfsV8k2bQAGmQUpjHcwKEvQx8Hn+kYp3uV3prZLcy/41Qt2+ZWt50
         +GDObPXKuVEPcRlyzFFyTzZOxPL2HWNMJvafbWCfk6g4HkMqj9uHEcPDlsqjpetzgtnW
         IZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSNIpToEpKx9C/PikZnCWZV0FikRekKMo16pPMd1DpA=;
        b=xf/nl5k/VvuWSpujsMmt38KEOwyX1Yrmfgv2PmGyyRtFKiI1+HbEvrAdcQkJscI7dL
         u1ElycFNIewYX0ebiZfWyp2OSYD/DOXgrxLQOIioCDjqm+0fiz5bfAj41wV7IEL0o0Ls
         abd4hQM42FXjahn4jB3yWA4U31D6jp+1rEtVEyUQG6V3zToXPAjvBcCbM8Ac56vnxrTJ
         u246ODVxCOuqIoM3mWqR6bR5ojFjo+4NEa65utdgvukZCi+aPy2HAG23Z5OQfI5zFWSt
         5a0fFRAVibxs1ySXoqNXukEsUUrP24YPlDsuWYEJveug8coz9d8jFhXWv4ifWfS/quzG
         bOsA==
X-Gm-Message-State: AOAM532rDjCQjejPRqzS0Z9SHRNfojNMbzmhaC9GvSYysBEqNchL/9Ip
        hW6TFD7Odac+9gjb2RQ6OLDvBEC1XKyAy/MBXTn3tA==
X-Google-Smtp-Source: ABdhPJyJ7+lq6DXzFoR+6irZCG4YAQlpZndZMI7bifxiTNpKl3Ag2MIF6bdalp4DUmMY3P/bAV7PO08efRdZqcY2MLQ=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr522640pgb.74.1649903578582; Wed, 13 Apr
 2022 19:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220405194747.2386619-1-jane.chu@oracle.com> <20220405194747.2386619-4-jane.chu@oracle.com>
 <CAPcyv4jx=h+1QiB0NRRQrh1mHcD2TFQx4AH6JxnQDKukZ3KVZA@mail.gmail.com> <b511a483-4260-656a-ab04-2ba319e65ca7@oracle.com>
In-Reply-To: <b511a483-4260-656a-ab04-2ba319e65ca7@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Apr 2022 19:32:47 -0700
Message-ID: <CAPcyv4jpwzMPKtzzc=DEbC340+zmzXkj+QtPVxfYbraskLKv8g@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] mce: fix set_mce_nospec to always unmap the whole page
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
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
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 4:36 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 4/11/2022 4:27 PM, Dan Williams wrote:
> > On Tue, Apr 5, 2022 at 12:48 PM Jane Chu <jane.chu@oracle.com> wrote:
> >>
> >> The set_memory_uc() approach doesn't work well in all cases.
> >> For example, when "The VMM unmapped the bad page from guest
> >> physical space and passed the machine check to the guest."
> >> "The guest gets virtual #MC on an access to that page.
> >>   When the guest tries to do set_memory_uc() and instructs
> >>   cpa_flush() to do clean caches that results in taking another
> >>   fault / exception perhaps because the VMM unmapped the page
> >>   from the guest."
> >>
> >> Since the driver has special knowledge to handle NP or UC,
> >
> > I think a patch is needed before this one to make this statement true? I.e.:
> >
> > diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
> > index ee8d9973f60b..11641f55025a 100644
> > --- a/drivers/acpi/nfit/mce.c
> > +++ b/drivers/acpi/nfit/mce.c
> > @@ -32,6 +32,7 @@ static int nfit_handle_mce(struct notifier_block
> > *nb, unsigned long val,
> >           */
> >          mutex_lock(&acpi_desc_lock);
> >          list_for_each_entry(acpi_desc, &acpi_descs, list) {
> > +               unsigned int align = 1UL << MCI_MISC_ADDR_LSB(mce->misc);
> >                  struct device *dev = acpi_desc->dev;
> >                  int found_match = 0;
> >
> > @@ -63,8 +64,7 @@ static int nfit_handle_mce(struct notifier_block
> > *nb, unsigned long val,
> >
> >                  /* If this fails due to an -ENOMEM, there is little we can do */
> >                  nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
> > -                               ALIGN(mce->addr, L1_CACHE_BYTES),
> > -                               L1_CACHE_BYTES);
> > +                                       ALIGN(mce->addr, align), align);
> >                  nvdimm_region_notify(nfit_spa->nd_region,
> >                                  NVDIMM_REVALIDATE_POISON);
> >
>
> Dan, I tried the above change, and this is what I got after injecting 8
> back-to-back poisons, then read them and received  SIGBUS/BUS_MCEERR_AR,
> then repair via the v7 patch which works until this change is added.
>
> [ 6240.955331] nfit ACPI0012:00: XXX, align = 100
> [ 6240.960300] nfit ACPI0012:00: XXX, ALIGN(mce->addr,
> L1_CACHE_BYTES)=1851600400, L1_CACHE_BYTES=40, ALIGN(mce->addr,
> align)=1851600400
> [..]
> [ 6242.052277] nfit ACPI0012:00: XXX, align = 100
> [ 6242.057243] nfit ACPI0012:00: XXX, ALIGN(mce->addr,
> L1_CACHE_BYTES)=1851601000, L1_CACHE_BYTES=40, ALIGN(mce->addr,
> align)=1851601000
> [..]
> [ 6244.917198] nfit ACPI0012:00: XXX, align = 1000
> [ 6244.922258] nfit ACPI0012:00: XXX, ALIGN(mce->addr,
> L1_CACHE_BYTES)=1851601200, L1_CACHE_BYTES=40, ALIGN(mce->addr,
> align)=1851602000
> [..]
>
> All 8 poisons remain uncleared.
>
> Without further investigation, I don't know why the failure.
> Could we mark this change to a follow-on task?

Perhaps a bit more debug before kicking this can down the road...

I'm worried that this means that the driver is not accurately tracking
poison data For example, that last case the hardware is indicating a
full page clobber, but the old code would only track poison from
1851601200 to 1851601400 (i.e. the first 512 bytes from the base error
address).

Oh... wait, I think there is a second bug here, that ALIGN should be
ALIGN_DOWN(). Does this restore the result you expect?

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..d7a52238a741 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -63,8 +63,7 @@ static int nfit_handle_mce(struct notifier_block
*nb, unsigned long val,

                /* If this fails due to an -ENOMEM, there is little we can do */
                nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
-                               ALIGN(mce->addr, L1_CACHE_BYTES),
-                               L1_CACHE_BYTES);
+                                       ALIGN_DOWN(mce->addr, align), align);
                nvdimm_region_notify(nfit_spa->nd_region,
                                NVDIMM_REVALIDATE_POISON);


> The driver knows a lot about how to clear poisons besides hardcoding
> poison alignment to 0x40 bytes.

It does, but the badblocks tracking should still be reliable, and if
it's not reliable I expect there are cases where recovery_write() will
not be triggered because the driver will not fail the
dax_direct_access() attempt.
