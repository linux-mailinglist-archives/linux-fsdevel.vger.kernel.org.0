Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8439F175
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 10:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFHI4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 04:56:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50910 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHI4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:56:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B06401FD2A;
        Tue,  8 Jun 2021 08:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623142498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s57GF5EVrU8EkU6hVgTxTv92JSfKxB+kZ8XzRaWUnBM=;
        b=dMUn34jq76iZfpe+e/UvfR64NqfiyE3bGkAnY7c5GBBn26baRgLDP3PSf/g+WNPP6nOAh3
        wxNlk4Q/cxIYWdmJZh48684o9Ycgg0G8kmQFLnQFdkIYRoOluOboCH4yj01stu5xe6fkZw
        n3WP11Zr8PmwFcRZ/QM2wsIbAoeJNFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623142498;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s57GF5EVrU8EkU6hVgTxTv92JSfKxB+kZ8XzRaWUnBM=;
        b=QB67RQ6oO8NzzFxSr5nVeyP4+sAxevwN2dFw2I9h2gNFohGorTS0PXXTrCglCxi/x2Cy7D
        qc3kQ5g6XNatMDAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A7FFAA3B83;
        Tue,  8 Jun 2021 08:54:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5F9E21F2C94; Tue,  8 Jun 2021 10:54:58 +0200 (CEST)
Date:   Tue, 8 Jun 2021 10:54:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v8 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <20210608085458.GC5562@quack2.suse.cz>
References: <20210608013123.1088882-1-guro@fb.com>
 <20210608013123.1088882-9-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608013123.1088882-9-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-06-21 18:31:23, Roman Gushchin wrote:
> Asynchronously try to release dying cgwbs by switching attached inodes
> to the nearest living ancestor wb. It helps to get rid of per-cgroup
> writeback structures themselves and of pinned memory and block cgroups,
> which are significantly larger structures (mostly due to large per-cpu
> statistics data). This prevents memory waste and helps to avoid
> different scalability problems caused by large piles of dying cgroups.
> 
> Reuse the existing mechanism of inode switching used for foreign inode
> detection. To speed things up batch up to 115 inode switching in a
> single operation (the maximum number is selected so that the resulting
> struct inode_switch_wbs_context can fit into 1024 bytes). Because
> every switching consists of two steps divided by an RCU grace period,
> it would be too slow without batching. Please note that the whole
> batch counts as a single operation (when increasing/decreasing
> isw_nr_in_flight). This allows to keep umounting working (flush the
> switching queue), however prevents cleanups from consuming the whole
> switching quota and effectively blocking the frn switching.
> 
> A cgwb cleanup operation can fail due to different reasons (e.g. not
> enough memory, the cgwb has an in-flight/pending io, an attached inode
> in a wrong state, etc). In this case the next scheduled cleanup will
> make a new attempt. An attempt is made each time a new cgwb is offlined
> (in other words a memcg and/or a blkcg is deleted by a user). In the
> future an additional attempt scheduled by a timer can be implemented.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Dennis Zhou <dennis@kernel.org>

The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one codingstyle nit below.

> +		if (!wb_tryget(wb))
> +			continue;
> +
> +		spin_unlock_irq(&cgwb_lock);
> +		while ((cleanup_offline_cgwb(wb)))
			^^ too many parentheses here...


> +			cond_resched();
> +		spin_lock_irq(&cgwb_lock);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
