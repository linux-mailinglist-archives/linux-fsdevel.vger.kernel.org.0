Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1E25F9DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgIGLty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgIGLrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:47:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C2C061575
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2020 04:47:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so12465281edz.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2020 04:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=395Y0lUxtoxk+N6Xwo36+dBOIhVjSE/2+oZvPClU7KM=;
        b=cuAJnS9cKwag10JrR5XWKLTSDpsVij2RIxygdpxgcJAAdzqC0pGMP0broEdFrjuV2u
         YK1YpzjfS7JWBVBZPRmTUcfnAukLTXmsLJ2XSzMOmdbEBvGaIW/6SMoesJ2yxCpA/WG2
         m8QnLvvHNNu3zgtJUbsMfzQakaNE4sxXw5yG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=395Y0lUxtoxk+N6Xwo36+dBOIhVjSE/2+oZvPClU7KM=;
        b=LXar6Ih+h6TKH+xGoi/F+dEGLO1XKLIHHYM9D+/NdwF9jrxEvG5cFnYCiKC/Rx6LyP
         OMrpRwmVlRKRQyGtOksAZ7AHvEeCAdX8B93UKzKgFHserGginm8W8i4RJ8mqUhXQgnSq
         nsMRNnjv4MCChFWqOIccwk5M8aYnMjEJou94lsZNOpadIm+f4vrUscd46qST16WcC3hj
         w94p/x12alyxA4IZltgt7QwkZixvodsXhFJDVQJ12MszYKGLtrfKYeSIxre57rV7bnHf
         iSzU2rZ4J48OIV7cOzKCVvLfZcSh6R25yp0T4DaNlEgA/7WYOLJfie3E6l8HecTb7kqm
         Qzuw==
X-Gm-Message-State: AOAM531Cf2ttt+Hqt24wrHzJ+xDZPODUtBsnH5X82GX0+9liP0z6rJHB
        25JOJ+P9wUGpYumCDQiyrOGXwg==
X-Google-Smtp-Source: ABdhPJyILtFsw8r3H1RpyzxLgjhS4fpPrmJqOehWQUoj7NYN8ViFHh3BGjy7PTSONASUxNPG0HBqNg==
X-Received: by 2002:a05:6402:1151:: with SMTP id g17mr21705446edw.227.1599479266759;
        Mon, 07 Sep 2020 04:47:46 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:80b])
        by smtp.gmail.com with ESMTPSA id q14sm14733379edv.54.2020.09.07.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 04:47:45 -0700 (PDT)
Date:   Mon, 7 Sep 2020 12:47:45 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200907114745.GA1076657@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
 <20200818100516.GO28270@dhcp22.suse.cz>
 <20200818101844.GO2674@hirez.programming.kicks-ass.net>
 <20200818134900.GA829964@cmpxchg.org>
 <20200821193716.GU3982@worktop.programming.kicks-ass.net>
 <20200824165850.GA932571@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200824165850.GA932571@cmpxchg.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Johannes Weiner writes:
>That all being said, the semantics of the new 'high' limit in cgroup2
>have allowed us to move reclaim/limit enforcement out of the
>allocation context and into the userspace return path.
>
>See the call to mem_cgroup_handle_over_high() from
>tracehook_notify_resume(), and the comments in try_charge() around
>set_notify_resume().
>
>This already solves the free->alloc ordering problem by allowing the
>allocation to exceed the limit temporarily until at least all locks
>are dropped, we know we can sleep etc., before performing enforcement.
>
>That means we may not need the timed sleeps anymore for that purpose,
>and could bring back directed waits for freeing-events again.
>
>What do you think? Any hazards around indefinite sleeps in that resume
>path? It's called before __rseq_handle_notify_resume and the
>arch-specific resume callback (which appears to be a no-op currently).
>
>Chris, Michal, what are your thoughts? It would certainly be simpler
>conceptually on the memcg side.

I'm not against that, although I personally don't feel very strongly about it 
either way, since the current behaviour clearly works in practice.
