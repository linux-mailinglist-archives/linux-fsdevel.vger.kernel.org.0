Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD86F891
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 06:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfGVEjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 00:39:40 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34710 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfGVEjk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 00:39:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id q128so15435671ywc.1;
        Sun, 21 Jul 2019 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMqsPQOjQqPIEBmD3EIh4Qtw05vaz+UOfW4nYOJHTL4=;
        b=t/VUEFE9R2TvEBxbMNvsYCoL2WZYdDc0V4kRWpaHd/rCAxdQIa436PxuYFihm/ifDL
         H5FDSOR4DAcsJfHRaXAU2y1fOgiHivBPZDcNU+NKvX/KOFe0+TIojO7yzrLOaCpfSgyH
         8w8H1swbhb7jAhafPPfws0q8ehyTp/OIOqdO5fSa9w6TNw/A3QFZcpZ7zIQOcFFirqf3
         rRY81Z8vai/trJWZwFmj3nqB2pLuwZujCtzdqgYaUFY39SgnBtvz0FEizNU7qvcPe1iZ
         9Cd4RFJF9WGz6EuAuJQeCzPQRQ2HfRrXe7rRYmw/vjWiISrRX9vt1y7X3WVeck0H9Ayf
         1UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMqsPQOjQqPIEBmD3EIh4Qtw05vaz+UOfW4nYOJHTL4=;
        b=NEPa6hHNRQdxAqyHmFex++84zd5bg/a2MmgFt+4fiq/a0EwbUe1N3qU/NcLlQxjasj
         YpYwlupQWTnM2xr7864s7iNZQreVL1P9NE/oJmBLhAJJO2NARKu6J946FfBkmTDsV5FH
         MrEQfOxUZuYyAJ/tSVp//elG75nCGJkxlSmrryA9Y6bUJOwZd1Z103Ed+41IqY4Qii5+
         7rM90Y+43Q36q2e08Qj1/FzjLl5Du+i2lcdzPf0irDJT6PF4lvB28pTeWVWTNFTgl3lV
         EQ7nIIVthKORXQSr2g9iZA5DSJdTvPYM4WEK2h0nXgnQrEMaWziGdrqGqDQ20RhGYKW4
         A+cw==
X-Gm-Message-State: APjAAAUv3g1CWTIpOvfZ8V4Cs1vZm7jCWr5sUKmkxmDwH/Cfflt9nVsz
        XTKA297oFdvdnawE5D6NfNebluBDuB0nPaxuaZQ=
X-Google-Smtp-Source: APXvYqw2nuO6UwixpRbfaNpk9MK1Ao8/qBkIZzg+dLv0cDdjoBg3WbnEO02wQKi8/VMw4pkqKPvLqF4+21jZlLPQ/AY=
X-Received: by 2002:a81:50d5:: with SMTP id e204mr39589702ywb.379.1563770379165;
 Sun, 21 Jul 2019 21:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190722025043.166344-1-gaoxiang25@huawei.com> <20190722025043.166344-13-gaoxiang25@huawei.com>
In-Reply-To: <20190722025043.166344-13-gaoxiang25@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 22 Jul 2019 07:39:27 +0300
Message-ID: <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 22, 2019 at 5:54 AM Gao Xiang <gaoxiang25@huawei.com> wrote:
>
> Currently kernel has scattered tagged pointer usages
> hacked by hand in plain code, without a unique and
> portable functionset to highlight the tagged pointer
> itself and wrap these hacked code in order to clean up
> all over meaningless magic masks.
>
> This patch introduces simple generic methods to fold
> tags into a pointer integer. Currently it supports
> the last n bits of the pointer for tags, which can be
> selected by users.
>
> In addition, it will also be used for the upcoming EROFS
> filesystem, which heavily uses tagged pointer pproach
>  to reduce extra memory allocation.
>
> Link: https://en.wikipedia.org/wiki/Tagged_pointer

Well, it won't do much good for other kernel users in fs/erofs/ ;-)

I think now would be a right time to promote this facility to
include/linux as you initially proposed.
I don't recall you got any objections. No ACKs either, but I think
that was the good kind of silence (?)

You might want to post the __fdget conversion patch [1] as a
bonus patch on top of your series.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/1530543233-65279-2-git-send-email-gaoxiang25@huawei.com/
