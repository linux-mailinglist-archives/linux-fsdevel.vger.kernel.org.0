Return-Path: <linux-fsdevel+bounces-75362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGl/CUoddWn4AwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:28:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98A7EB7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E22C301369C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6338A263899;
	Sat, 24 Jan 2026 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m58yS5I/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE11459FA;
	Sat, 24 Jan 2026 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769282870; cv=none; b=WB0KDUyMTIY5T08qw3FNMEA0L85OO+8gdjnuJrk0ePJIB1pAOIRRWEKazCCkSJCZ0uvSp6JQO6hA3vB/6/yR62heeaV4wek58vAbikKra4i9Dqgh86qoPfUquy7zwIHzfRd3TYWMEcI+EMQvcHUgBImYnCGQRmGNnI+3wNvMYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769282870; c=relaxed/simple;
	bh=RdIXVmuy0+sUc+oiYy7nGjj6fzI+3doQt0//05fe6og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HunC5YB2t8lYxSXWRqfCz0Sm7W7oxh/9WMpBIGJtbedt/uo/0or/o697gASmR05bVdkbumzwNntDi543unK/9uEdc/g9HS3OiBvgixi500PxgRawFrkbuWRwZFf4z55nNrsTwgail+d/BRsjGIj9BhfIOQwHyiDXY9E3pTeS9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m58yS5I/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C388EC116D0;
	Sat, 24 Jan 2026 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769282869;
	bh=RdIXVmuy0+sUc+oiYy7nGjj6fzI+3doQt0//05fe6og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m58yS5I/FsYNDuCUdf/CVJWOCrf/ECQJKFl6+HVgPgXpfRaLo7hRsFp37W93KosZ3
	 T6Ujgb3T8kfp2+V1SblRGUPrZpo5zIJWX3pCcquT43IEjEX1hPEdaoPJCzUWMzabph
	 oPW+I+Lhj0R68TAGsuZbrq3UD3431Xfhz1vW9Di5fg0Q/7HBEJNE1wDDr5xYx1CcPt
	 fBGWoUwW7vhZ5XOc4i55DZOGwCij0vlUzuqQNj7OUrRQjfOmzawSgDvvZPQWRyDpBC
	 dGJPUqNOBZtQOAJWx5yStfK5HdNU9w06H4da2abtWDOGery5FdSafrWiI3Mnz2skss
	 Eqr6lSRfPLjBA==
Date: Sat, 24 Jan 2026 11:27:47 -0800
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
Subject: Re: [PATCH 04/11] fsverity: start consolidating pagecache code
Message-ID: <20260124192747.GD2762@quark>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-5-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75362-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7B98A7EB7E
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:22:00AM +0100, Christoph Hellwig wrote:
>  fs/ext4/verity.c         | 17 +----------------
>  fs/f2fs/verity.c         | 17 +----------------
>  fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/fsverity.h |  3 +++
>  4 files changed, 43 insertions(+), 32 deletions(-)

This creates a bisection hazard: the new file fs/verity/pagecache.c
isn't added to fs/verity/Makefile until the next commit.

- Eric

