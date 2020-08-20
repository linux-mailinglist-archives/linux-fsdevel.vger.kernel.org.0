Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCD24BC3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 14:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgHTMnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 08:43:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbgHTMmo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:42:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB459AF0F;
        Thu, 20 Aug 2020 12:43:09 +0000 (UTC)
Date:   Thu, 20 Aug 2020 14:42:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820124241.GJ5033@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
 <87zh6pxzq6.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh6pxzq6.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 07:34:41, Eric W. Biederman wrote:
> Suren Baghdasaryan <surenb@google.com> writes:
> 
> > Currently __set_oom_adj loops through all processes in the system to
> > keep oom_score_adj and oom_score_adj_min in sync between processes
> > sharing their mm. This is done for any task with more that one mm_users,
> > which includes processes with multiple threads (sharing mm and signals).
> > However for such processes the loop is unnecessary because their signal
> > structure is shared as well.
> > Android updates oom_score_adj whenever a tasks changes its role
> > (background/foreground/...) or binds to/unbinds from a service, making
> > it more/less important. Such operation can happen frequently.
> > We noticed that updates to oom_score_adj became more expensive and after
> > further investigation found out that the patch mentioned in "Fixes"
> > introduced a regression. Using Pixel 4 with a typical Android workload,
> > write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
> > this regression linearly depends on the number of multi-threaded
> > processes running on the system.
> > Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
> > CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
> > instead of mm_users to decide whether oom_score_adj update should be
> > synchronized between multiple processes. To prevent races between clone()
> > and __set_oom_adj(), when oom_score_adj of the process being cloned might
> > be modified from userspace, we use oom_adj_mutex. Its scope is changed to
> > global and it is renamed into oom_adj_lock for naming consistency with
> > oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
> > used the additional mutex lock in that path of the clone() syscall should
> > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
> > (when the last process sharing the mm exits) is left out of this patch to
> > keep it simple and because it is believed that this threading model is
> > rare. Should there ever be a need for optimizing that case as well, it
> > can be done by hooking into the exit path, likely following the
> > mm_update_next_owner pattern.
> > With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
> > regression is gone after the change is applied.
> 
> So I am confused.
> 
> Is there any reason why we don't simply move signal->oom_score_adj to
> mm->oom_score_adj and call it a day?

Yes. Please read through 44a70adec910 ("mm, oom_adj: make sure processes
sharing mm have same view of oom_score_adj")
-- 
Michal Hocko
SUSE Labs
