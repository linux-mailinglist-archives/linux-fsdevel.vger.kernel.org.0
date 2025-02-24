Return-Path: <linux-fsdevel+bounces-42451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60913A4279E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58AD3169220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FC625A658;
	Mon, 24 Feb 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="lnahq4jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8425A2CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413766; cv=none; b=irhikk/3fen92PnBcHTqeMwNx7fPSKgLcopI1PhecBBmrA1IRdLoudirtx6Y5ubLaG8DW8YY2trvjzOeD4cXGMFAOXAoHF5Eo8xF4ZnpAX8wKALk8yWCW/jly/p3DjdbNrQXdxcz05kMzKCGCzupSz6Rdvc5SrhoaRF5Y3JsQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413766; c=relaxed/simple;
	bh=znP639qDra56/4CUkzxbXJtwHv7Db21X2va2+tu0sYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt0DFul5aTicE3Oq8a1gXHMg6soPKc06PfUlJjFWGgyrVF9hTAFDQ4Y63PqPLvBylnJ7C0JvXcKiT6afT+LtOB7TV3rg4Z4ucyx1TZy7UKmEVR0UmKzpsRMaXWoDYuyP19M/9blYSEFl41bkIaDKjZIsUJB4MJDTv+vXnL6sc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=lnahq4jv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21c2f1b610dso135272485ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740413764; x=1741018564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbFIiyVBu03rSNrD6SoQF/QaduESan/tbVEXpCDAIFo=;
        b=lnahq4jvtuhPxtHg0lUUhB7W4b5zdBMChBao31Gl7voRCMDBISD0SI5MY/EXw9/wGz
         4ufHSu+DiQtNAAobMlQHgEhACdgMCIAYn+ZuDROPFREvJtQm+3qC+MiLLBTSt+VZXVQb
         ey9fJA5oPNnx9UUeh/HuSxvtiSGt8iN9i3NSPcn/Yyy+h3FOmuwfF40vTLR5dwP61QFu
         NgOspP9pXU4yk6hjuCy28pyf2cF3QZ6GHR+IXNf7G4PBYXA88CMGhW6nEQVcxDSHTWUK
         4wpm9CnOm+svkLvzP9AEOrTUAsEi4xVYY+fpbEfsWVRO6BPjsCkRmlsidujNUTD6CUYH
         mVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413764; x=1741018564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbFIiyVBu03rSNrD6SoQF/QaduESan/tbVEXpCDAIFo=;
        b=furA2r7LDQcnj8feqLp3eJ3TY5820TDPbMRihe4rdNJhBKRuO9B3iNywTnT1pbyv5w
         TftH30oV4MZlyeHMifQDfkzoa2fa6MbqaqmxFwkgrVbhetC1nzxCTJcWusNXxT627Jb5
         5zCiHqQK35+BfykTGUfEDlOqhBHGeXm8kIi6SfDSpGOIW6WE5IgnewkYIScnvzdpqBBN
         1IZBw+xH/Xk7o14Yx4SNCRaz6QZNZbdkzuid54D+y/s//mi4gLUoxiSRSW/Zr2gblHS1
         LXn0FkO5n9w7Qr5X+sbbcjRboCH37WH4Gi+zX62akCJKVVWwXDpVo3SKN9YbVQReer0l
         +oSg==
X-Forwarded-Encrypted: i=1; AJvYcCWps+iuVlFCtZWFE3VIOhbJyaNQycaaXR4IdKPs2gCEvw5IEt8zB9fjeVW4Gd5HSGp3V0Ym9tOmOYqMTsLS@vger.kernel.org
X-Gm-Message-State: AOJu0YwecAdInaTx44kMNoxVGIeeaJFnrhCkMuPYzXOLcEvomWegdssJ
	HR6EoMYYSIPxRYINQ+UBrCIkv0KVhbUlp3N5oWrcSMxBZXtwa6aSwntxLCbwD4QpBbwSmNqoTuy
	gWLbIVRLdLR+UQwYrdk6x0XICe0F4K02RLGtq4Pr6/LbZdw/e65N2UEZ4iXvIKN8Iu9oTN7Ek13
	80Iup9Ft3dzojkqt9hllEB2O8RmGBdkc7609jB1MtQ/phMDskVPOZT2SKAZE0c0qnsmcU0Ab5jc
	LCck5qfxw2dyn3crr0F/XDlUhlwEBvrKPFRwLSB882PBZctSQgeSV6E+m6zdvNXFXusZV2L4Zv1
	YnVXet8Q0GMzxIz9MrKXF/jGiRAAlJM2QkqVVnIBI3qNbgWvFmBYQvz5uj5tNUljwvfdq93tQNd
	+Fglp4x8KpjQgynqIDoKwAxym
X-Gm-Gg: ASbGnctUXmoKOsUjvNGpSjBIIDczoaPFaXt+coFb3qM0M5MQEHFSTG2Xo8QpUiHO2c3
	W2ofDwXluw3dqt9to/yuZ2gA76ndHKdSo5q0GlLxbMh4qslEWK+TcIklAXSRhNniaCP4qBtIfsG
	SoQgeS+v8Y2yGR2ox3gndSUA==
X-Google-Smtp-Source: AGHT+IEQcUqXWyzW7txhoFxLDejkrVizVTPPzSveJ2vrUrEWjOUz5Sv5py/r8tfjXiTPcGqGgkDF7WJoXP7Am8Q34zY=
X-Received: by 2002:a17:902:e74b:b0:220:efc8:60b1 with SMTP id
 d9443c01a7336-2219ffb68c7mr179690365ad.39.1740413763937; Mon, 24 Feb 2025
 08:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org> <20250224160209.GA4701@lst.de>
In-Reply-To: <20250224160209.GA4701@lst.de>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 13:15:46 -0300
X-Gm-Features: AWEUYZlaokoekDAILx5r9gFW_X8gGLcj_ZVwIHgsDoW_nk-h_xzSP63aCt62qg4
Message-ID: <CAKhLTr0bG6Xxvvjai0UQTfEnR53sU2EMWQKsC033QAfbW1OugQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 1:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Feb 24, 2025 at 03:33:29PM +0000, Matthew Wilcox wrote:
> > I don't think it needs a comment at all, but the memory allocation
> > might be for something other than folios, so your suggested comment
> > is misleading.
>
> Then s/folio/memory/

The context of the comment is error handling. ENOMEM can come from
either folio allocation / addition (there's an allocation for xarray
node). So is it really wrong to say folios given the context of the
comment? It's not supposed to be a generic comment, but rather one
that applies to its context.

Maybe this change:
-                         * When NOWAIT I/O fails to allocate folios this c=
ould
+                         * When NOWAIT I/O fails to allocate memory for fo=
lio

Or perhaps just what hch suggested.

