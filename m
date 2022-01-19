Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3249375E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbiASJdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 04:33:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58136 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiASJdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:33:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 126B21F38B;
        Wed, 19 Jan 2022 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642584793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sBwHHJ1ePgsQCKzWB+AeBOf9B49vrtvnggHlWqo57lQ=;
        b=OhjQ5S+3jTKJtj13rH9+qcQS7K/pNbNNrkUDRiTRiKXztA2+TX7pFRQuzZnM5Qo6ll+iJv
        Fxz10ktEKFl55pu8bOYGyyKDSWT5W4HQikdMgrCfIhGaMnwdqU5JM9Bt6jpCfoB37JNh2x
        +Yinoc8i+oeJm9NOrEgqEyVgEYGukcM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BCD4C13E11;
        Wed, 19 Jan 2022 09:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xr98Ldja52FOKAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 19 Jan 2022 09:33:12 +0000
Date:   Wed, 19 Jan 2022 10:33:11 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v5 10/16] mm: list_lru: allocate list_lru_one only when
 needed
Message-ID: <20220119093311.GD15686@blackbody.suse.cz>
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-11-songmuchun@bytedance.com>
 <20220106110051.GA470@blackbody.suse.cz>
 <CAMZfGtXZA+rLMUw5yLSW=eUncT0BjH++Dpi1EzKwXvV9zwqF1w@mail.gmail.com>
 <20220113133213.GA28468@blackbody.suse.cz>
 <CAMZfGtWJeov9XD_MEkDJwTK5b73OKPYxJBQi=D5-NSyNSSKLCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWJeov9XD_MEkDJwTK5b73OKPYxJBQi=D5-NSyNSSKLCw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:05:44PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> I have thought about this. It's a little different to rely on objcg
> reparenting since the user can get memcg from objcg and
> then does not realize the memcg has reparented.

When you pointed that out, I'm now also wondering how
memcg_list_lru_alloc() would be synchronized against
reparenting/renumbering of kmemcg_ids. What I suspect is that newly
allocated mlru may be stored into the xarray with a stale kmemcg_id.

> Maybe holding css_set_lock can do that. I do not think this
> is a good choice.

I agree, it doesn't sound well.

> Do you have any thoughts about this?

Thoughts / questions of what I don't undestand well:
- Why do you allocate mlrus for all ancestors in memcg_list_lru_alloc()?
  - It'd be sufficient to allocate just for the current memcg.
  - Possibly allocate ancestors upon reparenting (to simplify the
    allocation from slab_pre_alloc_hook itself).
    
- What is the per-kmemcg_id lookup good for?
  - I observe most calls of list_lru_from_memcg_idx() come from callers
    that know memcg (or even objcg).
  - The non-specific use case seems list_lru_walk_node() working with
    per-node and not per-memcg projection.
    - Consequently that is only used over all nodes anyway
      (list_lru_walk().
  - The idea behind this question is -- attach the list_lrus to
    obj_cgroup (and decomission the kmemcg_id completely).
    (Not necessarily part of this series but independent approach.)

Thanks,
Michal
