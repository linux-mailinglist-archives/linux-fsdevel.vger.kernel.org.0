Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF444E2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 08:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhKLHyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 02:54:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34538 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbhKLHyu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:54:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A1C51FDC1;
        Fri, 12 Nov 2021 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636703518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4eMX7TMvJ0ihc860r22e2HZ4Cwsqms8Yzpn9g90MXM8=;
        b=hSJz3FWqJKqbxal213cJIhQ2EpexvzZhCOOoO2UAULCqwvPn+HVt0mloZUoDAM3ZtXTVkh
        FVH3ALfn1CD/pqHOVUP9Uj5Otd1xMm4/dWQWWq1tZ3kFLVJoyiOQ4DLpZ8XX5r+ZWClKdz
        PaHW9BZI7aywr1kzXIRDCXK4+ZX3fSQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFAD5A3B8A;
        Fri, 12 Nov 2021 07:51:57 +0000 (UTC)
Date:   Fri, 12 Nov 2021 08:51:56 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
Message-ID: <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111234203.1824138-3-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 11-11-21 15:42:01, Mina Almasry wrote:
> On remote ooms (OOMs due to remote charging), the oom-killer will attempt
> to find a task to kill in the memcg under oom, if the oom-killer
> is unable to find one, the oom-killer should simply return ENOMEM to the
> allocating process.

This really begs for some justification.

> If we're in pagefault path and we're unable to return ENOMEM to the
> allocating process, we instead kill the allocating process.

Why do you handle those differently?

> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> CC: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: riel@surriel.com
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
-- 
Michal Hocko
SUSE Labs
