Return-Path: <linux-fsdevel+bounces-58094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0756CB293B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9120206C32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA81223301;
	Sun, 17 Aug 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RezlY0wC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4B186A;
	Sun, 17 Aug 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443045; cv=none; b=ekTakK40FlZ4xecGQ649v6vzbBNlt3sBZswZIfaIJYMrix0HBfFhWYJy5Ke2qMHo2A3y2T0nxmDu0xoFZktvqCQYIsZ880qb1b7eVcRAgscdQrfUWy0jKCB5aXd1bnXT5gSH0rz04vjFfR1pjsvaR3nqmkGVCCE9XU5AHkaSiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443045; c=relaxed/simple;
	bh=ur5KkraNPuEYqHRyd33DJMmkfD9qgU9wZRmFor3Sagg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA+twe+Jp5Gc3fX1dcuWZu9oxZkVcHmFdjMPLEKZmN/ah7W6uL9MxQjFF6e5VN2b31kh+2QXaNEMtk8qOUPQHY/ftFcE55P8SmSupRguTkHZugGb20bjhTtklabn2h5uahwZp/1wksnW/lhMKJKBhf7rhSypwt/j27Y1HqBUj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RezlY0wC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a2a5b0689so1068077a12.1;
        Sun, 17 Aug 2025 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755443042; x=1756047842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oDBK2IHSfeCUc+llP0hNqW2uaLUwPC5fWWUTdXGDvk=;
        b=RezlY0wCEXJKFkhPfd7NRJvv5bLm7TkyfmuImICA4kU6JcOh1PuDzciDcyCwRLfzrE
         RH++TrccBbeBdJ9ezEEY50u0iO0YWmI74tbtAV3usi4//uYHFT7jm9G0fcT0N8xZ7EVA
         5hf5kCjOjWJ4EApcE3ZfuR+ip5CetWRJyfWqfojCdSSAIeLT/OA9V2mpi7QesyeORjgE
         f0ArJHSUAVuVn9F8gI4BY53TTYzgvYuVnw11EOnUZAo/m7y8gaM3gVLR34lGqtv5NP6z
         bbihOwIZpydGt7/qSfrkFmphCKKzjg+37BhXoDlBbBFNembS1UN/xkIh7Km+ZMpb7msm
         HE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755443042; x=1756047842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oDBK2IHSfeCUc+llP0hNqW2uaLUwPC5fWWUTdXGDvk=;
        b=SZksJGCxOE5uoP3yaB/p1SdSdaGxjCHmM1sLpyyFX6jAoiFIpwUFIzmj/SSjaNgtN8
         yvJ4KAa9RG5+BAjiMbgKYDTV2a3F0s+x6uXS+ihvxVfTqfSrxU2nltV2xf/CtMTf2bVn
         4Kghrmej5tY0reMDE8OLraDeUP8wYT9zpr/tO0neQ24Mnz8v4MYO2HqKPC92BAv2jguM
         Lg/n/4fJkyRu4+DYfQrUyoDGdrJYyPuYcRcuf2isxGX7yCmQh49h8PS+SMm8Xfd6gCwp
         g26gfZ3gU/i+CKIa8kO1S+M/BtFOCUAEvTxtKyPzmZyasfvYNzPeNYd916BFkhUREXtx
         KSew==
X-Forwarded-Encrypted: i=1; AJvYcCUqhgCMGo+vXm7Gru20oEkAErop+IefzNV++oJ/z+Al5oJdoWm4munE8wfjy9e8EU9McJ26/xV72y9w6XyB@vger.kernel.org, AJvYcCW5f/uMnY8MhUTHLJUnomO6cD7m6ICFGKh3KXP0f19P5bozEMXagAIebYCTrV7GMQIDYSLK7uMGWR239KV0ew==@vger.kernel.org, AJvYcCXd39jh3MSNwJjoTMkgiw9UxIrQBwBSIcFWtv9gWcq/UL4lAV1DeyerpSyHouCi5OnaUX9vjjU9aPuwLQAW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+r7ls+HZ2q53hGNBUBhfWWTZY90b6ijSolJt6Ew/CidpFfyD0
	HmH3O0zko196ch6ubTEUrNotUmfbGewFdjX5tLQ5YdeuYqa38Ww9kQb6Fb3/ztAzU2+P3+K1Xvw
	UWnpNAQyUXzRMqbDO61grI4RrMWkQIgk=
X-Gm-Gg: ASbGnctWn9vmeFTJmfcLQ2TVzuda7L9rDlGY6z8CFUxVJRKZmqaHKSFQEktK5oZX8Je
	cOyDzyb+Rx7hU5AxULr+gzM7F1LB4aRrjvYJV2Hm35KLBYMZvaOStGZluVW3JhV/CsINjRhJ+VN
	1sEtZgSsTltUyDmrXLCXGCd0Chf9tDw5lDpxMqJpdpk1X77N6kXEDtJAHiLFjTHJCtew4YJcGNB
	7bIn4A=
X-Google-Smtp-Source: AGHT+IHHwbsDRdYapi0Vuk3RyS86pXBaT5CViMbWdMAUOe2YX8fWP8ckFW5lM4R+7o8U08hw27G0sMnBBYaAaISNym8=
X-Received: by 2002:a05:6402:518c:b0:618:363a:2c58 with SMTP id
 4fb4d7f45d1cf-619b7077f75mr5218607a12.11.1755443041584; Sun, 17 Aug 2025
 08:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com>
 <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com> <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
 <e2238a17-3d0a-4c30-bc81-65c8c4da98e6@igalia.com> <CAOQ4uxgfKcey301gZRBHf=2YfWmNg5zkj7Bh+DwVwpztMR1uOg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgfKcey301gZRBHf=2YfWmNg5zkj7Bh+DwVwpztMR1uOg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Aug 2025 17:03:50 +0200
X-Gm-Features: Ac12FXz70SOaoH7XewpUKh3kqYrDwJFeBzKMp9Yd2G-ODp9NqVlb28dD1iZJGGE
Message-ID: <CAOQ4uxjf6S7xX+LiMaxoz7Rg03jU1-4A4o3FZ_Hi8z6EyEc7PQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:50=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Aug 15, 2025 at 3:34=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
> > Hi Amir,
> >
> > On 8/14/25 21:06, Amir Goldstein wrote:
> > > On Thu, Aug 14, 2025 at 7:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealme=
id@igalia.com> wrote:
> > >> Em 14/08/2025 14:22, Andr=C3=A9 Almeida escreveu:
> > >>> Hi all,
> > >>>
> > >>> We would like to support the usage of casefold layers with overlayf=
s to
> > >>> be used with container tools. This use case requires a simple setup=
,
> > >>> where every layer will have the same encoding setting (i.e. Unicode
> > >>> version and flags), using one upper and one lower layer.
> > >>>
> > >> Amir,
> > >>
> > >> I tried to run your xfstest for casefolded ovl[1] but I can see that=
 it
> > >> still requires some work. I tried to fix some of the TODO's but I di=
dn't
> > >> managed to mkfs the base fs with casefold enabled...
> > > When you write mkfs the base fs, I suspect that you are running
> > > check -overlay or something.
> > >
> > > This is not how this test should be run.
> > > It should run as a normal test on ext4 or any other fs  that supports=
 casefold.
> > >
> > > When you run check -g casefold, the generic test generic/556 will
> > > be run if the test fs supports casefold (e.g. ext4).
> > >
> > > The new added test belongs to the same group and should run
> > > if you run check -g casefold if the test fs supports casefold (e.g. e=
xt4).
> > >
> > I see, I used `check -overlay` indeed, thanks!
> >
>
> Yeh that's a bit confusing I'll admit.
> It's an overlayfs test that "does not run on overlayfs"
> but requires extra overlayfs:
>
> _exclude_fs overlay
> _require_extra_fs overlay
>
> Because it does the overlayfs mount itself.
> That's the easiest way to test features (e.g. casefold) in basefs
>

I tried to run the new test, which is able to mount an overlayfs
with layers with disabled casefolding with kernel 6.17-rc1.

It does not even succeed in passing this simple test with
your patches, so something is clearly off.

> You should also run check -overlay -g overlay/quick,
> but that's only to verify your patches did not regress any
> non-casefolded test.
>
>

My tests also indicate that there are several regressions, so your patches
must have changed code paths that should not have been changed.

Thanks,
Amir.

