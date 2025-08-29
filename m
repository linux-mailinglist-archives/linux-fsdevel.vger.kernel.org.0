Return-Path: <linux-fsdevel+bounces-59637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2939B3B7E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E3446005D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D06304BCD;
	Fri, 29 Aug 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9n1aWjD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF3F214813
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461473; cv=none; b=hkOOen6O7hvBhpc7V3eYVheiGdOQb1nSmO5Ljy8VcEvqpKReetMtv2kfWiKlUZ/8uTaPmmsUkFFnOyx/AmEFM9xwCelcdnLbdaohzrhgOX/4cNdOQ7bnUMEwmRP3njKpfTTFJLX9uSDpgEnrUziL4epEQn5qB6gamdbkZw8gdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461473; c=relaxed/simple;
	bh=rJ2MjM/ukFE8SrR6RXM7eJNOKvN6gwkteyrWfVIKhRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f02EV0Rkrj1w2SIIuRnvkOPkN12BKLQwEHtJXVPaqcuzsWZUeGQdqwmn5MrxGhRV10L3ksjPyIqvjV/kymQLn0E5WYhK7kiuTQO4gHG0te2zPm0TeXpu7x/XKDgVwRDWXOWggBJhdvnNSqmBtP8rsE72g88nFe8L0RPd4omuTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9n1aWjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4989C4CEF0;
	Fri, 29 Aug 2025 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756461472;
	bh=rJ2MjM/ukFE8SrR6RXM7eJNOKvN6gwkteyrWfVIKhRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m9n1aWjDYSJkCfdUUVImPT0EnvCDg1Kzo1KRWyf/OdRHA25b0sJoSCZyEw2qphVNH
	 H55BQiCr2hkx8/ZimRXS8o/7JJexvCXkfrb97zP5X8JXq855/u6RSlmkPNu1BQ2O+e
	 7aIRQxNdLYll5vYrmCG1+xC82vJwm+2yEGP7BisSMUfbnRaM675gUdhQv1pS8PlAhm
	 bSkAn6TScQ4320YZpBBebuIYRd6SHw3qbyzChgzVVlmGJpwtDN3QS4p53d6RSSHAK+
	 VwMyPScTVSWuHKtzSo+QSIUtgYfdDN6v5xk9t6bGb45kMYoEEdnbaIqd+4qAVosmYF
	 wX+3ltJOQZpgw==
Date: Fri, 29 Aug 2025 11:57:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 56/63] mnt_ns_tree_remove(): DTRT if mnt_ns had never
 been added to mnt_ns_list
Message-ID: <20250829-kehlkopf-intuitiv-862803cc1bdf@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-56-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-56-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:59AM +0100, Al Viro wrote:
> Actual removal is done under the lock, but for checking if need to bother
> the lockless list_empty() is safe - either that namespace never had never

nit: two "never"s

> been added to mnt_ns_tree, in which case the list will stay empty, or
> whoever had allocated it has called mnt_ns_tree_add() and it has already
> run to completion.  After that point list_empty() will become false and
> will remain false, no matter what we do with the neighbors in mnt_ns_list.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c324800e770c..daa72292ea58 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -195,7 +195,7 @@ static void mnt_ns_release_rcu(struct rcu_head *rcu)
>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
> -	if (!is_anon_ns(ns)) {
> +	if (!list_empty(&ns->mnt_ns_list)) {
>  		mnt_ns_tree_write_lock();
>  		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
>  		list_bidir_del_rcu(&ns->mnt_ns_list);
> -- 
> 2.47.2
> 

