Return-Path: <linux-fsdevel+bounces-60311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C6B449E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94A7A41EAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5672F1FCF;
	Thu,  4 Sep 2025 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co8ImQPx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C22EC559;
	Thu,  4 Sep 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025965; cv=none; b=cvaGvSQ+YscxH9bYCjX7pNb6wk6oi3IuzTa0PoojJ6bR3HMYWCEOxgvLoN9xwnQYZn6XmWXSLyuBcm5pPHrGOU/OFSPICV9JlDXqwTbwCB09TlgecrgzO4kTNtJVlyHx5HnW3Yx7CZP42vpVywUdi9d5qB1EvmpAqoog0GmXLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025965; c=relaxed/simple;
	bh=in0274ZF9EuWgAsOFccofLftoZtaFxJxkupX9B0YFYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNUihd9tMMpNUyzlx74mZluBdf5mI9/HykkUvL26n6NSmCq8r9eBiV2u/P4c2nW0JAleS73eSfWaC/Ki6mppqhLLEW0BSRPMLDAhVNvkFjvbkMED3JqWKMBCDzaUiZdHS9aIDeWqpGgkREpuizlwojNz3zEHfcnA1QeKb3882Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co8ImQPx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b5e88d9994so3036611cf.1;
        Thu, 04 Sep 2025 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757025963; x=1757630763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAxgReAvRTigM8br7yD1N24A1BWyPFw56Yun9lzGB/Q=;
        b=co8ImQPxoYS9YgVioy4okSqG8yoyNYx+CGao3HH1K0v0r7Ui396P21/bAm1dErluaO
         8PMtfLgXC2IJ/HQn5bYbf5fyWt/Fy1OVzmvQzrTg/4/E2kopTh39YuY3uoAk47ZTaCBi
         rzgqgecNsp/vkMPfyZzEQHIK9ALlTX24A3usURACyVNLq4iWn7uw1wfhaBfyELs/ZKXs
         Q5o8JhQoFIAhHQ9x759uP0lo3HTlmwxqNCUqTUFOHNd02W+y2IaPhDMvs6kCyW/rcEGG
         WjDXw+wtkR7CqCfPrWG8lBhJ8sW0FgYeegtnLxQcWId+hkN42mgFUDKETJZmoTnwak+j
         N3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025963; x=1757630763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAxgReAvRTigM8br7yD1N24A1BWyPFw56Yun9lzGB/Q=;
        b=qaT5W5Y30Tf1YwHDxh7Yj6PBvz2CjK4jsPuwOTtKIlcnt4WOstP/JgBL8KJZdz5zB/
         YgYZk+VZIzBEFxjuo9+1yD8fPGf0qMQ41HGN/SPplxK6R3eL3HRX6+CcjIFyl4SE4E7P
         kydH2rJIPlLzuPAYnjXBfvg4f9qX4pomp51YMzDi/qdz3z0oVaTRHeUYt182jnGnXc+4
         iz+UDEK7P4su4ZALch/14tmbWgsJkZK65gVHg7ohUc49oG7iX/CWVUFSkgES1wn91pIi
         qmFHK2gjmdobPkbHvJvbsnLR09HtWVjq7NiSxkFNnABhcu2cM40dXuYEBFQLNhUxshDu
         3KqA==
X-Forwarded-Encrypted: i=1; AJvYcCUGhR/8kaiqxHmd/LF+mGMe6cZZ9wZTRCcnJnFYl0+oLIDTPVUTOVJ//boDJ/LyB/+CHzCJNeGufjkc@vger.kernel.org, AJvYcCWGXq7Pb40X9pWLlGb4lKkwEUKuD6MZak1kh/LP/BGMepFoDjxX0I2TDpnFXJyYXoKodIurWUo8YEw=@vger.kernel.org, AJvYcCWu5Hiqxk/Bs6h0zWHWyyV7Q2YCRGT/5cpGTF4wbcYzCstfdJa2MnhGDlYx+PUr6v6haBj2kVGaThF8Yw5YVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzopU/fKIWJIqN3diNbMgqLg7PPuUInYLPCvDaeutyjpQP6MCgZ
	B/TrI02ijhYOSj74in1kCr8W5mXiMWAEnB7/C+5ByKOYkWgMJYSSSURZqwFRSrN1dIt9g2xqnG3
	+RH9LVMZs0KKoSgSOcTmcBM2k1QG1Iuw=
X-Gm-Gg: ASbGncuqfRXxtZh2GYxh7ZysnCoFUdJpkZI7c33u9Mv+KHHl1HTIK2fHty/Z8AO2+nU
	HyTd25N3FQrr/uAWF0Y0CWYim3ojyZBzXdunTzwetcrJXYUCDKSLETtEQhkYr+uvozaNPuKPWPW
	l5+FhWDingRY5KkWiRnvzVSsTRyW1At/ev4Z1u1+ah1i1ZEvAgqMtG9rYqfkucWcOiNT00s0set
	tW0rlq7
X-Google-Smtp-Source: AGHT+IGWjYXKWhDF19O+lp4CvUGr3EG7JmC6nzjpbq4xLDA7vyj48IcGMtxXrvoDHrKE0FcuNzA2vtctZNgL7QE8t8w=
X-Received: by 2002:a05:622a:5443:b0:4b5:8c8:11a2 with SMTP id
 d75a77b69052e-4b508c814a2mr64733971cf.39.1757025962440; Thu, 04 Sep 2025
 15:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-8-joannelkoong@gmail.com> <aLkuRRwdRkqYXAW5@infradead.org>
In-Reply-To: <aLkuRRwdRkqYXAW5@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 15:45:51 -0700
X-Gm-Features: Ac12FXx9ZU-jMY3EH2RX4PekWH8E4rBzlUPhSNNorJguDSlBCEQrwx1mmp_g610
Message-ID: <CAJnrk1a1FvFj+r0VATc0VpR-p4CXmftxYnNOj=APeAAmO9yuuA@mail.gmail.com>
Subject: Re: [PATCH v1 07/16] iomap: iterate through entire folio in iomap_readpage_iter()
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:14=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Aug 29, 2025 at 04:56:18PM -0700, Joanne Koong wrote:
> > Iterate through the entire folio in iomap_readpage_iter() in one go
> > instead of in pieces.
>
> Pieces I think here referes to the ranges returned by
> iomap_adjust_read_range?  I.e. "iterate over all non-update ranges
> in a single call to iomap_readpage_iter instead of leaving the
> partial folio iteration to the caller"?

I like your wording a lot better, I'll use this instead. Thanks.

>
> > This will be needed for supporting user-provided
> > async read folio callbacks (not yet added).
>
> Can you explain why it needs that in a bit more detail here?

I'll add more detail to this in the commit message in v2.

This is needed because a "bias" needs to be added before we issue any
async requests for the folio (and then correspondingly removed when
all async requests have been issued). iomap writeback does the same
thing. This is to prevent prematurely (and wrongly) ending the read on
the folio if the first async request is completed before the next ones
are issued (eg, when the first async request completes and calls
iomap_finish_folio_read(), "ifs->read_bytes_pending -=3D len" would be 0
which will call folio_end_read()).

>
> > +             /*
> > +              * We should never in practice hit this case since
> > +              * the iter length matches the readahead length.
> > +              */
> > +             WARN_ON(!ctx->cur_folio);
> > +             ctx->folio_unlocked =3D false;
>
> That should be a WARN_ON_ONCE.  And probably return an error?

Good idea, i will make this change for v2.


Thanks,
Joanne
>

