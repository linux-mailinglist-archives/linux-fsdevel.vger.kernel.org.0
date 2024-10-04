Return-Path: <linux-fsdevel+bounces-30927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09198FCCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 06:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439C11F2373F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 04:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9927581F;
	Fri,  4 Oct 2024 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVi6pqYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021819475;
	Fri,  4 Oct 2024 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017368; cv=none; b=QJqXhmXioBBS/Ij9ez1rK/DT9XPBR4z2Yo6Ougf5ONJ97BVXHgoudQxmX2/Aw3rGP7dBgLVjhNM7O8+v9jaoY4dX8FUbwy2rSMRxMTWMhulcXg0JgugMtebYbjlRfKp6Jm22LBHUUG6pEaroc2YEV9dyM1dvOcNqUfmC0SmsI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017368; c=relaxed/simple;
	bh=TUsrG1YURfFbI9ZQ5O9KwQkkpUD3OiESPgahQWq2Rus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQXOooEoqL21yRBaPHJ8i6qFu++3c+hZc0QA5OJydLIGGocFyAp5/HdU+lYmhg4MKa7BNvjfpZeSFpilEfsBWFmATkPAqMe/MAIHXfLk/a5rZxnBNil+VddPrhHBwUpPxbApR/I5RLPD7njcinx5EIecMHhDwnHesGhtGVTm+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVi6pqYK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b64584fd4so16764895ad.1;
        Thu, 03 Oct 2024 21:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728017366; x=1728622166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUsrG1YURfFbI9ZQ5O9KwQkkpUD3OiESPgahQWq2Rus=;
        b=hVi6pqYKrn8dgM0eI9ixdE8WIexPLQwey+MXTfB7nkMehLW5N3wwatdfeCYP5P02+P
         2aMcfARvvz6lnmj9H4QNS8Chz3SCOo/wpbpjaKnt67xRwmxyEBC3Uh+qL9jGRgcttizR
         Y3obqhXJYcJtmHgppDwYb6UgiuyKEn5X7OuhkL6Jemp7p56srEJI9qiiwuoB7P4s81Zx
         4Xfk9k9xx7B8gfvGyNaDO5sCPtOkqllD66J9SwR9p3xoqS9JFydoFzsnzeMV3+zy/TwC
         HQ0+jUweQGQLIi8GVThtk9Mgkegm2Wndm0gsgyV0QfDwMDawVRGsoMhX+hwa4J7M8biJ
         x1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728017366; x=1728622166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUsrG1YURfFbI9ZQ5O9KwQkkpUD3OiESPgahQWq2Rus=;
        b=Uez4rjhsNmKsYoe/XaFg5wOnVucWeobAg6vKPA4F7oT0SCiuIO6JvRz/l/lF1FpvVN
         +HqU7MoeRGpedZyghSTDfz8D/9UrZAnQJwZmPwB00knZMY8mbt2Z04RH0ICFdWkh7c82
         XRyB3290xnQtSTENukEB+C1yu51eDxHKNcgSLYfb+Jq0Du0bhdWPOST3rwljGhfxv1um
         aWnkmOs2J7btwWymgTGvnWn1hc1lFB4htCTABQd3mTAjiDqdkaJZ6wb+b4HZ50+qNqUt
         ChHrU65wjXyUb6C9UHo2ao5XOehiyZmGIdT7sd6k3N7yRw64BQ+S4fkdzAOjWz2T0vll
         Q1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUE9Wo63qg9LZj4tgHdX9hTRtxJIIiYRmo1O3MQLP0Iqaoqb3c5m6kZYSKVBzUKFHgGx/DkS39rrbwF@vger.kernel.org, AJvYcCUO6FHwqC5n1RM1ObWoHF1jDCASQwObgBmxEKd5qUNpW4knWog6o+ILbUHBsnI7E1AT5X8Wf7lXwu/g4SbOAg==@vger.kernel.org, AJvYcCVJ/w4XsBf3ZYT4XO/1DJevRd02A//DnFnyQKwT5ApSIg6hxObHOlJRm4x+WOGrCbqkCokIcpUvNGF9hQ==@vger.kernel.org, AJvYcCVSB36FTaycSaEu8J8sAXgWHEPjodeUcSstg1neePtKwxZIJ1oxj077SUtUpJJl7lTDHZpfxymIUcv4@vger.kernel.org, AJvYcCX/AmP27C06Gn1XnE8fi1EJ3uGc1/p3E4ioPVh64bpYWIQuU/WyO4cYRW3ExQsdiCvhG3oQ2AKVbkWm@vger.kernel.org, AJvYcCXCAgarJlzAGjaaSpZ4eQYgEiJo+XufLAUWqej1/qz/QjzFxnBb8WIp/Vw5LzXBu6Q0eAW3i67JxyvJ6y7sfRv5ET5u@vger.kernel.org, AJvYcCXuSJ94SmW3oLDSqh4gEuVSZ6cpIMwNINwHrW0saYiWLOpYh56DNlcoeLdW0XJAR7i/DYF+261CeGn+OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7szFqV9+BoQphTwgaC/Agvqk6AH1gOSDsgquNsL8WDjZo5XDK
	2on3CWckidUp6/2J0bwVQkcP+KBJZfZXoH4fXQ0rRaeEolu+HQTf
X-Google-Smtp-Source: AGHT+IEOZ5VHabq4uat+pKHrLZtskvm5qkTvRMBGxvUt1yb7vzghAthcJh027s31hSLyjL6Ys/bM7A==
X-Received: by 2002:a17:902:ec87:b0:20b:5046:356 with SMTP id d9443c01a7336-20bff04fad3mr14990785ad.36.1728017366009;
        Thu, 03 Oct 2024 21:49:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8decasm16481015ad.142.2024.10.03.21.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 21:49:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CE80345D328D; Fri, 04 Oct 2024 11:49:22 +0700 (WIB)
Date: Fri, 4 Oct 2024 11:49:22 +0700
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
	Randy Dunlap <rdunlap@infradead.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v9 08/12] Documentation: add a new file documenting
 multigrain timestamps
Message-ID: <Zv9z0qWAvTuS8zg7@archie.me>
References: <20241002-mgtime-v9-0-77e2baad57ac@kernel.org>
 <20241002-mgtime-v9-8-77e2baad57ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OBP6+ccGLM5fNBOy"
Content-Disposition: inline
In-Reply-To: <20241002-mgtime-v9-8-77e2baad57ac@kernel.org>


--OBP6+ccGLM5fNBOy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 02:49:36PM -0400, Jeff Layton wrote:
> Add a high-level document that describes how multigrain timestamps work,
> rationale for them, and some info about implementation and tradeoffs.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--OBP6+ccGLM5fNBOy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZv9zzgAKCRD2uYlJVVFO
o8z+AQDazz4grBaoJ/mtVu4UdxF3vdyAVG6PXKSWPFhB0JejcwD9E8qbXnSUInxR
88neK7F3Iq9tS3rwTgLVOuOzET6WWAE=
=TFot
-----END PGP SIGNATURE-----

--OBP6+ccGLM5fNBOy--

