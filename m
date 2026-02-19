Return-Path: <linux-fsdevel+bounces-77659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCPYJlJ5lmkwgAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 03:45:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA115BC5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 03:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 853A3300B195
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 02:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAC023BD1D;
	Thu, 19 Feb 2026 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGWQ1qpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3A1C84C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771469136; cv=none; b=ZnGa4Iaku6X7NbIWNoDHU5ikSzYZtEE25Yyojz/ftVYgWfE0w9AUH6QT4kzyTqyuyl2iGhE8X/+SMbAVdaMYr5i5nsTtea1rSSE9frgsMUuisbOXubflsPoG2gkGhuB57XjBh8z/wHPa/klVhfKLEFrWFWrx2ShyHN2uoF8Wsqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771469136; c=relaxed/simple;
	bh=RWB+AmFYGa5+tlLvfcDRbiIVnO8CuPkRE8vJDWRT6eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hm7oSXwPKrz0nzHb9+dJah8yJKLb/88ats7UnrCYq5PSYxpnKxpFDwJGNOxUVr1AXKiDjid/YNJhWy9HQIAtKdW6aHvKUHXIMIhgUb1rbbNVajhZpwJJd+UX0UsdbW99tQmPBBitE2GP2hvjLE8vdNd7346QPtmzWxCvt0vwhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGWQ1qpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE1AC116D0;
	Thu, 19 Feb 2026 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771469135;
	bh=RWB+AmFYGa5+tlLvfcDRbiIVnO8CuPkRE8vJDWRT6eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGWQ1qpzt3uqyfT2H//NdsVacTj3gICgvVh1qw5SGQqWHsc2DZKLK7jdohuRTQ0AB
	 v2IewAqBHuVASNwFFYG7VsM88+x9G3B9PzcNNvgne/c4zsX0UQDIecVcnwMMXCci7n
	 csqR1qXGcj3bE1f+ixFNCGZzhdGfsPsSXqGVi6GL9PExTIlIge0rk2ycJzjX1eJMn0
	 HIF/8bWwKKuNMG2jZcDQIKXhglLKtAIRnuqzfsD461qTHxS4HPY6GjJzMzbofYqUpr
	 FzYXmryOF0OUIA7DPlvq+udRn2RPxKU7yY6VjikDxmKJ5I25iK64knf5DHYnw8gWVB
	 AHV6OZosEbvrA==
Date: Wed, 18 Feb 2026 18:45:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, wegao@suse.com,
	sashal@kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <20260219024534.GN6467@frogsfrogsfrogs>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219003911.344478-2-joannelkoong@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77659-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 41AA115BC5A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:39:11PM -0800, Joanne Koong wrote:
> If a folio has ifs metadata attached to it and the folio is partially
> read in through an async IO helper with the rest of it then being read
> in through post-EOF zeroing or as inline data, and the helper
> successfully finishes the read first, then post-EOF zeroing / reading
> inline will mark the folio as uptodate in iomap_set_range_uptodate().
> 
> This is a problem because when the read completion path later calls
> iomap_read_end(), it will call folio_end_read(), which sets the uptodate
> bit using XOR semantics. Calling folio_end_read() on a folio that was
> already marked uptodate clears the uptodate bit.

Aha, I wondered if that xor thing was going to come back to bite us.

> Fix this by not marking the folio as uptodate if the read IO has bytes
> pending. The folio uptodate state will be set in the read completion
> path through iomap_end_read() -> folio_end_read().
> 
> Reported-by: Wei Gao <wegao@suse.com>
> Suggested-by: Sasha Levin <sashal@kernel.org>
> Tested-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: b2f35ac4146d ("iomap: add caller-provided callbacks for read and readahead")

I would add:

Link: https://lore.kernel.org/linux-fsdevel/aYbmy8JdgXwsGaPP@autotest-wegao.qe.prg2.suse.org/
Cc: <stable@vger.kernel.org> # v6.19

since the recent discussion around this was sort of buried in a
different thread, and the original patch is now in a released kernel.

> ---
>  fs/iomap/buffered-io.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 58887513b894..4fc5ce963feb 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -80,18 +80,27 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	unsigned long flags;
> -	bool uptodate = true;
> +	bool mark_uptodate = true;
>  
>  	if (folio_test_uptodate(folio))
>  		return;
>  
>  	if (ifs) {
>  		spin_lock_irqsave(&ifs->state_lock, flags);
> -		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
> +		/*
> +		 * If a read with bytes pending is in progress, we must not call
> +		 * folio_mark_uptodate(). The read completion path
> +		 * (iomap_read_end()) will call folio_end_read(), which uses XOR
> +		 * semantics to set the uptodate bit. If we set it here, the XOR
> +		 * in folio_end_read() will clear it, leaving the folio not
> +		 * uptodate.

Yeah, that makes sense.  How difficult is this to write up as an fstest?

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +		 */
> +		mark_uptodate = ifs_set_range_uptodate(folio, ifs, off, len) &&
> +				!ifs->read_bytes_pending;
>  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>  	}
>  
> -	if (uptodate)
> +	if (mark_uptodate)
>  		folio_mark_uptodate(folio);
>  }
>  
> -- 
> 2.47.3
> 
> 

