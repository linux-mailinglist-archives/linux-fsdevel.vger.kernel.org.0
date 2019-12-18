Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8262123C80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 02:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLRBhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 20:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfLRBhg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:37:36 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A198206D7;
        Wed, 18 Dec 2019 01:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576633055;
        bh=yTmA3N0DX4DzZsE04AWRZ/hwoPMTbo467LgbdntdUEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0XKSRFB3b3+GPGQJLXIfijh9GrV32Ow0FmIKduSw0ZmLWO1Fg9C/QMb367Ie366uN
         aAIepWd5Ho/+rNu2DCRDiiOl2RoTJhJNDxX2PyM0tXJNMxUJFKO0Pe3jYTU9deuGaK
         XaFxLP5ef8frRYzZ5rjHbnf8SxF/7Cn+L9jpdUHg=
Date:   Tue, 17 Dec 2019 17:37:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] memcg, inode: protect page cache from freeing inode
Message-Id: <20191217173735.e8ae519f4930b31f99f71619@linux-foundation.org>
In-Reply-To: <20191217165422.GA213613@cmpxchg.org>
References: <1576582159-5198-1-git-send-email-laoar.shao@gmail.com>
        <20191217115603.GA10016@dhcp22.suse.cz>
        <CALOAHbBQ+XkQk6HN53O4e1=qfFiow2kvQO3ajDj=fwQEhcZ3uw@mail.gmail.com>
        <20191217165422.GA213613@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Dec 2019 11:54:22 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> I've carried the below patch in my private tree for testing cache
> aging decisions that the shrinker interfered with. (It would be nicer
> if page cache pages could pin the inode of course, but reclaim cannot
> easily participate in the inode refcounting scheme.)
> 
> ...
> 
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -753,7 +753,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		return LRU_ROTATE;
>  	}
>  
> -	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
> +	/* Leave the pages to page reclaim */
> +	if (inode->i_data.nrpages) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_ROTATE;
> +	}

I guess that code should have been commented...

This code was originally added because on large highmem machines we
were seeing lowmem full of inodes which had one or more highmem pages
attached to them.  Highmem was not under memory pressure so those
pagecache pages remained unreclaimed "for ever", thus pinning their
lowmem inode.  The net result was exhaustion of lowmem.

I guess a #ifdef CONFIG_HIGHMEM would help, to preserve the old
behavior in that case.  Although given the paucity of testing on large
highmem machines, the risk of divergent behavior over time is a
concern.

