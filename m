Return-Path: <linux-fsdevel+bounces-64146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC4BDABAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 19:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E064F1813
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952683054DD;
	Tue, 14 Oct 2025 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCKb16It"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72723304972
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760461328; cv=none; b=HtZLudAOU4MgOEFvwOyeg1AJvka8x6VbCiIl49F+vW1tqR/K1kQgth0dGJPuSbNBSWVc4IGKtnZF416ifF6DjwODxqJhBLZk/RnB5uTyArzeOE7JGrTfTTcZBL8dsRB9V69Xnl4CbmZbP0tFxzLTH8FC1MJEJ5Wdnke1WUO0v+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760461328; c=relaxed/simple;
	bh=L4ugcq6cShFH07clIC29+wavr51l+pFw40whAk/VOpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUU11DiJuTTuT0sMlFKxoiLwondzlehWmOHdTQrteNbJnppNh0hSR/J081CSrDn5MPdiiR54ezMbZk8v73JQ7VbfwDBmWSmdTIKjwDcjfpLrUesU5y7szg28hWfGIBv+lWWpunPF5HJJG3Dmo5+GLRASJYNtvaUAZ0Z5zLpl/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCKb16It; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7815092cd05so10247447b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760461325; x=1761066125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiCVY5I1JOpPd1mbXTfrhMnqAsmeTTtG3NfQtMnTa2A=;
        b=HCKb16ItdVmdIrq/mO6LLg4FjyPsWcaGIkrKQkoa+t7jxzOz6H+4FpzplczDiPuMgL
         oZhc03ml831jOu3nMUkihblC3UukIxThZ8nV9e3w45kQg8zb4l4TA7+w3asku7nKtY+6
         OKsupcsFi2CpJCT3Txg9qlzoz2QkgJggw0G/fntS41LV7VCgR95lboJGhFIEoj2aQKPb
         ldhX7BTsMW2s3wCRanq3V5sB3Nyr7Bs1ZUNQCSFCyzBVanDq6JkiRW/NLCMCRbSRHzsI
         8iRG39vQLsvWWX74Fdkqu6lyDmcPBIZhuIDfPFACCZO7I32o4HjIo1B9j1tCcdK/4zc/
         VAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760461325; x=1761066125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiCVY5I1JOpPd1mbXTfrhMnqAsmeTTtG3NfQtMnTa2A=;
        b=OeuUE8DESxa4BoZRyo3BhsdFLhyqzZXWhkz9F57f3lXbVaef4CNWU4+V1/0YyccDsZ
         1xwykn3pgtOdNjvL/TeU4sWkx48dOQ7+MjvD4lDKUmiPXX1cvpI42smtjNSoSp6EH2wQ
         Ie3Hqv+XO5WdJLZwX48y/BAMS17HKjXjgY7lCDZiNLV6TOMVjd0VqSi/CFYQWf99o4/K
         dyQEAEuXSVE0V97kqUrkfLUCKanoDnMs92DNXxNAnfU68YcLdHsRLJe6ucgq11s88tiy
         71dz5gG/B3NWepn1Iln22fKMKHyQhbUOFZQtv8Sc52IAILhSAyamYXZNzAsbHF2vFYpV
         aOMg==
X-Forwarded-Encrypted: i=1; AJvYcCVvmL7AuBxeENdU2Vz+mpbKSwklWeXK2Ql+PHXgbS+9ul46lsrOcyX7HqMWu0g0rGtNZLny3MykmSkKkfnP@vger.kernel.org
X-Gm-Message-State: AOJu0YyCrJeWLaVM/YxisMJ9m89+9azyas2WhtRSMUtnd7hltVKt5eC8
	xsVW7Q6k5dRp4QyMlBDC5VgL1XuB2s/NKRdjk2XEPSCXjZ4yN81T4+xP+Kr5n8UcP8kfF4i/Iun
	NuOq97xy2P3tOhdv9z+a4T8z5ZkHt7do=
X-Gm-Gg: ASbGncs0XQRNtJXMkjarULX2hwSwBDvAdqobJ3dh+qtRafseHKRVF43aaK5HLDKYx1g
	1nDJKbMXpdQAd0sADP67tROWW1s9DIaL+LW1ZWO/SrD6DJ6vg1k54MVbInokbaoO7go8g7OwZur
	irTMCDKPldNy366RPuOUDEhm9uB8mNpQ6wOg3zlVcrrRp7N17zh+EbXIDm5XAuqRZZGmBEBAoBB
	IzsDe7FeetbEWLR72sh+v7qMlCR87ot0CO3FIENq2A5dDHL6nQ1yxVB/g==
X-Google-Smtp-Source: AGHT+IEujHm7zyW9C9csmplcIl28YSFbDC+RXAgRXtI1BLXHl0TPBl4b/XV5+0w/3Sz4hb4eZjnDYii/ibYLEg5tNaU=
X-Received: by 2002:a05:690c:fc2:b0:780:fcbb:c35f with SMTP id
 00721157ae682-780fcbc0e13mr190348647b3.30.1760461324794; Tue, 14 Oct 2025
 10:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
In-Reply-To: <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Oct 2025 10:01:53 -0700
X-Gm-Features: AS18NWDA-EBGXeaV443-s_8eQCzvx4G2-GBvxjQgb9Qan8gEi2zGKFJFUTwlXxQ
Message-ID: <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Brian Foster <bfoster@redhat.com>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:43=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 14 Oct 2025 at 09:48, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Maybe the solution is to change the write-through to regular cached
> > write + fsync range?  That could even be a complexity reduction.
>
> While this would be nice, it's impossible to guarantee requests being
> initiated in the context of the original write(2), which means that
> the information about which open file it originated from might be
> lost.   This could result in regressions, so I don't think we should
> risk it.
>
> Will try the idea of marking folios writeback for the duration of the wri=
te.
>

Is it safe to mark a folio as being under writeback if it doesn't
actually go through mm writeback? for example, my understanding is
that the inode wb mechanisms get initiated when an inode is marked
dirty (__mark_inode_dirty()) but writethrough skips any dirtying.
Afaict, folio_start_writeback()/folio_end_write() needs i_wb.
Additionally, if the server page faults on the folio that is now
marked as under writeback, does that lead to a deadlock since
page_mkwrite() waits on folio writeback?


Thanks,
Joanne

> Thanks,
> Miklos

