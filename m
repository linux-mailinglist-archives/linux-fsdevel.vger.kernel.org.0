Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF928628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 20:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfEWStx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 14:49:53 -0400
Received: from mail-yw1-f43.google.com ([209.85.161.43]:41509 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWStx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 14:49:53 -0400
Received: by mail-yw1-f43.google.com with SMTP id t140so15026ywe.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q/4hzu5ZLVp3mgIPesJPmq/IWbfe4flwA2HG1sCD0TQ=;
        b=u0BN/6Ny8Z4+blOm22Z5UCSC8Wy5XnV4pzNa9RSEvcRmexqQPvcwNghBha2X4MQ36C
         7dzsdV+f6ydrqcsngoZ6b81Z6BiBjBfDHoUWeZaLAK49agcruYHxVKfgwvl6vkbI7a2g
         qWF7FK3K5DeBcV4zvxpXp0o81by/At5dYBRjnk7yfQBXl0RTZNucfLEpe2dPkSFCumKX
         lM23S8zrXdpTm2qs3mlX+TjAUJg+SGmA3p+ePvgDlWxlg/5n+eJfvBZ/ka/EFGLzfvai
         bSt2zk6ItfPP82e9IfgqRiHMA9BW3IYp9vtRWaIl180exc8Z8hQL9gAUR3c4PwBkBOO2
         q+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q/4hzu5ZLVp3mgIPesJPmq/IWbfe4flwA2HG1sCD0TQ=;
        b=BDC74CJSRvbs0hKMG/VIpZct/pi1ctyanHssE78YWMxANhIK2teOKvmMeCZo9FlWQy
         TeAEVChrGO/s6VhgP+GprLe2s8wd24ArE/0USPhS4XjATYIk7ozmUIATzfSsU9gqv1UE
         4E2IGdulFHFmC8IYZES+mNSYoFXNU4OVESq9b+clNmiYI4KAytyw4XuQES3+h8Oyy9g5
         U2bdgCADLxmCe4xg5x3HQhFKsBNQibCueHMb/XdORQXI+B9Db5+sLK9S0jC7LWV9E9te
         Vhh/mDrZ+mBBugZLbMZUlepVUSw/gYjztpZxAJxyUa34YDxhrHbX45HijS5DDBGNpZy9
         /c3g==
X-Gm-Message-State: APjAAAWaYWRJUrlgCk92WmhP5OIcZlcDhWkagjnG2CSAe6oZQvFqgxdT
        fnoFL3nu4iEZ3mcklmoaYhT0hRxa2FMpMXYuHRTB+TXv2p4gKA==
X-Google-Smtp-Source: APXvYqzw3j/oSC5Q9iYfqvGAp+HoFdUfIIMs+Btzd/EKLDObZYBH8mQUpoL/qVeAVC9OPWePoER5CA68wIGZsaWSqM0=
X-Received: by 2002:a81:5ec3:: with SMTP id s186mr47879009ywb.308.1558637392374;
 Thu, 23 May 2019 11:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190523174349.GA10939@cmpxchg.org> <20190523183713.GA14517@bombadil.infradead.org>
In-Reply-To: <20190523183713.GA14517@bombadil.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 May 2019 11:49:41 -0700
Message-ID: <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > I noticed that recent upstream kernels don't account the xarray nodes
> > of the page cache to the allocating cgroup, like we used to do for the
> > radix tree nodes.
> >
> > This results in broken isolation for cgrouped apps, allowing them to
> > escape their containment and harm other cgroups and the system with an
> > excessive build-up of nonresident information.
> >
> > It also breaks thrashing/refault detection because the page cache
> > lives in a different domain than the xarray nodes, and so the shadow
> > shrinker can reclaim nonresident information way too early when there
> > isn't much cache in the root cgroup.
> >
> > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > does, but the optimistic internal allocations have fixed gfp flags).
>
> Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> I don't really understand cgroups.

Does xarray cache allocated nodes, something like radix tree's:

static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };

For the cached one, no __GFP_ACCOUNT flag.

Also some users of xarray may not want __GFP_ACCOUNT. That's the
reason we had __GFP_ACCOUNT for page cache instead of hard coding it
in radix tree.

Shakeel
