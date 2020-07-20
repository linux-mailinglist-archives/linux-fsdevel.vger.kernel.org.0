Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C47A227058
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgGTV2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgGTV2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:28:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917AC061794;
        Mon, 20 Jul 2020 14:28:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so3438304qkg.9;
        Mon, 20 Jul 2020 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sh/KLSzQqnJr0/PMf2DmO5rUtVYfFwMH4ti+obo2a7s=;
        b=EulKUbZ0padoY58Gz7BUn19Q8Hk6KEJaTssCqM4lILM7IAI6zewfZh8oqNUoUyQoQB
         7NTznTeKJycRqCHBebiJHdUDc3dJuXT4oWkSqv7Nd8vAXT58D5mHAgRZrE/rlefmctXk
         iF0R314VBwwyPtZ5vQ9GjPl1jHRYIZxMQkWwbkCU5KpbxSiLWlT5Nqva2QiK7czML7c5
         URTZec+Vmlsd24zt83lXA6dlTzT6u6pS8nCtPCyLiAvWG+LFRFdZ5hizdC/H3ow8Mkn8
         0jt58w1ztanJnkcf9f7qnHKksF3N35HduNlT0BJ1Z5fBq2yUpp1KgYjnlkc1j3tOh7m6
         BfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh/KLSzQqnJr0/PMf2DmO5rUtVYfFwMH4ti+obo2a7s=;
        b=gudpn3MvtSCEHHB0yIwr2tNZ7iTRR6paf8TE9QGtm8N21TzL8EAOmTXkXVeeY1XHWv
         cjbIIWrttcbKsaAt/2KDbtk09ZAEbD8wP0e26XPVrFCS2KLu5n8OeCJqYyRzZKWKuMUD
         NGOx7UKpcYTNxM+CHuQHUWS2nHmWiZ5nXAj8uEec5XnPo07UVlJDguRECN/8O3jZFv2x
         6/VJawQshzzMvW1vRKwW2Ta2HJxdtkalfzx0Ip5eikVW2CMU2rJrDRJrQndGShI6Lw1z
         LS9Wn2Sn52WL+f3fSgUN1qiCG2GizDjzhv40MVCOVmfIeRnpFb87joet8qsq3/wiY1UB
         7T/A==
X-Gm-Message-State: AOAM532TvstF8Ibwg0zJQyXGeHwLuThUHDBwJsu5BZ3nyWwxs4nj1T3y
        qK2RnpOSFAyqvGT6920E676dFD/gpJBFwtUgGF0=
X-Google-Smtp-Source: ABdhPJzsaontx5ozyXPRUXIspav4OYKL8Yae9yGB7WLujLekyBKPAJ+mXHiIErPXcPeOXd4tel2AAhIoC764A4fM5+Q=
X-Received: by 2002:a37:9147:: with SMTP id t68mr23191512qkd.34.1595280488864;
 Mon, 20 Jul 2020 14:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200720075148.172156-1-hch@lst.de> <20200720075148.172156-5-hch@lst.de>
 <CAFLxGvxNHGEOrj6nKTtDeiU+Rx4xv_6asjSQYcFWXhk5m=1cBA@mail.gmail.com>
 <20200720120734.GA29061@lst.de> <2827a5dbd94bc5c2c1706a6074d9a9a32a590feb.camel@gmail.com>
In-Reply-To: <2827a5dbd94bc5c2c1706a6074d9a9a32a590feb.camel@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 20 Jul 2020 23:27:57 +0200
Message-ID: <CAFLxGvyxtYnJ5UdD18uNA97zQaDB8-Wv8MHQn2g9GYD74v7cTg@mail.gmail.com>
Subject: Re: [PATCH 04/14] bdi: initialize ->ra_pages in bdi_init
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-raid@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Song Liu <song@kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-mtd@lists.infradead.org, linux-mm@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 2:37 PM Artem Bityutskiy <dedekind1@gmail.com> wrote:
>
> On Mon, 2020-07-20 at 14:07 +0200, Christoph Hellwig wrote:
> > What about jffs2 and blk2mtd raw block devices?

I don't worry much about blk2mtd.

> If my memory serves me correctly JFFS2 did not mind readahead.

This covers my knowledge too.
I fear enabling readahead on JFFS2 will cause performance issues, this
filesystem
is mostly used on small and slow NOR devices.

-- 
Thanks,
//richard
