Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273342C8788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgK3PQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgK3PQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:16:37 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D379C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:15:51 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t143so14462095oif.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ymyaL/VUpjN77BfIwvfG83Gjo8xA1mMwJchE8PRew4=;
        b=EIborbJSi32Et+tlLG4313xYIP2E3fWXKGWG4CmfMxWL4UBTb7z5GJd8bc5jo+mh9c
         +erGEbjQJyF4MPmU4AP9zCCTUaszDh499A45iJ/yuE66+2y0JLCptTvCFbBOp7Dfr0yp
         nOnk2x7+ZobpMnhsYTjlV20Jl15HQdShdR+5r2OvaXVlupcIj0MVm3ets6qUyRFaolNC
         3fzgDztJ2yDTBMxIM59y1iS/zXM8a70KVKzGgyDPNHeZXzxD54VdTjwUIyaSzqNYTp9z
         BOMPANOza1sI2Tf2sr9CbBUvafDAVf6vWh6h2K/fViP1Z3glqv44TI2M8h8o0nwc4ivt
         ujww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ymyaL/VUpjN77BfIwvfG83Gjo8xA1mMwJchE8PRew4=;
        b=Ex1rZN0g1Ytjzmc24bHnWgrbOxup3w8xyByfxPwUw3NIBomdWJCpTrMF4RpRYF2pOU
         mGzOnollb6OKdzSKt5mKfAV9oATSd48dqGuc0TnRSCSd3tdSZ+uIphSI0Os8nybQkWoo
         HxwZoX6nfK1kwja+WgEv3n+ulNJMj72dBV51YUbTGYlrKdlZi6bLE7bHjeKUn4U9dMOk
         9cyBT9V/NuPvr2ZZyETsdsgLV0dC84qv/7tCkrDSbUVMZWpttblrL523YhOIOZN+ajh4
         6E5ur+3pQ9qq8TnFhAMAqkNuMZ1VesVqVTE2mjTSIWUkIKJsdAVmlP/fddHpfFJcxu/B
         5ioA==
X-Gm-Message-State: AOAM531+MP/Xt6aRjgoJK+IrUr1N6Mm7AoxEhczWL6nuP99ydcqHZTJR
        s0xnaoi3hG7vPyCmGMCgOL3mmZGQszRt98tCnbo=
X-Google-Smtp-Source: ABdhPJxiPTP/CF84AZyrf4L3bu/MOkkWh5CU4td+FRRmmgMPCCM3Cu/iLRxu129MCvubGP5gfWmTtbj2353izp7blPE=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr15041901oid.114.1606749350848;
 Mon, 30 Nov 2020 07:15:50 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
 <20201130133652.GK11250@quack2.suse.cz> <CAE1WUT5LbFiKTAmT8V-ERH-=aGUjhOw5ZMjPMmoNWTNTspzN9w@mail.gmail.com>
 <20201130150923.GM11250@quack2.suse.cz>
In-Reply-To: <20201130150923.GM11250@quack2.suse.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 30 Nov 2020 07:15:39 -0800
Message-ID: <CAE1WUT54mPvQUEdLm_wt2-63oZvGO-uUCvhdHFosiN1ngm_NjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 30-11-20 06:22:42, Amy Parker wrote:
> > > > +/*
> > > > + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> > > > + * definition helps with checking if an entry is a PMD size.
> > > > + */
> > > > +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> > > > +
> > >
> > > Firstly, if you define a macro, we usually wrap it inside braces like:
> > >
> > > #define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)
> > >
> > > to avoid unexpected issues when macro expands and surrounding operators
> > > have higher priority.
> >
> > Oops! Must've missed that - I'll make sure to get on that when
> > revising this patch.
> >
> > > Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
> > > other bits for that matter). XA_ZERO_ENTRY is defined as
> > > xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
> > > the bits xarray internal entries are using and things will break.
> >
> > Could you provide an example of this overlap? I can't seem to find any.
>
> Well XA_ZERO_ENTRY | DAX_PMD == ((257 << 2) | 2) | (1 << 1). So the way
> you've defined XA_ZERO_PMD_ENTRY the DAX_PMD will just get lost. AFAIU (but
> Matthew might correct me here), for internal entries (and XA_ZERO_ENTRY is
> one instance of such entry) low 10-bits of the of the entry values are
> reserved for internal xarray usage so DAX could use only higher bits. For
> classical value entries, only the lowest bit is reserved for xarray usage,
> all the rest is available for the user (and so DAX uses it).

Ah, thank you. I'm not as familiar with DAX as I'd like. So what should we do?

Best regards,
Amy Parker
(she/her)
