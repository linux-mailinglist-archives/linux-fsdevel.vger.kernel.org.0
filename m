Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B54743A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 14:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhLNNir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 08:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbhLNNiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:38:46 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F33C061748
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 05:38:45 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a2so18282420qtx.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Dec 2021 05:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYw3dTNxx1w6/rYOsPCI3bE5Vdi4GI8AS7An95Gx17o=;
        b=tUe3gF9yl7uvFOGJXnZDGunLrwNeHUsuozlge/NZ0esl2wmx+9OuT9twoBCrogJXHR
         U+wazLt8k85qXcdVdlEr2QiWsHWjffFixl9JczbvlcYNtmeYAEmWFswwvrf2w87ZZrvq
         WrBqfJpvjakwAHIhRNOhg18W8LuPvroIdKQoOQRnU++rANlMZ6I+El/IZfP6vNfWdiK8
         G8BcYPbMdTezYk0AYApyD6ptaX+f18/ftVFujPLH6n561NNxDfTrp22U3edtVm0zJLLY
         M4kfHx2yE/xcYoqfmDuL+bzlIOAfap6ttSGzkp6IZ6XE2t7BnJ//QLefREQAx5CEcwRp
         97+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYw3dTNxx1w6/rYOsPCI3bE5Vdi4GI8AS7An95Gx17o=;
        b=xUHDY9gW4jL10lL6T/9tf+eC3jW+qj6lNn9WeNVk3Ket4LepnjnrnFjs4EIjGhn590
         zMsja2WrSOvSXydLVX3yS9DV0HMwIfAD8byV6iZsPWhUbXB/jIUuoX0XJY22A2EFjDkS
         znV+/zHpSLX1gUjBnlMCQsP1tghegFd47kBZfdDK5nrC99sEJoL04uetcMMM4JajBE+g
         HLvXTbFSJEdfuXwMVoHmvszafERddVnfXzUDfubIiEi0oMcAztThY1yyOtkhBYeVme31
         c2G/KE1hlm+pk5HOcf5QV7n5Is3HgiBKwfRSeWnY3d3lv3tbAxYXtD0GTI+F/1hCjgws
         jg4w==
X-Gm-Message-State: AOAM533IMCfl4VRv9cOQp6OM5qhyrhbpibRpfBx3zYvGiehjS7fCuUw2
        ryHFh3UUz4LjFPvIrCsKbyZiog==
X-Google-Smtp-Source: ABdhPJwe1RWdhQKAzec7IHklUmwTSxvNcuVGOWbGkmTG1+fmiDw0JM0mWzPgit/4twx8SXN+ZSxh3Q==
X-Received: by 2002:ac8:5ccd:: with SMTP id s13mr5995548qta.510.1639489125026;
        Tue, 14 Dec 2021 05:38:45 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e1e4])
        by smtp.gmail.com with ESMTPSA id ay42sm7612729qkb.40.2021.12.14.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 05:38:44 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:38:39 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     willy@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, guro@fb.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
        david@fromorbit.com, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, jaegeuk@kernel.org, chao@kernel.org,
        kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, zhengqi.arch@bytedance.com,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v4 01/17] mm: list_lru: optimize memory consumption of
 arrays of per cgroup lists
Message-ID: <YbieX3WCUt7hdZlW@cmpxchg.org>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213165342.74704-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 12:53:26AM +0800, Muchun Song wrote:
> The list_lru uses an array (list_lru_memcg->lru) to store pointers
> which point to the list_lru_one. And the array is per memcg per node.
> Therefore, the size of the arrays will be 10K * number_of_node * 8 (
> a pointer size on 64 bits system) when we run 10k containers in the
> system. The memory consumption of the arrays becomes significant. The
> more numa node, the more memory it consumes.

The complexity for the lists themselves is still nrmemcgs * nrnodes
right? But the rcu_head goes from that to nrmemcgs.

> I have done a simple test, which creates 10K memcg and mount point
> each in a two-node system. The memory consumption of the list_lru
> will be 24464MB. After converting the array from per memcg per node
> to per memcg, the memory consumption is going to be 21957MB. It is
> reduces by 2.5GB. In our AMD servers, there are 8 numa nodes in
> those system, the memory consumption could be more significant.

The code looks good to me, but it would be useful to include a
high-level overview of the new scheme, explain that the savings come
from the rcu heads, that it simplifies the alloc/dealloc path etc.

With that,

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
