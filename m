Return-Path: <linux-fsdevel+bounces-79275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJARG5Uip2mMegAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 19:04:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA71F4EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 19:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3F63155A49
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22214F797A;
	Tue,  3 Mar 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZK7bfkJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91DD3264E6;
	Tue,  3 Mar 2026 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560844; cv=none; b=uM6/UPTcOeaiIpNx732TUbwCFEAX1JabpXBxGbPP6pMgyZ305byl16l72fZHmwXDZzo0ezDf6J3keGMmf3ueGuRsn9l94JSZzh1Jorh2EAtktmytpmCZEdC+zoeqP8GZa4/H+nIKqNuMnOfWkHLxCfucvyb6PcCheRgN6+S7W/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560844; c=relaxed/simple;
	bh=spETfYMosC2Kp4mRy+ya6d6MGmqILxDoC7rPwcNQ0kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsJahIrRsavTfFHKh4hM79HaTT2UpySlppYeVButkcyMVmsc00J/3OyTSc9apWpCZ/HxQrGzBqxWQSDDjN3JkEHOABOklroLHlj+P/NmbruAFer/G3MFssEbovSyPIm9ra/8HbiEaK+5tHkKQokw5uTPpgVy0PLw9Sg0TnxqMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZK7bfkJ2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4MoG9hkzWKLHQRnvjG+fbUzFovSVj0LaQW2FGn3AtBo=; b=ZK7bfkJ2sjfgHNI+ZSVwEPBzq5
	78lv0xKkltX7hvzMAhFSSsA+xJORiOtOUhrVLqL3PEoPBiZ+RT7TOSjptRVYzluFZrgmsIxwUkbW4
	yRSBzQJsmT4fedDxSMwbWKxhgtQ1hluePd37WZsWxq/LAI3Bhj/FuGjYxnDKrkLYeRX4bFt4xzmvW
	ELzJtxyPQgZHZ1AYu9gsSxWb61IVeSAojmTpugFEtP5rvz+ZcE+FlpczWa7l9pVEaJ6KgXKjOocLM
	cTNrQAH2p5vL3Gni8i9PoeaTW6+i+7zew49JrLgL0z8wsmkgZl1A/U+JeTolf45jBCm4eSJ/6gq4E
	jhOGUvNg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxU2u-0000000BuW6-3QJF;
	Tue, 03 Mar 2026 18:00:37 +0000
Date: Tue, 3 Mar 2026 18:00:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: viro@zeniv.linux.org.uk, kees@kernel.org, gustavoars@kernel.org,
	linux-hardening@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] iov: Bypass usercopy hardening for kernel iterators
Message-ID: <aachxPdUi2puxQKq@casper.infradead.org>
References: <20260303162932.22910-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162932.22910-1-cel@kernel.org>
X-Rspamd-Queue-Id: CECA71F4EC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79275-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email,casper.infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:29:32AM -0500, Chuck Lever wrote:
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected slab regions, which is
> meaningful when data crosses the user/kernel boundary but adds
> no value when both source and destination are kernel addresses.

I'm not sure I'd go as far as "no value".  I could see an attack which
managed to trick the kernel into copying past the end of a slab object
and sending the contents of that buffer across the network to an attacker.

Or I guess in this case you're talking about copying _to_ a slab object.
Then we could see a network attacker somewhow confusing the kernel into
copying past the end of the object they allocated, overwriting slab
metadata and/or the contents of the next object in the slab.

Limited value, sure.  And the performance change you're showing here
certainly isn't nothing!

> Split check_copy_size() so that copy_to_iter() can bypass the
> runtime check_object_size() call for kernel-only iterators
> (ITER_BVEC, ITER_KVEC). Existing callers of check_copy_size()
> are unaffected; user-backed iterators still receive the full
> usercopy validation.
> 
> This benefits all kernel consumers of copy_to_iter(), including
> the TCP receive path used by the NFS client and server,
> NVMe-TCP, and any other subsystem that uses ITER_BVEC or
> ITER_KVEC receive buffers.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/ucopysize.h | 10 +++++++++-
>  include/linux/uio.h       |  9 +++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ucopysize.h b/include/linux/ucopysize.h
> index 41c2d9720466..b3eacb4869a8 100644
> --- a/include/linux/ucopysize.h
> +++ b/include/linux/ucopysize.h
> @@ -42,7 +42,7 @@ static inline void copy_overflow(int size, unsigned long count)
>  }
>  
>  static __always_inline __must_check bool
> -check_copy_size(const void *addr, size_t bytes, bool is_source)
> +check_copy_size_nosec(const void *addr, size_t bytes, bool is_source)
>  {
>  	int sz = __builtin_object_size(addr, 0);
>  	if (unlikely(sz >= 0 && sz < bytes)) {
> @@ -56,6 +56,14 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
>  	}
>  	if (WARN_ON_ONCE(bytes > INT_MAX))
>  		return false;
> +	return true;
> +}
> +
> +static __always_inline __must_check bool
> +check_copy_size(const void *addr, size_t bytes, bool is_source)
> +{
> +	if (!check_copy_size_nosec(addr, bytes, is_source))
> +		return false;
>  	check_object_size(addr, bytes, is_source);
>  	return true;
>  }
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index a9bc5b3067e3..f860529abfbe 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -216,8 +216,13 @@ size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
>  static __always_inline __must_check
>  size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  {
> -	if (check_copy_size(addr, bytes, true))
> -		return _copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i)) {
> +		if (check_copy_size(addr, bytes, true))
> +			return _copy_to_iter(addr, bytes, i);
> +	} else {
> +		if (check_copy_size_nosec(addr, bytes, true))
> +			return _copy_to_iter(addr, bytes, i);
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.53.0
> 
> 

