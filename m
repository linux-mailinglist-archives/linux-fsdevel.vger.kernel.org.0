Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5067114EBC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 11:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfLFKJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 05:09:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37623 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfLFKJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:09:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so7134300wru.4;
        Fri, 06 Dec 2019 02:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZgEefvOziF7z8mrF0WSJDLRpK1yoVeyxX5+8c1qtWd8=;
        b=ofbqXxLUpt+f4orqUBASv7mzvuuiytJi6rquais0s5d7bPXuqb2Cfgd5WmUscxyibP
         xIzRnO8mfb9okhAje29nO7euJjoi6Ghv7L78klNwWhwPsP1j84Y1gsH0V9fF1aE8C4qA
         eBm95VAaydWRyrcZD+KevSfV7ZlRno02uILQDguu9Q5DYW+/T3CCAABuoy7uxXwBPkqX
         dwfR1ZNzRkhfur40wSIhPUYWGXo0lZ9ya0cKdFlcZDKEJHWC7qqy9RIiVfdAuaAkLeOF
         +rOwEAuKZMJlFKiYpnK0JuOGbjsx1ZfuIUCJnkHdqBqOXG310ARvqVe4HAVe7KLkyDYM
         KfiQ==
X-Gm-Message-State: APjAAAXI2tmAzLc5dn53x2BZgSHGgukBHOE8qAQo3SHVqjjaeX5g1StV
        jR4D3tJtnp/m7T0Mn/705DQ=
X-Google-Smtp-Source: APXvYqwp/JAvBhEznJnvSk6geU/+ptgT24gTDjlJXdPPSVOp5WR/4oUSZ5jnN+uUQrMCeUwvJhcIiQ==
X-Received: by 2002:a5d:6901:: with SMTP id t1mr13926482wru.94.1575626942441;
        Fri, 06 Dec 2019 02:09:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c2sm15761600wrp.46.2019.12.06.02.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:09:01 -0800 (PST)
Date:   Fri, 6 Dec 2019 11:09:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: fix hanging shrinker management on long
 do_shrink_slab
Message-ID: <20191206100900.GM28317@dhcp22.suse.cz>
References: <20191129214541.3110-1-ptikhomirov@virtuozzo.com>
 <4e2d959a-0b0e-30aa-59b4-8e37728e9793@virtuozzo.com>
 <20191206020953.GS2695@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206020953.GS2695@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-12-19 13:09:53, Dave Chinner wrote:
> [please cc me on future shrinker infrastructure modifications]
> 
> On Mon, Dec 02, 2019 at 07:36:03PM +0300, Andrey Ryabinin wrote:
> > 
> > On 11/30/19 12:45 AM, Pavel Tikhomirov wrote:
> > > We have a problem that shrinker_rwsem can be held for a long time for
> > > read in shrink_slab, at the same time any process which is trying to
> > > manage shrinkers hangs.
> > > 
> > > The shrinker_rwsem is taken in shrink_slab while traversing shrinker_list.
> > > It tries to shrink something on nfs (hard) but nfs server is dead at
> > > these moment already and rpc will never succeed. Generally any shrinker
> > > can take significant time to do_shrink_slab, so it's a bad idea to hold
> > > the list lock here.
> 
> registering/unregistering a shrinker is not a performance critical
> task.

We have had a bug report from production system which stumbled over a
long [u]nmount which was stuck on a shrinker {un}register path waiting for
the lock. This wouldn't be a big deal most of the time but [u]mount were
part of the login session in this case. This was on an older
distribution kernel and e496612c5130 ("mm: do not stall register_shrinker()")
helped a bit but not really for shrinkers that take a lot of time.

> If a shrinker is blocking for a long time, then we need to
> work to fix the shrinker implementation because blocking is a much
> bigger problem than just register/unregister.

Absolutely agreed here.
-- 
Michal Hocko
SUSE Labs
