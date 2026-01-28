Return-Path: <linux-fsdevel+bounces-75689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PI2BAqEeWnGxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:35:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A69CBE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAEB301457E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E132ED34;
	Wed, 28 Jan 2026 03:35:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C032E12E;
	Wed, 28 Jan 2026 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571324; cv=none; b=L73QoKMdFOR13O5WsmXR1zveGS3UswkJAsecZYeS1Vb6I6hdFtXxAw5hllhjBkFDnmptlvVEBG8Bh1j28pCynq+XTVUCG5lG9epvj0WwtRu3/AezVEgbcdoCEfUTkrBMvhkY8YSJRC3wYvPaBTQ3JscMfwpICGL17d/YMw0wfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571324; c=relaxed/simple;
	bh=eYNUdo1vmoWHcZ7Atfbmckkz6n4R1F6pDEXQ0IL3Mqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldocfcar4KcIlyWTQ0zEbnnH6srBvLDbwuffgrqEl3Qy//+SvSi3OcjcaM6QdevsVsl+L4JRWoai/bOP9SKg53Mv6WDl+hkqaB0bPVSAZ1o3xVzHgD88IiWuctUgvCMbArehoKapTcx0/JOnKMUUhnFe3wj21M6DzaAjesZ4zYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 93A97227A8E; Wed, 28 Jan 2026 04:35:19 +0100 (CET)
Date: Wed, 28 Jan 2026 04:35:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the
 fsverity_info
Message-ID: <20260128033519.GB30830@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-17-hch@lst.de> <20260128032817.GB2718@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128032817.GB2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-75689-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 746A69CBE0
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:28:17PM -0800, Eric Biggers wrote:
> > - * a race condition where the file is being read concurrently with
> > - * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
> > + * This checks whether the inode's verity info has been set, and reads need
> > + * to verify the verity information.
> 
> Nit: the point is to verify the file's data, not to verify "the verity
> information".

Ok.

> > -static inline bool fsverity_active(const struct inode *inode)
> > +static __always_inline bool fsverity_active(const struct inode *inode)
> > +{
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> > +		/*
> > +		 * This pairs with the try_cmpxchg in set_mask_bits()
> > +		 * used to set the S_VERITY bit in i_flags.
> > +		 */
> > +		smp_mb();
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> Is there a reason for this function in particular to be __always_inline?
> fsverity_get_info() is just inline.

Without the __always_inline some gcc versions on sparc fail to inline it,
and cause a link failure due to a reference to fsverity_readahead in
f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)

> 
> - Eric
---end quoted text---

