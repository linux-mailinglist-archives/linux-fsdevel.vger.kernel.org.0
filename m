Return-Path: <linux-fsdevel+bounces-56792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A3B1BAC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3D6163941
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89029A307;
	Tue,  5 Aug 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="J0gmJ4B9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57B2522B4
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Aug 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754421143; cv=none; b=WDuZybr/A1dkArE0o+f5JO1rk6iYDhlwBfB3waVrOgcQ550lnlPNpcfQJCEQsO5x4hlZs4FZaT60E2gmO9hC5EiA+8F2B00qQl6xVXKqwtFfuVBWRjP+3PFSbJaZEfPtBnWuIcU3BFLETgzy62k5T9oLNpMHQPikTBtPpr+ggsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754421143; c=relaxed/simple;
	bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS/hdLj7O61/V6C5CEKQ7LlXfGDjOKogCD2qZQSu1UMlekiehbqv/85ZUohN+7oL1/fDNIH95xgnD/S78txfABzrdZV/wS42by1nKkqxSRm2+vjlwH3fpRX+PxUOXqkYrpv6/EHVK4G+gHFjAUtyI1DrMGEsf62GR9k8MhJimiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=J0gmJ4B9; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0862d2deaso9051851cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Aug 2025 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754421141; x=1755025941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
        b=J0gmJ4B9gxGtcihr9ideAGi3QR9QlekBJB72/QfAhBArJqjeJ/N1q8uLCeOQXeHIJl
         CD/PXatWVN/GJ6Jba7UvWMvCJl1ql8Zrd0CfvTTFfK6yjGbIyHhot3XN2iXgF+gj/H+u
         96ad8rWD4h+J0ujYeNE5wy7Hjgi3K5IrR95vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754421141; x=1755025941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBl0oeE4nsT7ufBB6vEQuyEr827Ck983JpEsHK0LPME=;
        b=jifDS0RwykJvt9hXti9sjxXifexVJVY4xCBnCG9KjyAcxUPM4cLo4gUJgDhOHdCAkU
         QuQfyNkRcCnFwikIHsgWPNVSg8Oe0q6P0jiuCi5E8k7ytNp3CXqwR0iz52pq7yITJ28T
         DUWu8uOfAyTQOjDhp8RklJe7RRS6vnhZ+l7upBV1HM5KkMvn52UOBd5+JBj5nntTRKoz
         y24THs0kuopXw3dIoASY6RC33VmZe58bfHAetO+rIqgE4JTxBGBpqnMWbJTPqzJ0QTmV
         SH9TEzIxowPYpilSq7KBMTY6CLLIvxUC9i8Wrj+VxCbNEY9/7dpFozyLWG3Jgb5IpwGQ
         W/bA==
X-Forwarded-Encrypted: i=1; AJvYcCUH+KH6C3nPOrVhrLL59z37nclq2rrf4bYo+3wIsySx2mmtvI6+j/1zdzFTXt7NFAN724yHoLoXcKfF+eOL@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiRRiFV2G5Sxp08s4K1lU/06+Bs+nF/LS1+wwJNr0aT1xphng
	8WXh3EYCkuNq32dKo9eHTs7cWKRIURJ+N1Xa/7rQU9AxH86yGOQYrEzurftDssleaOPx5t2AAfZ
	DOH/8QANofHBe67V30zEnQXVpIyWYMTeiJVXl2PzyLA==
X-Gm-Gg: ASbGnctiobs2TKP7io5iGoinuAcdxo65sOoIVOo666d4N+HfMEmljOfvzCjXzIbLIek
	TLmQwE0TG7K95oPfBoDvCfDkwi8pnFxix4lXBUromC4bX/yym/MGSVSDeNjzO7ndVTU/33gBMZQ
	GL1rhfqmyABUKcNblC+jZ09WmI64R3eCZZRiICu07xsNewX9otAq7RDxn+nXuST92t4N10yhC62
	gA8zHFuKnUZXtvrGfhiAqdZDTz1+Dd8WHsdfok=
X-Google-Smtp-Source: AGHT+IFWoDlflrPZk0GgYkVoWcd1gA1kzUM7JF7dTb3Klwde0+oPtrmOvnE+fiKVQpi5LGOMQXdloAMWNRI8KjI1qZo=
X-Received: by 2002:a05:622a:1f8f:b0:4b0:638f:79ef with SMTP id
 d75a77b69052e-4b091593e36mr1099141cf.35.1754421140942; Tue, 05 Aug 2025
 12:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
 <20250619-nennen-eisvogel-6311408892e0@brauner> <CAOQ4uxi3tT02zmZehAE06MyewER=NOj9iSZK14-nvPHJxD74kQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi3tT02zmZehAE06MyewER=NOj9iSZK14-nvPHJxD74kQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Aug 2025 21:12:10 +0200
X-Gm-Features: Ac12FXw7S2XQ0h0X5YXOVzg1wa8Hn1owLakgMOi4GIyXrSB5_WGnMXUeovWmX2A
Message-ID: <CAJfpegu+2nx5-pqR5FSVSXbyFEU6q=E-+t8Rd9ZrTsH-Z7C5sw@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: filesystems: Add functional test for the
 abort file in fusectl
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, zhanjun@uniontech.com, niecheng1@uniontech.com, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2025 at 09:14, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 12:04=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Thu, 12 Jun 2025 17:40:29 +0800, Chen Linxuan wrote:
> > > This patch add a simple functional test for the "abort" file
> > > in fusectlfs (/sys/fs/fuse/connections/ID/about).
>
> Miklos,
>
> I see that this patch ended up in your tree.
>
> Please fix above typo .../connections/ID/about =3D> abort

Okay.

Thanks,
Miklos

