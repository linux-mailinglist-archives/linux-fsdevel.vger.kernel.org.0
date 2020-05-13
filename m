Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2214E1D13B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 15:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgEMNA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 09:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgEMNAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 09:00:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE64C061A0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 06:00:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so17123830qke.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+cW70ChImxuqV2RBsl6w7NV4YFDYwLH2CWpZPYn8bwc=;
        b=ueBZ7XbbZpEcGa6ncc1N99qMbGVjWNDNqkGunZjHci2h023ddhN8dJF1xJmuaONvN+
         9TslYt/mBrZfFRMUkZb5agEyvyh5UhClFCX8DxTW9eEizKKEOfRycRQMTr4rMIjDot/o
         2S1/8fFrfFxOfEbPhC5ryqLCeT+ahFmll6lbagvvUuCl/dCAQvux7Imp3edG0zObITXY
         FQdfjaibsbo0zy2Y98ouPjVoqSnHj+N+OSzDvhSoWupA8W4KCX+NwYzCuc9mnmYL8jEO
         OEnsjfGAuj6B/HOEA/3Mo835BKZDDu9hEyQNf++9enhJKbUQWDpFnZcS+rTSXyWFFyXA
         5VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+cW70ChImxuqV2RBsl6w7NV4YFDYwLH2CWpZPYn8bwc=;
        b=j+phKuqQMsASoZD72sqH0KZjcXNgHbu23Y6fXakL0FTUJ8Hz6UcAhUwUxPl2T9y0fd
         1Nc/2xjPcR+2mwy7wcJlqyf8BbDT+PUm7DNQQW/RY+vEgnJKGicPsM5gb0jlPJ/Hs1xL
         Cl5Iqh/RwXow/VMzkJKOsxnxEVNE7IQn9jpFqS3YFjm1CIzCMvkHNmUxoE5O1vYn0RTC
         aF9XmyaL5W0djpIdryGIUIuWFPvqduYkfNsR6i+2agkySwRMe/iUFxfZZhzpH85K5G88
         YzV4HrKnUGf2bkvdjm/yFr58ZtmgcHxx5W0ZpSCggmL70UmONvYw/Yymu9R8V0GIqDzK
         3+UQ==
X-Gm-Message-State: AGi0PuY7t3mI9ANE+hO7MoqhICqE6OlU1cNAecITqsNC2TQc8jNU9De0
        KxPvXAnmPESVKuenBGkODE/+xA==
X-Google-Smtp-Source: APiQypKwvGZuJBxRqVUHNYuvoj8QpY7uTR3OAQ4b8juIRpGo91ZqMW8ow8DkU+0C6ZNMsRFoLm9hcg==
X-Received: by 2002:a37:84b:: with SMTP id 72mr15538452qki.252.1589374821767;
        Wed, 13 May 2020 06:00:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id t202sm13798497qke.97.2020.05.13.06.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:00:20 -0700 (PDT)
Date:   Wed, 13 May 2020 09:00:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200513130002.GC488426@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <20200512212936.GA450429@cmpxchg.org>
 <CALOAHbAZ0eUmrBGt=J0cJZzPmDtPKpfMK0jrUNa0Z_-JfDLoXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAZ0eUmrBGt=J0cJZzPmDtPKpfMK0jrUNa0Z_-JfDLoXA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 09:32:58AM +0800, Yafang Shao wrote:
> On Wed, May 13, 2020 at 5:29 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Feb 11, 2020 at 12:55:07PM -0500, Johannes Weiner wrote:
> > > The VFS inode shrinker is currently allowed to reclaim inodes with
> > > populated page cache. As a result it can drop gigabytes of hot and
> > > active page cache on the floor without consulting the VM (recorded as
> > > "inodesteal" events in /proc/vmstat).
> >
> > I'm sending a rebased version of this patch.
> >
> > We've been running with this change in the Facebook fleet since
> > February with no ill side effects observed.
> >
> > However, I just spent several hours chasing a mysterious reclaim
> > problem that turned out to be this bug again on an unpatched system.
> >
> > In the scenario I was debugging, the problem wasn't that we were
> > losing cache, but that we were losing the non-resident information for
> > previously evicted cache.
> >
> > I understood the file set enough to know it was thrashing like crazy,
> > but it didn't register as refaults to the kernel. Without detecting
> > the refaults, reclaim wouldn't start swapping to relieve the
> > struggling cache (plenty of cold anon memory around). It also meant
> > the IO delays of those refaults didn't contribute to memory pressure
> > in psi, which made userspace blind to the situation as well.
> >
> > The first aspect means we can get stuck in pathological thrashing, the
> > second means userspace OOM detection breaks and we can leave servers
> > (or Android devices, for that matter) hopelessly livelocked.
> >
> > New patch attached below. I hope we can get this fixed in 5.8, it's
> > really quite a big hole in our cache management strategy.
> >
> > ---
> > From 8db0b846ca0b7a136c0d3d8a1bee3d576990ba11 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Tue, 11 Feb 2020 12:55:07 -0500
> > Subject: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
> >
> > The VFS inode shrinker is currently allowed to reclaim cold inodes
> > with populated page cache. This behavior goes back to CONFIG_HIGHMEM
> > setups, which required the ability to drop page cache in large highem
> > zones to free up struct inodes in comparatively tiny lowmem zones.
> >
> > However, it has significant side effects that are hard to justify on
> > systems without highmem:
> >
> > - It can drop gigabytes of hot and active page cache on the floor
> > without consulting the VM (recorded as "inodesteal" events in
> > /proc/vmstat). Such an "aging inversion" between unreferenced inodes
> > holding hot cache easily happens in practice: for example, a git tree
> > whose objects are accessed frequently but no open file descriptors are
> > maintained throughout.
> >
> 
> Hi Johannes,
> 
> I think it is reasonable to keep inodes with _active_ page cache off
> the inode shrinker LRU, but I'm not sure whether it is proper to keep
> the inodes with _only_ inactive page cache off the inode list lru
> neither. Per my understanding, if the inode has only inactive page
> cache, then invalidate all these inactive page cache could save the
> reclaimer's time, IOW, it may improve the performance in this case.

The shrinker doesn't know whether pages are active or inactive.

There is a PageActive() flag, but that's a sampled state that's only
uptodate when page reclaim is running. All the active pages could be
stale and getting deactivated on the next scan; all the inactive pages
could have page table references that would get them activated on the
next reclaim run etc.

You'd have to duplicate aspects of page reclaim itself to be sure
you're axing the right pages.

It also wouldn't be a reliable optimization. This only happens when
there is a disconnect between the inode and the cache life time, which
is true for some situations but not others.
