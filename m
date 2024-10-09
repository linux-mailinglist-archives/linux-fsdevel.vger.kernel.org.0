Return-Path: <linux-fsdevel+bounces-31498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E3B997804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5539228300F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 21:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD391E32CC;
	Wed,  9 Oct 2024 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Lfhx58LF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9C183CD9;
	Wed,  9 Oct 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511167; cv=none; b=QuNY5GHeRD1vxNDYy4NWQUwhSVRuqMcucLRA62NwVninUYVII0Xp1Ysso/YBGks1XxKjuuaNhXdHXnHZzxqxrds8Nn30DjtsuNj9VF5DlLvvl5rWnZ3zsPeB6SWmd+QYYJ6IAYt/6b4hZAG+CTpGIApNPoalzebIuAbzRQdhE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511167; c=relaxed/simple;
	bh=E5AWC27aG0o5CisvhFleFhR3/dF6OzCogmbvKgH3AVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I+Jms2dn8cgd8gyOV6TflIUNTQxjHEZSy8sBhXtMzpEamMi/C4kwu/kVDA6AhTURHyk5nymAQzdaMZW4aOId9Zrp1RxJNsGFTtO725wnpGmwWS+r0RijrhAKu07yJzFpBjQZi/13o9/1VYcy3VmNPPzKMlfLuEw5Ht++PJXAFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Lfhx58LF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 539E742BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728511164; bh=XXDMsRlCKxTG6eBTaXeYupkf28S4+lkWp0XdWJLcz3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lfhx58LFy3EJoF0gVVY5dCY472M426TbheH4EW/a12vVWIo9v00rnP8u1EzkCbI3d
	 ZWRA20ONrtHUZIkYfhHvHp/o519eJkv160jA9twbuVXUhd0uRInjE2hbCoYjUu6Fc+
	 ZuhUs7oFAeLMCZeuQR/LL7G5xytPXavxXHmZTFpoyVnxFtga17LzM49mDsMgCZyLr2
	 5YnGjYSaHlSuRwNCbVBAeq+Jfm3nXBt5/fxoK7DSR9U80zBe1rH7VcOY5aw53U2RuE
	 3tl9O3H4huJ2lg7zL3YPmRc0p6P71T22mscANvXduAN2iQUuUKfqrwkKTeqJiFtIp8
	 2jIrNiOmFqG9A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 539E742BFE;
	Wed,  9 Oct 2024 21:59:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tamir Duberstein <tamird@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] XArray: minor documentation improvements
In-Reply-To: <20241009205237.48881-2-tamird@gmail.com>
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
 <20241009205237.48881-2-tamird@gmail.com>
Date: Wed, 09 Oct 2024 15:59:23 -0600
Message-ID: <875xq19bus.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> - Replace "they" with "you" where "you" is used in the preceding
>   sentence fragment.
> - Use "erasing" rather than "storing `NULL`" when describing multi-index
>   entries. Split this into a separate sentence.
> - Add "call" parentheses on "xa_store" for consistency and
>   linkification.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> V1 -> V2: s/use/you/ (Darrick J. Wong)
>
>  Documentation/core-api/xarray.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

So sorry to pick nits, but it's that kind of patch...:)

> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
> index 77e0ece2b1d6..75c83b37e88f 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -42,8 +42,8 @@ call xa_tag_pointer() to create an entry with a tag, xa_untag_pointer()
>  to turn a tagged entry back into an untagged pointer and xa_pointer_tag()
>  to retrieve the tag of an entry.  Tagged pointers use the same bits that
>  are used to distinguish value entries from normal pointers, so you must
> -decide whether they want to store value entries or tagged pointers in
> -any particular XArray.
> +decide whether you want to store value entries or tagged pointers in any
> +particular XArray.
>  
>  The XArray does not support storing IS_ERR() pointers as some
>  conflict with value entries or internal entries.
> @@ -52,8 +52,8 @@ An unusual feature of the XArray is the ability to create entries which
>  occupy a range of indices.  Once stored to, looking up any index in
>  the range will return the same entry as looking up any other index in
>  the range.  Storing to any index will store to all of them.  Multi-index
> -entries can be explicitly split into smaller entries, or storing ``NULL``
> -into any entry will cause the XArray to forget about the range.
> +entries can be explicitly split into smaller entries. Erasing any entry
> +will cause the XArray to forget about the range.

I'm not convinced that this is better.  This is programmer
documentation, and "storing NULL" says exactly what is going on.
"Erasing" is, IMO, less clear.

Whatever; if Willy's happy I'll certainly apply this.

Thanks,

jon

