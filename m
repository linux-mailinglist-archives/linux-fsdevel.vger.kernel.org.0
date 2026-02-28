Return-Path: <linux-fsdevel+bounces-78811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNc8Ee5eomkX2gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 04:20:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32091C01C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 04:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8054F305A42D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 03:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C2BD5A7;
	Sat, 28 Feb 2026 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk3xxCe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C951DF980;
	Sat, 28 Feb 2026 03:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248798; cv=none; b=Nk/CC9I7ND8MDeUUO9ZEKifIcC4112oZYzPZsR0+0IhgmK8c1t5mV3W2c3pbDc9oeDr3S6Vb86WENu821aGIB0bCCrQ8m4m3fv57hZmUDgfTjGlxon4LQ+aeQ+UlVkwPZkn3U3oRs2iYrXxEGHjBMHQj5Exqhr+ZtzKScYte3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248798; c=relaxed/simple;
	bh=jAaTl8amz6NojQ8tNyBlQViGuePzEjqJZ7SlMppHCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M0TkzMVQnUU8JDFBCBC5LeCcQcHuRpKNFzBdxZ/n/7tzxco9bThGGZX1gC6y6vW4U3W7nr4hvhAfhOEgoZlLs4n7/b4CwcKnE4PxCaj2I+F2y/IEmgzBeCBT1MUdK0bQi6AOmwyinYFmaqB18/258tZUrzpL0O+JQoyk8UrQf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk3xxCe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10876C116D0;
	Sat, 28 Feb 2026 03:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248797;
	bh=jAaTl8amz6NojQ8tNyBlQViGuePzEjqJZ7SlMppHCuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tk3xxCe9/xYjrflhO5Ellc9EE+aDKPaKTveLIc4SfXEEHOO9Xo6Q0GfbS+MVrnfx6
	 CHgIkw3FxADDIaZqbzhGmxQvZVaKxB1Ar2r8S4eozjwPhv9S0Gkf1uSHpEFyOAzEIM
	 ZwxCvxNgRml8f9zUi2SzOqOP6W8+rcTnA0puYNrfx5ZvfjcaEDRh1ALKBjBNc2SWlG
	 2FpGw94Oc0y+7LVKvDYlrcUAl6dDl82x+gPgTKvhLEGv1SzEI7QmRHx2mLjGTXQzDu
	 4XaDopUI61PFEwOPbt2ymGTuL526avgXaBvFpIsSG71f9os9Hnka/JweQW3+1GN/CB
	 sndgjtFbb/1PQ==
Date: Fri, 27 Feb 2026 19:19:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, David
 Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org
Subject: Re: [PATCH net-next] net: datagram: Bypass usercopy checks for
 kernel iterators
Message-ID: <20260227191956.56539ecc@kernel.org>
In-Reply-To: <20260225162532.30587-1-cel@kernel.org>
References: <20260225162532.30587-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-78811-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A32091C01C4
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 11:25:32 -0500 Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
> These checks validate memory regions during copies, but provide no
> security benefit when both source (skb data) and destination (kernel
> pages in BVEC/KVEC iterators) reside in kernel address space.
> 
> Modify simple_copy_to_iter() and crc32c_and_copy_to_iter() to call
> _copy_to_iter() directly when the destination is a kernel-only
> iterator, bypassing the usercopy hardening validation. User-backed
> iterators (ITER_UBUF, ITER_IOVEC) continue to use copy_to_iter()
> with full validation.
> 
> This benefits kernel consumers of TCP receive such as the NFS client
> and server and NVMe-TCP, which use ITER_BVEC for their receive
> buffers.

If it makes such a difference why not make copy_to_iter()
check the iter type? Why force callers to check it?

> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index c285c6465923..e83cf0125008 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -490,7 +490,10 @@ static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
>  	u32 *crcp = _crcp;
>  	size_t copied;
>  
> -	copied = copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i))
> +		copied = copy_to_iter(addr, bytes, i);
> +	else
> +		copied = _copy_to_iter(addr, bytes, i);
>  	*crcp = crc32c(*crcp, addr, copied);
>  	return copied;
>  }
> @@ -515,10 +518,17 @@ int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
>  EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
>  #endif /* CONFIG_NET_CRC32C */
>  
> +/*
> + * Bypass usercopy hardening for kernel-only iterators: no data
> + * crosses the user/kernel boundary, so the slab whitelist check
> + * on the source buffer is unnecessary overhead.
> + */
>  static size_t simple_copy_to_iter(const void *addr, size_t bytes,
>  		void *data __always_unused, struct iov_iter *i)
>  {
> -	return copy_to_iter(addr, bytes, i);
> +	if (user_backed_iter(i))
> +		return copy_to_iter(addr, bytes, i);
> +	return _copy_to_iter(addr, bytes, i);
>  }
>  
>  /**


