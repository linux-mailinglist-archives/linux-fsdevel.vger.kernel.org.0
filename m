Return-Path: <linux-fsdevel+bounces-45630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AEFA7A12D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AEF175845
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 10:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5D24BC01;
	Thu,  3 Apr 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMcGyA3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361B2E3385;
	Thu,  3 Apr 2025 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676834; cv=none; b=Uz4mBiJqbjZZb9y2prM5cAvSFGE9YPDm3VNBO57ctr8qKjiViwJaP0f5yxwVt2yTaCZAn4sCbKKk97LdjVrEsVLobOg57C4ai0ToO9Nwpm7zRWWTrLf1vE5sRS/9hBbEUnoP2cEHkC2e7XuhDqpoe4oze2hWn2jtRa4564vOXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676834; c=relaxed/simple;
	bh=QZV+Jwa06LV3pB3TnFEgDUTXRcBThFgYmeYH7w2JDSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqNnEpYJZOSglWqsqxw2a1RPmpMHf0ln5xSKali+69Bqm5U3Ad5rsdk8Ssa8UD7YCC7IkTkVzsjAjESpgURFFSzl+B2UuGeMvHkDc2tpxQHym+CIAUxHwwAcgEyMEi3ufZG0lr9EPIgFW+PEOk3tI8YNk5k1ZXekMqOh+Jm6ldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMcGyA3s; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so1407782a12.0;
        Thu, 03 Apr 2025 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676831; x=1744281631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZV+Jwa06LV3pB3TnFEgDUTXRcBThFgYmeYH7w2JDSk=;
        b=UMcGyA3syGB3XAN89/cL5UN8yWDUNDSmFO027x8tX2kmwKCbXjhsNDHntxf1ijzlwS
         TEEXyNJGn4Tt71aAH05g+tjaYHtlHR4FenVMWtaxGIIwNMxON4jf1fdQEesaDqgsRY2O
         y9Qc+lIWDjxD0iKFIH3LlqF4PvX7OLnyURkWuRucC/RpFxSiYfZ80Ygxnl8BZmxIi4A5
         8/+FqSHFbdH9C1/GT7k3KsjUjxkgzaOyVUvZlSO2OTw8Jw6iOsMMArCiYS8s8M83tN7a
         fBaKy/0MIYkfCvhkf6JvM/8FGBwwCTfvAMGLfaOEE6wDot/vRn3XdXQwYop8jpK0BBF8
         p7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676831; x=1744281631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZV+Jwa06LV3pB3TnFEgDUTXRcBThFgYmeYH7w2JDSk=;
        b=Fz4eSroRvg17H5syM7pQJEbNiEqbnE8VWTnX10m/tNV98vPoGhdPaOR1v2kD8+DKpN
         DNAorkOSJU2zmxtIjP63icx5n8QlUgILmDFfc4JVnc8FoY12NFvnWe/bdlLqvZHCGijd
         yIZmlBb4Yfxt5Ac5P8j1Q1mITW2QLEpgxLJH/t5+oAWkpTpF3QyGypUfRTD8oJ/T8BP5
         ujhItuI1/TvMEZlxzgaXICx5YKpCwh6JOnkMlLWddloTevBodrbFWOTKwJBJAwbBhW0d
         QUVwj4w7PjY/2BSRL0O0AAhwYpbp6iO4eEFfDuJCVA6sqZgBbKJN8qnXnZgU6q8zCnzv
         3p9g==
X-Forwarded-Encrypted: i=1; AJvYcCW6aX08jZx3l4dtIEUT2C81UPz9mDe53g7nZ3s1tCJSnGNgGUG5bm7K2GZ+RbAUoxcSKuwWygG42+cvDo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzCk+NuYe4XaU0UIM43pCQ7pW6LUo7hxTPkIcebahi+TTDSnO
	mI84a3vuGRJ+qI10XVoV8bsX18w9hFs0MJZqWFsyCXutK8G8xsYhn2OAVI5nPCA02Js/D7pDyXG
	n1lk4PkVzYXDK1FXCHzPqiUuSI3tjoA==
X-Gm-Gg: ASbGnctbpitWDevsswDbuQU6K7FjdDxQTQXfNPyle1VcEW2iD4xz/1BJewqHr7ltBgs
	HRL8TJ7Xn1TylZSWLRv4E8DsZUBSbEXFRHMKRjq5Y2rY2/LOnIxD7OVajEy7BRh0ntO6WWbR/by
	y4H+UISgIS0pTyhqoOCcB5RJ9N
X-Google-Smtp-Source: AGHT+IEQPhBtGUdnoz3s0qNXLga18NaHdD4DE6ch+TIQ04QvVm4UhWe3gP+S8/DLGViop5zLgQnVqHBMZa+rUglvWiU=
X-Received: by 2002:a05:6402:4407:b0:5e5:cb92:e760 with SMTP id
 4fb4d7f45d1cf-5f0871bde0bmr1742730a12.17.1743676830999; Thu, 03 Apr 2025
 03:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401050847.1071675-1-mjguzik@gmail.com> <20250401-erwehren-zornig-bc18d8f139e6@brauner>
 <CAGudoHF_Nfjq1nLZhMbFr3GJz-z=9Z4goacCgXbifxrQX7yiwA@mail.gmail.com>
 <20250403-tunnel-lethargisch-810d83030763@brauner> <CAGudoHFWrxxy8eMO1gz782aUA-7JobSTWYpuxuD-iR=UvYofmA@mail.gmail.com>
In-Reply-To: <CAGudoHFWrxxy8eMO1gz782aUA-7JobSTWYpuxuD-iR=UvYofmA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 3 Apr 2025 12:40:18 +0200
X-Gm-Features: ATxdqUFx5peadaURUYxhv1U4McCTJvNV5oXpbwVf0Nn5JFqMaD8yEEopUHiFlno
Message-ID: <CAGudoHEkZfPNN9XeFo84OMMEoKXn+iSRF-iSVqKSH_c7NOKFwg@mail.gmail.com>
Subject: Re: [PATCH] fs: remove stale log entries from fs/namei.c
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 12:39=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Apr 3, 2025 at 10:39=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> > I'm thoroughly confused how this would be a meaningful April fools joke=
?
> >
> > The comments in that file are literally 20+ years old and no one has
> > ever bothered to add new updates there even though Al, Neil, Jeff,
> > myself and a lot of others probably rewrote that file a gazillion numbe=
r
> > of times together or significantly or at least subtly changed the rules=
.
> >
>
> I agree they need to go. The joke part was not the removal, but the
> addition my own log entry stating the removal has happened.
>
> A genuine removal might have ran into opposition and I'm happy it did not=
.
>
> That said, my "submission" does not even have a commit message.
>
> Perhaps it would be most expedient if you committed the removal and
> repurposed part of your response. No need to mention in any capacity
> in such a change.
> --

I see I dropped a word: no need to mention me in the commit, just in case :=
)
--=20
Mateusz Guzik <mjguzik gmail.com>

