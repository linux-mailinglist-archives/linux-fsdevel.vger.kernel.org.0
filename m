Return-Path: <linux-fsdevel+bounces-44145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5DA635AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D0016E42D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Mar 2025 12:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB551A8F79;
	Sun, 16 Mar 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="Ld8tWdC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7986348
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742129674; cv=none; b=gIvSa40Dn0DVvjNVOCXCAobOhnlVI3h0xJQb8y2jTTvqxyHw0SHVPncY6Iw+AZIp+NjMFeRu+VInbe3LiOKLAEdkDhPhGftYfjifiSWOmh1cQl29a/IQqmSsCB7tvE8RD5HcfH5uponeusao1CsBGoEuC6Udj1ss98V4y2V63jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742129674; c=relaxed/simple;
	bh=OxA9qjBJqKakYnBRGso9o9ug7I0v0v6fw9kJZL/v/EQ=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=jkhUdtHxkA4bL831UbM7Ez35qxOoYiHPWuh2jhLz6DVFZLA/tmlpoSGpnO3IjIEeLx0BE1kAdab+7M894iHh7rsTTSdI1Q/GIqYaX335gP+GAdBS2Gn8//FgnoAiqqq4jaXKVtBg4DYZ5aQEbhp4VHAdpec4GhAxGLIA6SOZB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=Ld8tWdC/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so69119455ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Mar 2025 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1742129670; x=1742734470; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DNgoIYRjmwaaNFGCS9H1CvEFT1qMkwLF12E6od/1rOs=;
        b=Ld8tWdC/eOY6w1F+Fnc/5pk2MW7JvwwhAuT4snjfVVTFRKSj9GWyKF60SQ8s6/c83a
         Oeo7RVzYpsCGk0JddN7Pgmv9sGjV3vh0SnYi432XaBi7bhJsCTkSv3vByoYemkmsbdFt
         TSxWZBtT/YC2BRYHudBk/Jl5ROQYU3ixpIjv3ucTF4FLtddKo3SOtonLLWqlU6aRCqrG
         9Qfl9MJPyujYhtElGkk6gU6j3a2K33lcEiw9TLMrPeKebdyMCdB+rrsxk0Nbk/6MfVOX
         mvZiqlBYRzitSNRQJFIU9Xlw2xoSvmMy1zgCN/ySq79mKSlnM4dv+zEU3uNtPtyjMixU
         VPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742129670; x=1742734470;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNgoIYRjmwaaNFGCS9H1CvEFT1qMkwLF12E6od/1rOs=;
        b=k5RT9kDe4NjF0ncgwqELk1FGd4F5cs98w9b5iofOb5b5pMRvkrDAbD2BTfY3NL++N+
         QWbs0U1wBWdO+B5KP56p3GDVb2TvBGRgqe34xX5Ioqu4SXp6QhYUvJ0Jqr6sacVvWndj
         kKUHoi+o9RJZgKXTtKuq935dm0yu3Zbr2p5hMP5AI9hQ02B08oDIf1/IiTzM+ahKh0AB
         MmEVEl+D88cwkbRgrEl1voIwWouJAnv98OqvpHtpW/jYL2pjtzAOJL2vZ9MGgBbPfKwt
         qAS1jTE6Ep7Vd+pUQPf8+/FZRAsVjT1v31ZaIOmADbFSgrxLEgHqsgoDjnx5tx65my+J
         YERQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1BFyYOtrEVP8mvAhq/I1ZmcP9hqEVdW8nEjGhhY62hG700YpN6PlwnR3qcp6ZA6v0H0sorGJNsMKemcl4@vger.kernel.org
X-Gm-Message-State: AOJu0YzXmSDp/cFr6ga7r1rI7lB7hujxhIJNaxG2NLRm+Q7FTjZMX27b
	+uX3nlUjAy52GmMHK56My6cdpYLG/zHXdLvNBhQtkeU8UssGnZMWOQQdWtONYIY=
X-Gm-Gg: ASbGnctLxGhjYUSOYdfqREB/Ps16d9cPxfUAqoi5WxQ+CvLHaHSAbookBn7YSpp/BZ1
	CAXLBXROJ+/qEbjm6W5TJvRKsULT/0SQ1Rhx38zLtBvFoILhjEZJoKf34zKOALXs9WS8trHvyaF
	2gCV0pBJ+FNNI0TnV0LKeLzGnNqX/8Aa4c93zow9S/g0+XakhyGSCc1DwPu9nuvKAwAWQnyAlQY
	/9Nk/aXc1NwTMm5r+FGhp75xcFkI2tIg358njnJhE89u+pOMqWnmVXXgRuiBqpmOW6VsMp84CVs
	Q64f2bU+bWS9tIP74oLZ0FI8OsdPM/LNEFqjLOuZA7lpu3JxAr9ncV6NcwYCi+RAtngvSr1Rtaa
	pcwzqlBBpibp+t7WVow==
X-Google-Smtp-Source: AGHT+IFzsFhOYNXxQ4P0xXMx/sSODUbQClgIcbHZhWjx33vG1Z2MB70E9uzcFuoB9hQ2s+qFlx9SMA==
X-Received: by 2002:a17:902:dacc:b0:224:1c95:451e with SMTP id d9443c01a7336-225e0af5c09mr90792615ad.33.1742129670186;
        Sun, 16 Mar 2025 05:54:30 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbeb94sm57281945ad.199.2025.03.16.05.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Mar 2025 05:54:29 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <1AFB99D7-8C35-4011-8A76-8D5099963C00@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_39AAF613-7FCD-49C2-BDB1-1F3EA6BDDDA2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: hash: simplify kzalloc(n * 1, ...) to kzalloc(n,
 ...)
Date: Sun, 16 Mar 2025 06:54:11 -0600
In-Reply-To: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
To: Ethan Carter Edwards <ethan@ethancedwards.com>
References: <20250316-ext4-hash-kcalloc-v2-1-2a99e93ec6e0@ethancedwards.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_39AAF613-7FCD-49C2-BDB1-1F3EA6BDDDA2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2025, at 11:33 PM, Ethan Carter Edwards =
<ethan@ethancedwards.com> wrote:
>=20
> sizeof(char) evaluates to 1. Remove the churn.
>=20
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>

Thanks,

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> Changes in v2:
> - change back to kzalloc because sizeof(char) is 1. Nice catch. =
Thanks.
> - Link to v1: =
https://lore.kernel.org/r/20250315-ext4-hash-kcalloc-v1-1-a9132cb49276@eth=
ancedwards.com
> ---
> fs/ext4/hash.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
> index =
deabe29da7fbc3d35f674ff861a2f3b579ffdea2..33cd5b6b02d59fb749844fe481022f5f=
44244bb6 100644
> --- a/fs/ext4/hash.c
> +++ b/fs/ext4/hash.c
> @@ -302,7 +302,7 @@ int ext4fs_dirhash(const struct inode *dir, const =
char *name, int len,
>=20
> 	if (len && IS_CASEFOLDED(dir) &&
> 	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
> -		buff =3D kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
> +		buff =3D kzalloc(PATH_MAX, GFP_KERNEL);
> 		if (!buff)
> 			return -ENOMEM;
>=20
>=20
> ---
> base-commit: da920b7df701770e006928053672147075587fb2
> change-id: 20250315-ext4-hash-kcalloc-203033977bd9
>=20
> Best regards,
> --
> Ethan Carter Edwards <ethan@ethancedwards.com>
>=20


Cheers, Andreas






--Apple-Mail=_39AAF613-7FCD-49C2-BDB1-1F3EA6BDDDA2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmfWygAACgkQcqXauRfM
H+BQ0BAAsNaIw3vgIaT+xh7yJw5BH45EMg3Ku3GEXEt1acV4lFDZhcF1LVfC0vsa
M74lEHtETKjJWBIcYZLqXHZGLne/JpFbt6g1HfTjaV4MMfooNNrA44VnZYLUUA2+
RZM3HrlWFUhgvqP+j8nY8pO/1x6KuStnv2FiitZbAFeKyw+HjrGF3hZD9BZU3tds
AG0jpP6rindOWFzQFgIBB88Tl09BUSDsq4twC3vdkJ69fxYtuEhVqrQsQTRSG5oQ
Xp8OaKkgUsOr+AqWSqtqYLBH96Ogp61qsjQH1Ax7aYvt63hTlsVLCjwa+vMz1gTf
ji6BYvz7SP/4lFJJfDqVlvUlPhFKd2StdFn8WhAUqgkseIVA+GCaSGlcXuC+lFaG
pimvYEKQ6kNETl7aop+tMn2ijy1Nb8XFO9mf7PpuIDFIjtdvCNEj+vbnMbdI1VLm
CymVdzVeQENPg78GqlumiJm7BIX8FjdA4yH3enUueXDoAlT/3eNu9a+kfLBngqci
HxYzThWlICLdSQhnX1ciIaB3P9b5e8+4vEE5j8AXbaVJYURdEr2UDQUnXRYBL0Zo
zE9MbxpxXwVju3m7khAj5L/XQOIK3cC9HUcYA+/CPTZ8O9d2EkYHQYc6bqXOs+7t
ldMLrwbbyRBVSZjHoR/wsr8TD3budCa9f6A8/rw7um/MBqWIXJU=
=jEr/
-----END PGP SIGNATURE-----

--Apple-Mail=_39AAF613-7FCD-49C2-BDB1-1F3EA6BDDDA2--

