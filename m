Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEA6552B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfFYPA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 11:00:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46850 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfFYPA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:00:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id 65so12717579oid.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 08:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70GK+AO3uKZgZ8D6gQdcBKHcRe1VNXglbQbcE8WJm74=;
        b=fU1rmjcxyJLj8X7SU9OSUMW6fTS/TTAvS2BuaKyep2KXVX8Klq2gi7xlYz+zBZ+18n
         xCS9Kxr3HwDpCllFsnEqU9VPY7rIVGvXyJC+eJl1K8K6sxVm4BXrOvf5Sfenbzo3eaNe
         Pkc5x+yQkgn3mlww4y0wW9Q4ZyEdCBPigGFdKU5nv2MBCf1U7hlwzI/sAWDpjXCf/bYA
         3Iv8V+Gr7qAgr/dQwUID3dYSix2Op1c2gaQVFppP9zqpnG+GiwtYjz8pfxO2OGXTacNy
         RmYLZSw2vDSwUWEW5pZtL9aiSF20Q8IKHpfCpjgAJj3rfThycpY/ZNhHgTZkY2/gqH7h
         IIZQ==
X-Gm-Message-State: APjAAAWAyZD9+BrRe+wEekf9JUZjab/iUQs5BsN5DdFe1pnhrfvBliQS
        F5V3DvCK9c7h1ColDy5rK59nFyWaNihZqfqGzE2GrQ==
X-Google-Smtp-Source: APXvYqwVfRfIKs2VVNJMH0Mkm6UR86DyT56S+wxjZ8DOyZk2D51KNnNrKZ+AMlENIW6mD4mWEAqIylIPnsGNSY7gwk8=
X-Received: by 2002:aca:72d0:: with SMTP id p199mr14884156oic.178.1561474827425;
 Tue, 25 Jun 2019 08:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de>
 <20190624182243.22447-1-agruenba@redhat.com> <20190625095707.GA1462@lst.de>
In-Reply-To: <20190625095707.GA1462@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 25 Jun 2019 17:00:16 +0200
Message-ID: <CAHc6FU5=WPY2nKYLmTzoiuiCYycad6F18FJPmm3dWCBV-PpJJw@mail.gmail.com>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
To:     Christoph Hellwig <hch@lst.de>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Jun 2019 at 11:57, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 24, 2019 at 08:22:43PM +0200, Andreas Gruenbacher wrote:
> > That would work, but I don't like how this leaves us with a vfs function
> > that updates i_size without bothering to dirty the inode very much.
>
> This isn't a VFS function, it is a helper library.

Well, let's call it that if this suits you better.

> > How about if we move the __generic_write_end call into the page_done
> > callback and leave special handling to the filesystem code if needed
> > instead?  The below patch seems to work for gfs2.
>
> That seems way more complicated.  I'd much rather go with something
> like may patch plus maybe a big fat comment explaining that persisting
> the size update is the file systems job.  Note that a lot of the modern
> file systems don't use the VFS inode tracking for that, besides XFS
> that includes at least btrfs and ocfs2 as well.

Andreas
