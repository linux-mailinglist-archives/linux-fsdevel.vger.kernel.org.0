Return-Path: <linux-fsdevel+bounces-48144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE47AAA735
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 02:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11614A3053
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139433450A;
	Mon,  5 May 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KODD3dnU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456B2C086E;
	Mon,  5 May 2025 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484583; cv=none; b=YTMCMujevoUD2R+YRSK+U60c48+vSif4YjckTx6v4g5Mof+XgvVrF17d5H8vDjCiWilFw5so/zGknmnTVIhVwmvuRn8ozZFhwRUlgHCsz+Wgcgn9tJit7qCDKml+X+QBCCbJojlaWMJsNOUh2V5MdMzsnLF+9n1rRYjkMLPCjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484583; c=relaxed/simple;
	bh=V/as8NAbScpAc7r0jNSjRHgZ4ii7oO7JrW99rb0nMJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBSD+MgkyX7mLRblRRhfxE0FsyLidXyYwvyhm1GYrzORRnmoNvPIdzN6s3HTFahAe1OoY0MBWQ9a2h8VgM9TQ5NDKVWm1DOm0M+TG8OlO0roNlKhZS4Jp5AeDQrd9CxuuVMs0LrQpueTH5Rvj8ZeHeIVbPUETV0jqgLUY04aT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KODD3dnU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=wjv/3kkg8ER8GtdmsC4OfpctOuq/Lbu60oSY4NqUSV4=; b=KODD3dnUFam1+/IYyLJc/CXSLs
	Gw9rntN2BqtvuXlFEaZG6JhJA6URM/jLipCXwPYSr/YFlP9n4gLuYF2daWvE2rDCC7/vAkm6s0nuN
	QXiS6iKN3ofsx7PLEDDx6y9jUN9RXgITzSCI4Tsoj5PUIYa/DJBvbFIJhCstkDKqUwbc02C12msB4
	n2FHQzzYVeE56cAlg2pjy1u1CuD8oPlQuosvbOI+scszXsJeP/LLq1vjB8RGKxpTUp6AmIV81HpQg
	DIBWC0kfOdO3g7lB20nmxiiE6+K7HJbBWhLw45OAmxaH5ayGw5kNEpepcvcpoKjN9NZz0O6a1JQdr
	06dZq0rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC4Q3-000000073Pb-3xQP;
	Mon, 05 May 2025 22:36:15 +0000
Date: Mon, 5 May 2025 23:36:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	byungchul@sk.com, max.byungchul.park@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Prevent panic from NULL dereference in
 alloc_fs_context() during do_exit()
Message-ID: <20250505223615.GK2023217@ZenIV>
References: <20250505203801.83699-2-ysk@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505203801.83699-2-ysk@kzalloc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 05:38:02AM +0900, Yunseong Kim wrote:
> The function alloc_fs_context() assumes that current->nsproxy and its
> net_ns field are valid. However, this assumption can be violated in
> cases such as task teardown during do_exit(), where current->nsproxy can
> be NULL or already cleared.
> 
> This issue was triggered during stress-ng's kernel-coverage.sh testing,
> Since alloc_fs_context() can be invoked in various contexts — including
> from asynchronous or teardown paths like do_exit() — it's difficult to
> guarantee that its input arguments are always valid.
> 
> A follow-up patch will improve the granularity of this fix by moving the
> check closer to the actual mount trigger(e.g., in efivarfs_pm_notify()).

UGH.

> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 582d33e81117..529de43b8b5e 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -282,6 +282,9 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>  	struct fs_context *fc;
>  	int ret = -ENOMEM;
>  
> +	if (!current->nsproxy || !current->nsproxy->net_ns)
> +		return ERR_PTR(-EINVAL);
> +
>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
>  	if (!fc)
>  		return ERR_PTR(-ENOMEM);

That might paper over the oops, but I very much doubt that this will be
a correct fix...  Note that in efivarfs_pm_notify() we have other
fun issues when run from such context - have task_work_add() fail in
fput() and if delayed_fput() runs right afterwards and
        efivar_init(efivarfs_check_missing, sfi->sb, false);
in there might end up with UAF...

