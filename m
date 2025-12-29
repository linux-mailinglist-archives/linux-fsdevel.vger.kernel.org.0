Return-Path: <linux-fsdevel+bounces-72149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 801C1CE5AA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 02:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED9233008F9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 01:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678DD21FF21;
	Mon, 29 Dec 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoaGXt7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7581DE3B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766971331; cv=none; b=sq6waHvAWPkYr1SzFESyVcfaOKIan+FqH+WMYe/SLteFs2beNtmp6XSOF843CQNLL+hRy15f0ljc7lA08YYIt3O7CWTJGGzFMFOp5Lfysse0hCGy+fFRIqK7oukUloxYA/GNGeWbYpgHSpEMRSQgZGGQf5w/IAfd1CXU4Nzffb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766971331; c=relaxed/simple;
	bh=tWwhnzAdXMi3MgiDU1t3kLJHgUFZyXspGaFSp9SGreY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLrljGZnyyf3HjJtHqw/i1cNzdcdcXOORm8cs9cV39C6rn/fq7vS08qAqJ87p97IFeG5RdBv/gZ144Odyk0Ue/jpGX0yyCS+lRCMHwp57knG7+QqxQpZnzz/e/QsQXHsDfZRA2IeODVFNy0LJiCsdP1w9jH20gChYAtenuP02IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoaGXt7t; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0bb2f093aso86718505ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Dec 2025 17:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766971330; x=1767576130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWwhnzAdXMi3MgiDU1t3kLJHgUFZyXspGaFSp9SGreY=;
        b=SoaGXt7tA7ClyrO2W/8ZO7gtV5S3s7sI2udzqd7v05lYKT8xc67/y4GmjiW46OIsX1
         ujE8E/7jFPYcioyNJvtZCBKa5G4RhffYnl2gSVEshNawbcNrVZBDk8MAAzgPGxcXrm32
         1mfsXT6yuE01OCSN4mBV7shS+j/oVTE/jYJ7Y37x6QmVqqB/+/j1xmfVUKTg/Pcpib/t
         D5P0R49Fl+yW9wl9OS9FriQSsaJTZtvHXt5htfdbmlTPavWF+694ubFr7So4Jqcp6v5T
         H13Gqt1tH5c8MpVFHBN9Q0f+E9t8PSfQ2KeR9yUaQiarOUqeQ01zqv6YMCHSez4QyvyS
         WHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766971330; x=1767576130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWwhnzAdXMi3MgiDU1t3kLJHgUFZyXspGaFSp9SGreY=;
        b=aQg19p27KYLHGdmo32lCbluKktuNePIbHxYjMbgT6e3KUAK4PbSfMw9LYslGvXGSAe
         10nMN76AxWOYq3w0x0RRg1NA4fcyIHhUPof3390EUC/qod8+YjlnjwgcA7f8JOl1N/ks
         Y7BxRZIA4QTJoIA/FYQIsxFase5yZrDpkTfDDZyOcbSMUC9/U4TYWxnLnU32NyQ/vOtT
         qUEm3G46e5NwjvmsqQ/yN5JVHgGVBBaMTN+tnTbpi+RZkmNM3TPS5hsEtqWFsORrCEPW
         7i2uOX9OJLmAWuDeVs7fiieIePSV70dfXsetEaQsbEcyJVM27ovrs8tIHeqGWviLA008
         Nv/g==
X-Gm-Message-State: AOJu0YzGR7PIRbxlXgrsYptDb4KmH6fBwIWyIYXh3SB6Nyr8RMWf3Ton
	9aOVYwzGIJ7PelhHLeFnEve2UV6nPY6nj3llF/cpUkhYfSLId2gVTGsz
X-Gm-Gg: AY/fxX7tSKcHubZnrCs7QobJrGHSjtR0d/rE238iCcQPqCQnoMEyyUErn2NXG7XxXYs
	dmPoePSBQ8MFATqneYXhyxmXu2mIQ7xROWFeopw1CkTZ7Y4Fcea3OKLQkxUymu5YJdiq4fwCrib
	IYJ4z/kZauKvQOM0hH/UObRg/wqb6Hc3XatnqL8RElF38WRQ36LqsltrE5bQ2ghRrczm4wSo61J
	9S14uTj1JXdvvI3dnYXhvrPaPbMe0CytVzXmxjkv5l8tWDr6tDq2DoQgiSMGazV062mRyVgq9o3
	oslykTy+mTc8sVRSCX6djZMxnrkEg1N0Q5ZV8OrL1koZX4rZ+Ofbdkx9hnWvlGatQHAJY2bQ0mS
	Kr9ybRVT2jW9phENp2UeNqnrBudYdSK5vQg2ASoXTeU+XFobrk74dfNIwhAjdL2tpBWFTrwA2q6
	jgELW/PVSm1g8=
X-Google-Smtp-Source: AGHT+IFR2E088o3YuU0thtlAysft6Gj0OhHko20V+q214BwIRb8WUV+POgltHl7Jezk/JoJXj90jag==
X-Received: by 2002:a17:903:46c8:b0:2a0:f46a:b842 with SMTP id d9443c01a7336-2a2f273263amr301772475ad.28.1766971329587;
        Sun, 28 Dec 2025 17:22:09 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82762sm252035635ad.27.2025.12.28.17.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 17:22:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 825C243C7A4E; Mon, 29 Dec 2025 08:22:05 +0700 (WIB)
Date: Mon, 29 Dec 2025 08:22:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] inode: move @isnew kdoc from inode_insert5 to
 ilookup5_nowait
Message-ID: <aVHXvFogllII_Q8E@archie.me>
References: <20251229-fix-kdoc-ilookup5_nowait-v1-1-60413f2723cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H2Lbq6lmNQRbhqbR"
Content-Disposition: inline
In-Reply-To: <20251229-fix-kdoc-ilookup5_nowait-v1-1-60413f2723cf@gmail.com>


--H2Lbq6lmNQRbhqbR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 01:04:07AM +0900, Ryota Sakamoto wrote:
> The commit reworking I_NEW handling accidentally documented the @isnew
> parameter in the kernel-doc for inode_insert5(), which does not take the
> parameter. Meanwhile, ilookup5_nowait() gained the @isnew parameter but
> lacked the corresponding kernel-doc.
>=20
> Move the description to the correct function to ensure the kernel-doc
> accuracy.

Much better, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--H2Lbq6lmNQRbhqbR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaVHXtAAKCRD2uYlJVVFO
o9sVAQDbyraLLMS2uW01DT22sCnPm/ZA0tmitBngtN4AcLCfpgEAoh8pKMRLo4mX
PnIZvTAaUwAUPfOmWWbS+hD9hPDmqAE=
=VPVN
-----END PGP SIGNATURE-----

--H2Lbq6lmNQRbhqbR--

