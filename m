Return-Path: <linux-fsdevel+bounces-26845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE71295C0F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 00:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B08028462D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 22:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C31CF2A9;
	Thu, 22 Aug 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrDjj6yI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2A1D0DE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366325; cv=none; b=CsH8lWHve81wTPqnKdVf09jyxVtHdhq3L6QOR0wxM6L/T9BlfQbsZoCQkiA+zbOaKfrsirvIloOA7urRxi0LYoo+BGVn5bDVALMCiF1vkHPWBzrF8lAOrh1FYf4cmjI41iCcFX9WWG61AIt6M/2u/LMgJ6CnCu3lqqrbYm9zNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366325; c=relaxed/simple;
	bh=8gZiwCeYXDpO+4AWF0jKgMq1FPZSdcpEzN5GdO/YuyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCJlSGJ4fsp5BOHGOBOGPWKQ6rI75O+8dKaSzJbztZ9ybI31WBPGTWPJP2MIYX0iqK8eN/0x120T6y7+ISKnnsCZIZJM1y/rkUyCkjul2C4ah77WERLc3FGfb57r/E1B10aKwPuA6pJb1rVY7Ba1riC546BUj7lIcvZw9J8xRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrDjj6yI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe9cf83c7so7572561cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724366323; x=1724971123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gZiwCeYXDpO+4AWF0jKgMq1FPZSdcpEzN5GdO/YuyA=;
        b=VrDjj6yIzXdc5o+OZC/D9vY9QD+YcMKYstm6XadFuX0gDdXGpnnDq/Fz7b/hjR45Tl
         soMTbOND+lduuG3++UamlZxGMMYv1dJXBW3sYreoxmRWLj9XmkhalBedM0rjXcsSYhPs
         fXjMda5AqafembO3IVOSsAzMf7c3sR5ludlZlEIXtgl00R1nIUPEjT7AbHyJh7SxcNP6
         8s286vnZb4KPp84pYZaFrZboTiFwiWjcubW7NCVEFG1heiiEMJ81M3UUsqPJ3a/GHLx4
         PUWgPjSN8MLJW+4F7JII5B1wSdh059ZF09hOtr0s8NW+YlTAO8sB5phAPBA4Cds4/U3l
         dlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366323; x=1724971123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gZiwCeYXDpO+4AWF0jKgMq1FPZSdcpEzN5GdO/YuyA=;
        b=kiSjAXmpk+WVHZwk79dwO0OtdJiB57p3elQ+m23V1//oEeSTzbUhEXM4m0j9/xazXg
         OxAVd3KxtaQCNOQtF5srzkvLIzC/hPfaE8PO+8r3wKqweFO4WvW/aDX6q3MQ9jf7HxBV
         Lx9H4eNGXaHN3QhM7G+MVU+66vw09IU2VDliwvqm2LMGpZKsJniPxrMusXWvofQmJSLU
         EruClFTc2CV/m8Iu1zw1zhvsuxgsQYLWKQ+j4fsl+cMwtuCisoQRD6VQVaqwfatEcHN+
         PZu8nAfB0e4tonoQgrEbNgSncTfniaa9vFZlmzed3obqjRAwlr11cLwsa8CjpKoCogk0
         UVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzocnSw82pxsLUT/9StM5MzX6grOpHvGmADd7hx0UNVJuyl13hUJSeR88S6iaEZqSJwUK8xPpNaSQvKBei@vger.kernel.org
X-Gm-Message-State: AOJu0YztJg4d9VQdNyr3rMDchN4xUFjyh5lrE/bgvg4XV9TW62GDLHej
	F2mX0df6anAiFRqpPFAfU8iw0O1AzUwU2pRLzgiV168wsLltxYMTILJc8N07nC1XPm1D2mBMAZ9
	Cj0LMZb1takxYZpGx6sqnfwO9RyY=
X-Google-Smtp-Source: AGHT+IGiM1fY0Ww2Rif/G+Zb67V+ALJN9MCFFajovMzeNUVJnB8vXDAbk2Uw41zKolkkKeKvPYWVJepF0U3Lgc9y9W8=
X-Received: by 2002:ac8:690e:0:b0:453:5d58:bb65 with SMTP id
 d75a77b69052e-45509be25afmr6070531cf.3.1724366322978; Thu, 22 Aug 2024
 15:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
 <20240821181130.GG1998418@perftesting> <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
 <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com>
 <CAJfpegsPvb6KLcpp8wuP96gFhV3cH4a4DfRp1ZztpeGwugz=UQ@mail.gmail.com>
 <CAJnrk1b5_7ZAN8wiA_H5YgBb0j=hN4Mdzjcc1_t0L_Pj9BYGGA@mail.gmail.com> <CAJfpegtFRy=cKQdQGuqcwh3+4MM2u-_c-Gc04U06a8LJQfiG2Q@mail.gmail.com>
In-Reply-To: <CAJfpegtFRy=cKQdQGuqcwh3+4MM2u-_c-Gc04U06a8LJQfiG2Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 22 Aug 2024 15:38:32 -0700
Message-ID: <CAJnrk1YGXVqngH_i79t9EieGxkEX3F0+6LJ0u6jQduJkMR7CJg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:43=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Thu, 22 Aug 2024 at 19:31, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > For cases like these though, isn't the server already responsible for
> > handling errors properly to avoid potential corruption if their reply
> > to the request fails? In your example above, it seems like the server
> > would already need to have the error handling in place to roll back
> > the file creation if their fuse_reply_create() call returned an error
> > (eg -EIO if copying out args in the kernel had an issue).
>
> No, the server does not need to implement rollback, and does not in
> fact need to check for the return value of the fuse_reply_create()
> call unless it wants to mess with interrupts (not enabled by default).
> See libfuse/lib/fuse.c where most of the fuse_replu_XXX() calls just
> ignore the return value.

Ok, I see.

For v5, I will update this to abort the connection altogether if a
request times out.

Thanks,
Joanne
>
> Thanks,
> Miklos

