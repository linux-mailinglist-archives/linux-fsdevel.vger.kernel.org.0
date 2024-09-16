Return-Path: <linux-fsdevel+bounces-29426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41059799BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 03:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FB283A2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 01:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0DCD51E;
	Mon, 16 Sep 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmL+WM2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C9256D;
	Mon, 16 Sep 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726448489; cv=none; b=Yz+g5pMxahac/X813kLmJRDdHdRBLMKW/ebPFphE0SD6z1FGeMYl0ieTMZRCE4jtt8mTvRrdc/IDZknrmBUgmCoHDQ5pRoD1AkPg2l0n4N4ly4J6t8RIRVIrTW/CGruRnnIVd/Iy5S/kq/98SLUC945h93HuJc8O+bj95tFnr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726448489; c=relaxed/simple;
	bh=7D/C5zl6x2ll3AyrS76fk4gpdsq3I5CMMCG+mMI8Elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOP8JcKzVXqDJrdMzufjF9Y0dGi5t19iYu60anZG8fkv3aD1t5aqjJRry//UUmWYe9v8I7r4cAUWvhDbH/OK8HPGB/CZP4cYCANaxfqluIGbBCPYlMAZYI8liPiPybReVxZ/FeS2Xj2iK1gS7INmuCK3N2NhPVPS1lw034c4lS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmL+WM2g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db12af2f31so3492658a12.1;
        Sun, 15 Sep 2024 18:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726448487; x=1727053287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D/C5zl6x2ll3AyrS76fk4gpdsq3I5CMMCG+mMI8Elo=;
        b=cmL+WM2gDuP4O+bn690YwmFhQ0vXL4n+Be4FXT+6NrMbMwJNsOaHCVSbLsB5bVCFJx
         BoykbxIOQC/tyxrPBwl5hd28pQ7453AMb7wKDMRvidhChCLiodiG/Q0BVIMXGtMskbP6
         4P++jFgGMx4wUmT0eCHLQY484hbjkJsbk1ZnbzjhFaSNM0nmAd/4WWRWXEGdU7O8jNhO
         gBL/Y+tMU5V1dE4gQ1NjG2kI677N7CTb6gI/q8LnACmUw+/50q4KXVpnT6nqfzeR0kyN
         cD0yYIKFaxwn/ySnatFQtmYJzfl0ZMvI5mJe3ihqMZu3L2uioZkdPiF4tSh/ljuUrwIx
         q2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726448487; x=1727053287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D/C5zl6x2ll3AyrS76fk4gpdsq3I5CMMCG+mMI8Elo=;
        b=hfW4uY9AHq2FrjNEzDvRlq8d3/HgJ3Rnv6JBCwYqaYZ+7+v5ojnLJkRGX0/A8gJ1Tl
         D9SJuCpwJ/wzj+ZykfhyhZikww6ju9902U7NRu4b10RGG2qvH+me0TRbix7E4QlXDk3s
         BXYU/gwtPLTvvIHs46gVnacrMEguPXiHjLz2gztt0ZePKIBMdMf/1llR7NTtKeYVTuyF
         jwouKQs8mVPcn/65WODXRlC9wULPUQ9VKBI34VYiUMgQL+rn7LTLSx+4iuPSwxCzuGte
         Ro+GjV6fCi0Od6HKUXXA+gw1CY2FYzDdzGMHeWsD7wSGaq+POWmUWLpAV6UaTZGRpIMJ
         w1nw==
X-Forwarded-Encrypted: i=1; AJvYcCU6gPr6GZiCCWvt87JPJZVop2HKVTWtmVfHW75j87HPwqWOE5Q/h1pObTZ/Yr29Buo05MyMLiLq3Yi5dw==@vger.kernel.org, AJvYcCV+ef29yjCDReIQSI1xZTFW2FLbDMTdERqTZe+N9+YV19U2tExX5UUudVu5TFOd0o59XCm/YQJHoIcEpg==@vger.kernel.org, AJvYcCV1KfMhFRPYeB5wR2w0hVRrYO9VuCVX4fz7Gte9MsQan4vgya3oDBTjCGcF8G5uX2x8ogZ3xtmULzgo1SSRq38Zx/QK@vger.kernel.org, AJvYcCWHfzt861yQB6PRHHjgspZWyNtMHHeSLOxEQHB+dJE70zlhLOP/0Gsqy/NFRHYUMG7yXMR7VFDAlxsM@vger.kernel.org, AJvYcCXUWmz5+px2CjpNev7KKw47RQ8WCx22TjafwAgk+eWFfUgalQcefImg5fefHP6jZbytlNcVC2aR4SRQ@vger.kernel.org, AJvYcCXUbzumcfbGFuHyCoQ8Ryt6l5sYnpUc54wX1SVTXcrM8tCSs6JcFb9vYVmpC6LIJ4ciRKa8Xf1E+IBJKqt+RQ==@vger.kernel.org, AJvYcCXbP1nbH+5Tuh6XuD2Tcnv1agPva2WVUpkrkE/xO2vZ9QHVnFL0F9aarFtoz5UbyY20LHFWWbvHOJJ5@vger.kernel.org, AJvYcCXcS83TFyAh+8dHwtvClGNdMmaYs53fi5jSd+2GuqwPk2TKk+AFoghdtmOWXUk59WXmY90IDUmgkPbdQiER@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgf38IRsysiWk+NNSdQQB6MN94TiM5M+zWiK/dfv1ZAZP0EZdI
	WGaTyYeu+27E7ua+8xEBkhDODMA33TixslZEhkOMudLyHKkIsSfz
X-Google-Smtp-Source: AGHT+IHeKKZs+OQSLFWh2p0zJ8126QggRcFIs3Yl9qB6SRWRR42B+47A+pkLNPsEo9M1k9q1ghVFtw==
X-Received: by 2002:a17:902:da84:b0:206:adc8:2dcb with SMTP id d9443c01a7336-2076e35b147mr249054285ad.25.1726448486481;
        Sun, 15 Sep 2024 18:01:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473d05dsm27143635ad.287.2024.09.15.18.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 18:01:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8220D4A358AE; Mon, 16 Sep 2024 08:01:22 +0700 (WIB)
Date: Mon, 16 Sep 2024 08:01:22 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 07/11] Documentation: add a new file documenting
 multigrain timestamps
Message-ID: <ZueDYmduQtlAnX_5@archie.me>
References: <20240914-mgtime-v8-0-5bd872330bed@kernel.org>
 <20240914-mgtime-v8-7-5bd872330bed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwvsaHxP9Dj4QI8r"
Content-Disposition: inline
In-Reply-To: <20240914-mgtime-v8-7-5bd872330bed@kernel.org>


--kwvsaHxP9Dj4QI8r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 01:07:20PM -0400, Jeff Layton wrote:
> +Multigrain timestamps aim to remedy this by selectively using fine-grain=
ed
> +timestamps when a file has had its timestamps queried recently, and the =
current
> +coarse-grained time does not cause a change.

Do you mean using fine-grained timestamps when timestamps of a file has been
recently queried/modified BUT its coarse-grained timestamps aren't changed?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--kwvsaHxP9Dj4QI8r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZueDXQAKCRD2uYlJVVFO
o9i4AP0T1JkEX2kwhV2+holu89lH/60QVNXUO2Lay3YffP3/dQD9G4CUoLWZ82Xp
x8Jx3+7J66rerRpl5waFiihhu7wbiQ0=
=tXkm
-----END PGP SIGNATURE-----

--kwvsaHxP9Dj4QI8r--

