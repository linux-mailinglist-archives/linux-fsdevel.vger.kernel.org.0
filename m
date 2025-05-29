Return-Path: <linux-fsdevel+bounces-50093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922CAAC81F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9C1C03D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE1230BCE;
	Thu, 29 May 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHLr0oyC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0921A4E9D;
	Thu, 29 May 2025 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541664; cv=none; b=aeynzvSeeuFsNpZYxsCBDQCielu9+tfuiAuBJ4WdOgquHgKGtYMAQu8SELypMQZ3G+6nQj74rO2uT6I4ZvRSdkEBsGJffYRQXq8SVsVQoW1LrwTTi3RPk40LvYhrHSkR3qO85l70hM0yf/a6RVbqCrxZQwal80Oi0y4/3/eeiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541664; c=relaxed/simple;
	bh=va8x2OuP/XP9tUIN6TYly8/+r3SiRgdq7ss21hcfXrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJcNmIi2TSqHzcETvQu0uusKMeCARVCt+wfj3Shlgrqi9YLNRhkBmdm1Jkl1mw4REfFu9LLJl8h/Wn+jkgUDVQtrB+vYW7a4mgovQCwIPM1izvUnD9X5r3n9IdXY7+9gbyMGJP576WS2wsDIVShz2kgMKYlW9jxcbr2PYh6I0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHLr0oyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29E0C4CEEA;
	Thu, 29 May 2025 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748541664;
	bh=va8x2OuP/XP9tUIN6TYly8/+r3SiRgdq7ss21hcfXrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kHLr0oyCdmWcYpOoslfqCz/WOpR8Y+i+6tyIYoau+2WzBsjGtRLaXd6WTHxqVxVTz
	 4tr88sVRL3sGzUw4s1gxpAfVZo5bzPA98zKpNf4sKDvMHwI5V2qFSsWaHcIIFkupQG
	 GiKg88l9YKOEuj1Kh2YPP7VEjl+j/JprJJYPh7txuoN7gME6gD/3iRSJC4F04gubxM
	 3RHu6OsweVVU0YEpzygqHd8O3j/QRNRSBDPmJjIZl7VVGul36kRoj5oS55oL9NTz36
	 RMOd2cJzMDLYoU4Wp/i8QXd2doySkmu5OiixRlsgHguHS6qTpY6h7upRR8lSMPCClY
	 7VGBpdsAgNyRA==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6faacf5d5adso13760766d6.1;
        Thu, 29 May 2025 11:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbYGHUCggjTqUaiq2DRMuzQYKMCOcqQOC1BGsK063ZIzQcHI8iGNfaYcJkENG0Rv7BElXFh7LHN8GyAJidlw==@vger.kernel.org, AJvYcCWP+692HR4GnpDRKEQv5W/N39bHHIBkbpyDAwySPJlZ0m2q73/lA9Fb1JGH3Tn4WMsuLamPxxYzIE6Sed7l@vger.kernel.org, AJvYcCWjlNvF6k3UwCK3noFXcn3rb0soE8hJSAyXDkmFLuUJOmMJJmeEuaphSI+MyVwwz2yeMRI=@vger.kernel.org, AJvYcCXNY7Z74PrQ7KCf2T3AMxhH9ToYzGfn4ElDgI4mW/M+QavLMGnM9QudKHzQ2941+lJktH1/FOtFHBfObgcKFi0d1NUWbavA@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8QkOyJJ0mQleDjKTuYOxvPsje5OQg7jg+QDx6mPqkHW0y8Fz
	WLvZvnsQDjlZaJ8JrKirmotkcRI6idHrzbaJ5Lp9pKqvTLZLBc6YPxYTvwSMHcg7rkuv+K79nvR
	Wrj/Y5feTZQni3CqHnrD8og+Z+jRfdww=
X-Google-Smtp-Source: AGHT+IF6EPR6+2zjvOUnh/yy1Eu/+WwFCHyfFf4IxcU2aFuspgKBn8eKOejuW0eaU2iFowJOtDhNbKdKhRjaPf5sXBs=
X-Received: by 2002:a05:6214:caa:b0:6fa:9baa:face with SMTP id
 6a1803df08f44-6facec0f7d9mr10351106d6.35.1748541663143; Thu, 29 May 2025
 11:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com> <20250529173810.GJ2023217@ZenIV>
In-Reply-To: <20250529173810.GJ2023217@ZenIV>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 11:00:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
X-Gm-Features: AX0GCFuJEvhwqFfh-JvOxs1IMEGRcEd6UR-5Og_2gqEBY0g9YyGGE9Vhi82CZU0
Message-ID: <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 10:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
>
> > Current version of path iterator only supports walking towards the root=
,
> > with helper path_parent. But the path iterator API can be extended
> > to cover other use cases.
>
> Clarify the last part, please - call me paranoid, but that sounds like
> a beginning of something that really should be discussed upfront.

We don't have any plan with future use cases yet. The only example
I mentioned in the original version of the commit log is "walk the
mount tree". IOW, it is similar to the current iterator, but skips non
mount point iterations.

Since we call it "path iterator", it might make sense to add ways to
iterate the VFS tree in different patterns. For example, we may
have an iterator that iterates all files within a directory. Again, we
don't see urgent use cases other than the current "walk to root"
iterator.

Thanks,
Song

