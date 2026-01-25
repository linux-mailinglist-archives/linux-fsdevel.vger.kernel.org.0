Return-Path: <linux-fsdevel+bounces-75375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPSZB4NydWkIFQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 02:31:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F197F6C8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 02:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A4D5300CC90
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E621B4244;
	Sun, 25 Jan 2026 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKsh/FlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E73A937;
	Sun, 25 Jan 2026 01:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769304696; cv=none; b=fDXYmq6KGCp1DAR7/LPW2MADaQobcwop+1TlPj1LgFaI1kQ9OtTfhP146gyQRSptAKZUH14yg9npaaj3dygGuCqBgA2bwKV9yIt5QSQwdkhkLrVQoNXWLpQBEAxTXGWqc0OHN+LhYli8r3ibKSCWr5wMulZraBBhaBXEFwMsPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769304696; c=relaxed/simple;
	bh=3iMKlt4ekuSyqFUkFLSPSHU1p/JvwSOUPzMPH5DNdH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAVF4FJFRLqfaaWaflZHQar0Oz+saI/Y5e6UKIH2+gAF5BEOCY2yrRZx6oF83xMscQyUXt0uApFbk2mFOGHTL0uDIzqSN/HhKuseIVoZr/byjIBNdezpLIBVO++HYM0mcXfcg6sgto81ilp7pD1lLLHApfOQgqWtaA7HZphpvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKsh/FlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90025C116D0;
	Sun, 25 Jan 2026 01:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769304696;
	bh=3iMKlt4ekuSyqFUkFLSPSHU1p/JvwSOUPzMPH5DNdH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKsh/FlR6k8/j7LqfmKgDMZe6pyDi94yewRpX63qWUZ405K9Y1iXqRMDhCmaI8JNW
	 hHjTClwIXwbDp8z4r1k1uHw6sTpY0oCeLQkgN9JucQDykp8xJ8SkgkW4aFuyzez/bF
	 pHA6UOYHAzwE30ttiS5Vl0xr8iadmRDtFaXm3KYpl9k5aL28HRSjC1cmnwx4rLC3lE
	 DDio4J9GWT7QVSVP6TFCuJKwp9PT+VdFLaqngoQE5yTZ9H3B+kq20Q9W1NCt+NIj0l
	 H6cDKFS22aVMpnT3yn0/wHjPrsRpwn1FMXp2UxJC9HOES4E3sLH87EP9i4Ywpe2Ach
	 wSECnCY11if1Q==
Date: Sat, 24 Jan 2026 17:31:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260125013104.GA2255@sol>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-12-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75375-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2F197F6C8
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:07AM +0100, Christoph Hellwig wrote:
> +int fsverity_set_info(struct fsverity_info *vi)
>  {
> -	/*
> -	 * Multiple tasks may race to set the inode's verity info pointer, so
> -	 * use cmpxchg_release().  This pairs with the smp_load_acquire() in
> -	 * fsverity_get_info().  I.e., publish the pointer with a RELEASE
> -	 * barrier so that other tasks can ACQUIRE it.
> -	 */
> -	if (cmpxchg_release(fsverity_info_addr(inode), NULL, vi) != NULL) {
> -		/* Lost the race, so free the verity info we allocated. */
> -		fsverity_free_info(vi);
> -		/*
> -		 * Afterwards, the caller may access the inode's verity info
> -		 * directly, so make sure to ACQUIRE the winning verity info.
> -		 */
> -		(void)fsverity_get_info(inode);
> -	}
> +	return rhashtable_lookup_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
>  }
>  
> -void fsverity_free_info(struct fsverity_info *vi)
> +struct fsverity_info *__fsverity_get_info(const struct inode *inode)
>  {
> -	if (!vi)
> -		return;
> -	kfree(vi->tree_params.hashstate);
> -	kvfree(vi->hash_block_verified);
> -	kmem_cache_free(fsverity_info_cachep, vi);
> +	return rhashtable_lookup_fast(&fsverity_info_hash, &inode,
> +			fsverity_info_hash_params);
[...]
> +	/*
> +	 * Multiple tasks may race to set the inode's verity info, in which case
> +	 * we might find an existing fsverity_info in the hash table.
> +	 */
> +	found = rhashtable_lookup_get_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
> +	if (found) {
> +		fsverity_free_info(vi);
> +		if (IS_ERR(found))
> +			err = PTR_ERR(found);
> +	}

Is there any explanation for why it's safe to use the *_fast variants of
these functions?

>   * fsverity_active() - do reads from the inode need to go through fs-verity?
>   * @inode: inode to check
>   *
> - * This checks whether the inode's verity info has been set.
> - *
> - * Filesystems call this from ->readahead() to check whether the pages need to
> - * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
> - * a race condition where the file is being read concurrently with
> - * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
> + * This checks whether the inode's verity info has been set, and reads need
> + * to verify the verity information.
>   *
>   * Return: true if reads need to go through fs-verity, otherwise false
>   */
>  static inline bool fsverity_active(const struct inode *inode)
>  {
> -	return fsverity_get_info(inode) != NULL;
> +	/*
> +	 * The memory barrier pairs with the try_cmpxchg in set_mask_bits used
> +	 * to set the S_VERITY bit in i_flags.
> +	 */
> +	smp_mb();
> +	return IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode);
> +}

This looks incorrect.  The memory barrier is needed after reading the
flag, not before.  (See how smp_load_acquire() works.)

Also, it's needed only for verity inodes.

Maybe do:

	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
		/*
                 * This pairs with the try_cmpxchg in set_mask_bits()
                 * used to set the S_VERITY bit in i_flags.
		 */
		smp_mb();
		return true;
	}
	return false;

- Eric

