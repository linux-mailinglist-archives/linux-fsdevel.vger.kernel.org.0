Return-Path: <linux-fsdevel+bounces-75580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDQeJx1deGljpgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:37:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF4906C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF82301DBBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 06:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3CA32936B;
	Tue, 27 Jan 2026 06:37:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282E2253A1;
	Tue, 27 Jan 2026 06:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769495823; cv=none; b=ZYDIt8q4tshnFKrFPMsmcfHVwppt49jJ2rjQxBd8dgcxq5omEWA67OzLbX6mFvD9jDuZLBJBbE6KDAjq5E8/fSclSr+20qHnSakz7L1x6emG+s26gIT2r5Zq8YP63eIKVqvV5WwEtTmjO1HOmi2DcYlNKa2+3lhlpTGbFRO3wFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769495823; c=relaxed/simple;
	bh=yyBiFoU8L9w5mJ7YTB+YRKIzmJcaRgrcdbfGWIuZ9y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2LtY3kIDbxKu1RCK7UIbxZYRIB2UBZ8+HsElFzhXLjiCf8k+jaecEqiS6ENKHmkoyXw44ywiKPJbB/IpHuCKZcVU88h8XuuT7yrLMMpeBomcW1ezHDycdGi64MR/CN8pE4BV6sil7awUxVJwFXqcCm0nFAcOi5SJxEhdwSq650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4169227AAE; Tue, 27 Jan 2026 07:36:58 +0100 (CET)
Date: Tue, 27 Jan 2026 07:36:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
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
Message-ID: <20260127063658.GA25894@lst.de>
References: <20260126045212.1381843-1-hch@lst.de> <20260126045212.1381843-8-hch@lst.de> <20260126191102.GO5910@frogsfrogsfrogs> <20260126205301.GD30838@quark> <20260127060039.GA25321@lst.de> <20260127062055.GA90735@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127062055.GA90735@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75580-lists,linux-fsdevel=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3EFF4906C0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 10:20:55PM -0800, Eric Biggers wrote:
> > That's new to me, and I can't find anything in the documentation or
> > implementation suggesting that.  Your example code above also does
> > this as does plenty of code in the kernel elsewhere.
> 
> Not sure why this is controversial.

It wasn't controversial until you came up with that claim.

> The documentation for PTR_ERR() is
> clear that it's for error pointers:

Yes, but anything that stores an ERR_PTR is an error pointer.  There
never has been any explicit requirement to first call IS_ERR.

One very common pattern is to extract it first an then check
for errors like:

	error = PTR_ERR(ptr);
	if (IS_ERR(ptr)))
		goto handler_error;

one could come up with arguments that this is special, because error
is not used until after the branch.  But there's plenty of other code
like:

        type = alg_get_type(sa->salg_type);
        if (PTR_ERR(type) == -ENOENT) {
                request_module("algif-%s", sa->salg_type);
                type = alg_get_type(sa->salg_type);
        }

        if (IS_ERR(type))
                return PTR_ERR(type);

>  * PTR_ERR - Extract the error code from an error pointer.
>  * @ptr: An error pointer.
>  * Return: The error code within @ptr.
>  */
> static inline long __must_check PTR_ERR(__force const void *ptr)
> {
>         return (long) ptr;
> }
> 
> Yes, it's really just a cast, and 'PTR_ERR(folio) == -ENOENT' actually
> still works when folio isn't necessarily an error pointer.  But normally
> it would be written as a pointer comparison as I suggested.

You suggestion is using PTR_ERR before checking, to quote from the
previous mail:

> Or as a diff from this series:
>
> -	if (PTR_ERR(folio) == -ENOENT ||
> -	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
> +	if (folio == ERR_PTR(-ENOENT) ||
> +         (!IS_ERR(folio) && !folio_test_uptodate(folio))) {


