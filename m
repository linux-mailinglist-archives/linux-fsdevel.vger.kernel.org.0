Return-Path: <linux-fsdevel+bounces-48065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F7AA9225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5177A664E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF62202C3E;
	Mon,  5 May 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtrKBDen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87141CB337
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746445039; cv=none; b=uDX/picHJ5qqtwGa2a0100PbnVP+9iEqqMqC6tEHCjz52+D8+jNK78OGffjErhnHhIoKglKnJAlDGfRHPlyUjOQ4d0lYwucxyp7w8TDI5C6u/u9W3UIecsCpx8g4k0M7hxoIFVWR4p2+s6JaBETlF1pc2NMyRwffC7FWGN6GWQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746445039; c=relaxed/simple;
	bh=TwdL4njidmTiUpABaKHP8VR+Xgcb37aX98WOc2ZaBhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv/fJQqRNfovXoLCjkMnOTGTkqMwTcdYX6/K9eA6OV9KHUsiJYA1II5107CUeT3S2UosY8No7XnBCjCoDXrk7VCZfAsu34uUhq5UOmyV06RAPnzWWQCseju0I7miFIwKjFQDvOZoIixral8idXab3/ZS5Cp2uGplOJhiBQAQeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtrKBDen; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2c663a3daso849235066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 04:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746445035; x=1747049835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwdL4njidmTiUpABaKHP8VR+Xgcb37aX98WOc2ZaBhw=;
        b=gtrKBDenkoOIhPAJ7YohS7Ztv+GXWzde0Aq1E312fZzs4kX5KTKJTf+TB647aTjQyp
         dgsTnKLXp525jgCnNPn4BOnnO8W2gzjkceWWjIf7cWl2osVrj2kpoQvuKdTnKUG9IIV4
         4NfipbkiwcBbUV+1157YZmH0mra5ib28gpPCeW6bGAxncCPI/Cy7o5zkGlQpy+FPxOHt
         bUkQ6te/wZtXU5hHB7jTFPTOxBOlEWDiiBOrPa/VhwnOOtC1xH4i1vi1SeQSaWLSIPto
         eTJODUtpLR+9A+Y6zOmqffiFqsKtEKV4BlaRawBUKQP8z+sMt9oKFr4X8wa76NJBw96J
         vX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746445035; x=1747049835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwdL4njidmTiUpABaKHP8VR+Xgcb37aX98WOc2ZaBhw=;
        b=gJM5tvUgNhyEnzRJko31DksrG1eRwuivByP49lcm0B0/nV+msiRZAk3SmnfV3gmQho
         Rcs1UWiE+mwsa//YfegHiBN5Y5+R6WbwU94t94/kGrKYjyQ77NI/n7oJr+U+H6nGS+vt
         HPFltH6Hor6rSI2YO2zr09r6hpIqRzG5J+pLyAHAQae4GJLtEH7WoFfyZdyl6CBWj0vV
         puHiQYmaQAGnSEtB/pu/hHta9VZVQZWb4oBbMkvI/xUrlbtBBzrby71QK8s2Rahl2jIX
         txKT//xuiBoTfqaliL67N/OQawr6abBbP3JsRnIvxLA4DG3w/vqES1NV4LDcmzpCouhS
         n0aA==
X-Forwarded-Encrypted: i=1; AJvYcCWF8XPz3lhtRWrv8MyqoiewcjJD6O8UZH8ZxtWO3tXHZcJxn3rxFxwD/sMtOafeiBKtIMXeshVSbcg9MpzT@vger.kernel.org
X-Gm-Message-State: AOJu0YxclDy3JMhER4eP3bd51b+k39P7E4F4JyfovmZQ6MJCh4Ii4Ca9
	VZG0L5rb3hLAOAAUcN/9oPRPQecAvKyxfPi3SixGr08smbHFffS2InlH3ggh+e+lqRtTY/rTOBz
	r+1OfWk4Q5c1+LcJY+b6/vP4VmZs=
X-Gm-Gg: ASbGnctgCUTVNkLhTo9FjJFSkGDzo9Dg6fygrE92fPedm/DTL7NRdHLXJbRthszAuYC
	hNQiKMbJPXsDFCdaDbsHtxpc5rx2BLFigWq9KB+E7rXJEh1KVrxGNK+oGNFtu/agF6UQf5Q69vH
	yC9kOIBuMAT7uNVjDOczY=
X-Google-Smtp-Source: AGHT+IHao3jZ6jxNOmUtsIKVb8X6ETCj2AeM/YP1AZ77prmIbM9sLnOqcGorXXHPWn/3QiFRSmD2Ef021rss+KGNtbw=
X-Received: by 2002:a17:907:7f0c:b0:ace:cb59:6c59 with SMTP id
 a640c23a62f3a-ad1a49d7335mr645270966b.32.1746445034752; Mon, 05 May 2025
 04:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
 <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
 <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com>
 <CAGudoHHHVG7sX+ukMNc8feRkE+YrWknmCWjQ95W1xkYkSycwrQ@mail.gmail.com>
 <CAGudoHGAdTVVv-K7tOgLyPE2K=qG4VaZU=qrAaieqcO_sNn6+A@mail.gmail.com> <xq5cgpnzgcrglzvtcn23qfykekvkgpfuochcjbroyi6ya22yic@sigdivujq3dp>
In-Reply-To: <xq5cgpnzgcrglzvtcn23qfykekvkgpfuochcjbroyi6ya22yic@sigdivujq3dp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 5 May 2025 13:37:02 +0200
X-Gm-Features: ATxdqUGAr8dLqmFLsDR_Q17WZI2VQmY9__iGX2ZkjOKVG90XLLaeFkUSZp2xSAw
Message-ID: <CAGudoHG=Js3Xkm=0rmruscq2XOTeG=6-5L9Z5OkxAc2tMu4yWA@mail.gmail.com>
Subject: Re: [RFF] realpathat system call
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 12:30=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 02-05-25 20:28:13, Mateusz Guzik wrote:
> > The user would *not* get the path even if they realpath /bar/file as
> > they don't have perms. You could argue the user does not have the
> > rights to know where the file after said rename.
>
> Indeed. In particular if the directory hierarchy is deeper, the user coul=
d
> learn about things he is never supposed to see. Thanks for explanation.
>

I realized I was wrong here, but it does not change anything.

With O_PATH you can get a fd to a file even if you can't truly open
the file itself, as long as you can traverse to it. Afterwards the
kernel will happily return whatever path it can generate if you
readlink on /proc/self/fd. So should someone reimplement userspace
realpath this way they could get the result I claimed unobtainable.

However, the result would be wrong from API perspective. Suppose a
program tries to use it as a mapping "path provided by the user" ->
"actual path" to catch de facto duplicate path names. In this sense,
/bar/file is a broken result as opening /foo/file does not get you
there.

> > So I stand by the need to check rename seq.
> >
> > However, I wonder if it would be tolerable to redo the lookup with the
> > *new* path and check if we got the same dentry at the end. If so, we
> > know the path was obtainable by traversal.
>
> I agree that if following path lookup will succeed, it should be safe to
> give out the path. But there's one more corner case - suppose you look up
>
> /foo/file
>
> while racing with rename /bar/file /foo/file. With userspace implementati=
on
> you're always going to get /foo/file as rename is atomic wrt other dir
> operations. With the kernel implementation, you may call prepend_path() o=
n
> already deleted dentry with obvious results...
>

So I realized redoing the lookup does not work either for the same
reason one needs sequence counters to synchro this kind of stuff.

Suppose a thread continuously renames /foo/file /bar/file and
/bar/file /foo/file. A sufficiently unlucky realpath implemented as
above can return /bar/file.

This all sums up however to once more returning -EAGAIN after lookup +
prepend_path.

--=20
Mateusz Guzik <mjguzik gmail.com>

