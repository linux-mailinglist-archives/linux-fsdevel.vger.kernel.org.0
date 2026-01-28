Return-Path: <linux-fsdevel+bounces-75687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPVhNH2CeWmexQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:29:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39E9CAF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93AA23007AC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343D32E739;
	Wed, 28 Jan 2026 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsazHlGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A22BB13;
	Wed, 28 Jan 2026 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570930; cv=none; b=imki0B2jJrk206eauJ4orRcct2JSgEMImqSbCrG3a0jWtIRZiFMYHplSJs6v/0fhxQskXJ6K0B4B3O8Q464D7ZuepeAGh/nxZQx8oBel15GbgjAkxRfbHXIRbLjRVsTjT8W1BqNeGgHc3LYgOlXDjAam2i00f4yhr0QkIt1y4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570930; c=relaxed/simple;
	bh=M66VvmyKffB7Z0mgvoF1z/uND8SQzYs4dDIbYqFJeaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8X37zsBbfcj7E6ZIxAnzuPb9cJHSEHtfuDBWh5e6DDMTunywp8X4d6H72u6+8rDLh8ABSlICl7E6GDjMB2c/Lnxa7inRui8YJFi646dGWfrRd+PnIKfHknA8EqMdHhxh+PAzg4KZWNIn92z4pvVSEC7KtpYZ13X4PnY0uxt94c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsazHlGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E81C4CEF1;
	Wed, 28 Jan 2026 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769570930;
	bh=M66VvmyKffB7Z0mgvoF1z/uND8SQzYs4dDIbYqFJeaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsazHlGTI4JJelUSnWi1LzMyGszwGA9wTVyrjgSQpYx1q2Ekl5T9hLZT4mhuitl2N
	 Yia1KeKDb+mkwNd2bdvb0Q3tUbBJrq0x6xi74nf8m7kgpTv9c2umel5Paw3Uj+6DqJ
	 +zotcBTjbXQgYfzfmmeH7N0fULDmWZDA8rF6giYX6Wg8kc8I4K7221n6PAHR1TZ+v2
	 8AxChkyBMiAvAtZkrdPLwf4FuXafAMcuROFFuTIZe7ykfBSBdA5dJBd/ryAWl38det
	 1oA1z022UejlktPWncECiKhbfYMgIsJZLbdUfPK7KUNaQlIVAxXkl5ATvEVpi5gHc9
	 HwvfhJkcFhDvg==
Date: Tue, 27 Jan 2026 19:28:17 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260128032817.GB2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-17-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75687-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA39E9CAF2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> @@ -296,18 +243,39 @@ static inline bool fsverity_verify_page(struct fsverity_info *vi,
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

Nit: the point is to verify the file's data, not to verify "the verity
information".

>   *
>   * Return: true if reads need to go through fs-verity, otherwise false
>   */
> -static inline bool fsverity_active(const struct inode *inode)
> +static __always_inline bool fsverity_active(const struct inode *inode)
> +{
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> +		/*
> +		 * This pairs with the try_cmpxchg in set_mask_bits()
> +		 * used to set the S_VERITY bit in i_flags.
> +		 */
> +		smp_mb();
> +		return true;
> +	}
> +
> +	return false;
> +}

Is there a reason for this function in particular to be __always_inline?
fsverity_get_info() is just inline.

- Eric

