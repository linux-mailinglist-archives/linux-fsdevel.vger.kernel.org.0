Return-Path: <linux-fsdevel+bounces-79114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGGgMMVspmnMPgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:08:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DB91E91EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 06:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7445D3012814
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 05:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B82F90E0;
	Tue,  3 Mar 2026 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdQvKpp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F7201278;
	Tue,  3 Mar 2026 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514460; cv=none; b=Q7QUtAGrmgc10vyp7ljvip8UopkSGIYKoBjmc/Y+h9fS/ERGlwqDedcLnSkK7r1Eu3hSM1hZSR6x23eva1RpUNs+olPmt7ny+2dO6qS726rZBTWmQYCSwaCR7qH95ynEDdqLb8/xcBUpaWZ5CgmCVgA26Kxe9/9GT7KOGR9tKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514460; c=relaxed/simple;
	bh=1+kKr9w9x1B4o6FcZ1XAvN36pB8iYMy5wzHr3wwx+6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjLg6iKyXOkPIoDlIUBa5kvG4S3pagF8RGrlxy5V4hYAILBRyJf/eRW3ntZkMQuSoB/VXUQr02msJDeZvdH7lj+orrFqRKBxPjZEZfEczvGbZduYU/6RrbbJhlekZm+A28snzOEQcflqn5z9Dy+htfvsYU6WmBTU2oi/yOC/IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdQvKpp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9718C116C6;
	Tue,  3 Mar 2026 05:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772514459;
	bh=1+kKr9w9x1B4o6FcZ1XAvN36pB8iYMy5wzHr3wwx+6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdQvKpp2K/r35zCm0W6gRUwl4ZY8UaHyBvOYJzXsf+L4J1r9LKC9hjhf65BPuwGyT
	 yFqYzMK3vuokKly0l+YjMr6k9NLrJqehKXW6ixHMLnjx0Td9v48Id/KH88HW2Qr3dX
	 gZJiIgJImQMR05aCpC/CSHA9uu2aW7xULTrYcoYfdKxDvrf0C89CM68j5f0Y2NBExz
	 YAyM1VTwIUq9LfTSzFFm5csRWadKv1uqGQCDYG9T6IexWwAWJsxzPcOxhHI3l4l40n
	 NJWMj2kZ6/NzBXgrX4gJu32wP6r0+aZ9FdYIT+GQetCDHQeo09ckyuhro60zCH/OPH
	 AjlXlLdik735A==
Date: Mon, 2 Mar 2026 21:06:44 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fsverity: add dependency on 64K or smaller pages
Message-ID: <20260303050644.GC5238@sol>
References: <20260221204525.30426-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221204525.30426-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: B6DB91E91EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79114-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 12:45:25PM -0800, Eric Biggers wrote:
> Currently, all filesystems that support fsverity (ext4, f2fs, and btrfs)
> cache the Merkle tree in the pagecache at a 64K aligned offset after the
> end of the file data.  This offset needs to be a multiple of the page
> size, which is guaranteed only when the page size is 64K or smaller.
> 
> 64K was chosen to be the "largest reasonable page size".  But it isn't
> the largest *possible* page size: the hexagon and powerpc ports of Linux
> support 256K pages, though that configuration is rarely used.
> 
> For now, just disable support for FS_VERITY in these odd configurations
> to ensure it isn't used in cases where it would have incorrect behavior.
> 
> Fixes: 671e67b47e9f ("fs-verity: add Kconfig and the helper functions for hashing")
> Reported-by: Christoph Hellwig <hch@lst.de>
> Closes: https://lore.kernel.org/r/20260119063349.GA643@lst.de
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/verity/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

- Eric

