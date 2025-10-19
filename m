Return-Path: <linux-fsdevel+bounces-64620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506F2BEE35F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 12:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03203E1404
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E402BD58A;
	Sun, 19 Oct 2025 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIu0ckJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B21DE4F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871020; cv=none; b=ZeU7Az6Xnz9TsHibg/hJF3x5jRvuQ5p7BAJx9nJg4++unA4PyXVMENC6XyNchaNW56ZNEYp9t3+p+RebFjQl2p8Bbk/aTnsRbL950i2/PxEgXtZ4FqYVnbHC5gfkVld/7tos+bur1g/qMu9+zLtzOTlp4k/WeWXVub1DUe8CJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871020; c=relaxed/simple;
	bh=fNstHjYQ+Ysj93ewg+dKEXIcSLU2GJWWSMYmcobrxYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9zmYxdc3gq+4BloQkMyk849SLIqC5HP710/+VI/yOR+aH/ameutpZQHtY/pwsxz431O5XZdAFVLPZDtuSATfWGoM2e3d2lCQtV/h0zBZlb+vv2jjG8kMsMWzIo4dGSZ/a9XsBrp5to21JT9pWaGiehAECG9P5kPzP5gjXKwXeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIu0ckJH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so2604687a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760871016; x=1761475816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz7zRkyiFutQ61IP1yupRPRRuqu83JuV8e5afjo79xM=;
        b=QIu0ckJH8X9Hu2JZkmlYyB9GMsxHnzcenkrE81kzM2zy7Phgsj7DwLQ9iXaTrT8SnA
         MNABrKcGK5AXs/3IAe+30/T0I9ojNRHEquHfof5FZCoNbmuu7aSk/SavDAUFFv3B75jF
         UL6+k1M1AqNPeOdT2FllfUtxqyrB7ZAuwFi5ezbc+jsBCVXhIqiRQFwY+BpacDpXT9Wk
         +aa/n3tXQBBKU+p6dnXTcHWp1vsJw1OCQ8HiF9Sdi01AWsxmLAVQI9uYK0zuiFW5PQKT
         mYZnRMmVH3LToxwbVe+wAMZz1dKX68gXDXQfo9N374J/DQLRDtbtmbyjw3dYE6MV44OI
         FMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760871016; x=1761475816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oz7zRkyiFutQ61IP1yupRPRRuqu83JuV8e5afjo79xM=;
        b=W/+ysV/a2h12VjKN62w5EXkzRnxNxf4oVAHsMnhxONwBtKEXsEvx49f/wE/R7CxHB0
         GPHSIjWS50+sUe1r+TdSkzhjj80DnaP3BhW8BD4a3tut81GoSAtM/eSr7av4PG+27Jo7
         BL0MbpnCOG0XOJMv3aDnjvO1uH05RWvIDzY4dRlr/p/YVhq9dcLZpRPsCFUOiW6xV9Tt
         Q/c12oTrccwdAdQz87liL5PnukyICcgaEbnEXS1Pn8lvjDLblQT29H/olRDHmEG+yXgh
         RF2+qLy8PrdgpuLTIOqbx7nV/R4LoWu1Jr5mh9zEvDei4fUWFaevzJBlLvFrK+DyPmat
         SREg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHyf2nImqikJs9TZ9m0ZlCdI2VudbJjsdEtqy5qPmbanPIT1z8kCLMY+kFgjTzE8jhkW34c/f/PNGEybZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bDAJaWHjm1iuJL1aBgmqOO8pk3UbDeNKQGkpGbbB/ggHBPBD
	6HI1ilFKhr/fuNGnH848VhJhn3jyzyO7yaD+JGACt2Ek6xPAPS4h8sZ7/2tYK6gqNF9NyxswwTP
	mCv1vH1kqyZ8xTzL4/hCYidNl99hHipE=
X-Gm-Gg: ASbGncun2XIPIkwfwZJYY1lcQhe/OjAaMp95/sQ28rFBNZ9u4wzk2xV3FOCgRXdHq6n
	ID622LOIRQGRb23OlL7mvrYY3gfPyEVswWDfcMwq7nFWBS9Vvb6+s2oym3jwOIrawDN8u145f1w
	vrd7qABeyYswx2sUgOKufVvCZBWIrR1tZ8nWcCSt3U+xcwps8mNniQZ2LjjPw2mg1C2BI9UIWFK
	yLyyyOL0A/QTAIqyQCMZ4hQaX4iZ4AZ3YrJYEA3sufwas4vHYWaEMnevAQ8zTjLasUOyKFjc72f
	PrXafuVA9ktwCSbiPuf2OygfhMSXbQ==
X-Google-Smtp-Source: AGHT+IG8c+spr+UQbKooFR/dyv4qt6SWp6IWskh8KvUZswBi8H8WbXIMh8fXEccizpkLBB3TlDR++m3lSlmxW8mtULE=
X-Received: by 2002:a05:6402:5cd:b0:639:710b:6957 with SMTP id
 4fb4d7f45d1cf-63c1f6e69a9mr9635571a12.27.1760871016345; Sun, 19 Oct 2025
 03:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015014756.2073439-1-neilb@ownmail.net>
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 19 Oct 2025 12:50:04 +0200
X-Gm-Features: AS18NWBU_pgtjdvFi3BTsjYTwmuJgi8o5pMjIJi0tCEt6GTK1jgc7lRvtD0KlVc
Message-ID: <CAOQ4uxg-3-GdNXX4AUZu39QqA1HCb4KKHQ0y=6+TFSS-nRPqpQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Create and use APIs to centralise locking for
 directory ops.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:48=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> Here is a new series in response to review (thanks!).
>
> The series creates a number of interfaces that combine locking and lookup=
, or
> sometimes do the locking without lookup.
> After this series there are still a few places where non-VFS code knows
> about the locking rules.  Places that call simple_start_creating()
> still have explicit unlock on the parent (I think).  Al is doing work
> on those places so I'll wait until he is finished.
> Also there explicit locking one place in nfsd which is changed by an
> in-flight patch.  That lands it can be updated to use these interfaces.
>
> The first patch here should have been part of the last patch of the
> previous series - sorry for leaving it out.
>
> I've combined the new interface with changes is various places to use
> the new interfaces.  I think it is easier to reveiew the design that way.
> If necessary I can split these out to have separate patches for each plac=
e
> that new APIs are used if the general design is accepted.
>

Apart from minor review comments on patch 9 not addressed
from v1, all looks good to me.

I could really use a "changed since v1" summary in this cover letter
and/or individual patches.

Please push the pdirops branch so I can run the overlayfs tests.

Thanks,
Amir.

>
>  [PATCH v2 01/14] debugfs: rename end_creating() to
>  [PATCH v2 02/14] VFS: introduce start_dirop() and end_dirop()
>  [PATCH v2 03/14] VFS: tidy up do_unlinkat()
>  [PATCH v2 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and
>  [PATCH v2 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing()
>  [PATCH v2 06/14] VFS: introduce start_creating_noperm() and
>  [PATCH v2 07/14] VFS: introduce start_removing_dentry()
>  [PATCH v2 08/14] VFS: add start_creating_killable() and
>  [PATCH v2 09/14] VFS/nfsd/ovl: introduce start_renaming() and
>  [PATCH v2 10/14] VFS/ovl/smb: introduce start_renaming_dentry()
>  [PATCH v2 11/14] Add start_renaming_two_dentries()
>  [PATCH v2 12/14] ecryptfs: use new start_creating/start_removing APIs
>  [PATCH v2 13/14] VFS: change vfs_mkdir() to unlock on failure.
>  [PATCH v2 14/14] VFS: introduce end_creating_keep()

