Return-Path: <linux-fsdevel+bounces-75685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eALqCeuBeWmexQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:26:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A8D9CA61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E33302769C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2E32E721;
	Wed, 28 Jan 2026 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVoeY+wZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DC54763;
	Wed, 28 Jan 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769570557; cv=none; b=PtSZwNw6I75D/8EPC46lDY11b6MAjH3j0ip3yxgMZ2oUyTeW9sgnkLn0Z3cS1PttQUuhn3AXY3kpc3WMMguHZuBTfauqy09bKXgHNMnJ6QmMMT1cRuW8JOlchID8HALgxL06BMSCvACjdjiAdpsbMzY59bv5PvOgpCcQJ0TyXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769570557; c=relaxed/simple;
	bh=hO7Dvp+n2fT8USiyWHCLLJZmQ5uqUDuWImmkAnQEdLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOGP/ROkeKPmONFfdf3Yguv0XIOZi1slD8GtKlKjEaogDawS6SqRWSBgsM/8vT8G8xEq3fFF+6JHpHHvbTdw07mcTHSS46Z7jUwkzY2FMX3hbjyjqNN5GyrJvd3TI/YEcRubjfvAKtudjf0l8DjPcB4AgTuk7WBSxMVYSdJBlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVoeY+wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E8C4CEF1;
	Wed, 28 Jan 2026 03:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769570556;
	bh=hO7Dvp+n2fT8USiyWHCLLJZmQ5uqUDuWImmkAnQEdLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVoeY+wZx5buXBTIHSfGxUGQ57DrOaBRKk5U5A/3h9N3bozABH3DFmg7tGDTgOWXw
	 8pOK+jle1pHoNNdSngnSz79EnorWBVoK6MUWSACqVy6ko4d52R0r+wZV7trXYk6oGr
	 0tCJEH+MjaMQfWnMRpkSDQs5UBbaCv7/TXS1i9GYb4dVjHBTEAT7aHvgVCbaikQibv
	 rbWHYIIBbH1JSEqLPkGm9OzuvkCKXHUmqSWwyY7bTLmDhrYTHiTNqyA6bU5sfS2NlY
	 fB0DubjlJnjMafKhG51XCPpwFeVgmjXE8o8FQ03pRK/N+dEF22Vk5OOrn/DLTUWHuj
	 bVPe2pm4VAhKw==
Date: Tue, 27 Jan 2026 19:22:03 -0800
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
Subject: Re: [PATCH 09/16] fsverity: constify the vi pointer in
 fsverity_verification_context
Message-ID: <20260128032203.GA2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-10-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75685-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75A8D9CA61
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> struct fsverity_info contains information that is only read in the
> verification path.  Apply the const qualifier to match various explicitly
> passed arguments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/verity/verify.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Did you consider that fsverity_info::hash_block_verified is written to?
It's a pointer to an array, so the 'const' doesn't apply to its
contents.  But logically it's still part of the fsverity information.

- Eric

