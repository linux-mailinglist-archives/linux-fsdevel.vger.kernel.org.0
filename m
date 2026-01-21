Return-Path: <linux-fsdevel+bounces-74835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAkBDiqvcGmKZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:49:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A211F557FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3344D901372
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70248167B;
	Wed, 21 Jan 2026 10:12:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86062481238;
	Wed, 21 Jan 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990361; cv=none; b=bRj2bCxsZ+CcpaoALoqNC7jgPg/PtuInFNIhyUkrShH8uRM9aXcY7pzKkdK4dE3sRE0PJN8ccRSPktcB4qj/kuTXu7uKFL1AsTMKZqT4tHKBKYfIN2d65m/Jv/HtLmV2vMju2+xw3uws9M4BvwzP1bxAnhJTjGpwE+I8buAsiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990361; c=relaxed/simple;
	bh=DJWlDvhlyav+iIwRKqw40ldF+YMmp4lcVZqyheS1InQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OU+CfxCNtiq7yKxED0qKi84GZHLHroDJqodpoOemi8SFR9w7hFJ5sil/6kbcbTqiywnCvvhFhTca3vr36s7B1PIv06r/fVoYi/kHHfLaMImn1VsXpK7rXcKOsbOzkj6BZeEmsO+6kaZuqJpcUPMT80BZfC6Ipvxl6ZZdsn9zgnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A69E1227AAA; Wed, 21 Jan 2026 11:12:34 +0100 (CET)
Date: Wed, 21 Jan 2026 11:12:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Neil Brown <neilb@suse.de>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel
 filesystems
Message-ID: <20260121101234.GA22918@lst.de>
References: <20260121085028.558164-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121085028.558164-1-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-74835-lists,linux-fsdevel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lst.de:mid]
X-Rspamd-Queue-Id: A211F557FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:50:27AM +0100, Amir Goldstein wrote:
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).
> 
> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
> 
> Therefore, do not allow nfsd to export filesystems with custom ->open()
> or ->permission() methods.

Yeah, this was added in and not used in the existing export_ops users.

> +	/*
> +	 * The requirements for a filesystem to be exportable:
> +	 * 1. The filehandle must identify a filesystem by number
> +	 * 2. The filehandle must uniquely identify an inode
> +	 * 3. The filesystem must not have custom filehandle open/perm methods
> +	 * 4. The requested file must not reside on an idmapped mount
>  	 */

Please spell out here why ->open and ->permission are not allowed.
Listing what the code does is generally not that useful, while why
it does that provides value.

While looking this I have to say the API documentation for these
methods in exportfs.h is unfortunately completely useless as well.
It doesn't mention the limitation that it's only used by the
non-exportfs code, and also doesn't mention why a file system
would implement or have to implement them :(  The commit messages
adding them are just as bad as well.

