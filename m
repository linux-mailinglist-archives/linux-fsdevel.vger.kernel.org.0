Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F306113D43F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 07:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgAPGZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 01:25:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36287 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730461AbgAPGZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:25:52 -0500
Received: by mail-ot1-f66.google.com with SMTP id m2so13547234otq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q2Zze5PAbfGbIfzFdliXA62Y52BTomvMStI7KfWGBk=;
        b=u5kIlz7dq16rp2yrD78FB1VQ+w1Zq+JiSjBNilh5DRi9ac08AhhG0XDF9+gWsQ0qpy
         nPrmueWrxcoVKW2xQHkgjSCC/HAtaGq0F6o9mZiYIGXE2M+/oHKLChi/3SET+h2/jMge
         gdHRJFQskIPzuAAr2erbVkd1Vqf7B2Y9TpzL0K6Y09YJPlyumzeQ6+QXVQIqUZGH0KdP
         Ry+UfAL5nFVEdgiEYfWttB5EMFSnUtR7TlsE7HcXkBVw6yjtV1mebrsumkUQFFqveDNT
         BtjNugC2mm6DAp/slfvOUwzsk8q08hJISlAspgP1j4TZN69MyuzNRRaGYp0xWsEvnCkM
         XPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q2Zze5PAbfGbIfzFdliXA62Y52BTomvMStI7KfWGBk=;
        b=iXkIIm8tv6K2HUeTN6rcu6SOJ+uWGJgjoTVU3qDJG5TfK+53GpPXfOAo9yu0vhtgZG
         sspc9FdUUUwEtxlLvXQPx285qRyelJISHo7DU7h3CC4X67zptzly4sYcSRLm9mqnWtD/
         bqwQqqFSV3fZbyN6WbuwqQRHuAlWVuzLTWIDC7NUaPaeZHBdCgLAyU8pGI+8pVoiP4Ib
         P9mCJMNcIjBS3EqJDxHrFwibjgeBkDQIy3qyifl/0cQakhJ9ADC/UeSpX/ywnm+N82pD
         qOYpYGSt89uB7QvA7K986M3ZoO5amKT3JKJ155QyPB2wOs2Nxi2AaRpjXRv6rIdbsuza
         +mYg==
X-Gm-Message-State: APjAAAWOUlSzg8RLYW1zluzoF0zhSo7XJsoOQLlI8gldJhJ3LGuNpzxs
        7qsjX4HJg9Xg/CQllqxuuAubhWVcV3EBcOUNeewp/A==
X-Google-Smtp-Source: APXvYqwxrSywPSe+bSWTFb7guE1CCafYs03qvFymeop4ETyO8OyklXF9wh2bDlRNzFN+MYAZpycyHsRnLkWFEZhvIJE=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr838191otq.126.1579155952021;
 Wed, 15 Jan 2020 22:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20200110192942.25021-1-ira.weiny@intel.com> <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz> <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com> <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com> <20200116053935.GB8235@magnolia>
 <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com> <20200116061804.GI8257@magnolia>
In-Reply-To: <20200116061804.GI8257@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Jan 2020 22:25:41 -0800
Message-ID: <CAPcyv4gy7wkxCgmDtFjiS=abcRFUY77A4mcyCbMGuheqEV755w@mail.gmail.com>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:18 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Wed, Jan 15, 2020 at 10:05:00PM -0800, Dan Williams wrote:
> > On Wed, Jan 15, 2020 at 9:39 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > [..]
> > > >         attempts to minimize software cache effects for both I/O and
> > > >         memory mappings of this file.  It requires a file system which
> > > >         has been configured to support DAX.
> > > >
> > > >         DAX generally assumes all accesses are via cpu load / store
> > > >         instructions which can minimize overhead for small accesses, but
> > > >         may adversely affect cpu utilization for large transfers.
> > > >
> > > >         File I/O is done directly to/from user-space buffers and memory
> > > >         mapped I/O may be performed with direct memory mappings that
> > > >         bypass kernel page cache.
> > > >
> > > >         While the DAX property tends to result in data being transferred
> > > >         synchronously, it does not give the same guarantees of
> > > >         synchronous I/O where data and the necessary metadata are
> > > >         transferred together.
> > >
> > > (I'm frankly not sure that synchronous I/O actually guarantees that the
> > > metadata has hit stable storage...)
> >
> > Oh? That text was motivated by the open(2) man page description of O_SYNC.
>
> Eh, that's just me being cynical about software.  Yes, the O_SYNC docs
> say that data+metadata are supposed to happen; that's good enough for
> another section in the man pages. :)
>

Ah ok, yes, "all storage is a lie".
