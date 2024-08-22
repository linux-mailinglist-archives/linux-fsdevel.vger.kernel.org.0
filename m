Return-Path: <linux-fsdevel+bounces-26686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415D895B06D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2051286344
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA7170A10;
	Thu, 22 Aug 2024 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d6UcsoVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB87364A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315493; cv=none; b=q4ydkXsBpyA7tGUa4hl8awWkqQpE/Hi744u4+16bYtgG/Ga8OKi0EXH4Ok7hXNK73OHEb8go1OxRjbuiSBtQjkpbAAJSQCgGvqUU4e8+Hoo5FL0jjApSYbbKq0MQFXZhedC7k15wEXdGUt/514OstsisVYtYc0rYDlrarFoDtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315493; c=relaxed/simple;
	bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSQFC2YJOmZM2iMk+2Sd2urdK37Zbt+HUMIfBULnTcaEVFtY4EwF30clKnoz1SCKVe4J3bAF1P3fJaMsiHvMcJScLCBGXlKehuakZlvCr/gG1iHxPNSCROFeyopd6SB1iFyxq5p+N0fxN8hDRyII1ncj0CWtfoZA3FSjYnL8ryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d6UcsoVa; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so631680276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724315490; x=1724920290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
        b=d6UcsoVagWmOg4gMtyyrnX4ashxi+QonesqW/lWQrZQaJ3U/jyzdz1puaNu0MvuPao
         AyPTazPWZRwDP+l2FDG/+7q9R1SOHQRb2cwfvKTvBjKOM6QpK96ZK3Ac6UDuBNc8lPMo
         AM66VnB3EjJu02kpOv5CHM0TZ594YJAD8O/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315490; x=1724920290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfO68ABr8YmkVT3Xwko9ThKTkCQPRAKkOQzFlC/guPA=;
        b=L5NN7f2ZpNc3w2D1iCqgv8kKEQ6DYISrGaz68/1Jc2n9p7b+VfYVQPAOVuOgV/HRu1
         ayBiUrVE8+WViy0K5jaUOD2Usncm9Zgk57ERsZVD4+AuZZH21Ac2Wg6Nt1OV/UYJhTGm
         TtzFm8Y+w+54uop/vjLNQyPWbQP3cEqPMgCEwehjMTHQAAQfKlcPy1m5cpSOo4NW1Zbd
         o8pUdpmQaUD27yKCqc774Z27Kq7MZsZXuxq/bDJuHIlvX4YqGWnaDiRYKijNUauqmliC
         q9srBrR24dw1A4Kf1SDXx6dQvegUmUor3y1cMzZgCuNWLWkD4LHfdtKu61XQZ4Ntz23r
         MYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqV6vcDpXwdqLQttmIwXoCbOvQU2QNHSgVd9biLz/W00eJwINuzFqV9dK8m/+qQ1/TwEi/4Ky/f7Z1yhQv@vger.kernel.org
X-Gm-Message-State: AOJu0YwoC7jsRtoe782Q0M3ZDLK0tfSysmLs+zB64RXWci8fxxj1rrvO
	CCdhu5VsFevRtlTNRfYGSLmW2fns1ZRKUTR9GA7y1QYDkHn0XRe7UGcWAl4nhZqgtHQQOuSguIH
	bX8uJ61Lzz+ADqLb6bwr98dIxNd79vbr5IyIa3w==
X-Google-Smtp-Source: AGHT+IFF9x0kcV4O4K6ZspVN57UUPh5M6n3DoRW/LKTTDP4y3eH/KtTeC1NTvVIbWLwiW99ntfIxagBPmHeZAstrCBQ=
X-Received: by 2002:a05:6902:250f:b0:e13:c8e7:5bd4 with SMTP id
 3f1490d57ef6-e166640f1famr6031982276.22.1724315490296; Thu, 22 Aug 2024
 01:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-8-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-8-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:31:18 +0200
Message-ID: <CAJfpegs5+2DadbB6tfwLD+DAFzqfOTi7bZMxJCoj_r5Tu7jcfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] fs/backing-file: Convert to cred_guard()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Replace the override_creds_light()/revert_creds_light() pairs of
> operations to cred_guard().

I'd note here, that in some cases the revert will happen later than
previously, but (hopefully) you have verified that in these cases it
won't make a difference.

Thanks,
Miklos

