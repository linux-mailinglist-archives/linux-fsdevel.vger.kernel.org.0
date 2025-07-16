Return-Path: <linux-fsdevel+bounces-55109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A4B06F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC54564095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F128C2BF;
	Wed, 16 Jul 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdMDdEb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86603289E0B;
	Wed, 16 Jul 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651335; cv=none; b=hEx18pikaDeYCCRmH8KEqpNy2YAtAkyF115r68lHNrqJbDiZydRPX5kVF2FSvMw2x/UEyG1Qwwp0k0BUdUaEqtqIMTEDUMlMZINTlLvGbB8AJJnx/DB1TXbuzHrPTEedTIvj2sm4wkiiG+wuBRdG+IQnaOZEAZThIYQujxNUyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651335; c=relaxed/simple;
	bh=78+tpBJn33hSd9/wsG3MetwMUSK6DTYQtDO6aBY7PKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9RNA8NAo5ISxmStU/tTgA7X9x8Oj56UBZI8Ud9JfDWx1TVhmlYBe+2UcHGAQwl3XHWgJ2yjIreGo8JKOgsFnfvoLVCoaitU5wRx10teq3H7yWuilpsB8V+aMooC1FHc5N13i8ARFUSRsCn5Sf6b7wpLYYAH1uhERBgpa3UDUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdMDdEb1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso9887161a12.0;
        Wed, 16 Jul 2025 00:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752651332; x=1753256132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78+tpBJn33hSd9/wsG3MetwMUSK6DTYQtDO6aBY7PKA=;
        b=SdMDdEb1WZg+atzaZf2CI0PWaBNWDtX+kuN+lZQHd/0zksP+tJTm/kJDL3i3J6VYsT
         vqSQP0OsSdM47eAKwnJhXm2o0J1Gl5kI3TyphcU5idMWZiug+EGQ9hhCqdMIYKYbiwF0
         ykvdNmZQgWTC9WthNQlOfU3sB06zF2qgpKB4CnVauC3O5X8WyUAYUlHlGo3F0F55wXln
         Q1+m9wxarax1CHGFgANu3qLCJ3hvAHkPdOqouUoxGsR37HT8fCGuAdStzfFtM8R2p6l2
         7z6hLOMbps1Nb5PlHO7JrnbuErmCOAWPFWTt7PvRrvTES8TIouhAdJhu5qsWz2hteCwr
         2qJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752651332; x=1753256132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78+tpBJn33hSd9/wsG3MetwMUSK6DTYQtDO6aBY7PKA=;
        b=BPJJYIel1jGE3+cNvsBfPgXic/hfAI6NHnxWz3OclRyT2IBWNs5xQn3oFSmyIQ32RL
         /C97HaIzcQllHVzK2cB6X8W8hZ4Zbz5IedZh8OZw0LwEPInxqrtJ/O+i1JzZSJ5qQPG3
         Q3sQjH6hAqYl3SepnJqkUyKf3LedYCj1cH0MGMeWLv6mCrg6IVSmei6u/ViFFpcAstYS
         06dKDojXhx47yX2JUUxyHEGCGN8ZdyeQe07s8Czy7AAf4eBSQ9RDGhBtFyYykLu6KuzQ
         BxXA+d859ekhEevLE/ZDG5jbo0gDYE/wiC/wAd/raUzOD1Qr/w+CQiL2ZnA998TNzfRU
         xruw==
X-Forwarded-Encrypted: i=1; AJvYcCVPrFpMRNaohwpebE3Wb3UT4L6GpjM3x3Mc99ly01qYdtdX58Px5QV4BWe74+z/9CJa1NTX0GmQL8kLqADs@vger.kernel.org, AJvYcCXBI2AMn89RT1rXipLQXNE8J7PCgKbooZ9yLvCcU1zOwHyVsuB65Svxn63gnXVIfuo3zDfJbIZG2uqAmB+ufA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4saXesX/jH8Woou2OVuw8Sclq2aXYCxnd5PBnBAhOzbQs75N
	tqQhri3HyjSUEeJJkDNLrkt4Mmoz3P2JvNphcJJpl6lE77GWjIJ3fyKnqhe/fDNC7B/RA7WjepV
	JFfFFsSqKJrpN/KMBG/wzuXtx3mCF78w=
X-Gm-Gg: ASbGnct4+mjCb/9b+3IBx8vvnGBLfDBY6kZCecbU78DYb0z4Qi+gN587JmLq7Tw10SX
	+BbKOx6Keerex6XtUCDxqR29EG7EYltBVbhGazVEfXqzBpVVSM4UH/NgzZtaxZZf7jUe5REM0Nz
	x0wld5HIi6xmRcBsHMmvE8Iq2fXR4IhkHJe82UfMNYA8lHUMgtEcanbs/FP4xhjzZOsvJ8ABO6d
	mTsPJo=
X-Google-Smtp-Source: AGHT+IElvPGDS0hJdML+UHi4/NTXulOE/GszBzY9OMYjD4DZtXJIygZyGCT57CaIZ3SIsf2o2OYftA2TQ+O9EFLmtQU=
X-Received: by 2002:a17:907:f1e5:b0:ae3:f294:2b3c with SMTP id
 a640c23a62f3a-ae9c9ac15ebmr221819866b.28.1752651331392; Wed, 16 Jul 2025
 00:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <CAOQ4uxhyaJnqPvwpVyonb1QLpyFaeRYr1bUZQkCvN882v4vCaQ@mail.gmail.com>
 <175265035807.2234665.12851015773166459586@noble.neil.brown.name>
In-Reply-To: <175265035807.2234665.12851015773166459586@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:35:20 +0200
X-Gm-Features: Ac12FXw3ryWDBMArglkQiFlUSTTAGp7AoZI6YsL7uByD0Vq07mkDqJtqT3t5VzM
Message-ID: <CAOQ4uxiHNyBmJUSwFxpvkor_-h=GJEeZuD4Kkxus-1X81bgVEQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:19=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Wed, 16 Jul 2025, Amir Goldstein wrote:
> > On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > >
> > > More excellent review feedback - more patches :-)
> > >
> > > I've chosen to use ovl_parent_lock() here as a temporary and leave th=
e
> > > debate over naming for the VFS version of the function until all the =
new
> > > names are introduced later.
> >
> > Perfect.
> >
> > Please push v3 patches to branch pdirops, or to a clean branch
> > based on vfs-6.17.file, so I can test them.
>
> There is a branch "ovl" which is based on vfs.all as I depend on a
> couple of other vfs changes.

ok I will test this one.

Do you mean that ovl branch depends on other vfs changes or that pdirops
which is based on ovl branch depends on other vfs changes?

Just asking because I did not notice any other dependencies in ovl branch,
so wanted to know which are they.

Thanks,
Amir.

