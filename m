Return-Path: <linux-fsdevel+bounces-76647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJQfAvBQhmnQLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:37:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E08103258
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E9B303DAF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 20:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089330EF82;
	Fri,  6 Feb 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6jh2XcW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEBE2ECD32;
	Fri,  6 Feb 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410190; cv=none; b=PZ3Ou+7qHmVusskALkHpn10o9ICRVUQu4uX1v2LmnaYpmgrj8HL56fSEgS8PFs0iqq23+xZfVty4B41AveQQvYy3Vd3aQmn3JzAQAeys7p80iPAh9Goljua9hENKIdvSFDO9ARw5viLIJXklT3kFuRC7VTKVEfRG3HwTa6fKQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410190; c=relaxed/simple;
	bh=Ziova90xMI7CN1SotliWazTIi/cjDQBCr6Que8iOWh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVdxZVCvx341n430HVaOGNOS2cUqJsCHnMFB5ZKhgQkDzELvosAerV08t84gj5wrQWfNEPBYlzqaTIJl6dzu/LzUfzn6yDtQFw9h2e01IsUg7uGQgxRrIc25THsVblGpKvlQn4G8yhsUVLlE5zwUSGH4JoLsINPmNAWqdMlN7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6jh2XcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19940C116C6;
	Fri,  6 Feb 2026 20:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770410190;
	bh=Ziova90xMI7CN1SotliWazTIi/cjDQBCr6Que8iOWh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6jh2XcW6uf6I0YmtBGgkkzEaCO0jyXK2baByetwInFVCgm1RZct9TPpthkizR5Vd
	 cfnd8T1JYA0zxvnnbXrZJ4EW3+NkySCr25Uy0KTnfbdASBQyuq/tDf4OdR8IGwNi4+
	 G5bn/eDvxck7U4FTbUX0w/q/jsO5DznO1kIjPAzNEaJtRVgrq18JjxIqAXy0G1UDUR
	 SpOjMoMnxTfv0dWCyzPi8Yf+OgDmUi40/+Yo2pBWEO584jyRYlaMc7iiKNWbwYpWM4
	 N8c52wPYbRJlqZNEhfMv9CLdrpipwxHJzhOfIwq0CCasXZZlSQaikF71YC7GZdmpqE
	 cJs7J7RFf+QSw==
Date: Fri, 6 Feb 2026 12:36:29 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, syzkaller@googlegroups.com,
	andy@kernel.org, akpm@linux-foundation.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [Kernel Bug] WARNING in ext4_fill_super
Message-ID: <202602061229.D90563C500@keescook>
References: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
 <aYX4n42gmy75aw4Y@smile.fi.intel.com>
 <aYYD3rxyIfdH2R-d@smile.fi.intel.com>
 <aYYE4iLTXZw5t0w_@smile.fi.intel.com>
 <202602061032.63DD1CA3AE@keescook>
 <202602061152.EAAF56214@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602061152.EAAF56214@keescook>
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
	FREEMAIL_CC(0.00)[gmail.com,mit.edu,dilger.ca,vger.kernel.org,googlegroups.com,kernel.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-76647-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55E08103258
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 11:53:09AM -0800, Kees Cook wrote:
> On Fri, Feb 06, 2026 at 11:29:11AM -0800, Kees Cook wrote:
> > But I can't figure out where that comes from. Seems like fs_parse(), but
> > I don't see where mount option strings would come through...
> 
> Oh! This is coming directly from disk. So we need an in-place sanity
> check. How about this?
> 
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 87205660c5d0..9ad6005615d8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2485,6 +2485,13 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	if (!sbi->s_es->s_mount_opts[0])
>  		return 0;
>  
> +	if (strnlen(sbi->s_es->s_mount_opts, sizeof(sbi->s_es->s_mount_opts)) ==
> +	    sizeof(sbi->s_es->s_mount_opts)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Mount options in superblock are not NUL-terminated");
> +		return -EINVAL;
> +	}
> +
>  	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
>  		return -E2BIG;

Oh, wait. I see these commits now:

8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
ee5a977b4e77 ("ext4: fix string copying in parse_apply_sb_mount_options()")

Ugh, the history is that fundamentally s_mount_opts should be
__nonstring. Old code handled this fine (by using kstrndup), but when
ioctl get/set was added in commit 04a91570ac67 ("ext4: implemet new
ioctls to set and get superblock parameters"), s_mount_opts started
being treated as a C string, which would lead to over-reads (due to lack
of NUL-termination).

So, should on-disk s_mount_opts be required to be NUL-terminated? I
would argue yes, since right now a mount of such a thing will crash with
the reported failure in this thread. So likely, my proposed fix is the
best option?

-Kees

-- 
Kees Cook

