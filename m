Return-Path: <linux-fsdevel+bounces-52101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0AADF6B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE128189C7C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381481DE8AD;
	Wed, 18 Jun 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayOsYl9A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F5258A;
	Wed, 18 Jun 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274248; cv=none; b=K3Yg6zf9fNQ5eU+I6wBYqLe5Lw6qwFJHXistg/FYdZm1sdf6zOavsrX15557qugknGScbp9TrmtiSFZz1vZMbBgv3BIu7P1+RPb1vG3FqAsrUwAsG5WtFak2eEI/x/Sf/epxx5vvREG+BWDiYxEhilXd0bcoKCraDjWYCRafTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274248; c=relaxed/simple;
	bh=mthpMAefMd0Uj2daoERurR3iTXJ6Loy9FBWOnM80ZUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqZM27z0e/8lGT8HKr+ND4sFusrNFLpecd0Rl3N/dzfj7SfXWBsMBbtoC7Aiw6aPk8VHVIQzFQ94kV2vA1R7Kx1RjhAtbRecoSJorhSQrYLnaA34LZz87SDd02Sv6qIrQrSbrdqESTMtQohEyX8K+usVprdJizkWtV3pCBRRa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayOsYl9A; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0976776dcso2102985a.2;
        Wed, 18 Jun 2025 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750274246; x=1750879046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDKAOlHu69fxTS6iR0yk/a+F9PE14dEem44Hv6MyrY4=;
        b=ayOsYl9A9EaDycBQdOH16zzl6QF4Ulel3DTrRw/Eccftsc+4LuflTVrAvXjPzTQo2J
         o2fFW//ZY8LbdVaQEKtPf5faE14qqv+A9ajpa9A2IIMFf/CUblSVJ5X0XhdR2DkOzuDd
         VIivCivjqvmarDeWAmcK1vwFYq2dq4Gne64yowqyl+vlmfEagjo5waoBtUfvhsyFX6er
         M80akq6XeCPc5s/55PXzF+edekIaX/bvLDICs71xCXiF3ztA4Cwjwhn9XlfxAlLvlQc/
         Xr+JRg4Pw+XFLIubBUSyWLeJ1e4CxhuZjOC9L99DQpJ2n+8FOf2+N6M4t4j3qKCWpRCq
         LfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750274246; x=1750879046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDKAOlHu69fxTS6iR0yk/a+F9PE14dEem44Hv6MyrY4=;
        b=fPhaeliRkkDM2OenTtK9UqDsNmCG/SnqQAbJrlLmrF2PGCsG3CfRXT05gZsKaGM+l5
         RR21p3hMlJ8LDsrQIvWN1Qx8FacsGwaDShY3Iz+g1HMhETzeaFglhM0g+fUrCeVDUX4u
         xzbdzxTHWc5TkmoT14P22NVaNPQT4v6rLLtVLHGUSdkTsaAIchFBE6SkRbZ7TdXvRysQ
         xIELbbLleClrL546c6Mq0shCY6XVs0owF8iHpNz45OBrTDIA7nmeNKJHZQyBReGShVm9
         Tgt9p4pWI/pwdopIa+LZntuR3zjqd9Z3X5WuFNY/BXDYpE/9F9KuO6VOKK2sH9cvHtUT
         YLjg==
X-Forwarded-Encrypted: i=1; AJvYcCXdCes/+0d47cv1430vMQE1QbhANUZ4G6j5g+FOy28y1AxjJeGdoHZHlfJPbjcsSb0zbEFBRfpTnhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ic/PFXwZZr1R1tgKq8yfHLrSHnioy3iYttBHUByckkJFGarg
	A9RDPn5h2GEgIZZYzMWc4mOmgGiQ+2xFqtkhut8/52apEWdMzt7vniPOkpfbwsqFVEnkelwt8xb
	mig6jX+E3Y8A3Sm7Gz25OX2qYYujO/Q4=
X-Gm-Gg: ASbGncveSBFGS6L06DS6KnhhMoJzICJlDlYzALs1aVBSHUMXSmFkLYcalCBTFHtM3S2
	NsPVRT6QR9XoGhZYP8pd9Walr9PatXc7C4ePIhEd1rzV66dQph4RpcytppXBZBGicRGoN3fhSCv
	zBYHdLRRo3cVHxwUVh73DbMJIiH4hDfTUr6nhjXBlq2d4=
X-Google-Smtp-Source: AGHT+IH6gbjHCrxOi5ZSzcYPFC1O+4XzH2OkpTgxNcennHXcbPCgM9IeVMKWeOLxGV9+jTKxWO31UMiT1BGWi9+YV2Y=
X-Received: by 2002:a05:620a:24c2:b0:7d3:8dd1:e13c with SMTP id
 af79cd13be357-7d3c6cf5681mr2620098385a.38.1750274246039; Wed, 18 Jun 2025
 12:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com> <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
 <aFDxNWQtInriqLU8@infradead.org> <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
 <aFJEXZgiGuszZfh6@infradead.org>
In-Reply-To: <aFJEXZgiGuszZfh6@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Jun 2025 12:17:14 -0700
X-Gm-Features: AX0GCFtnICEMNloyMwPHF1l1QWfHW05IjqT03TbhkV_OyqlQI2raBoiCkFbN6Kk
Message-ID: <CAJnrk1aCo308fxgzYRnei1A29qskvMtiWNS50BJNwiyrQ2A_oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, djwong@kernel.org, anuj1072538@gmail.com, 
	miklos@szeredi.hu, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:45=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jun 17, 2025 at 10:20:38AM -0700, Joanne Koong wrote:
> > > Ah, ok.  Are you fine with getting something that works for fuse firs=
t,
> > > and then we look into !CONFIG_BLOCK environments as a next step?
> >
> > I think the fuse iomap work has a hard dependency on the CONFIG_BLOCK
> > work else it would break backwards compatibility for fuse (eg
> > non-CONFIG_BLOCK environments wouldn't be able to compile/use fuse
> > anymore)
>
> Sure.  What I mean is that I want to do this last before getting the
> series ready to merge.  I.e. don't bother with until we have something
> we're all fine with on a conceptual level.

I'm pausing this patchset until yours lands and then I was planning to
rebase this (the CONFIG_BLOCK and fuse specifics) on top of yours. Not
sure if that's what you mean or not, but yes, happy to go with
whatever you think works best.

