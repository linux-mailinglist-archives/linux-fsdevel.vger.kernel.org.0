Return-Path: <linux-fsdevel+bounces-75695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMbyJ8iJeWkqxgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:00:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461B9CE71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 05:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F4178303099D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403030B52E;
	Wed, 28 Jan 2026 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7CsrT+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE77A13A;
	Wed, 28 Jan 2026 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769572795; cv=none; b=u+prZtUow9XJkg8En0TV2xxI8CVRvdevvunDys9KtFlPOW6dxebjP5JBWQ/Cz7nOIwYweBU92aeAXFwWNnNSajvDL8A3xanwnd+NnzkPrwWBTJ3pSnhICuXSCVzLFRNF0ALFaMvVEX8TDaJkKmSVi5qR17z4XLw9Omfe9HTVsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769572795; c=relaxed/simple;
	bh=KN33KA8IhAJueLHNP+j8dBhI4ybmkf2zt2MgVF8LMVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxUfIF5uYnp7Q4wnAuSQmUTbIgQhr2y2eEP8SeShibqfF8FSL9KXwY7K0qsxp7+2l2mHfBDS8HZPo32OB5fsAqD3dGTW7rqRHIY2gdYAzsu1SVvGZAe9+6OM8W1LyGHKs7a4+NUwbaKzNo0aMu0pozQIjpLM2HutC8wb6vSWbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7CsrT+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA30C4CEF1;
	Wed, 28 Jan 2026 03:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769572794;
	bh=KN33KA8IhAJueLHNP+j8dBhI4ybmkf2zt2MgVF8LMVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7CsrT+r2m6K7KYhX/d3UhuDJaMed3HVYTI7HZ7VPvZR1nrTY+f3mfoxbWZM6N7y2
	 19ZURMQ3RY3J3YT4AOi6jnCP1zKx7oR9zX1RF94rFmwzBskxAh92OGcHNnMFVPxYje
	 8QdLNncWQnVLxR300bucB4AkwyZi3ccNWj4ARaF60JNMbYqaKupTeqcE/zOlFLpnb+
	 qFWRirO6WC75aVF1HmJChMyg44YqubHKFeW7Thq6CkDZxuHzWxM7ipbq6YYcUN7ls2
	 5pKJJJllMiiJuIf3gG/y0JhxSYO0wYZX+PZR1LD+RhMVKJaU7RUTjbaP07AwODFJxu
	 gLewy77vI9faA==
Date: Tue, 27 Jan 2026 19:59:21 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260128035921.GE2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de>
 <20260128032817.GB2718@sol>
 <20260128033519.GB30830@lst.de>
 <20260128034405.GD2718@sol>
 <20260128034838.GB31178@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128034838.GB31178@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75695-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6461B9CE71
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:48:38AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 27, 2026 at 07:44:05PM -0800, Eric Biggers wrote:
> > On Wed, Jan 28, 2026 at 04:35:19AM +0100, Christoph Hellwig wrote:
> > > > Is there a reason for this function in particular to be __always_inline?
> > > > fsverity_get_info() is just inline.
> > > 
> > > Without the __always_inline some gcc versions on sparc fail to inline it,
> > > and cause a link failure due to a reference to fsverity_readahead in
> > > f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)
> > 
> > The relevant code is:
> > 
> >     vi = f2fs_need_verity(inode, folio->index);              
> >     if (vi)                                                  
> >             fsverity_readahead(vi, folio, nr_pages); 
> > 
> > Where:
> > 
> >     f2fs_need_verity()
> >         => fsverity_get_info()
> >             => fsverity_active()
> > 
> > If fsverity_active() needs __always_inline, why don't the other two
> > functions in the call chain need it?
> 
> I wish I knew.  compiler inlining decisions are a big of black magic.
> If you prefer I can use __always_inline for the entire chain.

Relying on the compiler to always correctly perform three levels of
inlining and dead code elimination isn't going to be all that reliable,
as it seems you've already seen.  Using __always_inline for all levels
might be good enough, though it's possible the call chain will need to
be simplified by (re)introducing CONFIG_FS_VERITY=n stubs as well.
Notably, fsverity_get_info() currently has a CONFIG_FS_VERITY=n stub
that just consists of 'return NULL;', but this patch removes it.

- Eric

