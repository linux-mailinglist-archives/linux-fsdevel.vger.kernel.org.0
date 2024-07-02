Return-Path: <linux-fsdevel+bounces-22906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6A91EC3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 03:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DAF283168
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9169449;
	Tue,  2 Jul 2024 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnP4ABDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFA8479;
	Tue,  2 Jul 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882260; cv=none; b=qaSuZ0cJcrarTlUM9o4LTichtOVHVT3/BfT1DQYypXNlG2RXwnQfOmlCoSF9aZ7sU2sraDCVprWEtFzfXmAtM2IeuHh9h8yJVE1xcrXAqvrPEwEhrE6gl/OUeznB5+vcfoKdBQei3L50OZhI12oHH8L/e2Arz14kyzObq3b2f4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882260; c=relaxed/simple;
	bh=rSdvgnJANMza7cv2Jq/gA1bXg/Ri2T+DVceHUO/MoaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZugIW4ziNuipu4+kmJ811KS4JUn/L51+gHXnJFwavZfwLd/0EV3uauCBMHhHvo+ESEB5BJpM9ALhN1Q7mFHr2GCNehFjdQ79esYnKwgDsrvyJEYCJ7pNJGVciCQJEGzm6NNVzPYMDmYi36NM480Y8nKR4ClQey/XloZ55g9+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnP4ABDn; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d55f1e52bcso2106405b6e.2;
        Mon, 01 Jul 2024 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719882258; x=1720487058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGUnY4g1oaF4OnT/ERTEKmY9epCpAK1aDqzYl6Qb5jw=;
        b=FnP4ABDnwt0hbnzZeMtrlu+Tg3Ez/2ql7UtxKrHfODU72zu8M6921A2QCdSZghQKlg
         0aHhsN2i0p08J9NOvVuur2Jxu1izL0pTNIs2T9VqhvqL7iA5ZBIc4JTCLa0URbJqU3e8
         AAeH66IqDlA34C/TiWo7wCUaV0+hEAhut3MLrMLA5BRuEYOlHZSl3Uv6aur7qOPbD/KO
         hR4RZlD0N/BhraZ+1R95L4732DWavoKIoAt1RBG9Tb5FEc7rnz7hC2DHDPqkcNOG1i/n
         wDOUHMtEc/kZHVxI/xES2gVASyvHYOCIdifxNmfu8Mj5Bm9+1Oj5MP0JmjJ5Unb1b+Ec
         WR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719882258; x=1720487058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGUnY4g1oaF4OnT/ERTEKmY9epCpAK1aDqzYl6Qb5jw=;
        b=ZBt63V99Vlg0rbS/UX4t+4M7xBw2KLYwO1XlxLjHrFElOzgVnlc58/eQe5sksGuQP0
         Nc2A6af3PFxP2KcmP5Qc+kT0Bc2K+++Q5/N1rC4T847LpkqsHmxKxx5bAru/VorVFSPO
         4XmYILP5R2KCplKv9fwiNjUxrBzBsxnOSjnXqe1ryDNk5eiSWkWKR6uvbsu2cfam+ZXN
         ZkKGQWsAWP04sWanbUXGo9OLms7VW7KVCdpbr/3Smle0uddoCB73T30Uf8JKvu3KKlAw
         evkmvoKMqI8rKG0VgsghDHTDgkZnAicKL7WmO0ITPa9tUptTRpiRpJRBRLTCGyzc5ewZ
         2UjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNaZcrU/F4OkbVdstDW9+GJNXwcJzJ3pv/SmY5J4zJliVHecjqxcpOA6S1x91zBdOHci/XZI2tFp23E0Nj6kog8/Mx+WvWfHPAofc6
X-Gm-Message-State: AOJu0YypW0kR5Qfg2z6zMPSYLr5//krHD7OlRONEQDJS7XeiMbTRP0OB
	2/fNAFrCOOPUzvrSDNTph2a/MDcndvVYS1a6Cdb2MtkgJkgUO4Al
X-Google-Smtp-Source: AGHT+IFnwNgg4Ze9pZplQvvTnkE9/RMsDWedBEQs7uJuCtCW/TMRlZ2VXi9VoINfX7T0Lrv/0HpElw==
X-Received: by 2002:a05:6808:1185:b0:3d6:331b:ae05 with SMTP id 5614622812f47-3d6b3e729ccmr8653327b6e.33.1719882258437;
        Mon, 01 Jul 2024 18:04:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044adb21sm7403128b3a.141.2024.07.01.18.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 18:04:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5363B1816BD16; Tue, 02 Jul 2024 08:04:13 +0700 (WIB)
Date: Tue, 2 Jul 2024 08:04:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Message-ID: <ZoNSDQfohcDHAcU9@archie.me>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6FUSCBHY6FWIkT0I"
Content-Disposition: inline
In-Reply-To: <20240625211803.2750563-3-willy@infradead.org>


--6FUSCBHY6FWIkT0I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:17:57PM +0100, Matthew Wilcox (Oracle) wrote:
> Rosebush is a resizing hash table.  See
> Docuemntation/core-api/rosebush.rst for details.

What about "Document Rosebush hash table - overview, implementation details=
/internals, and API
docs"?

> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Rosebush is a hashtable, different from the rhashtable.  It is scalable
> +(one spinlock per bucket), resizing in two dimensions (number and size
> +of buckets), and concurrent (can be iterated under the RCU read lock).
> +It is designed to minimise dependent cache misses, which can stall a
> +modern CPU for thousands of instructions.
> +
> +Objects stored in a rosebush do not have an embedded linked list.
> +They can therefore be placed into the same rosebush multiple times and
> +be placed in multiple rosebushes.  It is also possible to store pointers
> +which have special meaning like ERR_PTR().  It is not possible to store
> +a NULL pointer in a rosebush, as this is the return value that indicates
                                "..., however, as this ..."
> +the iteration has finished.
> +
> +The user of the rosebush is responsible for calculating their own hash.
> +A high quality hash is desirable to keep the scalable properties of
> +the rosebush, but a hash with poor distribution in the lower bits will
> +not lead to a catastrophic breakdown.  It may lead to excessive memory
                                       "..., but rather it may lead to ..."
What does catastrophic breakdown mean anyway?

> +consumption and a lot of CPU time spent during lookup.
> +
> +Rosebush is not yet IRQ or BH safe.  It can be iterated in interrupt
                                     "This means that ..."
> +context, but not modified.
> +
> <snipped>...
> +IRQ / BH safety
> +---------------
> +
> +If we decide to make the rosebush modifiable in IRQ context, we need
> +to take the locks in an irq-safe way; we need to figure out how to
> +allocate the top level table without vmalloc(), and we need to manage
> +without kvfree_rcu_mightsleep().  These all have solutions, but those
> +solutions have a cost that isn't worth paying until we have users.

Use cases?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6FUSCBHY6FWIkT0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZoNSCAAKCRD2uYlJVVFO
o4apAP9PZ3g9T5lFRsj6oPjo8kO5n1EDN/32Y31h0AisexRO8AEA37nZcCLUHhFv
QgulTfF7stm9rpAKOaWHT5hCqczjuw8=
=ljDu
-----END PGP SIGNATURE-----

--6FUSCBHY6FWIkT0I--

