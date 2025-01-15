Return-Path: <linux-fsdevel+bounces-39342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF1A12F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4259D3A5E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 23:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314FB1DD9AC;
	Wed, 15 Jan 2025 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8ikXZEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C91D89F1;
	Wed, 15 Jan 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983320; cv=none; b=IKXZ7hbMAMGaxb51KWZpkM1+MXTERC72XjjZVTAmBu5E/0eWfbAeoRrn1UujtDdmAagFZNn6gQ9SXRi8BUl78v7B1uulgKaB1U9dZqPz6iXie0+PS6caZ2nh1N+GEkYLMFXFF97rL+waUUD2D9p1eJPRRvjvCt46ZiIizR+r548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983320; c=relaxed/simple;
	bh=coBNzMyLr2B3ORM3bAcGswH/1L9jg5+oGOssOWy6ZM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuT+UNrmnJN1YgQY6qrGhKw3rG8TfCLf3vvNo1OpN73EsFnMhOrgOZv15XUDmGm9saf3EL6zGAW8yNpAHLbKLe0ik3yV9vX/jqT1D/aTCZYUdUS0XAlmYrWa5SdEeatfphlwFf0f0Ph7/nV49P06hqmhapqfxtY+9TDaIejcByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8ikXZEb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso516801a91.0;
        Wed, 15 Jan 2025 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736983318; x=1737588118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BOQvIRSE/4krKgyvfXz5rShtQyPO6JUbtHLeMTfNu8=;
        b=J8ikXZEbHqJhnXgeQljDGTMLrnBUAswMWOCnL3xc6jbR8TCwL7MmTnV7b/x30aHyKE
         V3TF+1mVoxcyg0sFLZgK5dFNq4l/zn8iIfYKUsRP05HXTwVeJthUlk95gFEw4tkXHUX0
         atVslP8MyhpJxtee0EF/D7dUdNF7tSk6IoWsRJE5unQ/hECAlSEWk5wAx6oyTMlqY8UU
         57BaDUbuKs8d33EhKwlCc93S9lOwzyD1w3UfvrqPGW7QDYq90Rwh5xhLdaFUg2fLzXo0
         DYFvNy2jDtZTvOwQHUwaoTzfrPVu8VQ8qOmiHlZOizqshG9385+vzihHuRav1I8q6pu7
         cZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736983318; x=1737588118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BOQvIRSE/4krKgyvfXz5rShtQyPO6JUbtHLeMTfNu8=;
        b=feaZ4qMJZsWhxERYqnXgvP3neMXIfs2yO6Hljn9geTUhrPlTVOhXUUlqbODekyrYR5
         LnseVUhWd2vEbbCpj7c6Xl/21p5eXZXKYU2zWQlHoivNJtJfvrOBP64pbBQLE+NwO/Y8
         Zw3caXfLPQGBi1cYzgzSbZ6Lvbess5AODEFZTZuZONBybCMkzKBUCQiH0gNj7I62zHOo
         VFSQgZPBCNszvGkjxDwrkrdrNTcXorXzOGFbkYHzeiivWlDRzPwMiH61Ftij1kdvLbDi
         GaABSEZYGOXy96RlK2AOy5gqKVrNDGHn6RRds5aQaDgxzOYWWc4Nk3xKUANfb37An5nn
         9orw==
X-Forwarded-Encrypted: i=1; AJvYcCXT7BM7rDFlFqyx8ZppMdtB80EKcKcODC92SF0QGi0Od/dIl+v8JtSUqSRS87J1yxAj3AvVSGD/Zgsd7t07@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/g8F9ptHHzhukCvMUzHDj2pN1spVMNzclv994pUwP26bEWHB
	6mzhxPSFffP+rxMPy91LmCq1kEG7BW20JY7hxprc79wHQL7U617xGzocsSGDpphD6sZq2hCMnjT
	WgEYNSlq6q+XWOEGOQ0QFtHJw0jot3ky1
X-Gm-Gg: ASbGnctmkGjW4o2pjN1A5YPDucMOTaXWs61+n7T2J/ZgtaK6GT4KnOnerKEeUUaxxta
	P6bkKC6xz833+w86dcTm++X8Wk91ARaswCEUl6A==
X-Google-Smtp-Source: AGHT+IEMC/20z50FeSKQ+kt9T+tCm7U/3KQR+MgUg410TMWx/JxojFQ4i95RdCJSyAcyfnzhGj5N6cMM76M8+hKPogc=
X-Received: by 2002:a17:90b:520e:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2f548f424b1mr48272027a91.33.1736983318416; Wed, 15 Jan 2025
 15:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06b84c0f4c7c86881d5985f391f6d0daa9ee28dd.camel@ibm.com>
In-Reply-To: <06b84c0f4c7c86881d5985f391f6d0daa9ee28dd.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 00:21:47 +0100
X-Gm-Features: AbW1kvakBcaDZS8yt0Z4Ny1jWyrcaTcFzvHeC6hvnM_6l6-35CfbkhH40sjshzI
Message-ID: <CAOi1vP9A2MT2iaDGny0FY9cwxEN1Lvknemgxw1fL6PtYcsvqww@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: switch libceph on ratelimited messages
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 9:53=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hello,
>
> The libceph subsystem can generate enourmous amount of
> messages in the case of error. As a result, system log
> can be unreasonably big because of such messaging
> policy. This patch switches on ratelimited version of

Hi Slava,

Do you have an example (which is not caused by a programming error)?

> pr_notice(), pr_info(), pr_warn(), and pr_err()
> methods by means of introducing libceph_notice(),
> libceph_info(), libceph_warn(), and libceph_err()
> methods.

Some of libceph messages are already ratelimited and standard
pr_*_ratelimited macros are used for that.  They are few apart, so
if there is a particular message that is too spammy, switching it to
a ratelimited version shouldn't be a problem, but we won't take
a blanket conversion like this.

Thanks,

                Ilya

