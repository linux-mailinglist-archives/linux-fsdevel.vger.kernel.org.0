Return-Path: <linux-fsdevel+bounces-13919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE38757CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE760285FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F9B13790D;
	Thu,  7 Mar 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCrstuBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBC11369BB;
	Thu,  7 Mar 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841710; cv=none; b=c71zHSjbB2L0f7cCV45sua/Hdo8Kst3sICzqAte9GHUaXV7mEmCIStc9beLMs52kj01voChPshVB1DARdKisb5jGYFCEGJUnOm3nMsp6GY8zE29Q8TILMgCl9yMe0CzUL//Kqrq45i+VH7OZZBJCu2kLsCQY1hjM3rMxFJ+X6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841710; c=relaxed/simple;
	bh=hm84kKA+agsubOGm1+LlamcrcgNE0elQViO53M8e5vw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=megXHU0GLHsterQs3VHfm6Lc6YUOChqjyANH5g2XcSbLOTICbL5+w2rW0BkTd6Q//sZjhGKGgiglK/N3pCvCO3RyjSCimFT1SE5LrMWeyqBGH8r0XQJeGmmFWHmUr/oS2i6IgOkM8YE55v6oJMXm/NFHel2ToEeq0c54gqigE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCrstuBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2E6C433F1;
	Thu,  7 Mar 2024 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841709;
	bh=hm84kKA+agsubOGm1+LlamcrcgNE0elQViO53M8e5vw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nCrstuBNWGMyRdB5B1+AtiMquqTfz78AvfEfXy/Koy972kXN2U+kiun022JTjIW+Q
	 I+Kvk9NNKcXq0jvNIaRJeBi0Rk1+y7YCSmv+5RhjmuGrPZDSZz7wDp2g0fYtvwS0gm
	 URcMLyL3ypMC1bLDiCMdeG7TNW6nAi6KA7wvAtwfUXLnV4vhsp6JLXEiKp5STtodkb
	 XtsbrEdh5FkFp+2d15RTRyRUMMBezn+z5Dh+51934xKArsgW0evGf/XGeD6K/JMKIY
	 ECgYrlHl1dDovWyPlk1m64eGGiy1nMc8JaMccUrwKpDdZc6TohOvjNTwNb68RAtJlO
	 c3RIlOLQxNXfg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 22:01:46 +0200
Message-Id: <CZNSASBASJBK.R8MZW6X5VKMF@kernel.org>
Cc: "Seth Forshee" <sforshee@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>,
 <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
In-Reply-To: <20240305-effekt-luftzug-51913178f6cd@brauner>

On Tue Mar 5, 2024 at 2:27 PM EET, Christian Brauner wrote:
> The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
> that does a racy query-size+allocate-buffer+retrieve-data. It is used by
> EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
> where 9p returned values that amount to allocating about 8000GB worth of
> memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
> no reason to allow getting xattr values that are larger than
> XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
> values and nothing currently goes beyond that limit afaict. Let it check
> for that and reject requests that are larger than that.
>
> Link: https://lore.kernel.org/r/ZeXcQmHWcYvfCR93@do-x1extreme [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 09d927603433..a53c930e3018 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -395,6 +395,9 @@ vfs_getxattr_alloc(struct mnt_idmap *idmap, struct de=
ntry *dentry,
>  	if (error < 0)
>  		return error;
> =20
> +	if (error > XATTR_SIZE_MAX)
> +		return -E2BIG;
> +
>  	if (!value || (error > xattr_size)) {
>  		value =3D krealloc(*xattr_value, error + 1, flags);
>  		if (!value)

I wonder if this should even categorized as a bug fix and get
backported. Good catch!

BR, Jarkko

