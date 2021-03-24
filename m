Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A29347CA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbhCXPbd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhCXPbD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:31:03 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B6C061763
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 08:31:00 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s25so11559806vsa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 08:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc2uWcmOYHsuFaDaziuqmdBB7HXaAseMJtvKA68Mmns=;
        b=fgVNZ/IDRPoyZoHD31LkoInkXHTy1IwCgAtx21pvGa67w88TdtZKHj3DPqEmSFUBE7
         jxwQOpaCEFAmP+Z0CfkPSiblkqKw52T+DfiHYhYkoT1DBx1ZtPgKrozdMzxIURueDQWO
         i0zTqQ5yGF608We/Ym1CTK4nXTi0CJr2AXaSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc2uWcmOYHsuFaDaziuqmdBB7HXaAseMJtvKA68Mmns=;
        b=Y2aJjO42/puUbBIzWEiCZL7uV27v1NijAzJ7AjcbMXp5Ern4I1qNiyFouvcpNErkON
         b0WWNkPI/m18CEykygEe6GLx7tzAt1P3Ky0102fOsZRq+mfKKjBxVw/OZP2W6siuiyfs
         leWrwJ9pnx9nBROftlt9K8BuPHR4gkxWm17s1MK6kgEz/sN7n9Xzh18zrfZUg0meUi7J
         Za2PmzK+mhMKAZ4YoPjGSKJiy9bWOJn5V11zmU+PEnz2qJIhay1B38tT68NOZ9FQBD6w
         QDzYYuHBKCrfzPqnVjwaa9rz8ZswHvLVcpgm3N7gy2tqBR5D30cJX/o1GPnhe5MFNDzC
         LDgw==
X-Gm-Message-State: AOAM533p3hd8XKTxPufXy0a+rJXUDl5PqzFpU7+Dw4lREpOblJlrE+Gm
        N/V3UbAKSG8mPxOSb/clQs2EGw0D0EvLsB0Apjfwig==
X-Google-Smtp-Source: ABdhPJwm579irBFtm4RC1b0MKE8RnV15CUYnl01EApVoeqFUk6shtoofjqWy/7jG4DVpJLbWCmm/Y2I+XyzB+kSlBj4=
X-Received: by 2002:a67:6786:: with SMTP id b128mr2413476vsc.9.1616599860174;
 Wed, 24 Mar 2021 08:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210318135223.1342795-1-ckuehl@redhat.com> <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com> <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
In-Reply-To: <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 16:30:49 +0100
Message-ID: <CAJfpeguzdPV13LhXFL0U_bfKcpOHQCvg2wfxF6ryksp==tjVWA@mail.gmail.com>
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 4:09 PM Connor Kuehl <ckuehl@redhat.com> wrote:
>
> On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> > I removed the conditional compilation and renamed the limit.  Also made
> > virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.
>
> Hi Miklos,
>
> Has this patch been queued?

It's in my internal patch queue at the moment.   Will push to
fuse.git#for-next in a couple of days.

Thanks,
Miklos
