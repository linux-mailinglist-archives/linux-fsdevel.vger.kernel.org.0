Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFB2DB1DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 17:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgLOQsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 11:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgLOQsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:48:30 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C7C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:47:50 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id g20so28684792ejb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 08:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXHwqgEcm9tfwJrjyn+vC7PylGCKImG5xlD259/9c18=;
        b=QL0DddlNwFMBDUzOptIqzrfhXSZD3i3kQAVbC5zjH2I/YkJ340DPGvEB5EEqWsHIYG
         S5LSFc7kDnyLHNA35JfaHADa1QDcyGswOeXD8eLg/7h0uMIHBtWXn/ikCrxl5QaNVgZ4
         HmVaIQqLCYVuq5h2+FON371mMRzOzTxaRwz6w16tSn7psTgM4/p9vhEF1WvK9Pwv/Njq
         yMZN8HP7u9ucr8dnOy4Jc4Wgbqvye+7IUy5cfLghbPr4KTXKb+XjDqRr4EqYqxNGQmkw
         u2ZM941CLiIVs9q/4enY1dF5pg7BtdM0Vgzxr+HNcLye5LV/TY3Wy6e5xDHrM4rb2ho2
         aWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXHwqgEcm9tfwJrjyn+vC7PylGCKImG5xlD259/9c18=;
        b=Ya7GzSAS/Pm2sCUm6LFnoC08A5pEfFrTpU5FwGBLC6lmDvbl0oXPJ6RsR3wR7HQ5ig
         17vmgQ83WglCJ+GHDNoXID1/hnLxVejGyU7OKpuoVm6CVvwWl1Mhyepw3EBIj4dHylmr
         hyBy5nVWRPqC5J2FnADX7f7nFVoLqiONSX1e9r0FVMH/u2uP/3V4Q+N3nZpF8NcnL48b
         wKblJ1vS4tnv1M6hJTILCNg7HezRpv8sOeFI+1TgeJpqPH5ksDXwNd0UHhmAO5Bta0cz
         blFS9Vo8sFA31BnRLjqPi94RCqaehXd9CsGHYd3vja3YT7Yo5d8SFzjFA0jaaBW09Nbh
         36Bg==
X-Gm-Message-State: AOAM532f5/W5oitHnDF2/ZhDpVnGF+ErNd6cL2jbCmJzVJQxUkhJ3Ke2
        eumDgvJyleKTYgemaY+zZ2iQHg==
X-Google-Smtp-Source: ABdhPJwoaV5a3K6VC4rAmljALX9LaJUsm3aqRvmXecPudMp4PVCBbyKwpRo4TWGW8A+n9U2HVtEvZQ==
X-Received: by 2002:a17:906:254b:: with SMTP id j11mr28086895ejb.326.1608050868990;
        Tue, 15 Dec 2020 08:47:48 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id s9sm18639338edt.51.2020.12.15.08.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 08:47:48 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:45:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     Yang Shi <shy828301@gmail.com>, "guro@fb.com" <guro@fb.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees
 valid shrinker_maps for online memcg
Message-ID: <20201215164540.GB385334@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-4-shy828301@gmail.com>
 <20201215123802.GA379720@cmpxchg.org>
 <1874151608036985@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1874151608036985@mail.yandex.ru>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 03:58:06PM +0300, Kirill Tkhai wrote:
> 15.12.2020, 15:40, "Johannes Weiner" <hannes@cmpxchg.org>:
> > On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
> >>  The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
> >>  in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
> >>  memcg->nodeinfo[nid]->shrinker_maps != NULL. This may occur because of processor reordering
> >>  on !x86.
> >>
> >>  This seems like the below case:
> >>
> >>             CPU A CPU B
> >>  store shrinker_map load CSS_ONLINE
> >>  store CSS_ONLINE load shrinker_map
> >>
> >>  So the memory ordering could be guaranteed by smp_wmb()/smp_rmb() pair.
> >>
> >>  The memory barriers pair will guarantee the ordering between shrinker_deferred and CSS_ONLINE
> >>  for the following patches as well.
> >>
> >>  Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > As per previous feedback, please move the misplaced shrinker
> > allocation callback from .css_online to .css_alloc. This will get you
> > the necessary ordering guarantees from the cgroup core code.
> 
> 
> Can you read my emails from ktkhai@virtuozzo.com? I've already answered
> on this question here: https://lkml.org/lkml/2020/12/10/726
> 
> Check your spam folder, and add my address to allow-list if so.

It was indeed in my spam folder. Disregard what I wrote above.
