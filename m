Return-Path: <linux-fsdevel+bounces-57504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B5B225A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 13:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D361B64125
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925932ECE90;
	Tue, 12 Aug 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qgzVRuaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A92EAD15
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754997252; cv=none; b=Tat+BnMGn6BOEIMHDHKLrUds0vPxQwU2eQ+6ffJKtAo8eXK8T8c0eSsdDcv+j9DetC2qbWD/HRG/CCvV3K+diUuGjsfTZUQnacKgyMYKl7fkvDzYyXTR72GGEBOw6cV/8P3eB6FfCqISPU2VXvje4I1XzAIuN4Zf0Btl5J4w5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754997252; c=relaxed/simple;
	bh=r+j4yIaNHRIg2FsLqu4uPP3CnoIPww8WNh0povehQEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugp5dTWIm71G8LC3e7hjXLyQzsxaTxz+dEyLRpBFaHHFCO9j/kZhe+LtoEtfgssMIwqddTwEFhGvO+78Tc/CrMs1XifqU2A9D+kFebajB/WxflokA+YsgWRHkK5l/SDTE+1tu7GoXYzMf1gKMRgKMBtRXE+4vDOoMywAo9zo1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qgzVRuaH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0db8ce2ceso29357721cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 04:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754997248; x=1755602048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+j4yIaNHRIg2FsLqu4uPP3CnoIPww8WNh0povehQEw=;
        b=qgzVRuaHkK0/BIdMlom9u/3QXHjPQAPsVlgLxIU1WW346VgRrhdd23za9Ff86dbqZ6
         7WZ17667qMnsKaIQugrCUFGWjM7PbCgYNLXnhhvuxq2uMv0mx6xluZY6mRGWAGngQUWf
         ctXLSpTLeJPBaiYzKt3UZVcoFkhGZttmgrHQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997248; x=1755602048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+j4yIaNHRIg2FsLqu4uPP3CnoIPww8WNh0povehQEw=;
        b=quy6SQiNz5XSIREazujF/NHGloNnnf+EDyQsqIjo1PBifxfU+vV23Jr1JCMY5saiCF
         nzKZMdK4PQT583YpXqqUow30+SH24ZyU9gr60LWxYmb9l5lGW6ErKqDrsn/7Ar9G2SOe
         x44y0ZKCtYDp/wLgaHuy+EQ+2mCmlEFCMMkG3zMO2v5sWVrZHaIDZ/Vx1vBXDBsiESGC
         XGrtadzMyB4eNKTTxd2wpBoMZv/+dUnzp7p0qSMdsiH9T3kieCHdXZQ+aHFFyPxwjYo/
         4cWFQUy7fAbfoGUjgNzBguXBhfVFitSM5rv+Zg8Mm6EGnhIyo2kHyjGYgXmz0h15raDA
         Ks+w==
X-Gm-Message-State: AOJu0Yze4uzPOy+sYSNsaIKCRqHzJNz0W84ioz2LKEpXinpzZLo7catx
	dzrPR5t6ZdeJcl3X57Jrm5aITua4mOB2630IVWX69pj9E0uJhvFpSoZ8J1V0XJOMj8uYQeXEc24
	I0N/qeo6vTidmBDUJS2VnWw+FVUCYgZgHhtHZV/I4hw==
X-Gm-Gg: ASbGncve6BfbgewewHj3R86kvATAy9X/Be5GEe8+5VgueZCR8uxm+HQ4w5vzRG5Vpfo
	ahq3aBE3f0i87SgbfkA4s31b6QZWKTjOkEhbaHsNhBnidjwFJGnD0tT5jda9xCCOJAdc4WWJKp3
	aoQ7GaOUaKjG2z/xZVAJAIbngF8RwqFApSb+dn6Y2KcHAX6aWDHwf1PSmYmh8bVLD+ebGDcrd6x
	TRS
X-Google-Smtp-Source: AGHT+IHQYhSqmfdE0xzXHnDoCKg4YvLClz6yM+KFUmIF9eCorxMjYYGKJklIoGPTtD08uW6+sNSOrLlPQu1VIRls/+M=
X-Received: by 2002:a05:622a:58c7:b0:4ab:6154:d2a3 with SMTP id
 d75a77b69052e-4b0eccb8c6emr31141741cf.52.1754997248429; Tue, 12 Aug 2025
 04:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811204008.3269665-1-joannelkoong@gmail.com> <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Aug 2025 13:13:57 +0200
X-Gm-Features: Ac12FXxr26kpmMnlrjUv1Qw9y98AxmWMjQlwwGwK7BtYvoI-hNmfKyNz_qeMWdA
Message-ID: <CAJfpegs_BH6GFdKuAFbtt2Z6c0SGEVnQnqMX0or9Ps1cO3j+LA@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	bernd.schubert@fastmail.fm, willy@infradead.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Aug 2025 at 23:13, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Mon, Aug 11, 2025 at 1:43=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Large folios are only enabled if the writeback cache isn't on.
> > (Strictlimiting needs to be turned off if the writeback cache is used i=
n
> > conjunction with large folios, else this tanks performance.)

Is there an explanation somewhere about the writeback cache vs.
strictlimit issue?

Thanks,
Miklos

