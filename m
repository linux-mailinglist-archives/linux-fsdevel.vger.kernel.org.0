Return-Path: <linux-fsdevel+bounces-37486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B039F30AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18233188444B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9634204C23;
	Mon, 16 Dec 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKVIOaKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D21FF7BE;
	Mon, 16 Dec 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352741; cv=none; b=PDJuGIpCkmxZreSyDDthG0rLHw5wu/CFoki8zTA3fUqz7FGhIz05FW5KVRk/uIVWQfC/Hm7ktFmoPsfHj7Q3T5ItPqhBBPMYsm2lOegreEt4yTSmqXcYf3Fsrl72UvLv+Nf1K1h0Bkeu2pOXzDluz0BUg0zapCkk0IjqsZdIgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352741; c=relaxed/simple;
	bh=RxrgrvihZTuoLyQr4cr+IrHGG+3c4Zsd7PvDcCZzpnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAuoYmc2EvughJLgo7G/irZAoZlMemIbJNgjT407iP8EZ7JIbIxpnOnNwk9rRMtI8FeCK469gd+G7akWI5a/WPOA9XM1GB4qQ3tqgxaO4JYj2s6I23wGwnRRqditab4opPWhLZ1dpVTN+0dQUo+shnJ1bTIF4Ac+hLUQJG3UP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKVIOaKc; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eba7784112so1449258b6e.2;
        Mon, 16 Dec 2024 04:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734352739; x=1734957539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVGVMQ89oExPaozKGHaGfm/3lGE50xUx9fRNT1jAvsc=;
        b=LKVIOaKcf3eAWsEd3/6Ic239U1y2HiAZM8GmsXGNJJHiHJ/iiZeKuPK43wY6Rft80C
         g4UyWD7mmCPWu6cfRa0Ymht7cgBzGj9Eh6xRQCmhysDYLMte5Jow3FxEoA7scwrGHi4n
         F8XyCVNWz2kHWrYc4tEbUgpQS09mkSWcROwu/t3FL00REyEdag93KgY7dzdSljrPUEy6
         RMXok0rq7P7+6ygN43Tsfj28iR9wdICBIRWt4ur5ZzLHgPeGKH7BbGh5Ohwf9LOrHqCD
         h8YOMoGbmdn11+zn0mbEIRYa0RE7agDgdnsu+VzmUujVzvXqxQFXC/9qMOWaYehPLYWL
         QSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734352739; x=1734957539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVGVMQ89oExPaozKGHaGfm/3lGE50xUx9fRNT1jAvsc=;
        b=jICOnYP0w+QDE8Z9YBfjlTj8Bnj9iNBvyADQADWuFlhuYkEyyWrkF5Ou8efTe1Xh5g
         2MuEHNNztTZTLAI5YJ7aP9VQ8YRs3GyMTXppM+q2Fm7pp+fKPg6Bouw0ZO366pz86rJy
         Kw3MVQ6D1nRMyWxHepl8fh7e75MZYsUZltcT2uhmTeuAx6fUW6GvZuLVw3stGpfMz+M1
         gucyRk+bfvZ8bsT7VZ/SAyaOiblNTsOvWwH/BMahKxRYXhM4F6F6gfyxckO2Gu0D16d/
         RPxJQBQeyR5RWVdQXr0gWJKGY+QNpL63IVbWIZFRwaoyiZ92HWCCvRH9juyGc5AUP6aa
         vSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2PIqTskZyPZMiJBgFdiT3VSH5w7Q5baVWwI9YsF8NSBY2yLVfDblrpL+ThCrtgDRUoEAPozJOVKZVrNG2@vger.kernel.org, AJvYcCW5GkTJn4xNNSb1+cT42YoaOX49vqapj1QP2b7wnIo1+hCGpNVLgiJLJN14l1kdjhhexpT5tYDmrMWz@vger.kernel.org
X-Gm-Message-State: AOJu0YxImi5Reu3n+1RnHQNOwUTXQMIM6yyJxRsEpW4HnAuFzmx4767D
	gzAO80EJG2ncPv4s6hYkHFaDpnBLxHr31//NGcvnNbm6cBggNXJ0
X-Gm-Gg: ASbGnctiVhacfADi2yJFFerZE4Qb5WbSwWgpz+cjDaWUVrmIfPHtBfctVRuSIQ93q1r
	4No8ZutsURcU0IIFV5rUaiI8XlIfDnXvk0QybmFuheaETxulVaIWvum/agAeUNxkd7UaYmm41P8
	Gs2XlBmuhj8oGCnvUtK7qyjGZNa2NjYCG4ArFLY0tA4VUJeYqDgypFu2EcGtbj3gJhH8NgmaX/j
	zf+J2BzCo0AT+bt0gNmMYKM7SposPHfzp99xEkiEsiQ4lc=
X-Google-Smtp-Source: AGHT+IGRpWafDNkQJ+0/EF66VMx/62RnlUk4Fn+/6oaYB0X5Px1PH2XyKtGdpy9/e4qQAyjFNNExcw==
X-Received: by 2002:a05:6808:14c5:b0:3ea:6174:ac24 with SMTP id 5614622812f47-3eba67feba4mr8251226b6e.1.1734352737677;
        Mon, 16 Dec 2024 04:38:57 -0800 (PST)
Received: from illithid ([2600:1700:957d:1d70::49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ebb492bec3sm1516861b6e.45.2024.12.16.04.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:38:56 -0800 (PST)
Date: Mon, 16 Dec 2024 06:38:53 -0600
From: "G. Branden Robinson" <g.branden.robinson@gmail.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	ritesh.list@gmail.com
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
Message-ID: <20241216123853.g43jqafi7avnntpg@illithid>
References: <20241203145359.2691972-1-john.g.garry@oracle.com>
 <20241204204553.j7e3nzcbkqzeikou@devuan>
 <430694cf-9e34-41d4-9839-9d11db8515fb@oracle.com>
 <20241205100210.vm6gmigeq3acuoen@devuan>
 <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tiyppvgn6f5esnzy"
Content-Disposition: inline
In-Reply-To: <ba9bbcbd-a43e-465e-ba17-8982d8adf475@oracle.com>


--tiyppvgn6f5esnzy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] statx.2: Update STATX_WRITE_ATOMIC filesystem support
MIME-Version: 1.0

Hi John,

At 2024-12-16T10:35:42+0000, John Garry wrote:
> On 05/12/2024 10:02, Alejandro Colomar wrote:
> > On Thu, Dec 05, 2024 at 09:33:18AM +0000, John Garry wrote:
> > Nah, we can apply it already.  Just let me know if anything changes
> > before the release.
>=20
> I'd suggest that it is ok to merge this now, but Branden seems to have
> comments...

I don't generally intend my review comments to be gating, and this is no
exception.  (I should try harder to state that explicitly more often.)
Please don't delay on my account.  :)

Regards,
Branden

--tiyppvgn6f5esnzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmdgH1UACgkQ0Z6cfXEm
bc6iNA//WT+ynMu2/AuQ7G7FCSK0Ue2De75z3UHuw6ev6I24nnaLbH+aDJXJe1Ef
sfDqMLrZ1FaQbh0jImoFAE6zfl4gb+DO1KH318cL9rWgC7GcuBydNweiMdLv2djM
I/D6PylcHhXxUE+iLHCEOep8zIQpB3VcusHPwakNbePpr+zpT2VvEjoAdMcN1NeJ
Dow9LIB2NcT8cQMcMGyDtrCSWya+j2zvwpmSN2NmjtxfgZKuldD1aRzoxRFhmJsi
WnNseMJNMTYtn4knfNtZwFW4DOy02iKG0cnxKLPbD0MJYwi33tmruKBYXkRSwg+V
BDtLMix4Nnc8R2n62q1NfnLTWGABZDgi3N9qLhIpfJ60N3zxaOltfFPr5BTig+7n
5Pa3gMaRmfp9RJ9p37QDHvB/6z+Lcu36q6en6zVfmAAVkDdpcEm12CpvSp+zyh7K
d1uciEEVPOGLJQxQQgjZ+KKf5iMfX0EpqywEmk9CyfQwQR4ObajD7SuC/y2DLfG6
BoOcosebShJdmNE9rX+QrJjkQ5IszisoGfJEruuzYdSnnQ7d3ajetJMznas/kSaU
pTkoUHNAfDgr0DDHf3mM8S28Ez8nzPvtiCEqglv4Ewk9oYA3JyFbe103o5iFk9qo
OAxwKdJwoiluB2VdsIC0uEPooNSygH9GrPKhpPdFQM7hSnYifvM=
=sYF0
-----END PGP SIGNATURE-----

--tiyppvgn6f5esnzy--

