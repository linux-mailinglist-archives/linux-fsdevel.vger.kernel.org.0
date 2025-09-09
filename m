Return-Path: <linux-fsdevel+bounces-60707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C30B50338
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BA7A7CD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342F35A2BA;
	Tue,  9 Sep 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC4UMfSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D931B116
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436749; cv=none; b=haA2YPSSy4HNRNoJH3M/aZ7IgP1tNSIsLcP+RikFBihNP7iF0loDKl9tNeMeN9BL9ZDMaMbvBMPLV9ThOH7TCL6vfQf+B2duvydq40LjUc55udHFdiYQBY+XdKV7izCfeyy8KDfVFPNqfrV7DL8oUGtIGAmH3Ro/mcdNiKriH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436749; c=relaxed/simple;
	bh=ShdBczO5tCqNUFWWetOo2BTwq0mL8l+WlSWABBOv85Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkrxOych/LwKFsBgr28fuwobgEQJa6WcP3UWxwowUYe+9vl+zvy2aPXgIxSLvjE69xXiflrPUoujaYxckUpWCa/3mvVj9OeFxgMU1Qi/eGqWjkyGFIb34TMwzQczdTs2Pywf4EK51teyn5imEtTeb3R7J3KBEvIc2lG0R715Plo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC4UMfSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7CAC4CEF9;
	Tue,  9 Sep 2025 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757436748;
	bh=ShdBczO5tCqNUFWWetOo2BTwq0mL8l+WlSWABBOv85Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VC4UMfSebw5g5oxfzxq7joeCl26UlvdNIZ6PWkeY3bf030ez162WfZ1kwm4xAFfOR
	 BmVNtBY4b67bTj1BMIcFCLnT8dvaIYtVHpPuC6mjeUvQmgXuAeIsKEJ9gEwAZatplI
	 FZiw+IcSaQDX/RVVOVoJt1cd+Voqu0+vv/hQHyJ1Few70UFOe28TAJk1pG5+699FMx
	 DUiOOouhf8emkh+vLCX+aC/HfhTVtR48VvAqyYzxLSz4/Qu+ThoY2jAf08Bi7Z8wVF
	 wDTyufmtLMpj8Uphvg8ybztpT/eVGXyhTHVJIMd9lTyVTWIeAGtnXst0HFzrepr+8W
	 aX0HwnpeaywPg==
Date: Tue, 9 Sep 2025 06:52:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMBbSxwwnvBvQw8C@slm.duckdns.org>
References: <20250909143734.30801-1-jack@suse.cz>
 <20250909144400.2901-5-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909144400.2901-5-jack@suse.cz>

Hello, Jan.

On Tue, Sep 09, 2025 at 04:44:02PM +0200, Jan Kara wrote:
> There can be multiple inode switch works that are trying to switch
> inodes to / from the same wb. This can happen in particular if some
> cgroup exits which owns many (thousands) inodes and we need to switch
> them all. In this case several inode_switch_wbs_work_fn() instances will
> be just spinning on the same wb->list_lock while only one of them makes
> forward progress. This wastes CPU cycles and quickly leads to softlockup
> reports and unusable system.
> 
> Instead of running several inode_switch_wbs_work_fn() instances in
> parallel switching to the same wb and contending on wb->list_lock, run
> just one instance and let the other isw items switching to this wb queue
> behind the one being processed.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
...
> +static void inode_switch_wbs_work_fn(struct work_struct *work)
> +{
> +	struct inode_switch_wbs_context *isw =
> +		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
> +	struct bdi_writeback *new_wb = isw->new_wb;
> +	bool switch_running;
> +
> +	spin_lock_irq(&new_wb->work_lock);
> +	switch_running = !list_empty(&new_wb->switch_wbs_ctxs);
> +	list_add_tail(&isw->list, &new_wb->switch_wbs_ctxs);
> +	spin_unlock_irq(&new_wb->work_lock);
> +
> +	/*
> +	 * Let's leave the real work for the running worker since we'd just
> +	 * contend with it on wb->list_lock anyway.
> +	 */
> +	if (switch_running)
> +		return;
> +
> +	/* OK, we will be doing the switching work */
> +	wb_get(new_wb);
> +	spin_lock_irq(&new_wb->work_lock);
> +	while (!list_empty(&new_wb->switch_wbs_ctxs)) {
> +		isw = list_first_entry(&new_wb->switch_wbs_ctxs,
> +				       struct inode_switch_wbs_context, list);
> +		spin_unlock_irq(&new_wb->work_lock);
> +		process_inode_switch_wbs_work(isw);
> +		spin_lock_irq(&new_wb->work_lock);
> +		list_del(&isw->list);
> +		kfree(isw);
> +	}
> +	spin_unlock_irq(&new_wb->work_lock);
> +	wb_put(new_wb);
> +}

Would it be easier to achieve the same effect if we just reduced @max_active
when creating inode_switch_wbs? If we update cgroup_writeback_init() to use
the following instead:

        isw_wq = alloc_workqueue("inode_switch_wbs", WQ_UNBOUND, 1);

Wouldn't that achieve the same thing? Note the addition of WQ_UNBOUND isn't
strictly necessary but we're in the process of defaulting to unbound
workqueues, so might as well update it together. I can't think of any reason
why this would require per-cpu behavior.

Thanks.

-- 
tejun

