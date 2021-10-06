Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0A423E5D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhJFNEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 09:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhJFNEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:04:43 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98EC061749
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Oct 2021 06:02:51 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id h132so1160752vke.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xexEpJdvSs8WA8ytXi5Jvt5/cU1ono4iJfJ2H9LSanI=;
        b=XPTZYNUAGTD6PuQEs5Xnr6OTxYtUaCDBi3AEe+52RdarJKKJnE5CizERVElvjXPzKM
         4d/gtP5lgLu4BDUhPptbBVeRvJrT8oRMEDkKjqKvP9rskHDrmLI5sBGKPAdreEiq4WCU
         /9E9J0lxb4EB7BEUXcFWSyv/3YC8Q4ZRLXyQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xexEpJdvSs8WA8ytXi5Jvt5/cU1ono4iJfJ2H9LSanI=;
        b=WyHcfPCYW2guDutOiHU/lghX3lk2CcjbA/4+SKpkQlJ1Xod56xs2+spac9uMjuB4rz
         UnDeWVvgCiblxr304Wdt9jLL390LP7+1//DVnXCjJt1ZwcrIXtNWZKmtNhwyMAszI17I
         ox1Qovj5+9y2QG4DwYoaipCPLRiPfal+OZvsBye2i2twHR1wIaJKTsPMLJD1HagAas82
         I16Hsa8qf8r8exSAHDhMt0vcBq+5X5vwvEl5lJEh2Jrwe+PSZwMkWOAs9mNXb1WDKSXT
         AAxr3OIv+8mS7uBNjm5ZLIQVdvNW3/1Wog+ghR6+KHtbRU5moTsS+SKjFVSlLsFBHpsH
         RofQ==
X-Gm-Message-State: AOAM5325bBynu053EQbSNub+RoJbSkwi5Oq08DzSTOM4MVC3u0qDASW3
        rxg86wLe68qEvo7eWEIEsjil8IqU0cnMvy33cC3E6Q==
X-Google-Smtp-Source: ABdhPJy/n6KphMOu2px3HytTgvsxY7F0fpWvn8/i8x/gtytX8fTTLlXQjuPmaEce6ZmQULkfU5VA2wZuSNNcY8tRcIo=
X-Received: by 2002:a1f:1609:: with SMTP id 9mr25326030vkw.10.1633525366883;
 Wed, 06 Oct 2021 06:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210930143850.1188628-1-vgoyal@redhat.com> <20210930143850.1188628-8-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-8-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 6 Oct 2021 15:02:36 +0200
Message-ID: <CAJfpegtdftj7jQFu+4LBjysiAJ-hhLHkBC_KhowfJtepvZqaoQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] virtiofs: Add new notification type FUSE_NOTIFY_LOCK
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>, jaggel@bu.edu,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 30 Sept 2021 at 16:39, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Add a new notification type FUSE_NOTIFY_LOCK. This notification can be
> sent by file server to signifiy that a previous locking request has
> completed and actual caller should be woken up.

Shouldn't this also be generic instead of lock specific?

I.e. generic header  + original outarg.

Thanks,
Miklos
