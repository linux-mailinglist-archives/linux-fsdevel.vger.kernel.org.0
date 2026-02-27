Return-Path: <linux-fsdevel+bounces-78765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEzlFv/qoWkdxQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:05:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B01BC674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8155F31A1347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3583AA1A2;
	Fri, 27 Feb 2026 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf9L4gxR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6638F23B;
	Fri, 27 Feb 2026 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218907; cv=none; b=OB4Auk2AfE27/aAwPW/X10mtQa4o47Rav6TrNohGl6zIE9Bav9NQl3GUMj6qLlcm3jsSeW5ZQHq3qGY7bu2Qa1xup1Z6iw2FgOK30nvtdGMyhfDh6lOaNjW0TEcpR0I72diyFCb+CO2vVHf/hBOvnudwH69B4LPUVQ3CdQeHbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218907; c=relaxed/simple;
	bh=Z2SWO1TAj985JhBm/iuzoCyBG8BEbF3c/5450vL9iY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8ov7orwLV3OhYq16naA8w3TGCks2Ecc/Qf0Mj9RVQ2J7TubkuXosPydvW2i7J/ZpsuVB5Wl3r1mfHADg4Xj1JVJzLGvo0vl7FqblQwBOh4W7jJnmMwLmtcWRU/DwaWp2jufST/I78X0ChR90rdrjKUTjsmts0xRDSD9RZm7Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf9L4gxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBB8C2BC87;
	Fri, 27 Feb 2026 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772218907;
	bh=Z2SWO1TAj985JhBm/iuzoCyBG8BEbF3c/5450vL9iY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nf9L4gxRiSYdvq9zQDDmNuyu74QzZZWCogBd54aV2haNjl+oK7Ecl9b+olkgxl4VV
	 T+PRXkbmNKyDBzFKkrsh8kD2xfLRilmpEycMneSKmgEW/4LWuvlnyndBQ37W9bSk1W
	 rV82V7yMBU/VvVarWBevC+KD7V6HKhL1VatPH1JtX7FlaJmiziSGYZ6XkxvNrFSbY7
	 l5xB9z0IPTaBydrVfRfHCMwxAX9xTb38vncvatD17EcQs7W7lm48cxZ7b0VKwqKQwy
	 rUWRiK3mEmTXsqDNoa/9Fxdu/99FzMsnfsGG9YwDXL8dvyqS+0t60lg+k1cdLH7NaF
	 KryMftqEmmA4A==
Date: Fri, 27 Feb 2026 20:01:42 +0100
From: Carlos Maiolino <cem@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2] iomap: reject delalloc mappings during writeback
Message-ID: <aaHp9DlrDEIXU5eo@nidhogg.toxiclabs.cc>
References: <20260226233442.GH13853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226233442.GH13853@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-78765-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nidhogg.toxiclabs.cc:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C71B01BC674
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 03:34:42PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Filesystems should never provide a delayed allocation mapping to
> writeback; they're supposed to allocate the space before replying.
> This can lead to weird IO errors and crashes in the block layer if the
> filesystem is being malicious, or if it hadn't set iomap->dev because
> it's a delalloc mapping.
> 
> Fix this by failing writeback on delalloc mappings.  Currently no
> filesystems actually misbehave in this manner, but we ought to be
> stricter about things like that.

Looks good.
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> 
> Cc: <stable@vger.kernel.org> # v5.5
> Fixes: 598ecfbaa742ac ("iomap: lift the xfs writeback code to iomap")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
> v2: futureproof new iomap types
> ---
>  fs/iomap/ioend.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
> index 4d1ef8a2cee90b..60546fa14dfe4d 100644
> --- a/fs/iomap/ioend.c
> +++ b/fs/iomap/ioend.c
> @@ -215,17 +215,18 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>  	WARN_ON_ONCE(!folio->private && map_len < dirty_len);
>  
>  	switch (wpc->iomap.type) {
> -	case IOMAP_INLINE:
> -		WARN_ON_ONCE(1);
> -		return -EIO;
> +	case IOMAP_UNWRITTEN:
> +		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
> +		break;
> +	case IOMAP_MAPPED:
> +		break;
>  	case IOMAP_HOLE:
>  		return map_len;
>  	default:
> -		break;
> +		WARN_ON_ONCE(1);
> +		return -EIO;
>  	}
>  
> -	if (wpc->iomap.type == IOMAP_UNWRITTEN)
> -		ioend_flags |= IOMAP_IOEND_UNWRITTEN;
>  	if (wpc->iomap.flags & IOMAP_F_SHARED)
>  		ioend_flags |= IOMAP_IOEND_SHARED;
>  	if (folio_test_dropbehind(folio))
> 

