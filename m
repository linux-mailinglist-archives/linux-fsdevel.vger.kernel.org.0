Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B3F272AFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgIUQGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 12:06:12 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33840 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgIUQGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:06:12 -0400
Received: by mail-ej1-f68.google.com with SMTP id gr14so18575513ejb.1;
        Mon, 21 Sep 2020 09:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9b6OQ3Zjjrx1bFNpxG0aeuNVoOLkJTdiGt5QM005Xk=;
        b=ADpyjuSJwxN0kMTSKCUhA+ei9INXdBf7KMFuyqE6PGOk8Lte3Dax/6m+FgDj3CDJIe
         6luTSRUAEIiBqZHUeXsFNrlYjDj+mZ32JPYM18Aex6D2VGHwlnIcGcie29mGRbWk21Bv
         zoHvgcjpSmn7mdOI1+NB5eoY51r9FORm1+ryrcerR/nMnJItlW/XGqcng+O431PTSIe+
         6cZPwe749StpQdBjXWa5IZklK7BgpQOKpRiKsgdKJNgcpMS0DjBklV8V/h3r2HrbNHDk
         84oaock+3EuOhrCEsVrmP6ml8Z6yUHESgf49qlrLzIz/BBnnF+yA2XoldzbITbSN6DAu
         kFrQ==
X-Gm-Message-State: AOAM531BkGOWO6/6ZFI1JA1rbJjHspT6Cqurun2ZxZe2BJjLckfar6PX
        wL7y340uIQBTFd5s2v7aSA659geccr+so2A0heQ=
X-Google-Smtp-Source: ABdhPJwWAgzZvw0ilLAMX+EgPD7RGtqtEQoY1LTvuo8X/xI8z/htsAasYiueBv3hWPkjBe2uzU5w0cgCLVzSQRVa7Oo=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1mr152793eji.436.1600704370159;
 Mon, 21 Sep 2020 09:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200917082236.2518236-1-hch@lst.de> <20200917082236.2518236-3-hch@lst.de>
 <20200917171604.GW3421308@ZenIV.linux.org.uk> <20200917171826.GA8198@lst.de> <20200921064813.GB18559@lst.de>
In-Reply-To: <20200921064813.GB18559@lst.de>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 21 Sep 2020 12:05:52 -0400
Message-ID: <CAFX2Jfks7QTS5crWa43mp4TQ3LoquvRxjuEeCpsZr1aees00eA@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs,nfs: lift compat nfs4 mount data handling into the
 nfs code
To:     Christoph Hellwig <hch@lst.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is for the binary mount stuff? That was already legacy code when
I first started, and mount uses text options now. My preference is for
keeping it as close to the original code as possible.

I'm curious if you've been able to test this? I'm not sure if there is
a way to force binary mount data through mount.nfs

Anna

On Mon, Sep 21, 2020 at 2:49 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Sep 17, 2020 at 07:18:26PM +0200, Christoph Hellwig wrote:
> > On Thu, Sep 17, 2020 at 06:16:04PM +0100, Al Viro wrote:
> > > On Thu, Sep 17, 2020 at 10:22:33AM +0200, Christoph Hellwig wrote:
> > > > There is no reason the generic fs code should bother with NFS specific
> > > > binary mount data - lift the conversion into nfs4_parse_monolithic
> > > > instead.
> > >
> > > Considering the size of struct compat_nfs4_mount_data_v1...  Do we really
> > > need to bother with that "copy in place, so we go through the fields
> > > backwards" logics?  Just make that
> > >
> > > > +static void nfs4_compat_mount_data_conv(struct nfs4_mount_data *data)
> > > > +{
> > >     struct compat_nfs4_mount_data_v1 compat;
> > >     compat = *(struct compat_nfs4_mount_data_v1 *)data;
> > > and copy the damnt thing without worrying about the field order...
> >
> > Maybe.  But then again why bother?  I just sticked to the existing
> > code as much as possible.
>
> Trond, Anna: what is your preference?
