Return-Path: <linux-fsdevel+bounces-67867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084FC4C991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDF93AC29B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB32EC084;
	Tue, 11 Nov 2025 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koVbJfLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8E262FC7;
	Tue, 11 Nov 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852399; cv=none; b=FXFuSf12xvUPxMkbkv2kHsf7/X5i5Y7UaRFDKELj6DGPHyMwGMx7gOlmzIdSBZ//s/yTwivQC+4smBxU1nIDre9mpgs9HqYD57qaSlju3LsnALzf+cCcooOPvecaORIPG3FO7kYTDIOW3WumLP2+9yCbri0dMxVFLB7pEhEMXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852399; c=relaxed/simple;
	bh=67bbpUv1c6D8+8ny0J/gkB+aNs+NU8lTnMX848gbpDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZ7hx/aHtVBAtWSXuE3mv6dyUJMvJPeA3kFvE7gyheQ8dR8tLZNnQegUsQmk4imcyHVNPLNzMi2Up2IygXkgasqRI2ters56XY2+vs96so10+kcslqqNkLzh6gXHTSQj06gNWYvPVICtEYN1mrEQT/pMaS84uU71hwA75ebmbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koVbJfLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF714C4CEFB;
	Tue, 11 Nov 2025 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762852399;
	bh=67bbpUv1c6D8+8ny0J/gkB+aNs+NU8lTnMX848gbpDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koVbJfLFGaFqgtLogMDXWKWJPq2xRfIi602FUbaM8NELvsPmJh9JUUYECFwwUDvNd
	 8LIQELdwibGGRrrc5JmVUcCiCZ9zJkX3T69XLsa4ivgiqugr/93QN4BpVDhyjs8IdD
	 K3xPewB1S+SltIl7IOgHMTmiAIBSY0s8r/N3HV7BG2K3oX1HabPbv8Tl9WPSNoD8qy
	 p1wiVG2WIGXXj2wWm3uMOJbBDwGNuiyci3jESB1QPGGRAPKHy03fK2bvZ2x1Uy4RQ7
	 g6KGR9JBnXFPml5nMHqavxmZpxtdImEtV5Qp8xjqVHgg5YQ7K9RHLXpgEIkEXk3pjt
	 lW035xmPEHmTQ==
Date: Tue, 11 Nov 2025 10:13:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <20251111-umkleiden-umgegangen-c19ef83823c1@brauner>
References: <20251111062815.2546189-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111062815.2546189-1-avagin@google.com>

On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> grab_requested_mnt_ns was changed to return error codes on failure, but
> its callers were not updated to check for error pointers, still checking
> only for a NULL return value.
> 
> This commit updates the callers to use IS_ERR() or IS_ERR_OR_NULL() and
> PTR_ERR() to correctly check for and propagate errors.
> 
> Fixes: 7b9d14af8777 ("fs: allow mount namespace fd")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---

Thanks. I've folded the following diff into the patch to be more in line
with our usual error handling:

diff --git a/fs/namespace.c b/fs/namespace.c
index 74a162a5703a..76f6e868f352 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -134,16 +134,15 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
 
 static void mnt_ns_release(struct mnt_namespace *ns)
 {
-	if (IS_ERR_OR_NULL(ns))
-		return;
 	/* keep alive for {list,stat}mount() */
-	if (refcount_dec_and_test(&ns->passive)) {
+	if (ns && refcount_dec_and_test(&ns->passive)) {
 		fsnotify_mntns_delete(ns);
 		put_user_ns(ns->user_ns);
 		kfree(ns);
 	}
 }
-DEFINE_FREE(mnt_ns_release, struct mnt_namespace *, if (_T) mnt_ns_release(_T))
+DEFINE_FREE(mnt_ns_release, struct mnt_namespace *,
+	    if (!IS_ERR(_T)) mnt_ns_release(_T))
 
 static void mnt_ns_release_rcu(struct rcu_head *rcu)
 {
@@ -5750,10 +5749,7 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 
 	if (kreq->mnt_ns_id) {
 		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
-		return mnt_ns ? : ERR_PTR(-ENOENT);
-	}
-
-	if (kreq->spare) {
+	} else if (kreq->spare) {
 		struct ns_common *ns;
 
 		CLASS(fd, f)(kreq->spare);
@@ -5771,6 +5767,8 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
 	} else {
 		mnt_ns = current->nsproxy->mnt_ns;
 	}
+	if (!mnt_ns)
+		return ERR_PTR(-ENOENT);
 
 	refcount_inc(&mnt_ns->passive);
 	return mnt_ns;

>  fs/namespace.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..9124465dca55 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -144,8 +144,10 @@ static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
>  
>  static void mnt_ns_release(struct mnt_namespace *ns)
>  {
> +	if (IS_ERR_OR_NULL(ns))
> +		return;
>  	/* keep alive for {list,stat}mount() */
> -	if (ns && refcount_dec_and_test(&ns->passive)) {
> +	if (refcount_dec_and_test(&ns->passive)) {
>  		fsnotify_mntns_delete(ns);
>  		put_user_ns(ns->user_ns);
>  		kfree(ns);
> @@ -5756,8 +5758,10 @@ static struct mnt_namespace *grab_requested_mnt_ns(const struct mnt_id_req *kreq
>  	if (kreq->mnt_ns_id && kreq->spare)
>  		return ERR_PTR(-EINVAL);
>  
> -	if (kreq->mnt_ns_id)
> -		return lookup_mnt_ns(kreq->mnt_ns_id);
> +	if (kreq->mnt_ns_id) {
> +		mnt_ns = lookup_mnt_ns(kreq->mnt_ns_id);
> +		return mnt_ns ? : ERR_PTR(-ENOENT);
> +	}
>  
>  	if (kreq->spare) {
>  		struct ns_common *ns;
> @@ -5801,8 +5805,8 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
>  		return ret;
>  
>  	ns = grab_requested_mnt_ns(&kreq);
> -	if (!ns)
> -		return -ENOENT;
> +	if (IS_ERR(ns))
> +		return PTR_ERR(ns);
>  
>  	if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
>  	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
> @@ -5912,8 +5916,8 @@ static void __free_klistmount_free(const struct klistmount *kls)
>  static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *kreq,
>  				     size_t nr_mnt_ids)
>  {
> -
>  	u64 last_mnt_id = kreq->param;
> +	struct mnt_namespace *ns;
>  
>  	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
>  	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
> @@ -5927,9 +5931,10 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
>  	if (!kls->kmnt_ids)
>  		return -ENOMEM;
>  
> -	kls->ns = grab_requested_mnt_ns(kreq);
> -	if (!kls->ns)
> -		return -ENOENT;
> +	ns = grab_requested_mnt_ns(kreq);
> +	if (IS_ERR(ns))
> +		return PTR_ERR(ns);
> +	kls->ns = ns;
>  
>  	kls->mnt_parent_id = kreq->mnt_id;
>  	return 0;
> -- 
> 2.51.2.1041.gc1ab5b90ca-goog
> 

