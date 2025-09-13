Return-Path: <linux-fsdevel+bounces-61194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4CB55E19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 05:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA16AA7578
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01841D79A5;
	Sat, 13 Sep 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eRu/fFL9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VV2Ixn6a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F673A935
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734486; cv=none; b=mj13lQJt1J6NNsB7bVrcwIl01KcbtUVVnpSVjVxSornsEK16DOUC/Y3gdTyUzsb6QQtcS3faVAeUgtAQ90I8x2TWLhSFIuVGikD67wd1fr4+8p2UBDfX6GHXTCdS5mJW+jhRg89iTV0ICC/8kZpW4vvbnzWALa3zZEYgPZE2vPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734486; c=relaxed/simple;
	bh=YSJuFiPrKdq55WezCrMNFxFNary6Iz54UJFIinQijmc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gfYufVvKwn/U6LPC5SMZWbUY3WdHxEvSYDdTrYefuovp0PREzN965f7Jyo1+NiOlskohfOdikmPa14MFieXnlesETWbjZBg/e+sTmkULCSgXrsoEfvroIVcVkGb7mQXOVgSvTKQPFzWCIwnrUm5SoPz/HQOd1oELp9YGzjLCeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eRu/fFL9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VV2Ixn6a; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F40527A01EE;
	Fri, 12 Sep 2025 23:34:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 12 Sep 2025 23:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757734481; x=1757820881; bh=t7b1nTt96yh/AMOPFnuZ55klWLokSshMo2L
	Q3RZfn1k=; b=eRu/fFL9s+bFEdeg6iw5X0ezJIsyP0GETFDPhftwa4BUzan16iF
	Vxq2yPlzOMfoIRpFynBRj9NTySY50ca7+lHzyyKw5NazLzAZFDtbTxHUqBYECwUC
	WTCkJSLU7cPsZWRt2EwAFJT/Rba4DhcM+gqIsau6HQlFnjOipGeuAqsCuYpc0wEO
	aBnONaRhQWFRxJPC6yQy6qDJbf2QemtlQi/8EjD0xQom3iMiIb24hCXSphlaIyOA
	mb8I7+MKxnvGBbwaI4rQ4kdHku87TXc/sCU356Mq7KHL+lixoKPdLjJEYymI0v4H
	ovdE7MZEWF2NWt2Qf8d97SZUZjZPx5PwFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757734481; x=
	1757820881; bh=t7b1nTt96yh/AMOPFnuZ55klWLokSshMo2LQ3RZfn1k=; b=V
	V2Ixn6aWPJGrB9+FNq2rf4B03eS26dEHpCbay8Sdkkmeb9GXqM601ambfhy6MW6R
	4V63kCPsdw32s+ZS+bunPUuzsExL/SzzVE0j+i3KvChepdBxOiX7q03f6YzxLPEw
	piqzHKlKigO5WhddYe0xlAZc0cJjiwchbdwqvAXY1Q6z1Rs+858DGxbATp24f78I
	aKxuqw5g+oT724Fa/7vQpl00SOpWoSDynAo7d3BSSeuvyb84ViGDJrfCAlQTDloD
	K212ZiwCNwyiT5A7B287IXBYmH+xuFUi7sUi32rzHDKwVfl5ATWl5t/ZNEE0dQGc
	9T0sIDRwwjI+vccI559xg==
X-ME-Sender: <xms:UebEaO_6EYyI8kIgXyfHv0ArSyUKWajcKGx3Yc9-rpfX_3ICJxA_XQ>
    <xme:UebEaA-WPGA_hA90A0PSSILBilkPjWlGys-BdnCs36JiJDy8zbadCHHPuqUeiUOmB
    9vGKmE3BwVoww>
X-ME-Received: <xmr:UebEaGQ6tauvrO6rWUG5zmAfIs6Uw8k_yDM6umhxf3tfIMij6nqtaNanK8eWKp17lvVQzAGGyS5BA0uqZ1hhizib_M11rMB3Jqcxc1FGi-oB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:UebEaMcifwmfsJorqtMT4Lzz6WaBjt7JN1wyZvWWLbce0ysKKPlq0w>
    <xmx:UebEaCBtiS3ahqwWKHJJpojhlZbu5mGl0e52yq-y-pPmL8OBYY_BoA>
    <xmx:UebEaGmWW4erfX1UTyxK6qBPet8krCyeF1n6IfeLToguksQnQPYkWA>
    <xmx:UebEaFe8xxX4JJ7XQVRsR_ju46eljWv-5HCddmxZ7K4Pzp1VneoEmA>
    <xmx:UebEaB0t9-us3bGdHQey5-dITQ9P8bmo1w_G9ORk9d8jqS_EhW561_T9>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 23:34:39 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu
Subject: Re: [PATCH 1/9] allow finish_no_open(file, ERR_PTR(-E...))
In-reply-to: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
References: <20250912185530.GZ39973@ZenIV>,
 <20250912185916.400113-1-viro@zeniv.linux.org.uk>
Date: Sat, 13 Sep 2025 13:34:37 +1000
Message-id: <175773447741.1696783.10506741669018237734@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 13 Sep 2025, Al Viro wrote:
> ... allowing any ->lookup() return value to be passed to it.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/open.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/open.c b/fs/open.c
> index 9655158c3885..4890b13461c7 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1059,18 +1059,20 @@ EXPORT_SYMBOL(finish_open);
>   * finish_no_open - finish ->atomic_open() without opening the file
>   *
>   * @file: file pointer
> - * @dentry: dentry or NULL (as returned from ->lookup())
> + * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
>   *
> - * This can be used to set the result of a successful lookup in ->atomic_o=
pen().
> + * This can be used to set the result of a lookup in ->atomic_open().

This is my favourite part of the series - removing the word
"successful".  It makes the API more general.

My only other thought is that

	if (d_in_lookup(dentry)) {
		struct dentry *res =3D dir->i_op->lookup(dir, dentry, 0);
		if (res || d_really_is_positive(dentry))
			return finish_no_open(file, res);
	}

is a common pattern.  It would be nice if we could factor it out into a
help but I cannot think of a clean way to do that.
You can add
Reviewed-by: NeilBrown <neil@brown.name>
if you like.

Thanks,
NeilBrown

>   *
>   * NB: unlike finish_open() this function does consume the dentry referenc=
e and
>   * the caller need not dput() it.
>   *
> - * Returns "0" which must be the return value of ->atomic_open() after hav=
ing
> - * called this function.
> + * Returns 0 or -E..., which must be the return value of ->atomic_open() a=
fter
> + * having called this function.
>   */
>  int finish_no_open(struct file *file, struct dentry *dentry)
>  {
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
>  	file->f_path.dentry =3D dentry;
>  	return 0;
>  }
> --=20
> 2.47.2
>=20
>=20


