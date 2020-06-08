Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86761F1DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgFHQup (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:50:45 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:38998 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730600AbgFHQun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:50:43 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id E83A1C4A9A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 17:50:41 +0100 (IST)
Received: (qmail 26177 invoked from network); 8 Jun 2020 16:50:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Jun 2020 16:50:41 -0000
Date:   Mon, 8 Jun 2020 17:50:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: Rearrange fast path to minimise overhead when
 there is no watcher
Message-ID: <20200608165040.GI3127@techsingularity.net>
References: <20200608140557.GG3127@techsingularity.net>
 <20200608151943.GA861@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200608151943.GA861@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:19:43PM +0200, Jan Kara wrote:
> > This is showing that the latencies are improved by roughly 2-9%. The
> > variability is not shown but some of these results are within the noise
> > as this workload heavily overloads the machine. That said, the system CPU
> > usage is reduced by quite a bit so it makes sense to avoid the overhead
> > even if it is a bit tricky to detect at times. A perf profile of just 1
> > group of tasks showed that 5.14% of samples taken were in either fsnotify()
> > or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
> > mostly function entry and the initial check for watchers.  The check for
> > watchers is complicated enough that inlining it may be controversial.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Thanks for the patch! I have to tell I'm surprised this small reordering
> helps so much. For pipe inode we will bail on:
> 
>        if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
>            (!mnt || !mnt->mnt_fsnotify_marks))
>                return 0;
> 
> So what we save with the reordering is sb->s_fsnotify_mask and
> mnt->mnt_fsnotify_mask fetch but that should be the same cacheline as
> sb->s_fsnotify_marks and mnt->mnt_fsnotify_marks, respectively.

It is likely that the contribution of that change is marginal relative
to the fsnotify_parent() call. I'll know by tomorrow morning at the latest.

> We also
> save a function call of fsnotify_parent() but I would think that is very
> cheap (compared to the whole write path) as well.
> 

To be fair, it is cheap but with this particular workload, we call
vfs_write() a *lot* and the path is not that long so it builds up to 5%
of samples overall. Given that these were anonymous pipes, it surprised
me to see fsnotify at all which is why I took a closer look.

> The patch is simple enough so I have no problem merging it but I'm just
> surprised by the results... Hum, maybe the structure randomization is used
> in the builds and so e.g. sb->s_fsnotify_mask and sb->s_fsnotify_marks
> don't end up in the same cacheline? But I don't think we enable that in
> SUSE builds?
> 

Correct, GCC_PLUGIN_RANDSTRUCT was not set.

-- 
Mel Gorman
SUSE Labs
