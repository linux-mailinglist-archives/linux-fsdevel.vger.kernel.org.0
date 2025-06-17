Return-Path: <linux-fsdevel+bounces-51905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B363DADCE55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD53017592E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63A2E3AF9;
	Tue, 17 Jun 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQbquBVW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98132E266E;
	Tue, 17 Jun 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168460; cv=none; b=c2Mm4hIvAH4mugDHphcEXgDie0Wjodbk9w5I3DmDphdNanMX6LObfPFQFOUV5FKBJkyhgcnwZHlohYSwSF2y2hQvY95eWp3nmuAIOxaFGYDFYjS5s4BoIdkjYGvMe0g6zewvNvJouRZN2ELiTAnUBcLVhw3HgPZPo74aAifg1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168460; c=relaxed/simple;
	bh=+mvYcib1jOLn2MJdJlLe3/Of17qNWzn3vv5uSzZoKSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl/yJjI2fxj794RFGX1W66GaO/HqBu3oYdwnoKk3K2k8e9FwB9AL+PU18zphQadJuaYjFSiQ7opWs0gwaPIdiuL/ZGKb1oGwFGi+NJ09xnnulnYlJ3vgDTZ2++LZI8W0H10gl2PuGm95LgWXOlsyIKD4gQ/kUwFuOpgtdgz27jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQbquBVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161CEC4CEF5;
	Tue, 17 Jun 2025 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750168459;
	bh=+mvYcib1jOLn2MJdJlLe3/Of17qNWzn3vv5uSzZoKSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qQbquBVWTNilpD9J2DZukqDqhw6dYV6sQdAC3swnhkXDCzrarHfIjtDx6+iaanIj2
	 /w49fQnKSs5gIvxmaG8LRqyy10uW6vxniN9Vtlf836msmzLX6mULgZBsyo2VCzTtdQ
	 v8HEJuCYV3Vzp6qLFx9lNWclFdUMun1+SF3Xe0r/IgIThr2gBMuIJcCrwNKPXlzr4k
	 qKVgTe3En5KlysSFaraPhOlK6Hm77MlTIQOT81QI2BUf7+QXEZ3OYgm8HvmQq5bDyj
	 EA6ptglxv3jHHKeLyaL/2d/HPCJgn2G8R6Gxm7WZ6HZYrmkdGksTvaIIGBQm3ZA2aU
	 6u12Pn3Ty9DSA==
Date: Tue, 17 Jun 2025 16:54:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Steve French <sfrench@samba.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeffrey Altman <jaltman@auristor.com>, hch@infradead.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Keyrings: How to make them more useful
Message-ID: <aFFzWwPoXMhMJjTL@kernel.org>
References: <462886.1749731810@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462886.1749731810@warthog.procyon.org.uk>

On Thu, Jun 12, 2025 at 01:36:50PM +0100, David Howells wrote:
> Hi Jarkko, Steve, Chuck, Mimi, et al.,
> 
> I think work needs to be done on the keyrings subsystem to make them more
> useful for network filesystems and other kernel services such as TLS and
> crypto.
> 
> There are a number of issues that I think need addressing:
> 
>  (1) One of the flaws in the initial design is that whilst keys have a type
>      (which is necessary), this has to be specified as part of the lookup or
>      the search, which is overly restrictive.
> 
>      It probably would have been better to search by description alone and
>      then, if a key is found, have any type of key with that description
>      returned and let the app/service investigate the key to find the type.
> 
>      Now, this is still possible to implement on top of the existing API: just
>      allow a NULL type to be passed in - but we might need some way to
>      enumerate all the keys with that description, but of different types.
>      Possibly, the search function should return all the matching keys.
> 
>      Possibly, within the kernel, for each keyring, all the keys of the same
>      description can be stored within a group structure, and the search
>      returns the group.  This could also have the added benefit of maybe
>      making it easier to handle updates.

All keys matching the description can be collected by iterating all the
key types (instead of passing NULL).

Having only a syscall for the process has of course much better
concurrency properties.  Just trying to understand the improvements by
actual measure, that's all.

>  (2) For certain applications, keys need versioning - and we need to be able
>      to get access to older versions (at least to some extent) of the keys.
>      An example of this is cifs where (if I understand it correctly) the key
>      version gets cranked, but not all servers may have caught up yet, so we
>      need to be able to try the keys in descending order of version.
> 
>      This could also work within the group idea mentioned above.
> 
>  (3) For certain applications, such as AFS and AF_RXRPC, we may need to be
>      able to keep a number of keys around that have the same description
>      (e.g. cell name) and basic type (e.g. rxrpc) and version, but that have
>      different crypto types (e.g. Rx security classes and Kerberos types, such
>      as RxGK+aes256-cts-hmac-sha1-96, RxGK+aes128-cts-hmac-sha256-128 or
>      RxKAD) as different servers in the same cell might not support all or we
>      might be implementing a server that is offering multiple crypto types.
> 
>      So we might need a "subtype" as well as a version.

1. How the history is capped? I presume it is a fixed-size circular
   buffer, where the oldest entry is deleted, when the key is updated.
1. How history queried by the caller?
2. How a newer version is revoked in favor of a newer version?

>  (4) I think the keyring ACLs idea need to be revived.  We have a whole bunch
>      of different keyrings, each with a specific 'domain' of usage for the
>      keys contained therein for checking signatures on things.  Can we reduce
>      this to one keyring and use ACLs to declare the specific purposes for
>      which a key may be used or the specific tasks that may use it?  Use
>      special subject IDs (ie. not simply UIDs/GIDs) to mark this.

Is subject ID some kind of token that a process can hold (and possibly
can be sent to a process)?

> 
>  (5) Replace the upcall mechanism with a listenable service channel, so that a
>      userspace service (possibly part of systemd or driven from systemd) can
>      listen on it and perform key creation/maintenance services.
> 
>      From previous discussions with the systemd maintainer, it would be a lot
>      easier for them to manage if the key is attached to a file descriptor -
>      at least for the duration of the maintenance operation.
> 
>      Further, this needs to be containerised in some way so that requests from
>      different containers can be handled separately - and can be
>      distinguished

This sounds like an universally sane idea (outside the scope of the
patch set).

> 
>  (6) Move away from keeping DNS records in a keyring, but rather keep them in
>      some sort of shrinkable list.  They could still be looked up over a
>      secure channel.

Don't expertise to understand the benefits of this change. 


> 
> To aid with at least (1), (2) and (3) and possibly (4), I think it might be
> worth adding an extended add_key() system call that takes an additional
> parameter string:
> 
> 	key_serial_t add_key2(const char *type,
> 			      const char *description,
> 			      const char *parameters,
> 			      const void payload, size_t plen,
> 			      key_serial_t keyring);
> 
> The parameters would get passed to the key type driver for it to extract
> things like version number and subtype from without the need to try and fold
> it into the payload (which may, for example, be a binary ticket obtained from
> kerberos).  Though possibly that is a bad example as the kerberos ticket may
> contain multiple keys.

Does the parameter list mimic kernel command-line style of comma
separated attributes?

BR, Jarkko

