Return-Path: <linux-fsdevel+bounces-61110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF1B55488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA627A39C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628F311C03;
	Fri, 12 Sep 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNXvGJo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38701DD877
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693750; cv=none; b=g31UyhgOrtiKlacUqpPcuIh/D8hH/kOWZYXpKBaOxmZ9mL99V1XIPhpljC+DwteyqEWsj59QzC7M4Ca46sk++in6OERA3UFAPX8E/UnlXMHcX6UW+QhFaio5lBp6qNorDdDAPu+3o2K8b1WCvmHGYZfuMN14t57EZaGG7djwvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693750; c=relaxed/simple;
	bh=M1Nh2rz/HDsa+1zv1XmHSurQgYK48z+GrsF/2ix80GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ81GuLU7edQr+q7YOq1c8iw8PwWC+C8aqNqpzegTvyHlxJmFemvJ0o7F1CF7zHOEvIfZ3b/hRDtw+3aRiNCoj+/0QyJS403dQOHAmtoxR5Ee7/ZonwxD11huJmpAjs/YKc8S22A4CDDKRdgkW4yKpzknDT4llRJ4pQ3AWXTOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNXvGJo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD09C4CEF1;
	Fri, 12 Sep 2025 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757693750;
	bh=M1Nh2rz/HDsa+1zv1XmHSurQgYK48z+GrsF/2ix80GI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNXvGJo5QGkUBrCGskqK/RCP5ty18Au9VUgy8SwAnzv+0Ez6XAF0miH+jYKhCuF8A
	 6TJVcx7kxJgk44bkDVqsKYwaJppQPSsEU//M8ds7xYicDveck8UyiqKIACpI+CfDnK
	 xlTJLj4Yaubqht9D5Rwwy19RaUMSORzq2JP8RtKvc8Xt6zwuOiaMJ9zj0mjucErq8M
	 wJCxMHfJ1bIEfdmxCnq4Mtk2b92pK3npmqADyzJTRSFmLj5lc/ClLZLd8/euklvW9M
	 2cpHKqPtqAD5eq5m6H66J1kMUEM3IpGRp3iBc3ejGg1T80WCE/D3LQHufJOfaFjrsA
	 1XrmjIIpMZADw==
Date: Fri, 12 Sep 2025 06:15:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] writeback: Avoid contention on wb->list_lock when
 switching inodes
Message-ID: <aMRHNSDV4lXSsU9U@slm.duckdns.org>
References: <20250912103522.2935-1-jack@suse.cz>
 <20250912103840.4844-5-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912103840.4844-5-jack@suse.cz>

Hello,

On Fri, Sep 12, 2025 at 12:38:35PM +0200, Jan Kara wrote:
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
> just one work item per wb and manage a queue of isw items switching to
> this wb.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Generally looks great to me, but

> +void inode_switch_wbs_work_fn(struct work_struct *work)
> +{
> +	struct bdi_writeback *new_wb = container_of(work, struct bdi_writeback,
> +						    switch_work);
> +	struct inode_switch_wbs_context *isw, *next_isw;
> +	struct llist_node *list;
> +
> +	/*
> +	 * Grab out reference to wb so that it cannot get freed under us
> +	 * after we process all the isw items.
> +	 */
> +	wb_get(new_wb);

Shouldn't this ref put at the end of the function?

> +	while (1) {
> +		list = llist_del_all(&new_wb->switch_wbs_ctxs);
> +		/* Nothing to do? */
> +		if (!list) {
> +			wb_put(new_wb);
> +			return;
> +		}
> +		/*
> +		 * In addition to synchronizing among switchers, I_WB_SWITCH
> +		 * tells the RCU protected stat update paths to grab the i_page
> +		 * lock so that stat transfer can synchronize against them.
> +		 * Let's continue after I_WB_SWITCH is guaranteed to be
> +		 * visible.
> +		 */
> +		synchronize_rcu();
> +
> +		llist_for_each_entry_safe(isw, next_isw, list, list)
> +			process_inode_switch_wbs_work(new_wb, isw);
> +	}
> +}

Thanks.

-- 
tejun

