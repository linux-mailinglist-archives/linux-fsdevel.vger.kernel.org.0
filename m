Return-Path: <linux-fsdevel+bounces-8863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06783BD04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F341C281B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 09:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B571BC3F;
	Thu, 25 Jan 2024 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Q25VG4+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CB1BC21;
	Thu, 25 Jan 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174183; cv=none; b=n/zyayI+UQ+rw9BDZ28l9NKEmKIiH/qPWS2l7wl+2RflH2JuobyQ4dPSKsGR/kpvw3jw1UyuStPhxLTciGwI9Iwe5UM02xnzr2JXL4EI0pHKGjBjGBraBLC83IxqIplrlnqCH5kA2ZkaZ1ynkW21erQRu5mjngXAiIp6jHjB2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174183; c=relaxed/simple;
	bh=2MS9s1a8Dv9mlT2W2jXI33V9M5ds9L8zcdgaegbl64s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ka9rY0/TVbAVLZ8Lz24R3N8k51des4ppHZcnE6EXSisTmjwLpnry76i9b/cPn6IXJXotXsRohc9ucdy+FFpigjQKnWwXm527ozeroCpOiBmzK7c53a/J1lyBa470d0FaqY9u1g3kel0sukVcDLKvzCuuEvHTKKPkDdxIFMpy91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Q25VG4+r; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qi3k2n676fh37cer4gmqmbhyuq.protonmail; t=1706174171; x=1706433371;
	bh=pfsotTo/Zydb7H/lWqTfkcVY7FiDx1DJOismrr1aiyM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q25VG4+rhIbhEJ+0wpY8GWsKJDFm5o9RNMElt5ZMxqxZ/nr6q6Tv+uhycVfrT4eMB
	 890ytm/Zo9553SULhGg9q6/k1M9QeAyFh73B2Dilwdk63JzNpZvL6HKAxY9zYEGOKv
	 Whh2WgJoHt58Gp5zNLV3L1trrztS7qAlq2RLNAPE5BEeS9FX2aQweKD6mOSkkzzYRB
	 tC+/0JCkrO3xENTpPu98kVRndU+h3Rwxw0enYzoisop63Cn68hqkQ81be9UnlbL3OC
	 xr9Her5QGxSzWwZPnCGHUZ+hme0YMouWWAS1TCfMxvi07Q5rTjpU3h/d4+ScLoIi9o
	 fdflKlt96chbA==
Date: Thu, 25 Jan 2024 09:15:45 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 01/19] rust: fs: add registration/unregistration of file systems
Message-ID: <e977d0ad-ca06-4b42-b2d7-09dc9a571848@proton.me>
In-Reply-To: <CANeycqqJsy3rhBEVWspEqhUXgsQNj-Wcy=9axkDX9B3SLgupcA@mail.gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-2-wedsonaf@gmail.com> <ku6rR-zBwLrTfSf1JW07NywKOZFCPMS7nF-mrdBKGJthn7WGBn9lcAQOhoN5V6igk1iGBguGfV5G0PDWQciDQTopf3OYYGt049OJYhsiivk=@proton.me> <CANeycqqJsy3rhBEVWspEqhUXgsQNj-Wcy=9axkDX9B3SLgupcA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.01.24 19:32, Wedson Almeida Filho wrote:
>>> +#[pinned_drop]
>>> +impl PinnedDrop for Registration {
>>> +    fn drop(self: Pin<&mut Self>) {
>>> +        // SAFETY: If an instance of `Self` has been successfully crea=
ted, a call to
>>> +        // `register_filesystem` has necessarily succeeded. So it's ok=
 to call
>>> +        // `unregister_filesystem` on the previously registered fs.
>>
>> I would simply add an invariant on `Registration` that `self.fs` is
>> registered, then you do not need such a lengthy explanation here.
>=20
> Since this is the only place I need this explanation, I prefer to
> leave it here because it's exactly where I need it.

I get why you want this, but consider this: someone adds a another
`new` function, but forgets to call `register_filesystem`. They have
no indication except for this comment in the `Drop` impl, that they
are doing something wrong.

I took a look at the implement ion of `unregister_filesystem` and
found that you can pass an unregistered filesystem, in that case
the function just returns an error. I think the only safety
requirement of `unregister_filesystem` is that if the supplied
pointer is a registered filesystem, the pointee is valid.

--=20
Cheers,
Benno



