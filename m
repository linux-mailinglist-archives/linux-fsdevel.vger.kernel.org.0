Return-Path: <linux-fsdevel+bounces-72219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC8CE84F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 00:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DF393002B92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 23:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AB28312F;
	Mon, 29 Dec 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMrjxOGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B624466B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767049697; cv=none; b=pkXNEoZNVVAGKgw+aT8QQQCSO2O1Rf5w5AOTvliO1VeKwaNewy66JUO6XtVmtEC02ZLaHxSN9v8L+nv8TjnMBVSVsWT8xSUmOluZdBW5RvloBQ3eZqRg+rAzBBkYhWx6DAPbyl30G6CdB54zxTmvItsgJMxFF2/aKP+CTgt9YoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767049697; c=relaxed/simple;
	bh=aNueN8STB8e2p13feCmNv5nJqSlAaVexnX6voYAeEe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coKxdrUn+AI2oc0mYhh8H/mfEgKTVHiYkntEsaIbXxlos061Uh5U+BUSDaVwUQfJN+6iSJkpVvlzBEMpEyxHRu4IwkRdWpNj82GSY4FbQBGUj5DklH9wIOJ/f5eJhEhGjwYNGekEzJ2MfZbnGtLe0X5fZcXcnMl8N+weSs2XuUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMrjxOGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F00C2BCB0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767049697;
	bh=aNueN8STB8e2p13feCmNv5nJqSlAaVexnX6voYAeEe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AMrjxOGr6PKrNfrwYjVFA0VlNfPDQfcNa82j/4bP/RfM67c5xCiX+B8kX69Np1xi5
	 AMDq2YDAvc48HmPx8JX/GyjJWdM6KqG2APeafzsJPQkQEJjnhKe0MeSFiwPkqsLqSx
	 jwAQLnG4ZLLrjBoAVpDUZ/ne9x1bstXBa/x9FBpbl+sNVsreNTu3/y2K+AZBlV/Waq
	 QdU4fNBoXoxzdpC2/xsTHTlA99loeICBJyOFrDE5GZuMFoa15aDdsLySE9/wnpIZWS
	 VrWrBXW/Bbr+AMFsQncBHLDlNKy+7CzBEd5hT3SpSgadCBd5KmYsoGSjXn9foGVe1n
	 wP/1Y4MHeB3tw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7633027cb2so1714006266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 15:08:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0CgJQTCCBSKrULweYYGwWis4t02Jz4CWjORlX4ijE9712KCWxMzC9rPNy9gqFLmJV3hrkQO32AN7O7z6R@vger.kernel.org
X-Gm-Message-State: AOJu0Yytvoc309hFQZYXQtGHaIaNa66vetwn0YLSQGSUvPQZ4L2eDK+4
	dkNlzxukWux1j1OMKRycMK1SM5wKXBdV2Nz+owC91wp5r479l7vz0+cHdwMQ5clHt3SOUpl2KU/
	Oav63BNwdEMLSpxq3hIuUEdkgI39vjEg=
X-Google-Smtp-Source: AGHT+IECQV3fG3Xkkaa+oqpk1wjhWWbsaXK6M7xr/r5V5Vb6T5hnfFqHUBTNud3+WdG5Bo3ydpaQifY5WrSeqJnX2r8=
X-Received: by 2002:a17:906:30d1:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b803fff330cmr2690984066b.57.1767049695810; Mon, 29 Dec 2025
 15:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-14-linkinjeon@kernel.org>
 <aVKukOG-Oa0-3pA3@casper.infradead.org>
In-Reply-To: <aVKukOG-Oa0-3pA3@casper.infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 08:08:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8peJUopYfxxNE6KfFMWiXerR0d_3vyN39yn+WCT_DdVg@mail.gmail.com>
X-Gm-Features: AQt7F2odudIensYux9yccNI9RnnsnUHLvOELJ9IPzTBmEip3ddskXT5AGHZsCu0
Message-ID: <CAKYAXd8peJUopYfxxNE6KfFMWiXerR0d_3vyN39yn+WCT_DdVg@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] ntfs: add Kconfig and Makefile
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 1:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Dec 29, 2025 at 07:59:31PM +0900, Namjae Jeon wrote:
> > +++ b/fs/ntfs/Makefile
> > @@ -0,0 +1,18 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the ntfs filesystem support.
> > +#
> > +
> > +# to check robot warnings
>
> What does this comment mean?  I see ntfs3 also has this, so was this a
> case of blindly copying?
Yes, It is added while syncing with ntfs3. I'll remove it.
>
> > +ccflags-y +=3D -Wint-to-pointer-cast \
> > +        $(call cc-option,-Wunused-but-set-variable,-Wunused-const-vari=
able) \
> > +        $(call cc-option,-Wold-style-declaration,-Wout-of-line-declara=
tion)
>
> -Wint-to-pointer-cast is already enabled by default,
> -Wunused-but-set-variable is enabled by -Wall, so both of these can be
> dropped I think.
Okay, I will remove it also.
Thanks for your review!
>

