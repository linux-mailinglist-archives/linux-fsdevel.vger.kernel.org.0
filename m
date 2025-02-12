Return-Path: <linux-fsdevel+bounces-41604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E46A32CA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 17:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191213A62BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269D253F03;
	Wed, 12 Feb 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rHwAiNrJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507FF215050
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379484; cv=none; b=NzpWYtlipXTF+j7RfwPPiF4Oh8SS2E9B9vi30RnkrqOqOEj8MG4/Eaxs5L0928lGdOg1twNYlpQMAZr5MFzzCc4AICdNtJazRf90Zd1iRtHgWXGnuNI0T3x4hjCOBs8Wk0YJ3rEsizZ1myrrjxMqHSsdTpLbDdZ+HlVOS7rzCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379484; c=relaxed/simple;
	bh=P9JdwHaUKaC7H9Ci7BUO8mnUxxFaDC584LXFAy56ze0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAj/8tBdAveHhhMkJL5ghGt8MDF5MpkgfqBYUSVeZNfmOIzT53QfeV2U/H3WF9IcY8nXi1cChzTBok31ulrL1HJuM6OLxQxNIhO7UUmCduRk0LCTZELpQxEvzVhrVuNZHWpN1HGCf/bCjCd4LXK5O6BWJxzhgIYUsW2M6HPiB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rHwAiNrJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46fee2b9c7aso56602371cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739379481; x=1739984281; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vT+hMogTz46vryZ/YtUpB8CUx/hmD3efKVcLVJOFinc=;
        b=rHwAiNrJ0BgPN1fyXNjt5NNOPUdXPo2eCH7IIdezsP7jhXaSnfv/pMlRGBZiUA0Zvj
         Jk1d+tPpzdy6Vat8V85FNmqyHrJ51MljiBJvFdXsvIGsdr+nh5sSdeQBEIjr6hbXFA3f
         kaRWnbmo64Cb0VWnXSyleCJzaMdEiXER6IZMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379481; x=1739984281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vT+hMogTz46vryZ/YtUpB8CUx/hmD3efKVcLVJOFinc=;
        b=IZz4KdqS4H6lAjk2EL5a1f5m7g+rcBI/XfCi1gDJK/IuP6FJqE2nM5AX8bch/bZoDc
         gFWHNtzM6P7YphjcoN006PkoBGJTa8fO37aJiq4HesgdnJHwwrWcEkIqv7xxrgkJnzMF
         YkAsNj5+w1G4UD9rW+X19RbEeuTWoWm2kkxJ2DdonC/TxaxYr+LnhB8CgHhrxjm9Nmr4
         calG56ewuZf0/oB6CTFG6Fpy4m2bf3ldTdQBy1xJvVwRDeaB7S1tTUiuaIlnbGHVHR9J
         Zg0GW5n3CVcXOBVvfsJGuGDEtVGUtEWfnESizFCiXSPZTuuGgnzES7J/UQ9mTeEXDsCN
         hocA==
X-Forwarded-Encrypted: i=1; AJvYcCWddeUTVUVaYwt4+K0l55tI3pwdXQYdAM/H0wIyaX8mMYXEPvTUUEEvEWOnT54GVIRXCztVR7+cpsAIeWJy@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwCCnSdF1E9MOlmBNsdQ11VdlVRak/SKVEmB9/WASZmWbwzW/
	FoC8qHC1ZiF94ScEQiJlICD8bNnRN1lrxezh2qVIC+43ScwswMCwvFaPKqSHOZaNSr6xoM2dgNB
	VoG5a7QvINsNVZwunfn/StP+Ezysp2xAHZJXcvw==
X-Gm-Gg: ASbGncvJrXxjpXMcllhaKF4mO1jAPP64ODNEOtp3N9Di6rG4uVDyT29f6UL7Qtk4LIc
	hppVS+CwnxTnUuYsyWCS5A2AP9AAeCUecTbJz6JJbOLReEoz7pHb/rs+RgLpPrOTI5HH1Vg==
X-Google-Smtp-Source: AGHT+IFnzDALt4z009doDSKRYtYByrEnwBJUsIaU5OvZsRiDtAZNjs0x/YiFPJyI6tUyZN53KmJkq9tUS68zIvw2b2s=
X-Received: by 2002:a05:622a:181a:b0:470:1fc6:f821 with SMTP id
 d75a77b69052e-471b06edc47mr46227211cf.35.1739379480995; Wed, 12 Feb 2025
 08:58:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com> <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Feb 2025 17:57:50 +0100
X-Gm-Features: AWEUYZnDklP0Q04eQJbdif-V3Wr25nZfxbERwb43ZA_kG2OIKQLTbPE7mtefsDg
Message-ID: <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:

> It sounds very complicated. Is that even possible?
> Do we always know the path of the upper alias?
> IIRC, the absolute redirect path in upper is not necessary
> the absolute path where the origin is found.
> e.g. if there are middle layer redirects of parents.

Okay, it was a stupid idea.

> > > Looking closer at ovl_maybe_validate_verity(), it's actually
> > > worse - if you create an upper without metacopy above
> > > a lower with metacopy, ovl_validate_verity() will only check
> > > the metacopy xattr on metapath, which is the uppermost
> > > and find no md5digest, so create an upper above a metacopy
> > > lower is a way to avert verity check.
> >
> > I need to dig into how verity is supposed to work as I'm not seeing it
> > clearly yet...
> >
>
> The short version - for lazy data lookup we store the lowerdata
> redirect absolute path in the ovl entry stack, but we do not store
> the verity digest, we just store OVL_HAS_DIGEST inode flag if there
> is a digest in metacopy xattr.
>
> If we store the digest from lookup time in ovl entry stack, your changes
> may be easier.

Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.

> > > So I think lookup code needs to disallow finding metacopy
> > > in middle layer and need to enforce that also when upper is found
> > > via index.
> >
> > That's the hard link case.  I.e. with metacopy=on,index=on it's
> > possible that one link is metacopyied up, and the other one is then
> > found through the index.  Metacopy *should* work in this case, no?
> >
>
> Right. So I guess we only need to disallow uppermetacopy from
> index when metacoy=off.

Yes.

Thanks,
Miklos

