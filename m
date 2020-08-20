Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B58024B841
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgHTLOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 07:14:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:46226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgHTLOr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:14:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0AB0B80B;
        Thu, 20 Aug 2020 11:15:12 +0000 (UTC)
Date:   Thu, 20 Aug 2020 13:14:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820111445.GF5033@dhcp22.suse.cz>
References: <20200820002053.1424000-1-surenb@google.com>
 <20200820084654.jdl6jqgxsga7orvf@wittgenstein>
 <20200820090901.GD5033@dhcp22.suse.cz>
 <20200820103248.vkzrndewvy5vlncz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820103248.vkzrndewvy5vlncz@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 12:32:48, Christian Brauner wrote:
> On Thu, Aug 20, 2020 at 11:09:01AM +0200, Michal Hocko wrote:
> > On Thu 20-08-20 10:46:54, Christian Brauner wrote:
[...]
> > > > which includes processes with multiple threads (sharing mm and signals).
> > > > However for such processes the loop is unnecessary because their signal
> > > > structure is shared as well.
> 
> and it seems you want to exclude threads, i.e. only update mm that is
> shared not among threads in the same thread-group.
> But struct signal and struct sighand_struct are different things, i.e.
> they can be shared or not independent of each other. A non-shared
> signal_struct where oom_score_adj{_min} live is only implied by
> !CLONE_THREAD. So shouldn't this be:
> 
> if (!(clone_flags & CLONE_THREAD)) rather than CLONE_SIGHAND?

You are right as I have already replied to Oleg.

-- 
Michal Hocko
SUSE Labs
