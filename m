Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB521232FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 17:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfLQQyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 11:54:25 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38073 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQQyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:54:24 -0500
Received: by mail-qv1-f67.google.com with SMTP id t6so4016008qvs.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzNMqEKy+i126GtW2zZLwQfsfVoyhha71N6j1L+7V+U=;
        b=A2rtztcs9UaST2s9iupi1B5WmY/QRU8o3QUupO2GupjgQtTzL0SEfdEpjGdTTdLIG8
         qD4GmVhCAU0C8e0MMC8IdWzmfcNJSwQP+/YvE0/1SNdrtDrMNmr89hi7gGfO3n9Nqi6C
         XXsc0rqPgVHPkx+i7ONjMeUl83cLn8+nfPFVoUiX0edvlRnsdiRPhMR/Ko2/mf0bc0TD
         K404CtsukiJgi3ivLoLpN6sm3fDYtlj9TjnqaiDn/mriO55OBmDYbuAlr4hdt+q2iCNa
         PagyVJE3TdD9V50Q+m3I8OKzBGrYGAQUm0yncE0+PA4LqI9LALCm66CHiEB+bBKNh+Vv
         N3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzNMqEKy+i126GtW2zZLwQfsfVoyhha71N6j1L+7V+U=;
        b=ra/SKyOO2QY/uXuWcnSlwh4JtJfbTEV+hGFW7JAT+QLUQgxrZFdjK1Za3b4BVJygtM
         DLXGGvOJgv/uq++FHUGmYKGDLVY+ECqTlb45ocr3McE2dadYmlqIsTU1RFYVqPb9nCCM
         JCz22JvC5IlGjGs95YVBaioG3mn2Cjn0Iy0MXi2hE1UZH2AZB1r3sdX7GJOyVaqTL3Hb
         wXctYyrKxQSaWs6sxUmS3ODOn4QjMR+xoQA4s0Zc2Cat9V6O1hia8fBCQmR0upq6xnmd
         BmCJFoCvESMcSF9+1CH7LBHdt3fHAQoQMaRH1vyEPuXH+zhiGEv7LVWgvXGF3mBvReTC
         +MKA==
X-Gm-Message-State: APjAAAVPjAYp/LW1BEtDJSyNSNeYLzSC8v4tS94T68jkvIqpKVirsfpr
        1SakiTzLjS1e6PWSlVEFZvBW4Q==
X-Google-Smtp-Source: APXvYqyxmbsmxJNC0kUf9/3tLIScIj+e+DEnCcxzKZKnVJitlv+ffOe6HKLe80LuG/hk6hqLxtzcAA==
X-Received: by 2002:a0c:8b68:: with SMTP id d40mr1742352qvc.138.1576601663547;
        Tue, 17 Dec 2019 08:54:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:853a])
        by smtp.gmail.com with ESMTPSA id z28sm8445931qtz.69.2019.12.17.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 08:54:22 -0800 (PST)
Date:   Tue, 17 Dec 2019 11:54:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-ID: <20191217165422.GA213613@cmpxchg.org>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
 <20191217115603.GA10016@dhcp22.suse.cz>
 <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CCing Dave

On Tue, Dec 17, 2019 at 08:19:08PM +0800, Yafang Shao wrote:
> On Tue, Dec 17, 2019 at 7:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > What do you mean by this exactly. Are those inodes reclaimed by the
> > regular memory reclaim or by other means? Because shrink_node does
> > exclude shrinking slab for protected memcgs.
> 
> By the regular memory reclaim, kswapd, direct reclaimer or memcg reclaimer.
> IOW, the current->reclaim_state it set.
> 
> Take an example for you.
> 
> kswapd
>     balance_pgdat
>         shrink_node_memcgs
>             switch (mem_cgroup_protected)  <<<< memory.current= 1024M
> memory.min = 512M a file has 800M page caches
>                 case MEMCG_PROT_NONE:  <<<< hard limit is not reached.
>                       beak;
>             shrink_lruvec
>             shrink_slab <<< it may free the inode and the free all its
> page caches (800M)

This problem exists independent of cgroup protection.

The inode shrinker may take down an inode that's still holding a ton
of (potentially active) page cache pages when the inode hasn't been
referenced recently.

IMO we shouldn't be dropping data that the VM still considers hot
compared to other data, just because the inode object hasn't been used
as recently as other inode objects (e.g. drowned in a stream of
one-off inode accesses).

I've carried the below patch in my private tree for testing cache
aging decisions that the shrinker interfered with. (It would be nicer
if page cache pages could pin the inode of course, but reclaim cannot
easily participate in the inode refcounting scheme.)

Thoughts?

diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..bfcaaaf6314f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 		return LRU_ROTATE;
 	}
 
-	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
+	/* Leave the pages to page reclaim */
+	if (inode->i_data.nrpages) {
+		spin_unlock(&inode->i_lock);
+		return LRU_ROTATE;
+	}
+
+	if (inode_has_buffers(inode)) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(lru_lock);
