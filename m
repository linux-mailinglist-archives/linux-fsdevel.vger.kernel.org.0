Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD28C3A082E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhFIAOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 20:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhFIAOn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:14:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07FB1610F8;
        Wed,  9 Jun 2021 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623197558;
        bh=Np2CNaI10f2uKvZB+8HAW9VBjJUZilRyHauJK0qYGM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UnB1q0jQlepG/n+9aunHOVHnESQHqNJO0tnNJiaZReW3e+zFEQDsENcwOJkkw9VFN
         3pOvqYOf63gtypGuz/jPXvIjdIW/SOhYrSTfPrJ0kaArAGVJYON1mq5qHbxVqL1XSq
         yu58wXvf/psjV9Um+ReIXRJThocZ1wDtmkDD+EHY=
Date:   Tue, 8 Jun 2021 17:12:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-Id: <20210608171237.be2f4223de89458841c10fd4@linux-foundation.org>
In-Reply-To: <20210608230225.2078447-9-guro@fb.com>
References: <20210608230225.2078447-1-guro@fb.com>
        <20210608230225.2078447-9-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Jun 2021 16:02:25 -0700 Roman Gushchin <guro@fb.com> wrote:

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
> ...
>
> +/*
> + * Maximum inodes per isw.  A specific value has been chosen to make
> + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> + */
> +#define WB_MAX_INODES_PER_ISW	115

Can't we do 1024/sizeof(struct inode_switch_wbs_context)?


