Return-Path: <linux-fsdevel+bounces-64017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9FBD6133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0BB3E0F66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327672FE06F;
	Mon, 13 Oct 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2zeda8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8B259CBD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387235; cv=none; b=Xji5KU+n2vbUvjvUjFh9BlSZR1AWN8hy/PdShtMt4Q0PAij7U/Iba1o6whcSZRYWATlzChOrqeDJ4zDEAiyCaabv65Ve50b1ZhFZnfU92psn1poOQi+/dVI7gxUaYXDNIS5BrDluxTCCD58AhOCOKFJgvRIZc4hLgjLKCjJB6C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387235; c=relaxed/simple;
	bh=KU622TuPaRD2MQxn++PZ8PXYKTsWOl/F9uMV6E1/6x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LsMyLbJf/6lKYy4KkGK2LSZDnKVaQkeMV80OlaM6aYO5OXSVPO3jGp7xv6guM+8xrXJnUq76IJQG9FN/F5I3dFHfcI4wRRfPjoLvL59P7ECDIbqKDNkkVRCMKxZ56vNB5CkB08Z9+aEhfJ4HW//UMiptNl/AF+Hk20JYCjxRUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2zeda8o; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85d02580a07so538053285a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760387233; x=1760992033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlD9DtXQmkM+JhYn0iDf8SrXaOR+regmjV9sqHbrOfo=;
        b=X2zeda8omZyfo1NgDGWyx1dhJ9fPGnppdYNNQ5QX8B0NkHAxLLvdJaCYa5y0MPdH0r
         F+pT3aRqi5yJUGmWtWnXOIKKh1CFX4pm5foGmT99iFMTR0P/Q7d7aDY0H2saYIQI1gDG
         tpdTMOeMRhZAaycmwtpDA4rEV8XOGZ/qlX9p0kP4s4Cslz4KDS8YpF+kfYrkaw8NnfVa
         TaPZ2pjG5onRfuZNUAXgstBFj0wCljQVlg5p8380F7EkG+IDyHKqwrjnQM1VFCSsFs9c
         6Xhzvi+UcsWqCE7+Z8ygmGTexyZUsIh+fTHLmcCUlpF51mraspZmwYR6G9omz1OPhQaU
         LVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387233; x=1760992033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlD9DtXQmkM+JhYn0iDf8SrXaOR+regmjV9sqHbrOfo=;
        b=pe94Tf6phDMCtvwCsV6EWSGsTTBe1P6GNnCFWhp7+IOXmzNH5AOxunXNuetp7Jszh9
         LVo8VR7tJsG3+gTzPO3n/dpSg5DbehpUFtDVA2WAZRZLmwqh9Awy1ecHmSpe/ByjCjU7
         MJg0Zb+JKr+e95/0hoe0gMTCQAmV9+nv9AQczNnooH6dqByw2A0r2RewXgbRIPAyRhqj
         b7Fxxhl9/EIp6RHhXmAM/9pZjyS7WC27zxJ2cT6Pe+6TzJat9ztiI/jxK96j0s+GKd0Q
         cwxHh1HLmm/HjKJgg6QHpq9IPQDwdzpRFnFgYPtXRp9sP9O5vdjMjM8HR09OBJnDxceu
         HTNg==
X-Forwarded-Encrypted: i=1; AJvYcCXm78SnCqg/8lvs7oxpAMmIVMIuKrd8MXCpqHDtm1otcYRq2uy3alWHZYUdCHviIS468pObpuKGdacCVA7O@vger.kernel.org
X-Gm-Message-State: AOJu0YxblrKkwnihzy3mXydyPWxnsyf/weVMgp8dAkHuZWkl7C8w/Lsa
	Oky89lTLFqLkpajwFXHE08c748sTbHxrSFlG70+S0FKQCdcZS3Aj1rNsQ+yFGE4a8brzD5Y6ADm
	WDb3lsBJH+J4pdY6akM4HwTSNeDbfXNA=
X-Gm-Gg: ASbGncuR3Kk23Ar1WPwdrMAhA0F9teLCAJwM7HCj7WHSvvRYTjkG91TS79K+EHqzC/0
	Kto7aWTwLuI+Lsyp7M1EGeLFtg5pql5KWbyQduuLA+ChWlH11Hi9g47U9Hw+2rcIOG2Xt5wBsQg
	yhkcZ2fKA5SyDMs5DZbIrB6q/rIOcZQMweMoPrg589uB/umvm9RJLLyUtujhfbR8MPlLYIhDiKg
	ZALbZnKbVYu3Ad3QWlLUfn8foHMMb4qgiT07UEsc/NBxOqH1J9wtRv+NbNS44VavkDz
X-Google-Smtp-Source: AGHT+IHZNzDVN6agCpPrO/1izdrx2SionIJFnZk7hW0l+PesIrTne546MtffhxsmTfyBcUvnloV59yHjTXtPoQj0VMs=
X-Received: by 2002:a05:622a:996:b0:4e6:ecae:b83f with SMTP id
 d75a77b69052e-4e6ecaec1c4mr333015881cf.39.1760387232594; Mon, 13 Oct 2025
 13:27:12 -0700 (PDT)
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
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
In-Reply-To: <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Oct 2025 13:27:01 -0700
X-Gm-Features: AS18NWBpmt7G8mJLvyRGq_BVSs_ov0ThJXHiqkT3BmFkjrMzauVDQCOzZ0CpmUg
Message-ID: <CAJnrk1ZCXcM4iDq5bN6YVK75Q4udJNytVe2OpF3DmZ_FpuR7nA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:16=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 10/13/25 15:39, Miklos Szeredi wrote:
> > On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> >> My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> >> similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
> >> that it hasn't been invalidated.  If old_mtime is invalid or if
> >> FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> >> cache is not invalidated.
> >
> > [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> > Link to complete thread:
> > https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.=
com/#r]
> >
> > In summary: auto_inval_data invalidates data cache even if the
> > modification was done in a cache consistent manner (i.e. write
> > through). This is not generally a consistency problem, because the
> > backing file and the cache should be in sync.  The exception is when
> > the writeback to the backing file hasn't yet finished and a getattr()
> > call triggers invalidation (mtime change could be from a previous
> > write), and the not yet written data is invalidated and replaced with
> > stale data.
> >
> > The proposed fix was to exclude concurrent reads and writes to the same=
 region.
> >
> > But the real issue here is that mtime changes triggered by this client
> > should not cause data to be invalidated.  It's not only racy, but it's
> > fundamentally wrong.  Unfortunately this is hard to do this correctly.
> > Best I can come up with is that any request that expects mtime to be
> > modified returns the mtime after the request has completed.
> >
> > This would be much easier to implement in the fuse server: perform the
> > "file changed remotely" check when serving a FUSE_GETATTR request and
> > return a flag indicating whether the data needs to be invalidated or
> > not.
>
> For an intelligent server maybe, but let's say one uses
> <libfuse>/example/passthrough*, in combination with some external writes
> to the underlying file system outside of fuse. How would passthrough*
> know about external changes?
>
> The part I don't understand yet is why invalidate_inode_pages2() causes
> an issue - it has folio_wait_writeback()?
>

This issue is for the writethrough path which doesn't use writeback.

Thanks,
Joanne
>
> Thanks,
> Bernd
>

