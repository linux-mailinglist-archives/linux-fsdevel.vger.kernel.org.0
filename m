Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D5298778
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 08:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421992AbgJZHdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 03:33:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421981AbgJZHdp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 03:33:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603697624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=osZa4GQqoLyjFil+Xh6+gkjrSo2FUXDMzZmLc6SlDTg=;
        b=hvO1N3ilgC9Hi7IjXjtalLH27o7oltYweddZhpzRKYsM7Mq7nVoc2FvzJXW1waKCqRF+GX
        iEIcHuYc+bKy5RNcpQORA4zKIUf+PXoLYssdDQ1I745tZfvnK93sfYxoK7YM8RDhxqtKjR
        AjabODbNxlo43pEQT1xUdyanYl3MIKo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B44ADAC2F;
        Mon, 26 Oct 2020 07:33:44 +0000 (UTC)
Date:   Mon, 26 Oct 2020 08:33:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charles Haithcock <chaithco@redhat.com>
Cc:     adobriyan@gmail.com, trivial@kernel.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net-next] mm, oom: keep oom_adj under or at upper limit
 when printing [v2]
Message-ID: <20201026073344.GA20500@dhcp22.suse.cz>
References: <20201020165130.33927-1-chaithco@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020165130.33927-1-chaithco@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-10-20 10:51:30, Charles Haithcock wrote:
> For oom_score_adj values in the range [942,999], the current
> calculations will print 16 for oom_adj. This patch simply limits the
> output so output is inline with docs.
> 
> v2: moved the change to after put task to make sure the task is
>     released asap
> Signed-off-by: Charles Haithcock <chaithco@redhat.com>

OK, this seems to be broken since the scaling has been introduced.
oom_score is deprecated but it is true that the fix is trivial.
Now that you have added this clamping we can drop the oom_score_adj ==
OOM_SCORE_ADJ_MAX branch as well.

Have you found out this by code inspeciton or some userspace actually
cares?

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  fs/proc/base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617db4e0faa0..eafabeaf21d1 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1049,6 +1049,8 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
>  		oom_adj = (task->signal->oom_score_adj * -OOM_DISABLE) /
>  			  OOM_SCORE_ADJ_MAX;
>  	put_task_struct(task);
> +	if (oom_adj > OOM_ADJUST_MAX)
> +		oom_adj = OOM_ADJUST_MAX;
>  	len = snprintf(buffer, sizeof(buffer), "%d\n", oom_adj);
>  	return simple_read_from_buffer(buf, count, ppos, buffer, len);
>  }
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
