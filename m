Return-Path: <linux-fsdevel+bounces-79403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLTLM65EqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:41:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310A201CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2110330A009C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EE73B3BF5;
	Wed,  4 Mar 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgCu/Gen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2333A5E67;
	Wed,  4 Mar 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635179; cv=none; b=QNQpCsu3B6OgAyIi10hcaxYXY7Fa5gUhu4l1XnGVcidDCxO+aC/VsVKAknMHPEf/wiA2WDcmg6KxIVqmimNiQ38W4KZMkFdT62FDShzVxhTTkcOLdvwNiKP+2LZu+kTQmfvDoIDwU085bsG1x4SQoYEQAD8X/VhNX3EyteI5SDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635179; c=relaxed/simple;
	bh=XiF8T5NlprndbLc/B6gNI4qfV46YQF4JzFt2BTxfzOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGaFG1nKMYf6S3Ga7EgSErc+WY0qbc5F1NTwLoxWo+LTavFfN06JiJpm9bDygbFhNTD3aiNUtriH2u95csmRaH5L+oCThir4eNtg0xWjMlgwUsq5/S6NBS56JdwzxIP5K6eZhp+z2wHjpbinE/zJKLyUHp7jxSJhSA2iaGAgUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tgCu/Gen; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WD5GrjZm9bAEGIe0MSiOhMU23JEpvk4qh3aeqqK4kdQ=; b=tgCu/GenblYuVrai21d46hTJS2
	EcctAPdI2oLAJPwO9WCqO+fRuZN7UFRTRst7jVeXNIbVVw8Mi0BkXPFjrRi8NhfRoQA4aWVefgwDL
	5Q2smi/VT8lq+QKUI0LFJWO1bRrv9KQbUL3YoL+m6TGNzbXxBewHRZ4FOVT4vQliQQJyih/z8H2ao
	itag2aeOujjkM+/cSBXRUFpPaeumOUyNWoVbL75G9DdOlCsaE31xR85wqO6JNZI72nwW/vf0VJ58I
	pv8jJqEjvRGzeCpsld0PWaihOZsm05HqIVhOeSONqo4vK6JfyU017eztaQMMBBgnb0fcEJ92JpLpb
	zL1E39eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnNv-0000000HQ6Q-2eLS;
	Wed, 04 Mar 2026 14:39:35 +0000
Date: Wed, 4 Mar 2026 06:39:35 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab
 the buffers on request
Message-ID: <aahEJ7hY-tXRRjJk@infradead.org>
References: <20260304140328.112636-1-dhowells@redhat.com>
 <20260304140328.112636-18-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304140328.112636-18-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 8310A201CA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79403-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:03:24PM +0000, David Howells wrote:
> +/*
> + * Query the occupancy of the cache in a region, returning the extent of the
> + * next chunk of cached data and the next hole.
> + */
> +static int cachefiles_query_occupancy(struct netfs_cache_resources *cres,
> +				      struct fscache_occupancy *occ)
> +{

Independent of fiemap or not, how is this supposed to work?  File
systems can create speculative preallocations any time they want,
so simply querying for holes vs data will corrupt your cache trivially.


