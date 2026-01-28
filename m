Return-Path: <linux-fsdevel+bounces-75816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ln1KmKKemkE7gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:14:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E03A971D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 23:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 389F4302E417
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1445343D76;
	Wed, 28 Jan 2026 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6V+2AmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7142DEA6B;
	Wed, 28 Jan 2026 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638486; cv=none; b=UMuZBDOdv+REMJSQj9YuAbGv17hD/HY/a8r6ODsiRTPslBH38tzBH8+B7vv/5CciGQBljMBxE1PK2kgsX0N1D3cm04VUeWnqPssoqlA4i3/T0NQiIMNkUS0EL57p6F66hWHyoBTdxmvUqLDxjo8m4K4tFSF++e4iSF0hyo/tU6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638486; c=relaxed/simple;
	bh=74NOxbKqGkEgjNrHB91dvQmAkyTNGiv+n72fcNGKqZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM61cXN3ODUQW8E9K145wq0OuNOHq7vVY4E24vt5WndDzDRLLDF0sltYq6PvpDrVvq+Jr8sBq8M3F5//ASlPHn9QteYb5LQAmNijkc15brYwYrll0vnQcgq2tpshmf1XqZlNSywlV1e6NUmx1Txcyd0NzZmmN7dGeCH/UfHi/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6V+2AmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF25C4CEF1;
	Wed, 28 Jan 2026 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769638485;
	bh=74NOxbKqGkEgjNrHB91dvQmAkyTNGiv+n72fcNGKqZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6V+2AmGSx+O4xRcfzdNK367XLC6Zd1kGT9QPvZRs642jJUgA3AMa1pI1xMIBSBG3
	 l+R+OdGNtO35Yov9kFCv05zeeG4fFH3W1L9CJpg+79lorbczT4eHx+1oZlDSO3ZC4F
	 7lDNpTmb6whN9LQPIVYFn7DAqwG3+qvzJV/eBZZdAqCh9Hqm64b8BJIF2JY6klONmw
	 0J5SzHz2OYjPOQrBnHWRWU1iA17VZOQW8mKbREoWMggJgLTebM/cmrUO8VX3MRd/IW
	 XPyabvb/HQw/RRTsLjV0aeme/1rI65VVQnnVgp2JOlGnsS0EIBdmDMLkPvxVYHXkgz
	 Md+xlyZQrnDkQ==
Date: Wed, 28 Jan 2026 14:14:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260128221443.GA2024@quark>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
 <20260125013104.GA2255@sol>
 <aXaPph6Yi-hzf0J-@casper.infradead.org>
 <20260126044432.GE30803@lst.de>
 <20260126201206.GA30838@quark>
 <aXqB7Wlfx62bAjqF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqB7Wlfx62bAjqF@casper.infradead.org>
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
	TAGGED_FROM(0.00)[bounces-75816-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25E03A971D
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:38:53PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 26, 2026 at 12:12:06PM -0800, Eric Biggers wrote:
> > When CONFIG_FS_VERITY=n, there can still be inodes that have fsverity
> > enabled, since they might have already been present on the filesystem.
> > The S_VERITY flag and the corresponding IS_VERITY() macro are being used
> > to identify such inodes and handle them appropriately.  
> > 
> > Consider fsverity_file_open() for example:
> > 
> > static inline int fsverity_file_open(struct inode *inode, struct file *filp)
> > {
> > 	if (IS_VERITY(inode))
> > 		return __fsverity_file_open(inode, filp);
> > 	return 0;
> > }
> > 
> > When CONFIG_FS_VERITY=n, __fsverity_file_open() resolves to the stub:
> > 
> > static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
> > {
> > 	return -EOPNOTSUPP;
> > }
> > 
> > So the result is that on a kernel that doesn't have fsverity support
> > enabled, trying to open an fsverity file fails with EOPNOTSUPP.
> 
> ... why?  If the user has built a kernel without VERITY support enabled,
> they're no longer allowed to open files with verity metadata?  I can't
> see the harm in allowing them to read these files, they're just not
> protected against these files being corrupted.

Reading could be allowed, in principle.  But open and truncate would
still need to deny writes, and the code to do that uses IS_VERITY().  So
it still wouldn't allow S_VERITY to be defined to 0, unless these checks
were updated to use the filesystem-specific flags as I mentioned.

- Eric

