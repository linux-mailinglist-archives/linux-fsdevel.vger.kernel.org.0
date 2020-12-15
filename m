Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5022DADB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgLONHT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:07:19 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:43841 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726811AbgLONHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:07:10 -0500
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 08:07:08 EST
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 8CFF660612;
        Tue, 15 Dec 2020 15:58:07 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id OcKYYexCGh-w6IWopKl;
        Tue, 15 Dec 2020 15:58:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1608037086;
        bh=8mB7d8IwTKcg20kv8S+ADbckzXnrxLNOYv35fykpx+E=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=CP1EHMe9CaMM27YRVKyKhDzygETPxbGt99x1ne+emd9NJVmVpP76W1ke+d6szxK+9
         I4ZAuo/WD34hLysHOug04qr2j2pIJVLsqMnqOSooar2B8UZJ9D93OzZ8RQK4pVXFfr
         5Ms0lDMBQu8OeKdBVuzVec8fvSvK0HE1q58pJWbc=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by vla5-5336eea6ea62.qloud-c.yandex.net with HTTP;
        Tue, 15 Dec 2020 15:58:06 +0300
From:   Kirill Tkhai <tkhai@ya.ru>
Envelope-From: tkhai@yandex.ru
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     "guro@fb.com" <guro@fb.com>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20201215123802.GA379720@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
         <20201214223722.232537-4-shy828301@gmail.com> <20201215123802.GA379720@cmpxchg.org>
Subject: Re: [v2 PATCH 3/9] mm: vmscan: guarantee shrinker_slab_memcg() sees valid shrinker_maps for online memcg
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 15 Dec 2020 15:58:06 +0300
Message-Id: <1874151608036985@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

15.12.2020, 15:40, "Johannes Weiner" <hannes@cmpxchg.org>:
> On Mon, Dec 14, 2020 at 02:37:16PM -0800, Yang Shi wrote:
>>  The shrink_slab_memcg() races with mem_cgroup_css_online(). A visibility of CSS_ONLINE flag
>>  in shrink_slab_memcg()->mem_cgroup_online() does not guarantee that we will see
>>  memcg->nodeinfo[nid]->shrinker_maps != NULL. This may occur because of processor reordering
>>  on !x86.
>>
>>  This seems like the below case:
>>
>>             CPU A CPU B
>>  store shrinker_map load CSS_ONLINE
>>  store CSS_ONLINE load shrinker_map
>>
>>  So the memory ordering could be guaranteed by smp_wmb()/smp_rmb() pair.
>>
>>  The memory barriers pair will guarantee the ordering between shrinker_deferred and CSS_ONLINE
>>  for the following patches as well.
>>
>>  Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> As per previous feedback, please move the misplaced shrinker
> allocation callback from .css_online to .css_alloc. This will get you
> the necessary ordering guarantees from the cgroup core code.


Can you read my emails from ktkhai@virtuozzo.com? I've already answered
on this question here: https://lkml.org/lkml/2020/12/10/726

Check your spam folder, and add my address to allow-list if so.
