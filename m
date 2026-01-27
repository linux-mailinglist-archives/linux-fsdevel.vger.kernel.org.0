Return-Path: <linux-fsdevel+bounces-75577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4McHBYFZeGkupgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:21:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150490597
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F87A301D69E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416EF32A3FE;
	Tue, 27 Jan 2026 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTL4LvSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89661F3FED;
	Tue, 27 Jan 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769494888; cv=none; b=kIaYMbKFeAutRHD0IWKyZFXsjlzhHpGWtl3F4yG6Lc9tKDKM/8WsGdl+y400IWafCwT+bWHj+z31XZGJqYWTK/VfdFt9sjlkH1nwg0FGW/N+sZjgZLAR8MDfrQK/S8pHXI0vreuDLuy3jXSH2SywPvcVr/qb4k5G6SeADlzw/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769494888; c=relaxed/simple;
	bh=kk2V4G3auJhPjVPWGb0eJbR78yju4WWua17kbmc6Gxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxruRHFRI/4SH8QUNha46MGc3a9NErFCE0FKVyss18e+MWnKtfp1WCpgfGOVbtUQXbhVZaFDDxEEJGB7zKmx+yD0yxIlSpfAOcCoTylrg7gMD7XaKTH4nwLAZZubSWqu7/ZXN+Q9sezviKjHBqR/adH4Gf419sr5C1p06HUqPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTL4LvSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8398C116C6;
	Tue, 27 Jan 2026 06:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769494888;
	bh=kk2V4G3auJhPjVPWGb0eJbR78yju4WWua17kbmc6Gxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTL4LvSMUGOTtLW9wXJkpR0u684upITx8xZl84Y31HC1RqoKXvCBezyDsiP3ySxUr
	 E/B+8/BXI1rjjU3BkuZaAFz8J9hKYfFnYkRFHrf18UIwfmvBfV6YHk/uwHTp2HJQvS
	 6BKI68umDuXLIIj6tsO1PQXJlM4Jf7SQXPycRfvFXvAMNvpdSSTXwAvgN/7dcy0Df0
	 hr59kGK1M4AtByyuMO2mZWrc2ERwuVIuvR4fK3PqYyXBonryBdqnlvPZTfRfSBQmKj
	 IiOBH48fB1ojGb3ercxDF4N9AjHTAaHezrLsbjyKZzMJBJBL2DGFWg0BoYDuI3m0NO
	 8zk5iJ28eeEOw==
Date: Mon, 26 Jan 2026 22:20:55 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/16] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260127062055.GA90735@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de>
 <20260126191102.GO5910@frogsfrogsfrogs>
 <20260126205301.GD30838@quark>
 <20260127060039.GA25321@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127060039.GA25321@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75577-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
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
X-Rspamd-Queue-Id: 5150490597
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:00:39AM +0100, Christoph Hellwig wrote:
> > -	if (PTR_ERR(folio) == -ENOENT ||
> > -	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
> > +	if (folio == ERR_PTR(-ENOENT) ||
> > +	    (!IS_ERR(folio) && !folio_test_uptodate(folio))) {
> > 
> > (Note that PTR_ERR() shouldn't be used before it's known that the
> > pointer is an error pointer.)
> 
> That's new to me, and I can't find anything in the documentation or
> implementation suggesting that.  Your example code above also does
> this as does plenty of code in the kernel elsewhere.

Not sure why this is controversial.  The documentation for PTR_ERR() is
clear that it's for error pointers:

/**
 * PTR_ERR - Extract the error code from an error pointer.
 * @ptr: An error pointer.
 * Return: The error code within @ptr.
 */
static inline long __must_check PTR_ERR(__force const void *ptr)
{
        return (long) ptr;
}

Yes, it's really just a cast, and 'PTR_ERR(folio) == -ENOENT' actually
still works when folio isn't necessarily an error pointer.  But normally
it would be written as a pointer comparison as I suggested.

- Eric

