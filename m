Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264C62DAE61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 14:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgLON4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgLON4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:56:38 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D9C0617A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 05:55:57 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id p22so21057973edu.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Dec 2020 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=28yftlhd5Mm7TNEoJztkfUFW7tsicxqlvZ58WZP092o=;
        b=q8hRvO8FBlmEVVvGDqqdPymPT2VZCrOP6sdFOK85a8fzhGrEA+VPk8dRAl38JbXfAb
         pENLRXdI7wPSCGKgFbDvGVqnbbRQ1YJqOZGobDdUJevwJgsecLQ0xYQyU1R7BaKyJOAm
         aU8bjNtF5rSo+WjA633Q3G4UZXiJdP0mgMratYIzEVUbz4Yd3ALFdCr3qnjEbsQ7KGLI
         gl3imdIUYwv7AEAmQMNJsX0f1SFP7S+DAL7TLK0FN0FaOdsxR875O0AgQ0WZrUXnMyu3
         DYN8kHD7MtuD2z7RUKB5HUtduTjGtX3FHHdlziaVIJaOq47v8MTpI4KmaMgWA4Y5/SWe
         RpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28yftlhd5Mm7TNEoJztkfUFW7tsicxqlvZ58WZP092o=;
        b=QNb+mx7qq/koOZin90bTnM36cwlNPJWewm6ChX6xM1EHExaWLUgSWtiKzwJUuB5wqK
         9ixcNArfXq623+H38holtz+e/gY6TMU/Dt1n8XqZOB8uVpgCNcyt/mL60a3o9B9jlLRo
         930P2hCE+qvoPg8OTo9r6LC3es0EwtZ774+gnIG+F17ntYD/1MlqMiJO7y8JUObq8LR5
         WVI/2736Efkqpy1YEUbw4flNbzlT4RkgqhnDPmhKMi/5qHQ3qSCLjC455LHm15OUASTg
         qmBmBNYNFwMYi0ccFkv+uMcUtffVts/N7hUGkLyVFX+UrZCxTXgp0pd9kfcId62IS6fh
         tJOg==
X-Gm-Message-State: AOAM531Mb4WF+LfhjJ/hn64UFryP9tR8TTbmt0T5baqgXPjWFNuTCKAd
        VKXgJlJLwcWVjJtP3YhdOnDY2Q==
X-Google-Smtp-Source: ABdhPJyuNO0PF0kKJURjwb9+E/B+40e84QEC1lprj6xFNjGqXis995/63N/Dg86zVL7idzJQzFY5Fw==
X-Received: by 2002:a05:6402:2066:: with SMTP id bd6mr29548060edb.211.1608040556150;
        Tue, 15 Dec 2020 05:55:56 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:d6dd])
        by smtp.gmail.com with ESMTPSA id b21sm18147895edr.53.2020.12.15.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 05:55:55 -0800 (PST)
Date:   Tue, 15 Dec 2020 14:53:48 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Yang Shi <shy828301@gmail.com>, guro@fb.com, ktkhai@virtuozzo.com,
        shakeelb@google.com, mhocko@suse.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/9] mm: memcontrol: use shrinker_rwsem to protect
 shrinker_maps allocation
Message-ID: <20201215135348.GC379720@cmpxchg.org>
References: <20201214223722.232537-1-shy828301@gmail.com>
 <20201214223722.232537-3-shy828301@gmail.com>
 <20201215020957.GK3913616@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215020957.GK3913616@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 01:09:57PM +1100, Dave Chinner wrote:
> On Mon, Dec 14, 2020 at 02:37:15PM -0800, Yang Shi wrote:
> > Since memcg_shrinker_map_size just can be changd under holding shrinker_rwsem
> > exclusively, the read side can be protected by holding read lock, so it sounds
> > superfluous to have a dedicated mutex.
> 
> I'm not sure this is a good idea. This couples the shrinker
> infrastructure to internal details of how cgroups are initialised
> and managed. Sure, certain operations might be done in certain
> shrinker lock contexts, but that doesn't mean we should share global
> locks across otherwise independent subsystems....

They're not independent subsystems. Most of the memory controller is
an extension of core VM operations that is fairly difficult to
understand outside the context of those operations. Then there are a
limited number of entry points from the cgroup interface. We used to
have our own locks for core VM structures (private page lock e.g.) to
coordinate VM and cgroup, and that was mostly unintelligble.

We have since established that those two components coordinate with
native VM locking and lifetime management. If you need to lock the
page, you lock the page - instead of having all VM paths that already
hold the page lock acquire a nested lock to exclude one cgroup path.

In this case, we have auxiliary shrinker data, subject to shrinker
lifetime and exclusion rules. It's much easier to understand that
cgroup creation needs a stable shrinker list (shrinker_rwsem) to
manage this data, than having an aliased lock that is private to the
memcg callbacks and obscures this real interdependency.
