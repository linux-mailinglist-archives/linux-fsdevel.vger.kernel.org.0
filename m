Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06D2DB538
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 21:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbgLOUgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 15:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgLOUdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:33:46 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9663C06179C;
        Tue, 15 Dec 2020 12:33:05 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id j16so57922edr.0;
        Tue, 15 Dec 2020 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnIdZIbHofYFRuQmYpMAr+KqMcOINorVtwHcWuXO3CQ=;
        b=vDDe57R6klgFWHuh2HY3lU9Hse+4YOXW6G9FHSpk+R5Lwu/ePxlIzV1os6OnNraZat
         SHKaGNazTQ5cC/mxyhdKG4wReYKGicHSCkJm88LAtkC48osuGOT0i3+FWdnJaB47leHf
         iIou1yz7C33S5szb4x/1A93NvladUYWe8TP90XdAEjt/JP3inQ1f42Mj7UcTjXgqE6Ys
         FB3npC0z5IlASmY3btmSIe2+wY36PWxNHyPbLT8qaAf0nbaFUsPPR+XGLGM5cZBCj2go
         udW7rKICgaS0Ev69TvKLtrEporbt7P+6bRV6nbJjZI9p7UvPnonjSZhENKRZEPBvEzGM
         /ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnIdZIbHofYFRuQmYpMAr+KqMcOINorVtwHcWuXO3CQ=;
        b=esoodBaVRRplqM6imea1OODvuyupweNfGJkhmiEJ4YI6CBhzu4HyvBpDhzpVDMPDbo
         SEyCMjWhUF8FrL36Q5bTByOMoLFcB0N+q1ktIEXFvK+hiXT5xTZcpMKULZffl5VEPDSo
         C6thwjTyBnsJ/qmawoe4dExOjYO4E7pYZL78KceYkAUiEwboCA8WpXY5OZRObsGHMtH3
         Ly0l/5wTOPGnq5DGExSItFSnDGrvBDtAxPojgl8M3asPbumazjOC36mN2w/DAcntAHiu
         0EeuWC7GbQ8gPZPXQy4EqxyPlN36G7Iqv5RcB8R8Ye9HQ5H+knoRcafS3zaem2AbYqhE
         SZlQ==
X-Gm-Message-State: AOAM530pCkbsmHKsZD1IQ3Hm6N8zwP6v6ql3PN8E42aL91iAfvNfAjib
        qchd4nKoqKTfuTlg1DDN/p1y3z2Sw7ceq8W6+ss=
X-Google-Smtp-Source: ABdhPJzE/1t6NIjK7mvndb9OLxuvHdPZBWjgVPmyEBbMEyqiMi0B4DCaqEcPB8RGlchQ26lbTIqTqt55O1D6B3ysHWY=
X-Received: by 2002:a05:6402:c95:: with SMTP id cm21mr31133119edb.294.1608064384485;
 Tue, 15 Dec 2020 12:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20201214223722.232537-1-shy828301@gmail.com> <20201214223722.232537-3-shy828301@gmail.com>
 <20201215140754.GD379720@cmpxchg.org>
In-Reply-To: <20201215140754.GD379720@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Dec 2020 12:32:52 -0800
Message-ID: <CAHbLzkpVk3uHO+g=iQLavRJ1c96FuaKTKVz0pUUHSk1L2rJcfQ@mail.gmail.com>
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 6:10 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > exclusively, the read side can be protected by holding read lock, so it sounds
> > superfluous to have a dedicated mutex.  This should not exacerbate the contention
> > to shrinker_rwsem since just one read side critical section is added.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks Yang, this is a step in the right direction. It would still be
> nice to also drop memcg_shrinker_map_size and (trivially) derive that
> value from shrinker_nr_max where necessary. It is duplicate state.

Thanks! I will take a further look at it.
