Return-Path: <linux-fsdevel+bounces-77233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKEBJhfukGltdwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:50:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F118213DAB5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0292A3011F3C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC531064A;
	Sat, 14 Feb 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIxIqnhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6430F931;
	Sat, 14 Feb 2026 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771105811; cv=none; b=I0eG5Q8zCuEfY9nJbSW2yEBj3qWa025BE87KnX7IDr470DtW+SZVciEW50pr44Sgn4ai4bwmu4KdVViGydf3N2lXXVREjBIMRWmJ+pDCCj+76x+23HzGFePEGdRPJal3h8TY/5j/93LQuJAc0cOqBJXj21MqWOkWndcUL6P/8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771105811; c=relaxed/simple;
	bh=ByCxnIXhkyF8adSYpVRD9YFch315vVu5Im4dAbrrJq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTeDkURMTE4c+rCEQnXmXn/K1T31kCqn+cppOFljZcK7eU+lTB7jSLR0K3YuUHDNOhlkVgc/TC9BupipMuTSyv6BW1af3SwDOcYpJ0HuiDfJMSols5n2wfDcDWdtQimZZSz+i+1UdlsabL1uPw1K52NcChpYc3gVf2ld4fcwQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIxIqnhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE25C16AAE;
	Sat, 14 Feb 2026 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771105810;
	bh=ByCxnIXhkyF8adSYpVRD9YFch315vVu5Im4dAbrrJq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIxIqnhKAaO+g3BCIpmUeJYgBci67fffn8afyPqxaFJcFDVB+H/Igiut73MylpdPa
	 OdF5P9lvsZEEqUV54RLP+4xaSRrm4Qqf2B/HDAAcIKnDgEdC6HT7zLy7xMQLnHwqiR
	 Y4Yk0jU+oF8LV6BLWOjtZfIOd4b6nLvYvuJiLOViHYgxWP3NvUFYHl6N7Dt7Ilpcfc
	 ORAFgQwAB85553FBC0r2SQ40d3nWnW83pxKt09dx8FMbYYWUhKALJqFLGne8lTEEC5
	 O/stAdrOWq2DVDmq4gNbxNITFDStIlQcFbz89v601w0jjpxidKR2aexfiHooD7ifXu
	 Pyeb7rj8Lk4UQ==
Date: Sat, 14 Feb 2026 13:50:08 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs: use fsverity_verify_blocks() instead of
 fsverity_verify_page()
Message-ID: <20260214215008.GA15997@quark>
References: <20260214211830.15437-1-ebiggers@kernel.org>
 <20260214211830.15437-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214211830.15437-2-ebiggers@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77233-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: F118213DAB5
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 01:18:29PM -0800, Eric Biggers wrote:
> Replace the only remaining caller of fsverity_verify_page() with a
> direct call to fsverity_verify_blocks().  This will allow
> fsverity_verify_page() to be removed.
> 
> Make it large-folio-aware by using the page's offset in the folio
> instead of 0, though the rest of f2fs_verify_cluster() and f2fs
> decompression as a whole still assumes small folios.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/f2fs/compress.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 006a80acd1de..11c4de515f98 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1811,15 +1811,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
>  	int i;
>  
>  	/* Verify, update, and unlock the decompressed pages. */
>  	for (i = 0; i < dic->cluster_size; i++) {
>  		struct page *rpage = dic->rpages[i];
> +		struct folio *rfolio;
> +		size_t offset;
>  
>  		if (!rpage)
>  			continue;
> +		rfolio = page_folio(rpage);
> +		offset = folio_page_idx(rfolio, rpage) * PAGE_SIZE;
>  
> -		if (fsverity_verify_page(dic->vi, rpage))
> +		if (fsverity_verify_blocks(dic->vi, rfolio, PAGE_SIZE, offset))
>  			SetPageUptodate(rpage);
>  		else
>  			ClearPageUptodate(rpage);
>  		unlock_page(rpage);

Let me know if you'd prefer that we verified the whole folio here
instead.  Either way, the behavior will be still incorrect if this
function is passed a large folio (which it's not).  Either we'd mark the
whole folio up-to-date after verifying only one page in it, or we'd
access pages that were not in the array of pages passed to the function.

- Eric

