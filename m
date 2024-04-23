Return-Path: <linux-fsdevel+bounces-17511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A78AE85B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEAEBB23158
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3E013667B;
	Tue, 23 Apr 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p5BBX9Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77109134CFE
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879508; cv=none; b=WnxKMiVV9YpCSNGvDze/87X1HqPo1sesjrc2k9LYBrN3bdcqwOEOXlWIu1iNMMTMgmqx/epEKIrmxH7CIaLPbk0CB9d9FOlKs6uuYGK2h4gvABhwO0e2NJFz0kD/cyisSZzQmJ0nN0InmHOhFoUsLqOAN9MGPojZxXbSlO5g1KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879508; c=relaxed/simple;
	bh=Z/9E+iyTOU+q2SYKjyBW/HJLpGvdBpRPqfl+z8X4G6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnKdg2lPfrcyodGlhbzHyhrm3Naj5Hxy0z3dvlHPzQvMqwasaUTuSeHmx+jjKkDgWK3H0NThV5IYcBwhvoQT4gXd5bBIiG1wbVCbG1jKtmBATPqM71DzQL6+ZfNK3qympBlrbvUQ8sE1qcOsjLYHrjuW/kfhoeJgGMt/V1D0VMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p5BBX9Yc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a557044f2ddso629341966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713879505; x=1714484305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nVSj1ZoJ8TVILLNIUx2VW6Hc3BNXLBeU0YsCujIwX4E=;
        b=p5BBX9YcF4ZaPsGgxUbyJvVIwT3qpkJmCsulZUNUaRx3lVyx8mRgPu3BQik7AOp/Ih
         KkrTRsYL1iWaFl0RsgPmdqDMe6Tl7UGrsqdgpQ/KSiXNlwjgALmKOj8AKW0hZQlW5flZ
         qEK3JMrO7IUH0EbbtQluSNc4fjpMYLlWQJlE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713879505; x=1714484305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVSj1ZoJ8TVILLNIUx2VW6Hc3BNXLBeU0YsCujIwX4E=;
        b=uv48NcZok3BisyuYjD5KckMelkt05wMrarTeDLFP6xUK4JSigQvi6r6HEPBRGx0XHO
         ub1MAzb7jSnxXp7uXzdIE/384pISaIMxQkqJBy7/tiovOCQMekTyMzOBLMmJiXq/3KZr
         hME36X3tXoXNpa6mIvFrOzsczGNRtRN/JD6UMP2tRFAHyv0OWiR5Bixa7JYBqZzzRyMI
         BgChOKMqhVqWEdF4VM9gyicmysZLehlLIn0Fq50cGbIRTSlGoTsyJlOl+ruDhFfH0A1O
         +RILgP290e1FyKSH9V0R4xdJMnPWcc6oxTjTXrWH5p1Yng0UMW7jWzzbUKEr1SYSHRat
         x3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUzjQRAfGsE/l6Xti/vbyzmchlh8hXXPfC7Y7RjwF65RHUZ3Cr4OSDOc/9EBKVejOalm+Rb9CuCleM89ruvCyhvaDVoZrqSai8uvJph7Q==
X-Gm-Message-State: AOJu0YztoJqxWoolzeKPrXBtclCAzgHLK/SRLex8fztspBfEkTrUSY5o
	8E05p4g9b5rMp0893nilhKFsUSA8LlYboLe1rFfDn0aZTMlWk6LmbRzSUrVlJBOZ5RGzvR93mKA
	6YK9b1NygpB7MYrOGnUj4JlSWqTzc+nfUBXt+aQ==
X-Google-Smtp-Source: AGHT+IF1yKuP1fnlV5lQEfuSFJCFJQEd637Lj1ny8OrjP+ueesVoHa9tR+3xQZQXKSmYfbWxdUb9D23G8A3+CXToi+s=
X-Received: by 2002:a17:907:3209:b0:a55:b2f4:908b with SMTP id
 xg9-20020a170907320900b00a55b2f4908bmr5774773ejb.18.1713879504785; Tue, 23
 Apr 2024 06:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de> <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
 <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de> <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
 <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de> <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
 <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de> <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
 <9f991dcc-8921-434c-90f2-30dd0e5ec5bc@spawn.link>
In-Reply-To: <9f991dcc-8921-434c-90f2-30dd0e5ec5bc@spawn.link>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Apr 2024 15:38:13 +0200
Message-ID: <CAJfpegsJ47o=KwvW6KQV5byo7OtmUys9jh-xtzhvR6u8RAD=aA@mail.gmail.com>
Subject: Re: EBADF returned from close() by FUSE
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 15:24, Antonio SJ Musumeci <trapexit@spawn.link> wrote:

>  From the write(2) manpage (at least on Ubuntu):
>
> "Other errors may occur, depending on the object connected to fd."
>
> My argument has been that this note is defacto true generally.

Yes.

>
> The specifics of this thread stem from close() returning EBADF to the
> client app while talking to a FUSE server after the open() succeeded
> and, from the point of view of the client app, returned a valid file
> descriptor. Sounds like a bug in the FUSE server rather than something
> FUSE itself needs to worry about.

Return value from close is ignored in 99% of cases.  It is quite hard
to imagine this making real difference to an application. The basic
philosophy of the linux kernel is pragmatism: if it matters in a real
world use case, then we care, otherwise we don't.   I don't think a
server returning EBADF matters in real life, but if it is, then we do
need to take care of it.

> This is not unlike a recent complaint that when link() is not
> implemented libfuse returns ENOSYS rather than EPERM. As I pointed out
> in that situation EPERM is not universally defined as meaning "not
> implemented by filesystem" like used in Linux. Doesn't mean it isn't
> used (I didn't check) but it isn't defined as such in docs.

ENOSYS is a good example where fuse does need to filter out errors,
since applications do interpret ENOSYS  as "kernel doesn't implement
this syscall" and fuse actually uses ENOSYS for a different purpose.

Thanks,
Miklos

