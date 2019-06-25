Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1630455859
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 22:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfFYUEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 16:04:12 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33324 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfFYUEM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:04:12 -0400
Received: by mail-ua1-f67.google.com with SMTP id f20so7589279ual.0;
        Tue, 25 Jun 2019 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=m0MJL3wN2AP9H9zbmTuDAydVuJtVsHxPaQ0eNfh0YoY=;
        b=i3VFqgMUqFcuSRYzlmS4BKNh/g6AlKY/RFwfXl6n/T61oY9waxHHEthrv2954dnCrH
         9ndsVZMSpqx2PxgvpKS/3ve+MfQohIj53rS+cNwHnaD/czXhlyFXEb0Zg9uMvZNyUbZU
         5tqYVVRRnXO+oaFIVIVi8ZkjNr9GxA644ty1iAJIL6RS1nQLha0Efxoj7hm/xtxb1YzB
         9vCjoiEqzZ/6seA5VPpJiekigycahKRbuTlBGk5VGJTvU2Z1DoUGHmrxWnZgUCnytTcE
         HJAjBxQ0rSb8mw7cL1+ksAdlc4iPwhVhD8K0cOWJrhwiubLOxUrFX2Oow4mYM8y2qM41
         gWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=m0MJL3wN2AP9H9zbmTuDAydVuJtVsHxPaQ0eNfh0YoY=;
        b=IITkH+wcLhC0FpfU12ioxk/GzoYMr6Hn6g4IT1zqg6cRhjA8f4LOHh/btuLDhTuS6d
         MkPCijCuzHSoDHdE/EGB67XU+XY7HgVGrdVXlDikhhk/U+9h9rZ5m4UzpaSUoVAvTeRV
         +s2fb2yDA7aut/YnH+ZEb4v21tZt+t6c/8RVyfaDf6b3S9zLuGfYrGB67dNM7QI2tW66
         QVTkvUpOP2s+iXd2z079mwu7SJxRpsp7jmKxc7qjYHO5JwEWq+uHq3TWzKQGw0yOn7fU
         MR8ruuZ9rbs5jQ3uPwgYRPGbTHEtzJ1M3040hj4W5jsZ+dxt//7x0gZK6meHOS/GyhhW
         gfUg==
X-Gm-Message-State: APjAAAVQ9A+112tUHUhBksO1aePCIumojKZGyRoT19Lr4DXmF2acfa0v
        RsB8kW91NcBkKtVAgdT5RiAwR1WHoMwJh5fHiBc=
X-Google-Smtp-Source: APXvYqzGozuOSsNJiV4cafNPoEqKXExgHyjeHYQRTXssFTGhZPVmaqyRw4//oKx/wxOvqQhSM1dmJT1aThE1ZN6rkd4=
X-Received: by 2002:ab0:2a49:: with SMTP id p9mr151078uar.0.1561493051228;
 Tue, 25 Jun 2019 13:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190621192828.28900-1-rgoldwyn@suse.de> <20190621192828.28900-4-rgoldwyn@suse.de>
 <20190624070536.GA3675@lst.de> <20190625185659.tqaikm27onz6g3jt@fiona>
In-Reply-To: <20190625185659.tqaikm27onz6g3jt@fiona>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 25 Jun 2019 21:04:00 +0100
Message-ID: <CAL3q7H5eS9_KHwxDrkCGV1aVXvBdmJ-1UaGUnEcwRARr6pGzKw@mail.gmail.com>
Subject: Re: [PATCH 3/6] iomap: Check iblocksize before transforming page->private
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 8:58 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>
> On  9:05 24/06, Christoph Hellwig wrote:
> > On Fri, Jun 21, 2019 at 02:28:25PM -0500, Goldwyn Rodrigues wrote:
> > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > >
> > > btrfs uses page->private as well to store extent_buffer. Make
> > > the check stricter to make sure we are using page->private for iop by
> > > comparing iblocksize < PAGE_SIZE.
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > If btrfs uses page->private itself and also uses functions that call
> > to_iomap_page we have a major problem, as we now have a usage conflict.
> >
> > How do you end up here?
> >
>
> Btrfs uses page->private to identify which extent_buffer it belongs to.
> So, if you read, it fills the page->private. Then you try to write to
> it, iomap will assume it to be iomap_page pointer.
>
> I don't think we can move extent_buffer out of page->private for btrfs.
> Any other ideas?

The extent buffer is only for pages belonging to the btree inode (i.e.
pages that correspond to a btree node/lead).
Haven't looked in detail to this patchset, but you can't do buffered
writes or direct IO against the btree inode, can you?
So for file inodes, this problem doesn't exist.

Thanks.

>
> --
> Goldwyn



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
