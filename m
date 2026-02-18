Return-Path: <linux-fsdevel+bounces-77644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLWKA6ZFlmmYdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:05:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA915AC74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 867EA301BA7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50833A6F9;
	Wed, 18 Feb 2026 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6+A3jbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB802F616B;
	Wed, 18 Feb 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455905; cv=none; b=aOdCo+g8rJQAOzSbwT/flWiT/kD5FpZKNlychUBNnGffP8+YKNWkv0g5oO0TwK+JD0ECT43ua7fbV341PPSH8eMkyHiUUvOL2ZkT2VEqwXX8ps07TdKVn34WWV6Fk4fY2rViRlrAVXLaRKn4HqN2qNZMMzekkHX2w1xXTb0hWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455905; c=relaxed/simple;
	bh=m0Ge09sJIPzxExUr5refscakKrrITkNwyVfeS2JWhXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKEqnqRrkvkGadbv+wxZZ/6srja80dktYOu5wQqfc6apsVSZyFw1j/wwDuXj1nLP0PV0M9vrguSPzSGXmhVw6DYvQY3YwIAPK4x1NzfXaZb+/eclqXJzmU9Zi7REzv/tn5wkMFEjOjJZbKM6+nJwoTpwYEk4V2sAPDdRDldxocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6+A3jbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA43FC116D0;
	Wed, 18 Feb 2026 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771455904;
	bh=m0Ge09sJIPzxExUr5refscakKrrITkNwyVfeS2JWhXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6+A3jbMjxE1FkuoJXtX6lkJ5bI19axbGH+t2WCl5FpaTRcdzzXPgPiwbM9PrPWtw
	 /8maKDauEt+20Yp4Ql8x1Ylkw8UOMuDregpljmx8drOQFin44E/foQUrdInoj4K4a4
	 neu/l3QihXseyCrkrUD1hUEyuMJZlpJLS3f2V5SzNhK8HVitWkvPnJhyhgUw4GFQua
	 /7gFGqO9zCh67kDN7hdi5CDONhlj8qtT3yTQSSrhnm2j+RLWNRP8PkUQbQCJJQ+sNX
	 I4CmCG464ET0R6piXNYf0ZM+0iW7A3CFtvvYzFa1hbJoED0hGcszGdHiVy34b2jlw9
	 spHuhPWvXnltQ==
Date: Wed, 18 Feb 2026 15:05:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 08/35] iomap: don't limit fsverity metadata by EOF in
 writeback
Message-ID: <20260218230504.GG6467@frogsfrogsfrogs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-9-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231937.1183679-9-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77644-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 76AA915AC74
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:19:08AM +0100, Andrey Albershteyn wrote:
> fsverity metadata is stored at the next folio after largest folio
> containing EOF.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

I think this should be in the previous patch since writeback is part of
pagecache writes.

Also, should there be a (debug) check somewhere that an IOMAP_F_FSVERITY
mapping gets mapped to a folio that's entirely above EOF?

--D

> ---
>  fs/iomap/buffered-io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4cf9d0991dc1..a95f87b4efe1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1817,7 +1817,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
>  
>  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> +	if (!(wpc->iomap.flags & IOMAP_F_FSVERITY) &&
> +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))
>  		return 0;
>  	WARN_ON_ONCE(end_pos <= pos);
>  
> -- 
> 2.51.2
> 
> 

