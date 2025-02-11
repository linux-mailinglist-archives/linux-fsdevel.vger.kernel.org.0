Return-Path: <linux-fsdevel+bounces-41514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA87A30BB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72053AC2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D91FDA9C;
	Tue, 11 Feb 2025 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1w+BTQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93416215067;
	Tue, 11 Feb 2025 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276705; cv=none; b=P9nCJlfN+ULKJeB7SZGkHdZA9fUsRwQJi5cTJXkbaECPsbg/4sJzbwfYV0jS4TpIt0ns81+s4A3/z9XB5SkK/HqiZPhKzjV3g5PuIjAQajOtiXTNYCSFNbXMk8cO3xkPOvSnpGpUZSIwl/BuNDqeny1cMGVHlGLMBvuaQPL4L1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276705; c=relaxed/simple;
	bh=luIF/y8mz4y5i6r2JfpBlxxy/vxVKvXnmc1mgeWO/Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6w9IMNozSEk+nnGcGXB42uuUvfM/8CsA4RiC8/DIajZtsDvmLh2isq88hH12tVcQUW9A2QM+ZqzqD72YP4MtEvi4IWk7+M5Ss5QzwGK00hY9nOhyO4NNnwuYqZIxOSPEpt5Sk7qvHxnSR5kK+DqjkPQY3QpaqJ2BSSRbww47wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1w+BTQG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so10772536a12.0;
        Tue, 11 Feb 2025 04:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739276702; x=1739881502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luIF/y8mz4y5i6r2JfpBlxxy/vxVKvXnmc1mgeWO/Pw=;
        b=H1w+BTQGjGlMBhBGQj+argR8Jzwd1CpESsIqn3sdJLv6fOtPfmmw4cg6lk1nyrQcNu
         BPjL79puS0eNLI0gwBUsrQC534EPEr52OMIPZCE/m70zCfeiDTQQU+RsM6SC5WfS4Lyc
         g8hGa+kukgMcF1omELnDEpxPzbGgetocz4dM8UyI1hyhl4QQBlT+Rtk7NloCGQMMo5ZQ
         P3ZooR0Vd26TXHHYAFHaznK+UwDHml4FEIZAuqmcdWlqT0zijAGhK1PKvAz/v4gJqE9a
         s0fD+G+saEqdw34C2MB1fnlfvcqnUMg+GObN3rfx7om4W9gnGy6GKrvOJkZH2EoHUs9S
         OoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739276702; x=1739881502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luIF/y8mz4y5i6r2JfpBlxxy/vxVKvXnmc1mgeWO/Pw=;
        b=WSF9OdDjBTepEm+S22NFkdXkT8ZU05+/agVR/i4wVJ0KrejAbNYQunv5UCt9DsGtM9
         rhfcj31CoxCDHjCSDCHOcqyjtGYVt30pMVk8V7yiEzhSwG9bBlrHajH49mKSEdpZ73l5
         /4lS6+rVrw/NjITcqDm1JzCblY4TZi1mKjUrhTHZd67wqLXUWIi142HuCa09PNwx8KAO
         peGhE2iw1UlHRfbz1/aJikTt/KMWacYk9b6aBqY3ea1ysWjnB7ivT9eAW+0u/cn2CUaA
         xDYTHNQhttn69xbYbyEswb7wnjjT8YGJ9yMk88Q+3HtRirN38lT0o28GOSPzYpr9Ytfs
         ErZA==
X-Forwarded-Encrypted: i=1; AJvYcCV8rDYrXeEk0BW1IBMBnZDtjs6LnCvUhbsaKJ/loxWZtJjve2EKqqRblCA1UuHGe3A9dP3rx/rcLNhadcyCbA==@vger.kernel.org, AJvYcCVJFPuORWNSuCUj193qrlaX92ZtyfBKD9eGiidE5UdwBgFrh9Oi0Z8B0RKa5ACNCiBUKq/b2/9rJOa4DFdO@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsTlAyn5Qb6mhN2hLSnuJOwZfjzgtdzrhAXTxzVP/gm6l4vzM
	bl+aycAnc7wMAB4qepP7ZopcGmcN1R/yYgMQIOfcKpmbEnCQMDruubC6VqxoqwA6TBrCiHVE/k5
	IFhmrNASO9og4A963z/6t1Zkct8WFQexgRmc=
X-Gm-Gg: ASbGncvsxtdknghevTn4k1nJUaFO5FN5hAJd7dxgxcKrzewzdnLdyuZSfcQz1XKvQh8
	uFZGBy9az7/Zqi0FhVW2ieJPgQUGk+txwCtTTHbJYzWplGcfqR/7JWHi0JGsiz/aE4fQwZrse
X-Google-Smtp-Source: AGHT+IEw5iy9IvJHFTgVY/mCL4X9T/JUy1OHL1GrpeFqk3wnWbt8gbcNVXssDvFoQbPsh7P2omk4ysuFHoCLj8MfKqQ=
X-Received: by 2002:a05:6402:51cd:b0:5de:5a85:2f1f with SMTP id
 4fb4d7f45d1cf-5de9b900d4emr2832752a12.7.1739276701715; Tue, 11 Feb 2025
 04:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-5-mszeredi@redhat.com>
 <CAOQ4uxgOwu1pnS9BoMYDua6D4aJ+UUOwbsSyUakP2dMd5wQaBg@mail.gmail.com> <CAJfpegtPj6FW59xpVBSxL8UwhC8qPv6gCQov=2QQUty0YW-6rg@mail.gmail.com>
In-Reply-To: <CAJfpegtPj6FW59xpVBSxL8UwhC8qPv6gCQov=2QQUty0YW-6rg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Feb 2025 13:24:50 +0100
X-Gm-Features: AWEUYZlXNHXcmXflhsl9AkTBs3sHqs5v0LA4AQXrrCyGA3Aa7I593YvV9gfeKoc
Message-ID: <CAOQ4uxgkzSsiqaQn0EXBespMo+Yck2KnCAE8+Yydbi+zOtMN9w@mail.gmail.com>
Subject: Re: [PATCH 5/5] ovl: don't require "metacopy=on" for "verity"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:14=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 11 Feb 2025 at 11:50, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 8:45=E2=80=AFPM Miklos Szeredi <mszeredi@redhat=
.com> wrote:
> > >
> > > Allow the "verity" mount option to be used with "userxattr" data-only
> > > layer(s).
> >
> > This standalone sentence sounds like a security risk,
> > because unpriv users could change the verity digest.
> > I suggest explaining it better.
>
> Same condition as in previous patch applies: if xattr is on a
> read-only layer or modification is prevented in any other way, then
> it's safe. Otherwise no.
>

Yes, but one has to follow the series to figure out that userxattr
means that redirect/metacopy are allowed from lower -> data only,
so it is better to mention this again in the context of the commit
message that relaxes the requirement.

And also even if lower is on a read-only layer, maybe we need
to fix the uppermetacpy vector from index to make it safe.

Thanks,
Amir.

