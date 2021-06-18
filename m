Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD433ACDBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhFROoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhFROoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:44:19 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89BBC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f1so3462093uaj.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nqlCd2eHu+FNO0OH2gW6QkHD4Px5yMOfqRW26XQAK2o=;
        b=kYhMqUnz83h3s/37sIDv6unVm3hgmAnDw21NoXLxZpBiEwBC4HQ+gGAsfPYatAsbuA
         X6IEjDZiJzyns2/lnFDnsJqMlW113kPs5bpoxHBn/CzbOfrqQyh9d84b9u1Mffj/ekUZ
         pAWAT6WofHxbRthUqO1Wercd8AhpTrNpbSfLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nqlCd2eHu+FNO0OH2gW6QkHD4Px5yMOfqRW26XQAK2o=;
        b=P8QdaGqT8WPwf9AqqVMW4mC0DJsBArwbZ347esNKkx06mYlnCYX8tzkt4+KXas7nDv
         iXraqy5Ncq/3LawjHqRzYvMoWS5Fcz42QOw8YGD5IgYXGs9XcQmR43LGjOi1qCwYTyak
         yzHKhGFVgKqQJtT3leIogOYOHye88wM76iKeX3ZygBbMKqHem8F+osvrMs9E2zE76ip5
         JPb78w60CZbHgpmbMlfOKQHQOjH6P6FelD8uzJE2zP8BJqTu6WxtG0W3/si2RRWXmV4H
         j0ti5Fdc+vqvTdS1U6Ya2CE/jF0ksse3JOQfaYFyFtl52zo60bZnIyoCTlqnBzeiRCuT
         UuhQ==
X-Gm-Message-State: AOAM532E57Ki0oZspPOilWFKR0v517urfEmNGc0qS8kITqrY5ypDQfuB
        PEVGfrBbrQb8avU7WoOxsI89s/i3kIy0j1aBXXGfsg==
X-Google-Smtp-Source: ABdhPJxCPhcUp8VAgjMWYNQ+3Qh6e+CuVyciWjfH2mFAT6A530O3DOsPQ0ktvjy3CnVHRYCPNLlXR3q0wOPmds5CHuM=
X-Received: by 2002:ab0:6448:: with SMTP id j8mr12732714uap.13.1624027329045;
 Fri, 18 Jun 2021 07:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095309.3542373-1-stapelberg+linux@google.com>
 <CAJfpegvpnQMSRU+TW4J5+F+3KiAj8J_m+OjNrnh7f2X9DZp2Ag@mail.gmail.com> <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
In-Reply-To: <CAH9Oa-ZcG0+08d=D5-rbzY-v1cdUcuW0E7D_GcwjDoC1Phf+0g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 16:41:58 +0200
Message-ID: <CAJfpegu0prjjHVhBzwZBVk5N+avHvUcyi4ovhKbf+F7GEuVkmw@mail.gmail.com>
Subject: Re: [PATCH] backing_dev_info: introduce min_bw/max_bw limits
To:     Michael Stapelberg <stapelberg+linux@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Roman Gushchin <guro@fb.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Jun 2021 at 10:31, Michael Stapelberg
<stapelberg+linux@google.com> wrote:

> Maybe, but I don=E2=80=99t have the expertise, motivation or time to
> investigate this any further, let alone commit to get it done.
> During our previous discussion I got the impression that nobody else
> had any cycles for this either:
> https://lore.kernel.org/linux-fsdevel/CANnVG6n=3DySfe1gOr=3D0ituQidp56idG=
ARDKHzP0hv=3DERedeMrMA@mail.gmail.com/
>
> Have you had a look at the China LSF report at
> http://bardofschool.blogspot.com/2011/?
> The author of the heuristic has spent significant effort and time
> coming up with what we currently have in the kernel:
>
> """
> Fengguang said he draw more than 10K performance graphs and read even
> more in the past year.
> """
>
> This implies that making changes to the heuristic will not be a quick fix=
.

Having a piece of kernel code sitting there that nobody is willing to
fix is certainly not a great situation to be in.

And introducing band aids is not going improve the above situation,
more likely it will prolong it even further.

Thanks,
Miklos
