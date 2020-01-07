Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87171328C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 15:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgAGOXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 09:23:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39887 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgAGOXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:23:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so17815944oib.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3VJe/dxyES65jnKtxYvETSNTHRiCAT6fnUUzfyEBsw=;
        b=IntyA5ICPEcRthqRYPCmMbZcDUdsPJKB41XMg3aNHyS8R6cuHoUT2CPYMdsXtRhIV/
         LE4AcTadPsbgzvkcanUbj/feghWprHupsWmFBAPc7sYF+VAsmKBx0fZyJQK8bF8M1Psc
         370rbvXm8e9yiT13+D5wg9K9mjUTdZdQ9TNUaJGocfOBIb2O4l3RX+l6g6lrQRLR542K
         uq6u075ZxqWd1dtGOT1YwXlKc+p25Z2v9ktm+IMQk7DdS4ccYqbvvQwR3hNsxwzI7ML7
         uZQ0x6Z/8r+EpXB5udA1qIlwP1zqd7XKjywpXRr4ylCkyezT+6v9gNmT4LaYtbSFwB4R
         bikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3VJe/dxyES65jnKtxYvETSNTHRiCAT6fnUUzfyEBsw=;
        b=iquEwUKKVFh0MDXCxWdnyAh29n5Rd/fsKSEvLKJ544lAe0DHpIkxRytbEUyUAVSlJa
         TeKT6oEA54ATXOa6ejMhTumuWpyOEnW2LJW+utMJK426A1/dBTwFupYtYJ6ZgI2DR2RY
         +BLaiCWf4JU68vy3ACVrYU5muzORkEJYYN3rf4SDXPj7OIE/XAeTt8qVl/hisU8rg1XF
         QyEeMZ9jUEXkWsFMDYWa4i9ou/sQ0sUgbNc8XQxXAzgyZLUDunZG6Rr6JMHb7xM6c1Zd
         JFKb029aQhX+5QoW6fxG+1EJMu0amxR8OUGPrOY4qRBQ+sHkmK0wek3K/S0yG6MPN5aS
         9ZDA==
X-Gm-Message-State: APjAAAVC4HfqTDAGs4dNnjf0YM0kzoCavAf+4IAp2FCyz5WYQg+JwvqF
        2ESNIFeMYl4GzAsc8daRZI/CBpLNthXv2Ac+q5Iw5w==
X-Google-Smtp-Source: APXvYqw+M12ZkKSJLTKleOTV1+IDlcbTBO8wNYejP3Rd62JSmbodZTAR2/rj6LbHMWOXB71wX7xzQYargDcyrZtNksM=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr7383807oij.149.1578406985047;
 Tue, 07 Jan 2020 06:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20190821175720.25901-1-vgoyal@redhat.com> <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org> <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org> <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area> <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
In-Reply-To: <20200107125159.GA15745@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 06:22:54 -0800
Message-ID: <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > Agree. In retrospect it was my laziness in the dax-device
> > > implementation to expect the block-device to be available.
> > >
> > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > dax_device could be dynamically created to represent the subset range
> > > indicated by the block-device partition. That would open up more
> > > cleanup opportunities.
> >
> > Hi Dan,
> >
> > After a long time I got time to look at it again. Want to work on this
> > cleanup so that I can make progress with virtiofs DAX paches.
> >
> > I am not sure I understand the requirements fully. I see that right now
> > dax_device is created per device and all block partitions refer to it. If
> > we want to create one dax_device per partition, then it looks like this
> > will be structured more along the lines how block layer handles disk and
> > partitions. (One gendisk for disk and block_devices for partitions,
> > including partition 0). That probably means state belong to whole device
> > will be in common structure say dax_device_common, and per partition state
> > will be in dax_device and dax_device can carry a pointer to
> > dax_device_common.
> >
> > I am also not sure what does it mean to partition dax devices. How will
> > partitions be exported to user space.
>
> Dan, last time we talked you agreed that partitioned dax devices are
> rather pointless IIRC.  Should we just deprecate partitions on DAX
> devices and then remove them after a cycle or two?

That does seem a better plan than trying to force partition support
where it is not needed.
