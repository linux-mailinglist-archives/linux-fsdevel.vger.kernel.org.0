Return-Path: <linux-fsdevel+bounces-59046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935FFB34028
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F69D178EBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9920A1E6DC5;
	Mon, 25 Aug 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aojj81Yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFF246BC6
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126584; cv=none; b=UDdE/vnPq0Bbyay+OpIkWYvTRhKu/aqZyR3zT1PfdbzZcTvKwuC5CKnCdVpl/9coC5htGKf4uN4fR8YfAS77yqt+w0zIhLJ2mZFto664/JtvgBm+Ot1wVaMXg3GHnj0QFuewjkjpuLW3vUYwdfkaOqf1NMQvXEHviHL5oVsSLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126584; c=relaxed/simple;
	bh=na7WfYkwYIRwrGrSXviW5qNSGgJOuQ1vmSj4YQtENhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU/JzLvLZLMGE5T88by/sE+nino8A3yUdyAVotsraTKrUmsqV44bwf5vdXOh5eVTYubRPi5Y4F96ByTt9BN1qrTh3h3LB7pOuoD6N/rP7ncE2cuKC03lLjwuXyTZTwjXrseciH6wDfzvhV3nhLhxebZTJSuPE4IQNVmESmKmDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aojj81Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823A6C4CEED;
	Mon, 25 Aug 2025 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756126583;
	bh=na7WfYkwYIRwrGrSXviW5qNSGgJOuQ1vmSj4YQtENhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aojj81Yyj89xOOy570eemqi3R0keL44bMHhLrPOlLHQEm2pJ/jTqUaim8sFIspC4r
	 KiffmoXCMk2k2I/+4RC4lQ09deTSafLiGUlnql/aomVLSeuA+W9KrakLQt84hBLlh8
	 x+BaoCEtFjWteuYjeL5ZBqHyXk/vR34y5FnIwaqvlJT1Pj6amnKW9CpcoJH6adeygw
	 3ga63HvVveaQ2chMXb9q1v9MEaZjJkzlm/tKFHZTkdEChf2K5BctLyuMkCUDOB7Sn4
	 MkXEQQ+OdEyDPo5hoA7JzqPhMZ22TBhOphWLpHpXxmXqRhp+R7XLLZ+KFa5Xlhg+oE
	 Tqrz+yZs6O8FQ==
Date: Mon, 25 Aug 2025 14:56:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 15/52] path_is_under(): use guards
Message-ID: <20250825-heilt-hackbeil-850d914c3905@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-15-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:18AM +0100, Al Viro wrote:
> ... and document that locking requirements for is_path_reachable().
> There is one questionable caller in do_listmount() where we are not
> holding mount_lock *and* might not have the first argument mounted.
> However, in that case it will immediately return true without having
> to look at the ancestors.  Might be cleaner to move the check into
> non-LSTM_ROOT case which it really belongs in - there the check is
> not always true and is_mounted() is guaranteed.
> 
> Document the locking environments for is_path_reachable() callers:
> 	get_peer_under_root()
> 	get_dominating_id()
> 	do_statmount()
> 	do_listmount()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 12 ++++++------
>  fs/pnode.c     |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index acacfe767a7c..bf9a3a644faa 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -4592,7 +4592,7 @@ SYSCALL_DEFINE5(move_mount,
>  /*
>   * Return true if path is reachable from root
>   *
> - * namespace_sem or mount_lock is held
> + * locks: mount_locked_reader || namespace_shared && is_mounted(mnt)
>   */
>  bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
>  			 const struct path *root)
> @@ -4606,11 +4606,9 @@ bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
>  
>  bool path_is_under(const struct path *path1, const struct path *path2)
>  {
> -	bool res;
> -	read_seqlock_excl(&mount_lock);
> -	res = is_path_reachable(real_mount(path1->mnt), path1->dentry, path2);
> -	read_sequnlock_excl(&mount_lock);
> -	return res;
> +	scoped_guard(mount_locked_reader)
> +		return is_path_reachable(real_mount(path1->mnt), path1->dentry,
> +					 path2);

Same thing, no need for this scoped guard eyesore.

