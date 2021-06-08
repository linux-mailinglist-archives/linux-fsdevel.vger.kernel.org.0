Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510D339F12F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhFHIpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 04:45:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50342 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFHIpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:45:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DCEF11FD2A;
        Tue,  8 Jun 2021 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623141828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iISBLZW6vnOrxf1PW5nBJaiWFRRWjobdH4Xa3xTC/lU=;
        b=njPEmPPpqnXg+tK+t2CDK3LGjIjtcmBh4GjeomQYXxUy4wdWJIv5Qfh3tYvVx3Ji5/9kO1
        QyjjZEfBuDOcJoAU1stmecuDDIuh4TJjuDElafj2O8/cIeoJSYIjozJzVJ9hj7ekFDz1VO
        EJ39+iqOxFuiRomisRKW5s6b6jEbKjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623141828;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iISBLZW6vnOrxf1PW5nBJaiWFRRWjobdH4Xa3xTC/lU=;
        b=WZxVu+knMuzzI4pcbDtECurFxUjtzwLXtn+LHGOZ/eE7TJvRoflemPzoPTgweVLDUQPNMX
        Inv4z139hONYZOCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BC035A3B87;
        Tue,  8 Jun 2021 08:43:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 83E781F2C94; Tue,  8 Jun 2021 10:43:48 +0200 (CEST)
Date:   Tue, 8 Jun 2021 10:43:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v8 2/8] writeback, cgroup: add smp_mb() to
 cgroup_writeback_umount()
Message-ID: <20210608084348.GA5562@quack2.suse.cz>
References: <20210608013123.1088882-1-guro@fb.com>
 <20210608013123.1088882-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608013123.1088882-3-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 07-06-21 18:31:17, Roman Gushchin wrote:
> A full memory barrier is required between clearing SB_ACTIVE flag
> in generic_shutdown_super() and checking isw_nr_in_flight in
> cgroup_writeback_umount(), otherwise a new switch operation might
> be scheduled after atomic_read(&isw_nr_in_flight) returned 0.
> This would result in a non-flushed isw_wq, and a potential crash.
> 
> The problem hasn't yet been seen in the real life and was discovered
> by Jan Kara by looking into the code.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index bd99890599e0..3564efcc4b78 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1000,6 +1000,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
>   */
>  void cgroup_writeback_umount(void)
>  {
> +	/*
> +	 * SB_ACTIVE should be reliably cleared before checking
> +	 * isw_nr_in_flight, see generic_shutdown_super().
> +	 */
> +	smp_mb();
> +
>  	if (atomic_read(&isw_nr_in_flight)) {
>  		/*
>  		 * Use rcu_barrier() to wait for all pending callbacks to
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
