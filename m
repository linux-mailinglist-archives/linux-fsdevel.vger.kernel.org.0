Return-Path: <linux-fsdevel+bounces-76158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJTGG9SXgWl/HAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:38:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F30D5589
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B713038A60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 06:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82037C113;
	Tue,  3 Feb 2026 06:38:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57C37AA92;
	Tue,  3 Feb 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100683; cv=none; b=JXIwNsg1iPx/ALHTkXRF67zQ9WEMGJ3S/t7ONmarNHI7Pb8Ge0K/gmIlaZhS5tFSg8qpKS1b6UJAlhdBRBUXbXJCwVa0oes4CLubaU8Xs10XA2wHG8W6PiY/SfG1jEePTYTsqEg3gmqyAuw2sOdn7bPSP2GljhIGztU8L+6IjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100683; c=relaxed/simple;
	bh=qRM9E+m2kLf/MXZux+lZvcCViKKHXHstWsSTPpYV19s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Gp9PgAoxZmm8rmNITURPfK5YCmsb6UlSVGMUVJhFVGB5VIAv+W4+VnjEmAr6J8M8/56vjjvVF54mX7eEunft2xQoEAbtE6WXEuz4PrMzNcUKIaTwdD4UgIVcffvadn1dNsgAIr2zhCVBnjzrQjx+sS7hbviiYj0jzc8gU3ND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 561A768AFE; Tue,  3 Feb 2026 07:37:58 +0100 (CET)
Date: Tue, 3 Feb 2026 07:37:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v6 12/16] ntfs: add reparse and ea operations
Message-ID: <20260203063758.GB18053@lst.de>
References: <20260202220202.10907-1-linkinjeon@kernel.org> <20260202220202.10907-13-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202220202.10907-13-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76158-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,toxicpanda.com,sandeen.net,suse.com,brown.name,gmail.com,vger.kernel.org,lge.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0F30D5589
X-Rspamd-Action: no action

Suggested commit message:

Implement support for Extended Attributes and Reparse Points, enabling
Posix ACL support and, and compatibility with Windows Subsystem for
Linux (WSL) metadata.

> +struct WSL_LINK_REPARSE_DATA {
> +	__le32	type;
> +	char	link[];
> +};
> +
> +struct REPARSE_INDEX {			/* index entry in $Extend/$Reparse */

Why are these using all upper case names unlike the rest of the
code?

> +	ok = ni && reparse_attr && (size >= sizeof(struct reparse_point)) &&
> +		(reparse_attr->reparse_tag != IO_REPARSE_TAG_RESERVED_ZERO) &&
> +		(((size_t)le16_to_cpu(reparse_attr->reparse_data_length) +
> +		  sizeof(struct reparse_point) +
> +		  ((reparse_attr->reparse_tag & IO_REPARSE_TAG_IS_MICROSOFT) ?
> +		   0 : sizeof(struct guid))) == size);

A bunch of superflous braces.  But in general decomposing such complex
operations into an inline helper using multiple if statements and
adding comments improves the readability a lot.

> +	if (ok) {

... and just return here for !ok and reduce the indentation for
the rest of the function?

> +		switch (reparse_attr->reparse_tag) {
> +		case IO_REPARSE_TAG_LX_SYMLINK:
> +			wsl_reparse_data = (const struct WSL_LINK_REPARSE_DATA *)
> +						reparse_attr->reparse_data;
> +			if ((le16_to_cpu(reparse_attr->reparse_data_length) <=
> +			     sizeof(wsl_reparse_data->type)) ||
> +			    (wsl_reparse_data->type != cpu_to_le32(2)))
> +				ok = false;
> +			break;
> +		case IO_REPARSE_TAG_AF_UNIX:
> +		case IO_REPARSE_TAG_LX_FIFO:
> +		case IO_REPARSE_TAG_LX_CHR:
> +		case IO_REPARSE_TAG_LX_BLK:
> +			if (reparse_attr->reparse_data_length ||
> +			    !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
> +				ok = false;
> +			break;

... and then directly return from inside the switch as well?


