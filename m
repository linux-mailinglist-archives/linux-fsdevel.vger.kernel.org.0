Return-Path: <linux-fsdevel+bounces-60657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE16B4AAAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB37164B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563D831B833;
	Tue,  9 Sep 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kTq6PXB9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340A31B132
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413805; cv=none; b=sl9egZeZv8gmyS+YFJ/Ror4/bxtAIqq/PUNgaxR2Nn420YtmctJxlQZkgqSPdTlDT41UjMSXVCMvSx7ygobf9ZQdp89412kzL2lv1nk75QMgEKU0vOS9Fc44D5IcSpXJSBLOzdxoHTIeoQxgifJ7UcTcpBKaxBKCsJaN/GkYvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413805; c=relaxed/simple;
	bh=GX3maST+9EDwNZo+fAmccb7LBCF1ybVhr+6m1O6o7QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOAj981nua/eCbp5WMdMcvoMMV8YaL4lgY+hpCPp1FBpPqBt2gPp6ybvT5VQtbU/V36y4TSndWwJT8K18A5yT+z2tiuoQjtoiqes7zxXHpAqhOg5NBjrsUwjY/I13TVoXOz5W2u5v93M8kEK+Frgd1aVF7Oog8qlqNrqPUBgX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kTq6PXB9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5df4043d5so56732681cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757413803; x=1758018603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GX3maST+9EDwNZo+fAmccb7LBCF1ybVhr+6m1O6o7QI=;
        b=kTq6PXB9Kbw6lx9s0nepHZ3OqALbL0R1wj0u73OcGDibcXcvdgKYQCGn2wWiBx6FHR
         goxdDfjqwFsu8sVUim8SMixPHnsnOfXsxvtC14XAIVhVXf3YJ0TjCFK4Cacevpjn712Q
         KzI7ieIu4IHeR2ivFt9GIwx1V2pa1TyAs5Esk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413803; x=1758018603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GX3maST+9EDwNZo+fAmccb7LBCF1ybVhr+6m1O6o7QI=;
        b=rlRiY/A/Jzs7aOGBF/6JVaTEmxkIrSByLkWKQa6870Ebro9FzFqvvXl5FXj/SBJJ9M
         8U+8CLokA+bROZB7CmjptafSHnqzrLIaqTisWuba4QC7JgSKPS1TLp6V9JgDD626xqgl
         CssHYLDhce+yHjMD2FIG4jtWbevlRu+uKeWzLo4krGqjUbyfNDjV/WeeKboy8z2MRQVa
         Iq6sAkMUUsP0MR2tmHeMcyzDDWCePuPCLiJgcgpYCXQ1C5UikDl/XJdP9boOJ6bNQZph
         qDxxU5IyWacJkMnY+qnLYj+Ao7YRb/92DitCvJdf2h9fpWhXAq3w4NJcx7heQLixK+Er
         Mlfw==
X-Forwarded-Encrypted: i=1; AJvYcCVTAYD0dEMvLdm/u/pcvWcxOGHjXqSM6BLEkJkwC4NJJMdk01GJ9iHh6oQHy9m/SjNPikvTwFgUR65l76eV@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrGGLTMagH2licG4hxOW8IOXaYhBvE5/4nCq2nOSqWh1LFKAG
	cwlJSFOXMnS6Y7+ulSU2w6I938jWtzKaSUek3NzjgrsfcbL/F1LvKcFVqF5C7+ugBiCH56XsJ9w
	0Pea0oJ6zqWQKxXZsXMZmMuTDOx8dJIRUGT5SfQMLJA==
X-Gm-Gg: ASbGnctdalV3POhSI0hDbm9iHIZ/AZx9IgB6uFjHywl0XmMdVBsMDYrqMpDdYCn3SzA
	AbU6k8gvUu8ZIFzrGIoDN7HK7v32WWIvhwagord7Tv6/l12lA0tJVfT2lNBenijbYXzU3sOkAK/
	s0E8Gu6Uhz3ro0/6OcA6KYGovm+nOnffUX+YMNWcjtQdKjLZC8sf2W3pdYr70TQZXPcjFR/pY24
	0YF8Jo0G/Aqlbrf1v/6TU4J3m388cfGztrgWxrXUw==
X-Google-Smtp-Source: AGHT+IGP/jfrK9kbKxT07DtCCCsJM6+DPrCYE3z/CSZX+dN+v4UVqeHSZONhN69V37VX83LrCI9NukLA19mUazY0fGI=
X-Received: by 2002:ac8:58c1:0:b0:4b0:61bf:c2b with SMTP id
 d75a77b69052e-4b5f843a12amr132964341cf.42.1757413802683; Tue, 09 Sep 2025
 03:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4a599306-5ef1-4531-b733-4984d09b97a1@ddn.com> <CAJfpegs2YGe=C_xEoMEQOfJcLU3qVz-2A=1Pr0v=gA=TXrzQAg@mail.gmail.com>
 <c6417bf9-77c6-4dc7-a5bd-9b2aad5822d4@ddn.com>
In-Reply-To: <c6417bf9-77c6-4dc7-a5bd-9b2aad5822d4@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 9 Sep 2025 12:29:51 +0200
X-Gm-Features: Ac12FXyOS-tBn9_UhpBkcBsEsHI3pCbs-fkwF5wYcMgIpGMC7aZbkqEWVMaHy00
Message-ID: <CAJfpegu0E_FUJBnaUhSKB36XtEWLNYd31dpfFh3T122aX8xA3w@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Bernd Schubert <bschubert@ddn.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org, mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 12:25, Bernd Schubert <bschubert@ddn.com> wrote:
> On 9/9/25 12:14, Miklos Szeredi wrote:

> > Instead of introducing yet another list, we could do the same
> > iterate/free on the ent_in_userspace list?
>
> Yeah, would be possible, but probably hard to understand for someone
> reading the code? At a minimum it would need a good comment.

I'd prefer a good comment to additional complexity.

Thanks,
Miklos

