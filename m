Return-Path: <linux-fsdevel+bounces-6837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944BB81D51C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 17:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8EA1F2212C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6C11CB0;
	Sat, 23 Dec 2023 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj3Y/LrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F20CA7E;
	Sat, 23 Dec 2023 16:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB976C433C8;
	Sat, 23 Dec 2023 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703349378;
	bh=N9AzMOu4koi0frJdk8bVKllnwJ5h9l24nJ4K62YY+pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qj3Y/LrZ2lOQTBRnK85le0wCLszMYvalS1tEsiA2oDhp7qpSDDdWUvTaMpGXz9dhH
	 4ykHNYOdo8VERL63YuAP4CjO7id17Ib8H6NWh/sBrdWlq+wS7ll95qpMlhdjgHcdnu
	 8JtgzESsnTo6Lf8rD4QWsFDvri8BBMcUcAmlGZNGux6X5DTVPZyfo04LtfBCt+2WJy
	 GyAIEspIRqQcufLhNhVK901yYC4p12YjlNF9t1bG4qBLD3rqEKTEJCs4lNVZJdc5Ng
	 zjjAeI5g3LafLZMaXy6Kg5nFDlh43NDOP71OPd4Z3S89V59zbDhPZNPHi4R8ctqG06
	 8j2jAc6SxjjNw==
Date: Sat, 23 Dec 2023 16:36:12 +0000
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Markus Suvanto <markus.suvanto@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wang Lei <wang840925@gmail.com>, Jeff Layton <jlayton@redhat.com>,
	Steve French <sfrench@us.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>
Subject: Re: [PATCH v4 3/3] keys, dns: Allow key types (eg. DNS) to be
 reclaimed immediately on expiry
Message-ID: <20231223163612.GG201037@kernel.org>
References: <20231221134558.1659214-1-dhowells@redhat.com>
 <20231221134558.1659214-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134558.1659214-4-dhowells@redhat.com>

+ Edward Adam Davis

On Thu, Dec 21, 2023 at 01:45:30PM +0000, David Howells wrote:
> If a key has an expiration time, then when that time passes, the key is
> left around for a certain amount of time before being collected (5 mins by
> default) so that EKEYEXPIRED can be returned instead of ENOKEY.  This is a
> problem for DNS keys because we want to redo the DNS lookup immediately at
> that point.
> 
> Fix this by allowing key types to be marked such that keys of that type
> don't have this extra period, but are reclaimed as soon as they expire and
> turn this on for dns_resolver-type keys.  To make this easier to handle,
> key->expiry is changed to be permanent if TIME64_MAX rather than 0.
> 
> Furthermore, give such new-style negative DNS results a 1s default expiry
> if no other expiry time is set rather than allowing it to stick around
> indefinitely.  This shouldn't be zero as ls will follow a failing stat call
> immediately with a second with AT_SYMLINK_NOFOLLOW added.
> 
> Fixes: 1a4240f4764a ("DNS: Separate out CIFS DNS Resolver code")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Markus Suvanto <markus.suvanto@gmail.com>

...

> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index 01e54b46ae0b..2a6d363763a2 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -91,6 +91,7 @@ const struct cred *dns_resolver_cache;
>  static int
>  dns_resolver_preparse(struct key_preparsed_payload *prep)
>  {
> +	const struct dns_server_list_v1_header *v1;
>  	const struct dns_payload_header *bin;
>  	struct user_key_payload *upayload;
>  	unsigned long derrno;
> @@ -122,6 +123,13 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  			return -EINVAL;
>  		}
>  
> +		v1 = (const struct dns_server_list_v1_header *)bin;
> +		if ((v1->status != DNS_LOOKUP_GOOD &&
> +		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD)) {
> +			if (prep->expiry == TIME64_MAX)
> +				prep->expiry = ktime_get_real_seconds() + 1;
> +		}
> +
>  		result_len = datalen;
>  		goto store_result;
>  	}

Hi David,

As has been pointed out by Edward Adam Davis, this may result
in a buffer overrun. Just above this hunk the following length
check occurs:

		if (datalen <= sizeof(*bin))
			return -EINVAL;

But the new code above reads beyond the end of sizeof(*bin).

Link: https://lore.kernel.org/netdev/tencent_7D663C8936BA96F837124A4474AF76ED6709@qq.com/

...

