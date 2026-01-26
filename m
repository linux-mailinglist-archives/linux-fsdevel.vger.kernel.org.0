Return-Path: <linux-fsdevel+bounces-75533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKoYHrnRd2mFlwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:42:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 172758D341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5857230209E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B092D7D27;
	Mon, 26 Jan 2026 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvCXJa1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AF2D6E7C;
	Mon, 26 Jan 2026 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460033; cv=none; b=eHlVVZUyBNEYLbdUTz983tvzZWc290YCPcByqsZXjPoPvj1tK4YbHIny1nlGz5F3bALxm3iVAVID2nWc4p/TIJAenypqq7O+gQdOhzZOZ54Pe/BLF3Vecp1DID0sd8GpcXT7xJP0GZTej8L7TMimSt8WC8gTbNZKx7I3SaBetMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460033; c=relaxed/simple;
	bh=l9LtVaA6nSgchLlbWTin67CmDN89iXVzMWWCdcxjYtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhXuV9BqAi4Twdw1aSxjNFzICVf0DpiXw53XglfKXGfz80iG04z8sWInwWqmAKca/UNrbW3QedfL4F3kNantlf5E3GOZPYDukV8MRzio/Lr3xl1/oDfG7lw9G5m+R2pq+6qNyv2lLJHUTVrt/QDpTDRZ/VwyNz8CRs95UJp7bOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvCXJa1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EF5C19425;
	Mon, 26 Jan 2026 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460033;
	bh=l9LtVaA6nSgchLlbWTin67CmDN89iXVzMWWCdcxjYtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvCXJa1wvGHyoJV9yOd66dqhtlHhRupqhUfh5O2T0Ya8SFJbAMSYNmVfKko3GIlzu
	 GZ4v7xk90vOaiMqntDQZxal2LJHyMdqlrfA2VrpO1g1ONf3CaidthkaAO/8WSMijUC
	 nRhLsxhFiOQKBR46zuWB+3wSNaEv0N1t9HVvogXMcgvEXPJsyzsH3D7nLjEGus2NDu
	 BtuiviqxabzsOo6QlqNqbiaPJMyPcakCnf391arUowfEXOpSoV5GY9Xab/cmuxIRhp
	 MtOqb7XafJGEURKGFxcUFt7JsLfBHierdMIOntMx4UUkCnLxHWHNc05ScL7mmULr5F
	 7Ls1cBic34NrA==
Date: Mon, 26 Jan 2026 12:40:30 -0800
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
Message-ID: <20260126204030.GC30838@quark>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75533-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 172758D341
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> The file open path uses rhashtable_lookup_get_insert_fast,
> which can either find an existing object for the hash key or insert a
> new one in a single atomic operation, so that concurrent opens never
> allocate duplicate fsverity_info structure.

They still do, though.  But that's unchanged from before.
ensure_verity_info() frees the one it allocated if it finds that one got
set concurrently.

> Because insertion into the hash table now happens before S_VERITY is set,
> fsverity just becomes a barrier and a flag check and doesn't have to look
> up the fsverity_info at all, so there is only a single lookup per
> ->read_folio or ->readahead invocation.  For btrfs there is an additional
> one for each bio completion, while for ext4 and f2fs the fsverity_info
> is stored in the per-I/O context and reused for the completion workqueue.

btrfs actually still looks up the verity info once per folio.  See:

    btrfs_readahead()
        -> btrfs_do_readpage()
            -> fsverity_get_info()

- Eric

