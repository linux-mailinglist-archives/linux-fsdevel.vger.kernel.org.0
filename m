Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA16316BED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhBJQ77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhBJQ7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:59:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40EC061574;
        Wed, 10 Feb 2021 08:59:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id jj19so5463110ejc.4;
        Wed, 10 Feb 2021 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZixN6Q/4ReK9YtVCNtVo5cDo+F6iIEK6tabVtfOzxo=;
        b=Rq7xCOotKS9ZpLJt7mztI4zaEi7hNGUIkviW+Rh0IHqkEftTg4Ao0h6MELWhz+xcle
         E/IQHaPwkqKKu+ymFzsU/pg7WI73tsddPelKXby+JVgt6OqjmwceDddIBPMHgon1b03Q
         qHTO7RokQtGa7vNbp0aeyyzJxbXVgnajTj15dyvyECpv90PceOJQfRNPbbmejRzarwzE
         Psq8DugOhJXTH2BgccoDMJFjNiNE6oGWSUvxiwUdz//D8rjrttPMQvRT0ymwXslFOuNW
         qXJ+2wwE0WtTjTh0mJlvxBF6dd9HZ1bftTrQAWLbAAzuKmFoqoQhJvUZDiApiThkQyK2
         MexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZixN6Q/4ReK9YtVCNtVo5cDo+F6iIEK6tabVtfOzxo=;
        b=orRGJTqfiolbPzJtvPNrsp9CQDz1PuFrxuZgLh3tAKtzqk0jUlLfC+ku5oijIpJB10
         vBVl4TLvRCpwGsfnKEd0og9c0bwXzYwL834dqp2QfPNO/eScVBzo1OwaX7AkT4ePos8M
         yEXSiVlJTDU9eTGIVgN267kvbXW2G2mEwEdBpuRt3b7K6AboJVWPVqNIkMTpLVJUAW4r
         O4eSuOFwOLsIgewGuNW7FAa8Vn1Kih4RaBbD2MSpGe9IwisBKr8uwfkeWLTs8CSip8hc
         HaWRRT6kgymDCUNwVKsU47hnXey1CIl2L++yBhcHS8jpFwbhVZVdvaVZTOj1/CZXaJNJ
         96KQ==
X-Gm-Message-State: AOAM533PRZS/F6Hzx8EkyWz34nrAn96kkvOmYc29R+TP+x6vnd6A6Uu3
        nh9koHeqXluBhlKMPJd2czgsUY997ns9073tGoo=
X-Google-Smtp-Source: ABdhPJyOUgWmInD4qVcgQuWqw8PD0zsXXPLcq6zX4rspY74T4IQSbdnnewUZt7QWQDAqh4rzLc+HPrDLiAWQqIA/5yM=
X-Received: by 2002:a17:906:755:: with SMTP id z21mr3949721ejb.514.1612976343938;
 Wed, 10 Feb 2021 08:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-2-shy828301@gmail.com>
 <CALvZod5GW=zk0hq+_qqV1KGxz7MJ_RKctj6H=uS7bxHdhxOWrw@mail.gmail.com>
In-Reply-To: <CALvZod5GW=zk0hq+_qqV1KGxz7MJ_RKctj6H=uS7bxHdhxOWrw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 10 Feb 2021 08:58:52 -0800
Message-ID: <CAHbLzkqCPSh6LAepBrWm5f=21aM8f-cKsCC-Oq6iGiwP4LscbA@mail.gmail.com>
Subject: Re: [v7 PATCH 01/12] mm: vmscan: use nid from shrink_control for tracepoint
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 9, 2021 at 11:14 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Feb 9, 2021 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> > uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> > shrinker is not NUMA aware, so the traceing
>
> tracing

Fixed. Thanks.

>
> > log may show the shrink happens on one
> > node but end up on the other node.  It seems confusing.  And the following patch
> > will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> > the code.
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
