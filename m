Return-Path: <linux-fsdevel+bounces-50015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E4AC743A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99365166900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54B221F02;
	Wed, 28 May 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdShdbQj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742B4A28;
	Wed, 28 May 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472882; cv=none; b=QtMa1GAjKZFiyglnk+kzMSy/FQL+ddZXgcXvLepFdY8PDS16ABLdtlncGnG5RoV1IUyEZOWhfCFPNOZL+XRJ3u8jPUEdGkhl8ELWSfsbWXyjPUCTzIgI7Ee/+kpdiM6Mmfs19mRjYaCr5yflRFL6KPJVLZ5GDOscqiRh5ZgB0so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472882; c=relaxed/simple;
	bh=3cGkQkoWTuBKfIQIbDcC/g/dQymUkZHxWrRjIjYv1Io=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDSMYnKW4nWjRUZ/ZKrDGuunxNi74opf+947wQorhbqXLYkcpjLNoNx57svHIZ7twcWna3WwmCdK1Nt+CmsevXZXG7FEyDp9/ZManF28u89fpH4Y8Hemb4RxoDEoam83WBY3jQ8PklJT4TVwHBZkUIP0N25nE9tImEqc4xLNddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdShdbQj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23278ce78efso3595585ad.2;
        Wed, 28 May 2025 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748472880; x=1749077680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+JpffenepplKhyFKZp/OfkJ5wiK8oE9uBddYOW1nd8=;
        b=XdShdbQjqvlpCdr1PGZSWC8BWBrOhlkpiyx0Uiab8WK4A2l3dJW6etI8nEOUBqLW0x
         kbP/eYt664/3Y7HO95h85+/0EdvSTJpNEKztTxb+toyOAMg/yJmKnj1qtW9j9tyOR4M/
         cWqEpNaGrjdk3/0aSOW+Y8fKj0o5y6ddTyOw7tXmv4W4+/HLxfzvQZoDdI7p66BbyEq4
         kCsdCdQcpiREWAoqR6AEjts4HtfFpv7JoxBqNLhRLgreJVavCMkGZxDPGPVeqhEITEbn
         2LYVwi0BG//Ai/C0TptnWFCKTbOeTwvDQQO0b311Xc8eW5MOXYXKic5VTk+tTykRIzGz
         SRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748472880; x=1749077680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+JpffenepplKhyFKZp/OfkJ5wiK8oE9uBddYOW1nd8=;
        b=tk3sra4Y53eoxx8DeCBqVIrkYFCTpOisHdRwrMAz65tpIgHkkzulas4Hp7OrgIEix7
         837JhNSleoofW4/w/6Rl9E+mWJD7otmhMyPfXvnJ1xrbpysIXOdyDoeAuD9Af2yB+Nx8
         tTmcsGxIO5aDKRLY9O4L3ZVvHMuFnDHVPc8eMLvmTyVojJo8LAFaw5v0lyBdK+lhDqf9
         /legIJ1moAp95OJkIuvEEz8PDpu/FVJeOVJps5ci0/9PY2n4m5nzP74A2qyjHKOtFHhi
         gVT/gdH47+FnwcQ9VAjfRxxrcwhX56HXph3LN6+/1Zqom6W39kuaKCZO8a/qufpe71nH
         fwWA==
X-Forwarded-Encrypted: i=1; AJvYcCVUl+rWcf8aQzcZXEzjUbVc5ecqt12FMqvNeNjlwYIZVQb5tyXPc4sKThz8pLQQ9h+C6d8RJlwzSIvVVnUL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt9j1Qu7wSzOzFYiee5qjYhJYX7m1quafiAafvTiT1F/qHWnO5
	+Dc5kn3/YSpz544+/NH6Lwp3znYfl0w1PQYSrRgEAzRhZD0/UXqHFy4ACR+iBbKF
X-Gm-Gg: ASbGncvigT9D2k4qXe/S5vXtVelbs393CgURARN0uOmNF9RIS0jaGNihiEdtJT35pbx
	IVy90OkILuc7nQUnovqATmPbal0/L+sqX+MDT4ByewJwBlM5b4Vf/wyhvrbB2yGIKg0KlXhUhHz
	1b7DmdkBo1dsc+ATWi9aaoGT+1YWSoy4U310c4z0zPKIN2aacZJZiotb99dnVNao0Q6U5F7vW9R
	RA0reSJcBT+VNCz/X+rDPlfhGv01y0/76cWWbRbaoRNpLjKa+vU0PGW5sxPgFTTZL13j1KNS/UC
	Y3MD/fP7k/fS81EWn+6oxM2VHbQIUrTwquGg5WBmLPFxKfvXxbk8obVZ4tkbpd3g5jFFeg36n73
	ghwPLLhZv9cNRGTqB7ia3GMBth5FzgCD0td1+q43awg==
X-Google-Smtp-Source: AGHT+IGR6BI/Gxhy1LdJ653yYgomJNo6233qnb6GdrchmwyC0/aOkF58+BXjwzrgYaafQGjXpAaRgw==
X-Received: by 2002:a17:903:3a86:b0:224:23ab:b88b with SMTP id d9443c01a7336-23414f48ec8mr253313805ad.8.1748472879938;
        Wed, 28 May 2025 15:54:39 -0700 (PDT)
Received: from illithid (59-100-175-234.cust.static-ipl.aapt.com.au. [59.100.175.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd8e2dsm1081885ad.56.2025.05.28.15.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:54:39 -0700 (PDT)
Date: Wed, 28 May 2025 17:54:35 -0500
From: "G. Branden Robinson" <g.branden.robinson@gmail.com>
To: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC v1] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <20250528225435.cj2agonqjkqqowwg@illithid>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <c27a2d7f80c7824918abe5958be6b5eb2dbe8278.1748467845.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ck4oisobixdbkry7"
Content-Disposition: inline
In-Reply-To: <c27a2d7f80c7824918abe5958be6b5eb2dbe8278.1748467845.git.alx@kernel.org>


--ck4oisobixdbkry7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [RFC v1] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
MIME-Version: 1.0

At 2025-05-28T23:31:29+0200, Alejandro Colomar wrote:
[snip]
> diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
[snip]
> +If the directory entry is the mount point,
> +then
> +.I .d_ino
> +differs from
> +.IR .st_ino :
> +.I .d_ino
> +is the inode number of the underlying mount point,
> +while
> +.I .st_ino
> +is the inode number of the mounted file system.
> +According to POSIX,
> +this Linux behavior is considered to be a bug,
> +but is nevertheless conforming.
>  .TP
>  .I .d_off
>  The value returned in

Can someone add a *roff comment supporting the claim in the second
sentence?  For example, could we have a citation to an Austin Group
mailing list post or a ticket in the group's Mantis bug tracker?

I've followed the Austin Group mailing list for years and, to me, it
sounds uncharacteristic of the POSIX developers to decree an
implementation as "conforming but buggy".

I've checked Draft 4 (the final draft) of the 2024 standard, and see
nothing to support this claim in its dirent.h or readdir() pages.
Typically, if an implementation is "getting away with" something that
the Austin Group finds objectionable, they anticipate and give notice of
a potential change in semantics or of a planned interface removal in the
"Future Directions" sections of their entries.

It's possible I overlooked something.  I used text search rather than
reading all 4,101 pages of the standard at a sitting.  (I count only 9
total matches for `d_ino`; all are in the aforementioned 2 entries, or
[new to Issue 8] posix_getdents().)

There may be something analogous to the mount point situation in the
case of symbolic links, which the standard _does_ contemplate:

"The value of the [dirent] structure's _d_ino_ member shall be set to
the file serial number of the file named by the _d_name_ member.  If the
_d_name_ member names a symbolic link, the value of the _d_ino_ member
shall be set to the file serial number of the symbolic link itself."
(p. 1858, lines 61297-61299)

...which leads me to wonder what an implementation--Linux,
specifically--decides the right thing is when one readdir()s a symbolic
link to a mount point.

Regards,
Branden

--ck4oisobixdbkry7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmg3lCMACgkQ0Z6cfXEm
bc7rSA/9HrLDFuBBPBmGGNGHkfpe+cJMIKNV8elLpnaKR/0FqVt4Pv8vbd08r3P+
pdDGxselDbCfGJjxoCQnvANTrtaJfn/eaSzfUpMBhrjClVhum1+Gp+QG5h75+t0I
/Jlk+ideprid+BnIXiK38X5VPDVuVhgkNOjX01DX1f7u4T7q7xetG2eWO9zT9etf
sc1eidtpAotuE/S1JHgL+dPwOHnU+zEJGdG18xq1q7K/GkEouKn9sQITbwAkMV+E
Y+55fvGxfPJ6qUw6lqlvbtjDxrV/kzN6SutepQ6LB7CVHazUFUsSQ6uTsolbs9pN
UKynavDLotUwcGKfHO6RuenfNLkUMiwspyarYQDYImW3/XAhhNHVp/7Ntm6/1yI5
zTQxM9wEIlmVMaAQwUgJw8Wjk8pkHyK5u87MrtrTtaoDvOlo4d/2l1INqjaHotr0
/owrZbZeEAF5Uy1JbzkQlpQ7In0Kx5rhZRaNV+AZNZIKfPk4K4fCjVVdo/ImEABM
RdbRsd2n0MdRLiRgG16mj93gqIBCR5tdrhd6HnwaoSIdABF0YJWg05dWOdA7vL8o
SyKLjsg+3TFHfOlAAORil/MONpmvzG04C04Uwfb5o91dimW6YBV9GVcg8bg1Ne2i
htrRA+3YPEXd2YM7dHOsgBtBBqh4GC9DfUD5CN0hcWuHp4uTio0=
=kYM3
-----END PGP SIGNATURE-----

--ck4oisobixdbkry7--

