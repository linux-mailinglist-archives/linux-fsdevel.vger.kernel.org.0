Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10D15984B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 19:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgBKSVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 13:21:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35421 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgBKSU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:20:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so8710727qtv.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 10:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6/Te+6lAVYFK89u5s4ITvONIuwvEzCRENBRMlel8AM=;
        b=aLYA6QD7r8l7BRmVYCdYFhLJ6+BTNSmfcsvcr1NKaO2FUg7e2sB0f5KZcSPi6p74nR
         6O933w7cbNN+FMz4YGCHH4AVN9pElo92zZlPlGuW0gSBq93BAPgEVr601eiAKnaapD/P
         GrnClfjV4wYOcuftH0Q5ekckpEe3ICyZVzmuNt9p75AlrUcLSUbK/YzbcYm34mH8OxqT
         SfQIEy8AuBFAXjI1EbnHUegO1y6lcC3eyPs+Uqaoqt4qUKVp8fvgx9LN7qxXVuWu884y
         xs/XxkT5R1DXkbm4qW8hogIMuJAsKO58D/GM+ADGdFgzSYgN2zco6ccBy5HHxO5WoFvi
         2Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6/Te+6lAVYFK89u5s4ITvONIuwvEzCRENBRMlel8AM=;
        b=MRh4gom3ukqrdPXmQBsDnQgQFap/ZJxme9vCtWsYwH8Twog2wUgYs24+r2Squ6B/BE
         7KvAlPey52sg8K8HJ+cODR4RbT0tk3xEahhc20ALY+uqyik5UFn11VfaKmfKsmGNSZqC
         HkmLtrkzxAkVvkQEkDw21Bd2TAlJK9lBDXwlhRGUfxBbFRry0ks8SzHoCwookZtIpDx/
         j8TWgB0zH5zTj6hULGodcH/nGS1AhF6ooLp+1KRHjHkRLce+Zzbk8xnz3sNBrc2dhTDK
         z8M9EbfqXqeSXpet+zl7xJG7wuWlvpfr0E8LU/TRgSNejychCHmSQDxNZmOY0MOYr+X8
         Sg/Q==
X-Gm-Message-State: APjAAAVO1X4NqSxkxjYGoq1wOKbXj/kNwxqYcaT/kWHJc0tkUs2ySlnv
        GKrST6eV7NamBDBOvNxXrNsPRDk+P1c=
X-Google-Smtp-Source: APXvYqwDVs8B12ktsqqe14aSoG5G5O9rjJ6O2GFDhj+2bdU0bqJzMwN1LLweA+J2YzGHbm2yyex9eQ==
X-Received: by 2002:ac8:4410:: with SMTP id j16mr3712001qtn.261.1581445256183;
        Tue, 11 Feb 2020 10:20:56 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:3189])
        by smtp.gmail.com with ESMTPSA id r37sm2562886qtj.44.2020.02.11.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:20:55 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:20:54 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200211182054.GA178155@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211175507.178100-1-hannes@cmpxchg.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:55:07PM -0500, Johannes Weiner wrote:
> However, this change had to be reverted in 69056ee6a8a3 ("Revert "mm:
> don't reclaim inodes with many attached pages"") because it caused
> severe reclaim performance problems: Inodes that sit on the shrinker
> LRU are attracting reclaim pressure away from the page cache and
> toward the VFS. If we then permanently exempt sizable portions of this
> pool from actually getting reclaimed when looked at, this pressure
> accumulates as deferred shrinker work (a mechanism for *temporarily*
> unreclaimable objects) until it causes mayhem in the VFS cache pools.
> 
> In the bug quoted in 69056ee6a8a3 in particular, the excessive
> pressure drove the XFS shrinker into dirty objects, where it caused
> synchronous, IO-bound stalls, even as there was plenty of clean page
> cache that should have been reclaimed instead.

A note on testing: the patch behaves much better on my machine and the
inode shrinker doesn't drop hot page cache anymore, without noticable
downsides so far.

However, I tried to reproduce the xfs case that caused the
69056ee6a8a3 revert and haven't managed to do so yet on 5.5 plus the
reverted patch. I cannot provoke higher inode sync stalls in the xfs
shrinker regardless of shrinker strategy. Maybe something else changed
since 4.19 and it's less of a concern now.

Nonetheless, I'm interested in opinions on the premise of this
patch. And Yafang is working on his memcg-specific fix for this issue,
so I wanted to put this proposal on the table sooner than later.

Thanks
