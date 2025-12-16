Return-Path: <linux-fsdevel+bounces-71468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E01CC3875
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 15:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D455305C1E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0588534EF15;
	Tue, 16 Dec 2025 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xsfy893h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD834EF08
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885630; cv=none; b=eGxd7YNM5E6UTkLF0DiVL8tBEY+8TaJt/Dx08l9G4sp3onY3QO+T9kLKuIVeMIHeQJ3oTTh8Pu8xj3HZmLYmNJ5FjcN423h9SYdZFRtRnNGRWjVvvRKr99QNUC66e2Q76g9+ME6dVts+IKlAKIpoY4JQCzrhCb59FhNF0xeFofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885630; c=relaxed/simple;
	bh=hh1duVCAnumTBIgr3zDdRXr0MLcZGqkr2SVcBgv4wmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0GOX6P2wpmbkUasT0ojyoN8xjFhsSBpyWbg6HY82OhipSuMjM8Rm1NMQavowgvxe3OvANJ3G02N4qmY3lFuK2o8ZPtiyjBBKQO5uWGrdUGDVSMx5lUieSx7/nqnuTDsI1qtf+g14LO080eLKDmxnjKi1pyVYOnn3dI+wyWHnYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xsfy893h; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f1b212ba25so37874171cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 03:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765885627; x=1766490427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFHQg+/n7sULWXsn/oQ3oX1VR+5L4K9j0kFk6RwJ4WQ=;
        b=Xsfy893hYf4JlucLwdVFY96Y2RnU++lssu7bQr8BX/gl9qB4ejLemba7iwHbSTdCCN
         fPlPf2fvlIu/y+z1YCBXnikv7+14+0Y4JILxx6Na5SBoa5X6yuA91ptw3hsfsvzarRL2
         MoO02AdSlvzvPFQTJdkjDY+PD1w5EkQSOqlrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885627; x=1766490427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFHQg+/n7sULWXsn/oQ3oX1VR+5L4K9j0kFk6RwJ4WQ=;
        b=WD2DlnZ4VvWxcd3ooLzJ6MSF6KDf7xMEAzLTAM7v+TxLQ2ZjyxidKa/FyuU0/AenCh
         VGGXgUbdi5FhcsJQZfYnsRCsvPkGqyquOBdqCYoRVahIFA2RNh3UYrxFaGGauBB1/PJw
         t/Ysrik1j1BCAIDD/GBmnGn+4MHAAEFBmZ3U11TWYejcuK3Yh7/IqNrNsp2BtgfSBDpc
         GZ0B46PdGN4o2HSQHIo0X3nld8eRCcHjQ6wGPPTg/3mfxYa9SrBWJ3IZzl5AOmwqq/t6
         Hs/2+xVBluh4GMdTfnIsXt9IX7vxkihS0TQJZIw2yh8NkrkEUPpYi9M2ZO2CvqO9f0kh
         cZlA==
X-Forwarded-Encrypted: i=1; AJvYcCVNClyGWCehBiwrNn9p/qt4HWuryX/bp15IZv4+OFFSe/Y0wf3b1lN8U5lMJuZbPrTrOnoB1Z1qU7XcvKVb@vger.kernel.org
X-Gm-Message-State: AOJu0YwbP2xqo3/IgaohWt/D3fjWb42ZYcptVA19dXs0lY6XaIUnNag4
	9ZXCh0TTGS04wakFEMtWXhULMP5fv9cNMdZTEi/ItYTXEKTexmU074xlqouJmxk/Bs3rFU00G6F
	kHRuleht1noXCdiQ8uf/yoyBvXG2aNVWJGr3KBFtZXw==
X-Gm-Gg: AY/fxX6R10yhU/0PGDklSEJUmu4s5ajveWcu6b1Ta9KMUbqM/myv+7R7LN+GS0ONM7J
	ndGBEfGKhfylB5bUhXexFTUGUwkgWuK4WdvI42diQ4nsGXM89bRzEzZpjoGXZoWJks8aw6IWftc
	HBFSYSE20YyvFfcCOSW/yI+Wg+chFkSpVFk9479shMCEWfOLteJBGRh7qup6mOo1M9iqbwBkN/n
	TJ2D01Dx8BZEtwMMXLzd5Hhpu+8xfmek6TV9iFJ1zzuFV/rBdyhlvbhMlp8w1DZxJIUji5S+Ebj
	Ar8Egw==
X-Google-Smtp-Source: AGHT+IEDnShj0T3ABJEqTwofymLjlHynA8sAoMJd4aAzqCwm+4V+ZbwdxSI3O8sF9tEPVFR0xKDnXSbByrCBUhrGRr0=
X-Received: by 2002:ac8:5a47:0:b0:4ef:bd4a:e549 with SMTP id
 d75a77b69052e-4f1d05ee78emr213755611cf.60.1765885626761; Tue, 16 Dec 2025
 03:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-4-luis@igalia.com>
 <CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj84xPPCMGQ@mail.gmail.com> <87pl8ed5l3.fsf@wotan.olymp>
In-Reply-To: <87pl8ed5l3.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Dec 2025 12:46:54 +0100
X-Gm-Features: AQt7F2ruTvDOeIEVrN4Up3R10BMqrqtbZHXyi5_zOAWiJBjRQ9aN_adm142A0Xs
Message-ID: <CAJfpegt-0VDicWso6ZjsFyawuKj8Xf4qwTEth00CdAd-pUNcjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Dec 2025 at 12:33, Luis Henriques <luis@igalia.com> wrote:
>
> On Tue, Dec 16 2025, Miklos Szeredi wrote:
>
> > On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> This patch adds the initial infrastructure to implement the LOOKUP_HANDLE
> >> operation.  It simply defines the new operation and the extra fuse_init_out
> >> field to set the maximum handle size.
> >
> > Since we are introducing a new op, I'd consider switching to
> > fuse_statx for the attributes.
>
> So, just to clarify: you're suggesting that the maximum handle size should
> instead be set using statx.  Which means that the first time the client
> (kernel) needs to use this value it would emit a FUSE_STATX, and cache
> that value for future use.  IIUC, this would also require a new mask
> (STATX_MAX_HANDLE_SZ) to be added.  Did I got it right?

No, using statx as the output of LOOKUP_HANDLE is independent from the
other suggestion.

> What would be the advantages of using statx?  Keeping the unused bytes in
> struct fuse_init_out untouched?

Using fuse_statx instead of fuse_attr would allow btime (and other
attributes added to statx in the future) to be initialized on lookup.

Thanks,
Miklos

