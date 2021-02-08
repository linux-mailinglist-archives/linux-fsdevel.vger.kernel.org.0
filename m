Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8F312BAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 09:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhBHI0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 03:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhBHI0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:26:15 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5BC061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 00:25:34 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id l192so7089926vsd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWpXNk9Y+G7a2x2FXqJab48oIcf6fRr7sg2s0g1XV/Q=;
        b=nYdwkzeeU93vwWCVoAVZc1tis0j/40vIrVm7/IW7330CqTB22w5SQP24Zu+jVA3H8R
         5/4DOhKaP0QncUCE5gKUNCt/BiRhi1Q0xXmO/rLXFmZztPi7QS6kBXCdkvxzUeSqI4t8
         TvQLcCP4/nVLBSDmSdcer6pc/Cilsr5fDbwaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWpXNk9Y+G7a2x2FXqJab48oIcf6fRr7sg2s0g1XV/Q=;
        b=mUifmb/TtWR0yQjp1nvmBXn74eQXerNLK3b1t4sc8nlInmj8mxhqwwwq21pHOxspU2
         d5U6TE6J8e6ICBy/r1N/YWFEVzEYBRqNh98Xoq1Vx4pGeP3P0ddwkuEz9zsV+hrwJ6Ep
         p3SZP0i0PDDWpq2s7yUVweOSA47jCd1mzvzcS9NB7bRDKjziCn5skNAAcI2ooIAKiL0v
         vYCPcuCN/nDYENVkygqU92UZjCNSSr+IERw7r+ucPBCgsBW8YCcAHAeUhS+/h/M9d4a/
         DNO3WfuZTrjITC2mCnHc+SVuesZFj38DyRs50vL6fWbw5sqLTWsFIQJMaBrb5Sy3gQTy
         3Yaw==
X-Gm-Message-State: AOAM530XnTOCqSC15ErHaL+HAtUBgsKvibGMpmTNEqmUs5Nk9Z19pofl
        Y3YuTFmf1nkbrm+M19Iaal/AhWFxNmJit/NuaBz6HA==
X-Google-Smtp-Source: ABdhPJzE95NhfjihZWoaQK5RgwPwArelJ+aYd/pxes9cWm0nmVxzjfkbXLwThKHWtViqMJ7c/7X1O3VJ9ZFOP8gkpak=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr8896448vso.47.1612772734040;
 Mon, 08 Feb 2021 00:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org> <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org> <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
 <20210203145620.GB308988@casper.infradead.org> <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
 <20210208020002.GM4626@dread.disaster.area>
In-Reply-To: <20210208020002.GM4626@dread.disaster.area>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 8 Feb 2021 09:25:22 +0100
Message-ID: <CAJfpeguTt+0099BE6DsVFW_jht_AD8_rtuSyxcz=r+JAnazQGA@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:00 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Feb 03, 2021 at 04:03:06PM +0100, Miklos Szeredi wrote:
> > On Wed, Feb 3, 2021 at 3:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > But let's talk specifics.  What does CIFS need to contact the server for?
> > > Could it be cached earlier?
> >
> > I don't understand what CIFS is doing, and I don't really care.   This
> > is the sort of operation where adding a couple of network roundtrips
> > so that the client can obtain the credentials required to perform the
> > operation doesn't really matter.  We won't have thousands of chattr(1)
> > calls per second.
>
> Incorrect.

Okay, I was wrong.

Still, CIFS may very well be able to perform these operations without
a struct file.   But even if it can't, I'd still only add the file
pointer as an *optional hint* from the VFS, not as the primary object
as Matthew suggested.

I stand by my choice of /struct dentry/ as the object to pass to these
operations.

Thanks,
Miklos
