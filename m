Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E772F1E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbhAKTBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbhAKTBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:01:10 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975FC061794;
        Mon, 11 Jan 2021 11:00:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j16so922194edr.0;
        Mon, 11 Jan 2021 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzP+1DGQOIvMcrmW5euTCx4qruv4FZRB/uAKoISXx7g=;
        b=vYvjvw2VygIPnmh6It2+CmmoRmokSmmdOVcghJAay5P0gwOKgCtrJIRfxmNk2JQ9Gt
         Yp0EGdFJPRo/PUP/Tvb5Co7yP6dVVCNru/NvggkdIy5K54ABaJH9xQODCLmSHkFnFRIy
         ep+ZBEwOBxlwgelNEP5kkgO2CNeoE9ZK9v8Oa6dRWAv7JOM/RC+4tBCCA1UZiJig1v1c
         7j14pM6nHFGOWjiKadNnZvQpLqTEU7rmlkd2GSB6GAxQCnL6MbK/HH8V4K9Jvc68mdVQ
         ws2kbYHyusZvYf84yhPCtP56WXOvrGTi9ph1iWYcDNx5QmkaFOvQO6OVVLmgsoBmNXAd
         d33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzP+1DGQOIvMcrmW5euTCx4qruv4FZRB/uAKoISXx7g=;
        b=I4rf85gYB9URgHP9lY6Z/3I7TGotXWRVFMBt49O+HL1eKk6MagfI2NteBpL/k5rcIA
         l9A1R7lIYFQDP6co18Hn6bQ7aZ33RERmPqdnpTdVUV5mwHlwbOxXxVIyEWku9u+HV0d2
         09hklLi15OHbvMCagQNxTd0P0wS06WIs1tEsQTtxVk3e+PLIHZvr0T1o0aNwuZ3v9gn0
         HTbvgX2PY1oCrEyDo/WE56rMxpWWKt457wv86H8F3GqkcJzMJIQYgVx4wF0Nh7SsqfEL
         ufmc2+FLG0avsM3sLZUsJ4IrYxzJytNzBVryQc/5CR5DZTiXG7R8PCAjjM86d9BW1OCd
         1vNA==
X-Gm-Message-State: AOAM531F3ICtU/tIRRXGIYeyMo3LK2BLdAMwXVQpngiYGNIOAFEV2pMA
        /K2WwKIWXbm2utw73ZUPcUahh0OPo6Pa5BJF8/w=
X-Google-Smtp-Source: ABdhPJxstPPw4CO3o1D30g5iH8wIXuWOW04btKKyxK2E6Wtyijem6zZOJ+FxolNGIMsJ4KvkthSWqv5R7y1ou0a4L1Q=
X-Received: by 2002:a05:6402:c95:: with SMTP id cm21mr593253edb.294.1610391629218;
 Mon, 11 Jan 2021 11:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20210105225817.1036378-1-shy828301@gmail.com> <20210105225817.1036378-3-shy828301@gmail.com>
 <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
In-Reply-To: <20210107001351.GD1110904@carbon.dhcp.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 11:00:17 -0800
Message-ID: <CAHbLzkqnLKh7L5BWdSsoX5t-DjpOwYREwY5yBXgRUqAuubueQw@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 4:14 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jan 05, 2021 at 02:58:08PM -0800, Yang Shi wrote:
> > The shrinker map management is not really memcg specific, it's just allocation
>
> In the current form it doesn't look so, especially because each name
> has a memcg_ prefix and each function takes a memcg argument.
>
> It begs for some refactorings (Kirill suggested some) and renamings.

BTW, do you mean the suggestion about renaming memcg_shrinker_maps to
shrinker_maps? I just saw his email today since gmail filtered his
emails to SPAM :-(

>
> Thanks!
