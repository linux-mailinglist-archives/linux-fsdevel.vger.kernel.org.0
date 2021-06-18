Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997773AC46C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhFRHEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhFRHEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:04:00 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA89EC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:01:50 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x8so4433737vso.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OH59EQaFszbJ3L0jQevna/zcsPt7eeIqoBHNldN0uLk=;
        b=RQYKJB2jgxRi/Zfa5bMBWe0fok+eeJXe2E+YIRAprXYu6i1q/sRvFlP7B0dcy12i/s
         5CpI8HMXxFHPznXGW23UZ/dGLVCIOHqzCrtlxPvC3frBINMEIHRvwrMhZiJa4nN3XPQi
         tuHTOvFUk6OY3SdDp7GkjCETLT0r+I31n9sIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH59EQaFszbJ3L0jQevna/zcsPt7eeIqoBHNldN0uLk=;
        b=jsU4YS3C6anq1tg2E11UoEoMAjBn23QDZAxCE/aF0YWyxNXl5Y8Bz+ALuISSZxUVVA
         Yr6OnO8xqeHacRB+k3k06L0k7IO6gBgSYXWohhjtPkyWAb97+e6pZSTmwrUUcQXR5SKK
         pPeasT669WTVteaXRRUMpjfZBfVRoFa4YA5Fa6ybTxDoyvhbJnO6K1uSi5ToO3JFHZ46
         jBKD6EB7RHkGvlnCIHpDYIIye2PdtkM1EB33wG6++0RZXFMtAHWeM6bVGGfBgr1n1oRc
         OQM2N455RkLYGaNGc5mp+xnZWLCvSfmAVrV64VQOkNtpCDZx5In5SiJ2ruoaN9SEMeTE
         Jg8A==
X-Gm-Message-State: AOAM531tXovUL1EJJQLJ61nXAecxquaPT8knjMRUler//iRJOWWmMVCg
        XrDlMhOj5Op2aJDA9PsmfF5i8JudPCmzeYKWBqIrHQ==
X-Google-Smtp-Source: ABdhPJxdCvJoCiU+FREbCKtRlqIMtB3jntP5kXM8JylnJTGkRVSOqc6HIYuUsOObIJPrd4ckhY1CtrVN5Vnmr1CJiwo=
X-Received: by 2002:a67:f659:: with SMTP id u25mr5191118vso.9.1623999709975;
 Fri, 18 Jun 2021 00:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210525172428.3634316-1-ira.weiny@intel.com> <20210525172428.3634316-2-ira.weiny@intel.com>
 <20210611172301.GA1600546@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210611172301.GA1600546@iweiny-DESK2.sc.intel.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 09:01:39 +0200
Message-ID: <CAJfpegv3iZ2pj8Cn0cvhZB0pVa4SC8LSZ9OYx3Qr-BwWmvtGag@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs/fuse: Remove unneeded kaddr parameter
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 11 Jun 2021 at 19:23, Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, May 25, 2021 at 10:24:26AM -0700, 'Ira Weiny' wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > fuse_dax_mem_range_init() does not need the address or the pfn of the
> > memory requested in dax_direct_access().  It is only calling direct
> > access to get the number of pages.
>
> In looking for feedback on this small series I realize that I failed to email
> Miklos for the fs/fuse patch.
>
> I'm adding Miklos to the To line...

LGTM, but this is Vivek's code, so adding Cc.

Thanks,
Miklos


>
> For the rest of the series is there any feedback?
>
> Ira
>
> >
> > Remove the unused variables and stop requesting the kaddr and pfn from
> > dax_direct_access().
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  fs/fuse/dax.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> > index ff99ab2a3c43..34f8a5635c7f 100644
> > --- a/fs/fuse/dax.c
> > +++ b/fs/fuse/dax.c
> > @@ -1234,8 +1234,6 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
> >  static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
> >  {
> >       long nr_pages, nr_ranges;
> > -     void *kaddr;
> > -     pfn_t pfn;
> >       struct fuse_dax_mapping *range;
> >       int ret, id;
> >       size_t dax_size = -1;
> > @@ -1247,8 +1245,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
> >       INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
> >
> >       id = dax_read_lock();
> > -     nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), &kaddr,
> > -                                  &pfn);
> > +     nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
> > +                                  NULL);
> >       dax_read_unlock(id);
> >       if (nr_pages < 0) {
> >               pr_debug("dax_direct_access() returned %ld\n", nr_pages);
> > --
> > 2.28.0.rc0.12.gb6a658bd00c9
> >
