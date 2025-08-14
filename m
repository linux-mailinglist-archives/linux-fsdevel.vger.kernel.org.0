Return-Path: <linux-fsdevel+bounces-57954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F7B26F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793C21CE0470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 19:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806B227B9F;
	Thu, 14 Aug 2025 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpNvB+AL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771E1E7C1C;
	Thu, 14 Aug 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198396; cv=none; b=PnoAjHqap9IV4vDNmu3sUcX68hTjMFQWbBnZcUBJxSO8x8c2qJswzoOdtdhxgxcDWRV5JqxVc7tXXn9yLeAatl7aPg78CHrhcnFpEhg/QlfeyhHKx468vzbCMBDarSKruTGCFy8EeTiEn8+8xk2SiANSptxeqOFtpZu/D6h6tcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198396; c=relaxed/simple;
	bh=Gl5qY1vC7MVtgKs/z6TAzei/9IYgcNSG/kIjlhtFRnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E99ia/TbXxziokrn6d+ILl92aj+yu0yuYMYGnItmLDs14JSasULaUrv5iAPWnGcZ6/iDlBZYLrs7ZthYVSabWeX1gTmEj0tojGVDoPc9iqCnq9eIwZbvZG/xvPLg/vwZyeel0/cHaChBR0YqWR0CYrxFUvYfpXGxVqxLMNbQGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpNvB+AL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b6548adso2384845a12.1;
        Thu, 14 Aug 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755198393; x=1755803193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAhVAoURUJdSUUlBSqT1WO1faYwMP8wnEJgkORbsqYc=;
        b=dpNvB+AL70+5GfTpF3vuK5YZ/BzrR1Y7lyUfS4rOPFoyhRvxFmv1RQnjZKGUc9Fkc+
         fLGSWcsI7U8fgYpwI64VhriOJzJkbZcrN2Dfmz4WcQB7zmKeRgJuJ0JZg0Rup1iPhTlc
         uVQubYhsLlf2LDmJ4hJcs9Y1HwW4RO8tR6etFuwXSxlkaRrK7mY91wocYzgqDOZDyMlY
         Z6HVkoiC0mS/W+Ig3xQJ2W0Is+6pNG/FZniO6vwFcfaJwB8QhOLFV6ftmxuwY8uU4TLX
         EaXQpDe3lg2xgcO7AI4JtxPWasmJcShX0k/XyixNH3600nkpXjDvTJZt0p7r9SLUYmWH
         CoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198393; x=1755803193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAhVAoURUJdSUUlBSqT1WO1faYwMP8wnEJgkORbsqYc=;
        b=nEGeNRvyJp4it81pNR9zK8ex+o5eE16bUGbQagnP8lNVyeSaw17XF0aQQTwlSIYwx+
         oI+vht460iIikCvh4tqU9PuyXEJ+q0rnCnZwokDz0r5pcSQ7Dvrgmt91sXh4pM5eYO/h
         r251wytOA522sGHXdKpGnyswvkCFC5IXxdIKgK755gDeT852+RIf2YYzoe0OcGyWqHhT
         ylcMy0cV+qYqWIEzoU8mu2jPaEEhTdKrXqC26eC/VdGsbNDBHqJ4oL0qgcbi6VpEYBOi
         ps4OM0UFPi/pc4pnKmkTOE6Gx2w2mjPNlZAR9RR5xoDhO2idq9zhOdUDAKiyfuqh7eiz
         USuA==
X-Forwarded-Encrypted: i=1; AJvYcCVJjSehxIlovbElE/DYhyHdivLawCLu+6NN1rIEZwkkkmaLH9cwuqZrPwSxDUYi80g2oz1JNCShpl9M3dUO@vger.kernel.org, AJvYcCX183nhvUtkQOmnnMh5HbQH9fUCbs9G12E3MvZQdsKdbscs7HoYw5zEYcpsoVqRHrLWA1WO2h02smeRu2sMYw==@vger.kernel.org, AJvYcCXn1JzxCSWk+nntY+l5RLjTaOXH5Bir/TgvYGaV2SI1eudH/C3HWlwe6/uCLMjzpYI3LHe+zexe6OBeVx9C@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVj7erMt3tMRP0I7tlMRm2INvJ+d42ixx7MG5DSTISzps6dL+
	xZ8yDEFFzoMq1Amxc8s6nRpUnXLlg26N/jrQxTp3MWqE+SrYQmTX4tPupBfw/5vRdDIjrlK2NnB
	QN4buZhn/1SmU4NYUwj3ItRSg2CjQGOw=
X-Gm-Gg: ASbGncs8rUtDwsPr6IugxC1+4AxPRPFSkMPiBahiHBDUCyTasthgOLusnAAW4lJRvyW
	5sQBsDW9OOXf49LMhOkD4qoW2IUUYXtEQHukSRDOitJa/uAa+3eBFf6ksLKKxyrTBelfudoGG7n
	2qb3qIrk5iDbftzjyc9zUefJoq1XnDr3shh/RxV2Vi/NTK+178nlpXMS+G4FrOY5u8L8KAbBMj0
	B1CtMI=
X-Google-Smtp-Source: AGHT+IElhQmv0oK8HFelo7BIqbRwzMQ+UDMLi/aHl8Ceh/7D8ASt9x1S2QuK2brtjgJ2EUl6Rnb/PnKxXcVjsVCMHq8=
X-Received: by 2002:a05:6402:1d50:b0:618:4d65:38d3 with SMTP id
 4fb4d7f45d1cf-6188b934541mr3598381a12.5.1755198393288; Thu, 14 Aug 2025
 12:06:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tonyk-overlayfs-v5-0-c5b80a909cbd@igalia.com> <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com>
In-Reply-To: <cffb248a-87ce-434e-bd64-2c8112872a18@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Aug 2025 21:06:21 +0200
X-Gm-Features: Ac12FXwLgPmfdwXP-DChItN8pOTiIklXy3PtWKK2QU6H3JYlZl6frxcjtQB86Dc
Message-ID: <CAOQ4uxiVFubhiC9Ftwt3kG=RoGSK7rBpPv5Z0GdZfk17dBO6YQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] ovl: Enable support for casefold layers
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com, Gabriel Krisman Bertazi <krisman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:30=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 14/08/2025 14:22, Andr=C3=A9 Almeida escreveu:
> > Hi all,
> >
> > We would like to support the usage of casefold layers with overlayfs to
> > be used with container tools. This use case requires a simple setup,
> > where every layer will have the same encoding setting (i.e. Unicode
> > version and flags), using one upper and one lower layer.
> >
>
> Amir,
>
> I tried to run your xfstest for casefolded ovl[1] but I can see that it
> still requires some work. I tried to fix some of the TODO's but I didn't
> managed to mkfs the base fs with casefold enabled...

When you write mkfs the base fs, I suspect that you are running
check -overlay or something.

This is not how this test should be run.
It should run as a normal test on ext4 or any other fs  that supports casef=
old.

When you run check -g casefold, the generic test generic/556 will
be run if the test fs supports casefold (e.g. ext4).

The new added test belongs to the same group and should run
if you run check -g casefold if the test fs supports casefold (e.g. ext4).

> but we might as
> well discuss this in a dedicated xfstest email thread if you want to
> send a RFC for the test.
>
> [1]
> https://github.com/amir73il/xfstests/commit/03b3facf60e14cab9fc563ad54893=
563b4cb18e4
>
>

Can you point me to a branch with your ovl patches, so I can pull it
for testing?

Feel free to fix the 2 minor review comments on v5 in your branch.

Thanks,
Amir.

