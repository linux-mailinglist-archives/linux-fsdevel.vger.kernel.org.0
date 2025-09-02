Return-Path: <linux-fsdevel+bounces-60010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD7B40D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A63D1B27DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14FD3469E0;
	Tue,  2 Sep 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwpkpNXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859962853E0;
	Tue,  2 Sep 2025 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837909; cv=none; b=HSH7HIwT0BFr1L65fGgYO+VVgdOLIY/cLE6NTmHHfFcPaTdSDeE/Gq2MsdkQ2S31qSxSwonxLxPylTcPnyoVv1kYODluRiVOTnYYIb+zviGCzgzYG7QUXp5JNAmtiwiHHP+MMSMMD7TRzNL5CmJ9bMNeJwzQE2OXhGy5xf68Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837909; c=relaxed/simple;
	bh=6W3DcUkvuDn6ffZ/Yp4bwQSp61ZGeiWIgF3Ou2HFsC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRQ9XffRlb0vRzS+TS43Qydm9pdWXJXzQQBmIoENawC2sXEo43BZ4wM8G2d3MWLnxS/NzxJfu2rvlayI3WDI0Rpe5RUj+RVEZ4WcGFD4eEMzP2nIpCVzyWHIyr+2acWl3XIYwKPaDi6F/JxGzTQJN1JU6XvoUD2gaXMZNY1tNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwpkpNXN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c58e29so98658081cf.3;
        Tue, 02 Sep 2025 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756837906; x=1757442706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BmLoBAAArAnQ+mO5WuxR7ckRkG/PjVIDgG0FMHYxWE=;
        b=EwpkpNXNAOd92QHEn9t5m8kXx8qj6GzGy91nVt0WcOgfE/jqkehVSZnAQdhR8JgvgR
         kNJZ+wn7LmM0J8Qc8kvbHABlcQ4rmGVOtCmeWMOwBEeD4+sZGo/juN+eieSApQXcvGCL
         CwVnI0hF9dS0MUPAILTMCbS/7Us1wqysamXJYyQyq6jezKFKiFOCFHc5SLCqoXecXvU7
         zG3cPAkZ6xBs2TTRJH/gEyjnrJRW9rw9eHAn1omRW6PArUQyBz7t8ntP6pgfbMSeLA+P
         b0CPQw0Ce96fub7Us8MWfwwasSJmT6LSNSMf6jyPmGJFmyXIxv202orJruH0ZWqyQ/oR
         fQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837906; x=1757442706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BmLoBAAArAnQ+mO5WuxR7ckRkG/PjVIDgG0FMHYxWE=;
        b=KaOXTPN3sW8PfcLawGctqdq1JYB9Qo/MbNc3baKBa0knCjOxeNvjft0YHvUVZqVhAH
         sj/3vM4frGSzUQb8labkEcY7CvMYwpodRoozOadK3BVPWitgqO0VDozm+d7HQ1cw7R+k
         NnNV0ysiXm0QI1fTmADnYoO8rg4lJeOjmK3TjpKAPa7lmNkl5Ils55h5205Amn0hIbNs
         lN8qxIDa12bzsm92UGjVu/HDXUP018C//ySLNJeQwBT8pAO46MIZXiVd4m0fl/pC8Dp7
         qqz+6jdSYIPD/jLqKANHSdM542CLKh0UHyfS0HbKIwCEyDCLebsbLIxC+1bVfjtiScTy
         4V3g==
X-Forwarded-Encrypted: i=1; AJvYcCUIWikBzcFyoIaaBUOSYxKcObgDDZX6uXUS1r9Cv4khoEOSHKJRiLi1LqiUIHTxQi4UsEBM9M7XhciQ3PrA@vger.kernel.org, AJvYcCVurQ93NLvUX5tQPR77vRRPoa9/m5tuZlOrhQwPikpmfr+8tNWz1CJxrjgVCku5wEca3GAmgSc9mdt7Ulv2@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNs5TKPscazZf6yj79fQgnbRtA/XFI++cX88L76r7kG6JsFOJ
	j4D2drzuZSWhydli1saNS0yuvEDpr6wfaVhcOpwMXzaTKqTYtuhWFcmV+OydAwVlBBHWxMWUrbz
	lCppoNpqKw551GmTgbtwzehDwT8Jc67ypcGtZQw4=
X-Gm-Gg: ASbGncvvLZziM83dQocX7oSel2yHNn5VfdpdhUHRizywMkOkpFnc+U16ixicTvgJLI1
	g2dGgtnfO60GB4bigrnPJ6AuC6S2jMLMmkm377sAh4CCJmoY+eq7kali+4y8/B9yp4rK0yaOLsm
	ZTrZXY1JHOp+0IWEf/KgxOrUd+ETzSXTAv2KbmSUtw5IHFKPQ0NT934xMPJzyzazoJUqF753vd0
	mIyyx3JGWrJI3BUrJc=
X-Google-Smtp-Source: AGHT+IHcAyBnsnaRFB6GvR0M9DwvhMZoK+VuMBmgCxXr/vNuz67Gbf8JR2OjFajr+EO+IDJjDUux1S3Vf225kTFDcBc=
X-Received: by 2002:a05:622a:5b9a:b0:4b0:8883:d893 with SMTP id
 d75a77b69052e-4b31d7f05f1mr155243871cf.9.1756837906304; Tue, 02 Sep 2025
 11:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902152234.35173-1-luis@igalia.com> <CAJnrk1awtqnSQS0F+TNTuQdLDsAAkArjbu1L=5L1Eoe0fGf31A@mail.gmail.com>
 <87bjnssp7e.fsf@wotan.olymp>
In-Reply-To: <87bjnssp7e.fsf@wotan.olymp>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 11:31:35 -0700
X-Gm-Features: Ac12FXyWCjRArQS_0eTRUkJ33VG6qC_AY2RkPyQAWqPz0UNa3dHdO88bp5HHn6s
Message-ID: <CAJnrk1bd62RcE9UU8COdpzSF0kk3DPYwgmwk+xCQew0-C43WXg@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove WARN_ON_ONCE() from fuse_iomap_writeback_{range,submit}()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:07=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Joanne,
>
> On Tue, Sep 02 2025, Joanne Koong wrote:
>
> > On Tue, Sep 2, 2025 at 8:22=E2=80=AFAM Luis Henriques <luis@igalia.com>=
 wrote:
> >>
> >> The usage of WARN_ON_ONCE doesn't seem to be necessary in these functi=
ons.
> >> All fuse_iomap_writeback_submit() call sites already ensure that wpc->=
wb_ctx
> >> contains a valid fuse_fill_wb_data.
> >
> > Hi Luis,
> >
> > Maybe I'm misunderstanding the purpose of WARN()s and when they should
> > be added, but I thought its main purpose is to guarantee that the
> > assumptions you're relying on are correct, even if that can be
> > logically deduced in the code. That's how I see it being used in other
> > parts of the fuse and non-fuse codebase. For instance, to take one
> > example, in the main fuse dev.c code, there's a WARN_ON in
> > fuse_request_queue_background() that the request has the FR_BACKGROUND
> > bit set. All call sites already ensure that the FR_BACKGROUND bit is
> > set when they send it as a background request. I don't feel strongly
> > about whether we decide to remove the WARN or not, but it would be
> > useful to know as a guiding principle when WARNs should be added vs
> > when they should not.
>
> I'm obviously not an authority on the subject, but those two WARN_ON
> caught my attention because if they were ever triggered, the kernel would
> crash anyway and the WARNs would be useless.
>
> For example, in fuse_iomap_writeback_range() you have:
>
>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>         struct fuse_writepage_args *wpa =3D data->wpa;
>
>         [...]
>
>         WARN_ON_ONCE(!data);
>
> In this case, if 'data' was NULL, you would see a BUG while initialising
> 'wpa' and the WARN wouldn't help.
>
> I'm not 100% sure these WARN_ON_ONCE() should be dropped.  But if there i=
s
> a small chance of that assertion to ever be true, then there's a need to
> fix the code and make it safer.  I.e. the 'wpa' initialisation should be
> done after the WARN_ON_ONCE() and that WARN_ON_ONCE() should be changed t=
o
> something like:
>
>         if (WARN_ON_ONCE(!data))
>                 return -EIO; /* or other errno */
>
> Does it make sense?

Yes, perhaps you missed my previous reply where I stated

"I agree, for the fuse_iomap_writeback_range() case, it would be more
useful if "wpa =3D data->wpa" was moved below that warn."

>
> As I said, I can send another patch to keep those WARNs and fix these
> error paths.  But again, after going through the call sites I believe it'=
s
> safe to assume that WARN_ON_ONCE() will never trigger.

I am fine with either keeping (w/ the writeback_range() one reordered)
or removing it, I don't feel strongly about it, but it seems
inconsistent to me that if we are removing it because going through
the call sites proves that it's logically safe, then doesn't that same
logic apply to the other cases of existing WARN_ONs in the codebase
where they are also logically safe if we go through the call sites?

Thanks,
Joanne
>
> Cheers,
> --
> Lu=C3=ADs
>
>
> > Thanks,
> > Joanne

