Return-Path: <linux-fsdevel+bounces-30888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C998F0F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52619B211B8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD219B5B5;
	Thu,  3 Oct 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HuzNaZ+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88B8C07
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964146; cv=none; b=Q78OvTeESjzI1UJpoC7PrF3xg4pqv1LJela17agjvKLkn6OUlExoQXpB4o9jnXYAOgZyoSC1wtPaBCY3/l5PS0VPgelWUU5gDIdpXpf9TgzNiGio04r0eQ0BTaJ07QJtKYS0fOduEc58zhLtzpJQgQznkbu2WHSSsOhRx/xyiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964146; c=relaxed/simple;
	bh=GGNEFwQtpO7uH9/V1N0/M+6tFdm2eOpZCU3ZMlg/AoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7WmdHwqDGK2LhO4qb3npDp0il60heBTd9DWnYRQtqzPjNrL2mOJjcVZfEMKMGl9IbFMJeWnH17THhjx+rxD3Zt69UkT2CyDviVDLnCGJWl/GDTcOPe4xW2qvHdI36gL0hmaMKPd02QfpokXiuhMximrDNs/dILqS4ij6IwZCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HuzNaZ+N; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90188ae58eso128965866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727964142; x=1728568942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGNEFwQtpO7uH9/V1N0/M+6tFdm2eOpZCU3ZMlg/AoI=;
        b=HuzNaZ+NnsImIK+mD7Wk7ctNFV7yoqtzjc3nXCZDiJanVXbnfByAxf4wMdCv8IUkQE
         Gh/5OoPJ+v2VUrG+Jje5fpuGrW7oEmhZDZvls1njI2rjHGkHFPUjyPpcJ0Q4WeI/NkTW
         U4A3R7BBWnAqy1cQ6OgGFlTLfO8Xd7eLvb6SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727964142; x=1728568942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGNEFwQtpO7uH9/V1N0/M+6tFdm2eOpZCU3ZMlg/AoI=;
        b=BmhVLJUiIC3RkZb2+4N0oAQBFbnS8MTwl1TqZsU884WA5Zxxiy4gmYKvtuYOPcSJx2
         QbIEMAUjQGE0OVsIsaG1ZLOBACP2xS6D+yUdY0pVjme0HaD4+IiUDvk2TnfIwk/+Vwrd
         nSIzVfj0YYmoJZ7XQ1s3ew4k+CokRZwbP905lXRxOqDRT5JTFL5dlnm3g3qWQzBJrq6c
         +NY9wVaJ+VeJm9/pOrMHNCNaqFWmXOhqIZSLQLYAu20gxGSYOn0ma+lG3HeMOnjUL9aZ
         tecmErMIDl+AWUnLWeojUt2W1O/+T2M9/JWgFmOK303F7zC6QcqOc3R1g7DKHLezMoxU
         ifRw==
X-Gm-Message-State: AOJu0YxYDT/cYHmjaOGI4w1VP0FNBjhmuBAg1CUvE8qzsRQ5Ibo4ToGA
	UCPKwoJp2MxrSNIUXRVr+khNN6CAd3MUDrkGt1zCvlGMQAv13yB7JZo/evxyxQ0r1dUlukNrPu2
	JRllJlO64olL8O8xCFdAqfKxby5h/qx4g5cv+7v4MsIe0Vzcg
X-Google-Smtp-Source: AGHT+IE+UXj7GhOIGGEYAwkInONvkMh6STHVU/3DmDtx5z86HCLVgY04r88GJd+fbrfAEfLGvrTzQYCbRS7qaZEfQlc=
X-Received: by 2002:a17:907:6093:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a98f8201512mr661615366b.11.1727964141672; Thu, 03 Oct 2024
 07:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
 <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm> <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
 <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm> <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
In-Reply-To: <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Oct 2024 16:02:09 +0200
Message-ID: <CAJfpegvK2+Q=L4hM5o0fZPuJc-zkCwZHj2EcLXFFEq__sPmXgQ@mail.gmail.com>
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 15:56, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> I'm inclined to do xarray, but still to assign an index (in the order of
> received FUSE_URING_REQ_FETCH per queue) - should still give O(1).

xarray index is unsigned long, while req->unique is u64, which on 32
bit doesn't fit.

Thanks,
Miklos

