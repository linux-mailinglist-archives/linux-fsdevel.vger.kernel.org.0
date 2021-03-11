Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD521336948
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 01:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCKAxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 19:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKAx2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:53:28 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CE0C061761
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 16:53:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o19so252559edc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 16:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=VytBblI4nb9JtqHcpg5PYs38jajnTR0u0JS6jpl3x32VbN+1FmkpQKztC6QGh/owq5
         OKZtrVWvRSAAgZSa52MpRCKaSLrn8M/wS7+lpN3thB2qy4x5ASseSLbpttO55PtkZRcg
         Usu+VKGsxFUTs0UMAmVvtsOBETR54kARgVDHg+jieLrIMe5HoGU7jO+WFaXqB1/Shadj
         acLiBoL+9rXMHYN4h5kBD34GepJ6XoGwLlBU74peSFTH4olLLWwe877BUouMrPF9vqxz
         iTkHZTfI/P5BPtXD8Ih2GVWaZnwQK2AMiro/XIrqqU/ujd/Qp2vrSZYPEp61VpSaQc8f
         2Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4/XB1NjVzkcassvGF9k8OOkOtHMefsYgpLIOhbHN44=;
        b=uW4DIclao77HHXCtxvjOE0SeY4Bib+gyz6OFDuRb5ZDPOd5InccBNOyS25+wcuYuTE
         n5ZMZUaYK0smaS4rKM4Zlr0wVXIBnSFXRgE8Pds/wBg3no87iQgWT59B6GjDoYsSBaWf
         UIaP33WBJGS6aapHEfsFJaaeL3MCiow/xaTUdohKWMKWXuBWDWUXV4f5AwIUICelFn7a
         Q9APq5oSnmDI5ffN8nacNvBe+8Toq6EpWv4ZeTGola9rnny/CeO2wATg1mLFwpttc5z7
         8vKruHKU18a8wG0m2ytVGwJwAg1nX55wRdu1CFDhTP1OUqXR6UpA/6/pWW1D2XhWq/8q
         sCyw==
X-Gm-Message-State: AOAM530KPBnTG89DRWnW0DP3JShY7usDx3/qYtbgll93vgIaA+TAyh7b
        sFbKPoC9nrX351b3SOdmLk8CJD6MMNlb1fr/wqd9Gw==
X-Google-Smtp-Source: ABdhPJypQ8GemOXeRAlB5nBwa/LaXTEzwLO62LM4I6+2OuCpeLVCa5nLj+566PgoZJjKJzgw0+xwotjje7pT9PlLG2A=
X-Received: by 2002:aa7:dd05:: with SMTP id i5mr6011841edv.300.1615424006716;
 Wed, 10 Mar 2021 16:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Mar 2021 16:53:15 -0800
Message-ID: <CAPcyv4i80GXjjoAD9G0AaRDWPbcTSLogJE9NokO4Eqpzt6UMkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Neal Gompa <ngompa13@gmail.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 6:27 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Mar 10, 2021 at 08:21:59AM -0600, Goldwyn Rodrigues wrote:
> > On 13:02 10/03, Matthew Wilcox wrote:
> > > On Wed, Mar 10, 2021 at 07:30:41AM -0500, Neal Gompa wrote:
> > > > Forgive my ignorance, but is there a reason why this isn't wired up to
> > > > Btrfs at the same time? It seems weird to me that adding a feature
> > >
> > > btrfs doesn't support DAX.  only ext2, ext4, XFS and FUSE have DAX support.
> > >
> > > If you think about it, btrfs and DAX are diametrically opposite things.
> > > DAX is about giving raw access to the hardware.  btrfs is about offering
> > > extra value (RAID, checksums, ...), none of which can be done if the
> > > filesystem isn't in the read/write path.
> > >
> > > That's why there's no DAX support in btrfs.  If you want DAX, you have
> > > to give up all the features you like in btrfs.  So you may as well use
> > > a different filesystem.
> >
> > DAX on btrfs has been attempted[1]. Of course, we could not
>
> But why?  A completeness fetish?  I don't understand why you decided
> to do this work.

Isn't DAX useful for pagecache minimization on read even if it is
awkward for a copy-on-write fs?

Seems it would be a useful case to have COW'd VM images on BTRFS that
don't need superfluous page cache allocations.
