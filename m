Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4462F1FB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbhAKTn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbhAKTn4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:43:56 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B1FC061794;
        Mon, 11 Jan 2021 11:43:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jx16so21556ejb.10;
        Mon, 11 Jan 2021 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heazb9k/m8/zIdtN3jRoAAnqyK1a1wK3ts+R6742L6M=;
        b=OUQ39xFQqtOehkimmfAf739cawBRIfUXq7buq8L9pTI+oTRJ3bvIXwHVcWE6jhQQjo
         XurM1fh92irZV6l+GGdJL9SBg1OgBxukzfs0olW8S9FIvE1Kfv8i32Yh9J0Dvx5Bj//E
         yN3ZmFAL92lFx4JciAQPbuQv5Rk79nG1RF8MDWIK80DMY8C6moQghyBcwOsszppodCVB
         6TCLYY5/tHEvrxUEjBTWVRcxdcqH3UmGrYpKm17tZlq+ho8+RRbWffnTn066q+vYrNab
         roHQf8XBbRSxDHgBWRexLFM//N0oOmsaEBMEIy48QTokon4+JtzLtt1sgWVgNcFV5VsR
         Q1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heazb9k/m8/zIdtN3jRoAAnqyK1a1wK3ts+R6742L6M=;
        b=PmeWmhYcJaiRQfhQb8a9TyWrPdMEkGL4BRSxEqu2xoNIiwTHUZKzoD0MTvGAu8Aj4E
         Hh7VNjOoloT8IO1yE8+bT+lQAsho5X0Lor6HwaINzT1azvgigbaRgE2kZ1nHvOQKdVny
         l/vgZDTzGBDCu6yQZcYEs+HB42Qq2DgZIpl+RtTVRkqBiP5aDcU6xJgM3pEm6MitnpKP
         LJzD1TX/q4q8Gt8sOTaJXhdCzsdcR9qZ1NaEiTUtEfjX9kWaE+ukf8T2+oiBaf3oxZ7b
         UgXgicfAZ+73ym2ZKyMuS7N5JVB19h2EouEF8CXcgiZz8+L7lja3nx1shZpzLeAQopuH
         5a5A==
X-Gm-Message-State: AOAM5313ModPfqbS33Y0JUHTsIw7H4i9zeKtF4dU/klJyQuL5XCULfdT
        ViQMpkJwZ2OVAydF9N5pcwAZQ0Sc3x22ZmjQa0w=
X-Google-Smtp-Source: ABdhPJxU1h3Fa4qWWsvhta1+jAtDt3hDvEy4bC1whizOT51BBn8be0SpuiWBBHYcXoccZ+wa/cKStF3Sn8sOozF3VDY=
X-Received: by 2002:a17:907:20a4:: with SMTP id pw4mr677910ejb.499.1610394195084;
 Mon, 11 Jan 2021 11:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-3-shy828301@gmail.com>
 <20210107001351.GD1110904@carbon.dhcp.thefacebook.com> <CAHbLzkqnLKh7L5BWdSsoX5t-DjpOwYREwY5yBXgRUqAuubueQw@mail.gmail.com>
 <20210111193740.GB1388856@carbon.dhcp.thefacebook.com>
In-Reply-To: <20210111193740.GB1388856@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 11:43:03 -0800
Message-ID: <CAHbLzkoYhB1fPyTwBtNqyppbypWuihFWMPAwNVjX0Yk_t2EUGg@mail.gmail.com>
Subject: Re: [v3 PATCH 02/11] mm: vmscan: consolidate shrinker_maps handling code
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:37 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Jan 11, 2021 at 11:00:17AM -0800, Yang Shi wrote:
> > On Wed, Jan 6, 2021 at 4:14 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Jan 05, 2021 at 02:58:08PM -0800, Yang Shi wrote:
> > > > The shrinker map management is not really memcg specific, it's just allocation
> > >
> > > In the current form it doesn't look so, especially because each name
> > > has a memcg_ prefix and each function takes a memcg argument.
> > >
> > > It begs for some refactorings (Kirill suggested some) and renamings.
> >
> > BTW, do you mean the suggestion about renaming memcg_shrinker_maps to
> > shrinker_maps? I just saw his email today since gmail filtered his
> > emails to SPAM :-(
>
> Yes.

Thanks for confirming, will do it in v4.
