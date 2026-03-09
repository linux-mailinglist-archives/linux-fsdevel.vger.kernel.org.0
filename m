Return-Path: <linux-fsdevel+bounces-79819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9/GicEr2knLwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:32:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B10D23DA7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 18:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2CA8300AEEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC9C2D3750;
	Mon,  9 Mar 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLZNeytv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03321F181F;
	Mon,  9 Mar 2026 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077534; cv=none; b=HDS5SKZ5qUtEHIAwwrtEUQLp56zwFmDjYUa1TxjCeOgjjKQT5gQCjNVqolV4n/2dDdgkNmJec8pPBoFLaf3i4902H1Aj21t0ElEEYumWhalgoPdz2tS8D++PDZ2jWXOQj/BObyYGzSkxU506vWBRaiIeqxdbPS066KHM70uHUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077534; c=relaxed/simple;
	bh=mLWs1N/FOrRDInUz3HyuBDfXhEOENFzzrD+KBPIW4kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU6YfJ5B9Nh4LpkvcOmnmQ2SHDO1YE2wYI93rYCIfmx0aWHa2M17HSS71F3+EY1IISI/WAALaokSMd0wMdAbSrpz+X3nyClSVLo+TagBWu+4FhiQpLL7UGiH6ugV6NaALm4BbWykfYTHnqo9gRLFrcFQxxb5Kx0jLePrRHCLNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLZNeytv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D86C4CEF7;
	Mon,  9 Mar 2026 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773077534;
	bh=mLWs1N/FOrRDInUz3HyuBDfXhEOENFzzrD+KBPIW4kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLZNeytvAj0eS9Eu6Qj4XLjjSZRU7RYgTX7MnlQNZnKyTG7MrxpLqVuguLMRK5G7t
	 nJ3QzEstNXmNME75tP8GCR/0Vh05PO3x4GUDvKT0Imkd+fJoAJMEd+31rwstFEf1vh
	 H7mDDn74KqXoT2FPu3p7BPtJU4E8RjjnpyOPLAtOLlsg+Z6tTswOp3r+qGzGJCUBH+
	 ajWpooX21jn00B3chn9FD3osFIzU8x8mNOVXIzabIgwwJ6afWzcqQBaVcrVuDMyirO
	 qmubtsb/ZXg4butGHqxoPSp5M1V9gxMN6kBRtW9Xz5Hfmp22n5Y27/VEy1aQ444tyw
	 Kv6V2PF+lQP9Q==
Date: Mon, 9 Mar 2026 10:32:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 4/8] xfs: flush eof folio before insert range size
 update
Message-ID: <20260309173213.GN6033@frogsfrogsfrogs>
References: <20260309134506.167663-1-bfoster@redhat.com>
 <20260309134506.167663-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309134506.167663-5-bfoster@redhat.com>
X-Rspamd-Queue-Id: 2B10D23DA7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79819-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 09:45:02AM -0400, Brian Foster wrote:
> The flush in xfs_buffered_write_iomap_begin() for zero range over a
> data fork hole fronted by COW fork prealloc is primarily designed to
> provide correct zeroing behavior in particular pagecache conditions.
> As it turns out, this also partially masks some odd behavior in
> insert range (via zero range via setattr).
> 
> Insert range bumps i_size the length of the new range, flushes,
> unmaps pagecache and cancels COW prealloc, and then right shifts
> extents from the end of the file back to the target offset of the
> insert. Since the i_size update occurs before the pagecache flush,
> this creates a transient situation where writeback around EOF can
> behave differently.
> 
> This appears to be corner case situation, but if happens to be
> fronted by COW fork speculative preallocation and a large, dirty
> folio that contains at least one full COW block beyond EOF, the

How do we get a large dirty folio with at least one full cow block
beyond i_size?  If we did a pagecache write to the file, then at least
the incore isize should have been boosted out far enough that the block
will now be inside EOF, right?

--D

> writeback after i_size is bumped may remap that COW fork block into
> the data fork within EOF. The block is zeroed and then shifted back
> out to post-eof, but this is unexpected in that it leads to a
> written post-eof data fork block. This can cause a zero range
> warning on a subsequent size extension, because we should never find
> blocks that require physical zeroing beyond i_size.
> 
> To avoid this quirk, flush the EOF folio before the i_size update
> during insert range. The entire range will be flushed, unmapped and
> invalidated anyways, so this should be relatively unnoticeable.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_file.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 6246f34df9fd..48d812b99282 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1263,6 +1263,23 @@ xfs_falloc_insert_range(
>  	if (offset >= isize)
>  		return -EINVAL;
>  
> +	/*
> +	 * Let writeback clean up EOF folio state before we bump i_size. The
> +	 * insert flushes before it starts shifting and under certain
> +	 * circumstances we can write back blocks that should technically be
> +	 * considered post-eof (and thus should not be submitted for writeback).
> +	 *
> +	 * For example, a large, dirty folio that spans EOF and is backed by
> +	 * post-eof COW fork preallocation can cause block remap into the data
> +	 * fork. This shifts back out beyond EOF, but creates an expectedly
> +	 * written post-eof block. The insert is going to flush, unmap and
> +	 * cancel prealloc across this whole range, so flush EOF now before we
> +	 * bump i_size to provide consistent behavior.
> +	 */
> +	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
> +	if (error)
> +		return error;
> +
>  	error = xfs_falloc_setsize(file, isize + len);
>  	if (error)
>  		return error;
> -- 
> 2.52.0
> 
> 

