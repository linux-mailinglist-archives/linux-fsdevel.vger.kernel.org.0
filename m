Return-Path: <linux-fsdevel+bounces-75691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICKPGoaFeWnGxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:41:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED59CCFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29EB3013D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC532F75F;
	Wed, 28 Jan 2026 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbwCTTNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CF309F04;
	Wed, 28 Jan 2026 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571695; cv=none; b=JbLXaXP4/+/BzZZY+YdbU9rCIMz9heiBfYIifl+9vEReV1biQF8DjvGcOQvdX3i1o1jZMFmRvXsd4cd1MHE28NDEMqhYwKHZqDO5FM0Nrq8s+580tGtQyyyBNM4R5wxdeVuiT4pTyIcpCK4Zx7o3gHd1uXhUsWUgNFJ9cFXQTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571695; c=relaxed/simple;
	bh=34CW2N/dMbkFR7cyXaksGnhaLHYhfifPNLB5pSoQWJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeEDlBhdUScL4t3ceZEehtcVGuV//E8oEJ7jyYNCCHdVHr6ld7nJGcWOdBqxt0ShR9ifDrmgswM8fAminjTQsqpBeIp+T6SyQZEThs+Phwef4UGdufFkCUuSQyRngGlo18B6TjulzDE7UEhEOeSzJYuXrHzJui0fveLi5zN8I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbwCTTNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AE0C4CEF1;
	Wed, 28 Jan 2026 03:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769571695;
	bh=34CW2N/dMbkFR7cyXaksGnhaLHYhfifPNLB5pSoQWJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbwCTTNNtA2TKf57Dcgd/gAlPCfwSPJkzXB3I0ZjyGqro2OC4619YEMvb7YfHTNfM
	 jbbinV6fx+3o6stxCiyTbER6NlHiabXHM2N0tJsuZYdqiA53a1y3FENrQCJUGd/QWZ
	 KJ89SaP7IBuIx1QeDPYdGy+5fanThEWZyeXhXMIviAkumfjCalzL7OWk8+Kq7nV7k8
	 dMWmiOE1p5dO7wppx7RgSc1wDvLCR19Nt3jBuW3KtXQCkh4VYhPb5OKtosUKtClEpu
	 69vfH/WpL7e3WbzfuH7+Px8no6l4ad0AwmMuuYOe7xaD+Z8U7wSiaMdfA+BI+uODz7
	 vqATPSgpMFC4Q==
Date: Tue, 27 Jan 2026 19:41:02 -0800
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
Message-ID: <20260128034102.GC2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-10-hch@lst.de>
 <20260128032203.GA2718@sol>
 <20260128033242.GA30830@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128033242.GA30830@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75691-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: B2ED59CCFA
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:32:42AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 27, 2026 at 07:22:03PM -0800, Eric Biggers wrote:
> > On Mon, Jan 26, 2026 at 05:50:55AM +0100, Christoph Hellwig wrote:
> > > struct fsverity_info contains information that is only read in the
> > > verification path.  Apply the const qualifier to match various explicitly
> > > passed arguments.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/verity/verify.c | 15 ++++++++-------
> > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > Did you consider that fsverity_info::hash_block_verified is written to?
> > It's a pointer to an array, so the 'const' doesn't apply to its
> > contents.  But logically it's still part of the fsverity information.
> 
> Well, it doesn't apply by the type rules.  But if you don't like the
> const here just let me know and I'll drop it.

It just seems that the motivation is a bit weak.  It works only because
hash_block_verified happens to be a dynamic array, and also because the
spinlock that used to be there got removed.  And the very next patch
removes const from the inode, so it kind of feels like we're going in
two different directions.  Maybe just drop this patch for now?

- Eric

