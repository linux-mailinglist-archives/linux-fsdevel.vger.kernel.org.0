Return-Path: <linux-fsdevel+bounces-68271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C955C57C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF9263486A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85C208994;
	Thu, 13 Nov 2025 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ygibk4j7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D0913AA2D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041159; cv=none; b=WaREMBTBLBjZwcCD3bugmybCb9d47ZZgoJvbraP0EPTeR9OI+D72pjSYcPvnbq34ctQTDBWoZqUJ9ys9wP0qx8ZH30KiKmq1Fm3WxH54KtXZN/MkScxbc1fT3Y/xPLQdBUnke5LPQGR4prvnFUKxl7iLUsPQFMkKq2adxXf17wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041159; c=relaxed/simple;
	bh=n+QF1qMZIlbo5ZUwr6r26QvTuSxfrrDlWY7CjW4I6tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4sAqurmpgY56W+H4I3tm6AOBpuvQI72Ts9ycsM76sOBQ5a4GmVJ43yGa9co9OSSR6rTywgKASDRUaBSRJXQebrmwC9CZE6wNwJ0Dc26jJtfa2x6nuVsELHAH0yhP/N+MpdjrmlWnlZNuFbZNUVjzp57dXOXE7styuA7pWg+W7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Ygibk4j7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88054872394so10217426d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 05:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763041157; x=1763645957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+QF1qMZIlbo5ZUwr6r26QvTuSxfrrDlWY7CjW4I6tQ=;
        b=Ygibk4j7kiikVZKymYDEIbD8DfuA4mEdds2q3u/MlcxtubGnI4e1HeCLRM02NhGJvB
         RcoavAyxu2PVMkJgWH1w0rowKZ7bOpYX5G8TDCyEm0cypfXhOFYd9pGoLmePYAc0LcRS
         Yvb59dtWbW42BO2MuZZQWE+LMjnCHQ2NFjSc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041157; x=1763645957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n+QF1qMZIlbo5ZUwr6r26QvTuSxfrrDlWY7CjW4I6tQ=;
        b=UOvxrUfUjZ8VNzp4ZyTy5OkXuZ6ef4HB8eU7hMIYsuRs9rWJM/LKuKKAj9EvHlxlrP
         sbM4j3WqhequHiplP8CJt9qp/K1ucFWNSwQcq4J8StuRFRVBu9bLoUZlo0FcjPL+lU66
         /AF/Y5Xv4cQ31eXFlu9b2I6PEiM7FygYVi7FlYuWPyOOQfpdALryDmu4rI9W2zfObPtT
         9CScNCH+TfSVMDwujIw6OjZQP9wIwErEaiWcoIkIAPiZT/+GxxgdpESjwpKZh94dxr3M
         kBEO/OScSZ0huMBmbGX2vd9+9oVOvHoItczR13QKzaFhrSbpdbQ73U8fXvGFBQUJFqW0
         7qWw==
X-Forwarded-Encrypted: i=1; AJvYcCWAUiLfqzVnGaYxYWb5rAvQ570OEbIVTA4pKn2lgHEseWEl0b2GZETna6C4pdEEs4gAjnBM82VdO2O/d7GU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/69SLxH3YGBOTBKtSmyFl2DAUnaJnjyZ0iIFzgW6HHbAopH/
	N/AFnjPkaz6PwaQ7PMDicBbOeNW5fnbyOjyRxCGKZwVWSwyDpiImsjaYSTkNZDoLmKzK/ooUl1Z
	dLdl8DwpPQgFDmoPMrNIgGiOSVhr3xBNp80+4BpBNrg==
X-Gm-Gg: ASbGncvKsiV2LfeWCmuwxQu1aSKXf20OWzc+IlEZn/7XgDPfx4O6jdUuTPWx8qNQV9d
	ATxplQZQVBxOI8+HS54MgwisYcwzyVTQzDwUqyDVhgSk9Pxi+eyE+J4OohasL93GPtIpaYmwnVp
	AiScmAjdIPrI/LAsr43OShR96jUp7tnUo1j77x193p8isNnWBdtbu/VoSmbaj13jz1tcV3SldSP
	KOUXKxEzfMrhD4cd8QiyPf50zYHWUfE3Le15HAjeZmjr8ix4jqgcDTjNVCz
X-Google-Smtp-Source: AGHT+IHG/LjC5S6TUtVX2CjbTvKRR98/1uXdm+r/2VxpDUSQrHGKdDwqjSV7QDKMdXQv9/C0Z0Lu0JYBQsKbBpDpqVE=
X-Received: by 2002:ad4:5746:0:b0:87c:152c:7b25 with SMTP id
 6a1803df08f44-882718e510cmr100650186d6.13.1763041157194; Thu, 13 Nov 2025
 05:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
 <20251113-work-ovl-cred-guard-v1-3-fa9887f17061@kernel.org>
 <CAJfpegt9LQe_L=Ki0x6G+OMuNhzof3i4KAcGWGrDNDq3tBfMtA@mail.gmail.com> <CAOQ4uxjnmLiLzM-a1acqPpGrFYkLkdrnpuqowD=ggQ=m72zbdg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjnmLiLzM-a1acqPpGrFYkLkdrnpuqowD=ggQ=m72zbdg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 14:39:05 +0100
X-Gm-Features: AWmQ_bmN0A-u3kmz-W_mEDRKhkg9WaqBxy_G-fMwYX89VUGf-XiGKVMq_OqfcWs
Message-ID: <CAJfpegvr9HJ43zvAUgA-Q+3sYaH3wpz8NdmW5ESHxk=Y8gqUNw@mail.gmail.com>
Subject: Re: [PATCH RFC 03/42] ovl: port ovl_create_or_link() to cred guard
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Nov 2025 at 14:34, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Nov 13, 2025 at 2:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Thu, 13 Nov 2025 at 14:02, Christian Brauner <brauner@kernel.org> wr=
ote:
> > >
> > > Use the scoped ovl cred guard.
> >
> > Would it make sense to re-post the series with --ignore-space-change?
> >
> > Otherwise it's basically impossible for a human to review patches
> > which mostly consist of indentation change.
>
> Or just post a branch where a human reviewer can review changes with
> --ignore-space-change?

And I can easily create that branch myself with b4 shazam, but then
the review is disassociated with the mail stream which is a pain.

Thanks,
Miklos

