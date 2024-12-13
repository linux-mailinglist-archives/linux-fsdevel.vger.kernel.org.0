Return-Path: <linux-fsdevel+bounces-37393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0E99F19D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 00:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7D61881502
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631C61E500C;
	Fri, 13 Dec 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3PYQe+1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2A1C3C1D;
	Fri, 13 Dec 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132179; cv=none; b=lW8UvPhhSlK2kjvbs7qNURqS33J+FrLx7SmUXWIZtuCn/0S1r57UIbYCkNzA6UuTXxLoR7l9rNQhsAiaaTf3yYM/S1y/yT2Gs9zblV4C3WYyQ/PRGUZHqfiiuK2zRbF46uDZR4U9lw7eRCjjUDC5tyJoFUeem8M5VvrOp0J2ncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132179; c=relaxed/simple;
	bh=V6nLkJ+6VLZgE10ewA3liyVk+k3+WLQV8J7Rp4RqhFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/BpWCre1AB4KmnbRQVWp6KaogGT19yBC0lxT0uz4m+T8bq8FUP1IQD0Zi+/XsvRcVSSj0QUUbC9EJGQ7FncK24EnkS78eq7E7wW6e4tN2IvX4DggZBTh0dU45UagDxYylmVF2GWBnHOZXyl9xmO73I5d6ILdJEoO9I/Nldww/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3PYQe+1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3003d7ca01cso21751191fa.0;
        Fri, 13 Dec 2024 15:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734132176; x=1734736976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6nLkJ+6VLZgE10ewA3liyVk+k3+WLQV8J7Rp4RqhFM=;
        b=g3PYQe+1Rugf6f3Dk75wGz7ECU8CEhWuKiKj/P/necg10GhTlUuGiRT53gEtfwqhCD
         OkoyDm8DGXmNsoGUgMWYc3GE3CZV+nfNtGFea6ZvXpQXBBLv0CcjjP+x9anooBqKZxgR
         s1XJmDRJAOQYhrNL045sg1rsbjIDOUcDSVW/yJGF6mZFkMd2tRQC1DZ7TDje9uxMKn/c
         1u9dhTSUfaAi9POQCmy1ZqgLFyPkAh7W02MTPFoJ/sfnQc0mVdaT8WQxqr6FlQUJaqmj
         EqdLSE2AgWuwLUagBimMdTHOdvn7ETNGF8XaX5XMMgj1cddORepBscFzsJ9X18/qTQO7
         3KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132176; x=1734736976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6nLkJ+6VLZgE10ewA3liyVk+k3+WLQV8J7Rp4RqhFM=;
        b=KiBpTnJqGdx/5DCiMXc0K00KSrDA4/Kefnkud9dKJmC1XF9q02WubD5L/HSNX84CQf
         Ozg0MTrkCerUwSfeoIg2vE1RM2rqLQnm44YQa06ZwkvX3yiNoEJzRqhfkOQsI3ZSwXFB
         9OG2h6JlxTddCa6PehuhtcNE4ALpZB26AFDo/V/gD4fp8ieacUMfuIjG9DPUiGks3fE5
         pVM4FAW92YGmdMi+xW4+f/namF5L86XMU/t360Ml9IStOO1VUb7esNftzTctgfmczDCe
         TNGL9XGU0H4y6cD7T76/pb0TmBZ3Fy0uJefqFia/pZdAxxD1WGbLx7e2ahXM8uc+JIE3
         QWuA==
X-Forwarded-Encrypted: i=1; AJvYcCUCcw6nUl8q3gkG3tY47D8iIv5pSH6ZhF+qGt9Dxf7LfJmUJ+1c3CphJiDDJ0YX/wI51raAR4ZANKZDZtoSv2c=@vger.kernel.org, AJvYcCUCn2BQmXpmy5jJX0fae0cet5ZjggBkdsTZHB2Xaf9Ia2hs1n7A3XOCV7yoiOYlYoxgx0FHf40CY5sV44+i@vger.kernel.org, AJvYcCUt2kc8JeTqKtnBaBrVeO4erejV4seaV4+c1ApiPsgm6Vm2nKxN8ZD5KPABkE10ocpNxXA3jp2+NCGLFq2c@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RHYn2eHhSb60LrnbmZe26fmIH5vhrr6S+ccoSWFNrtvv9+yi
	QWhF9/HEcSytDkeQpoPROlpvsz+ly92rJLa9Nvi+9/lzZR/lru0XLVlObH+o/Vu4mOHEL9LqKf5
	X+7MlEAryk5/D44mDL2NLvxs+bpk=
X-Gm-Gg: ASbGncu7CQhNvgfbO07iXalVj5ArEoy1typnMeTBGYR670p0LOYb5arTlWwBuCBDsgl
	ODmRIi8eIopkKos1D6AfxshoVOHpoUzlK8PaDJdIWlj53PSHbSg8j7tnch35ei3LweNreI0qQ
X-Google-Smtp-Source: AGHT+IFmY1TQVEvLWSJ44CGLliUIslxwkoSHnsNknATRCm7EAtso74d0C01/m7J1p1lYFVNhIQmLcOp/vl+O02BqnY4=
X-Received: by 2002:a05:651c:1582:b0:2fb:54d7:71b5 with SMTP id
 38308e7fff4ca-30254462636mr16865741fa.22.1734132176158; Fri, 13 Dec 2024
 15:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-rust-xarray-bindings-v13-0-8655164e624f@gmail.com> <CANiq72mUoDFZuJZsfEbodXtXsVoHAXRDO27gBES3=uAOGZ6kfw@mail.gmail.com>
In-Reply-To: <CANiq72mUoDFZuJZsfEbodXtXsVoHAXRDO27gBES3=uAOGZ6kfw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 18:22:20 -0500
Message-ID: <CAJ-ks9kSWw+txqFOrh4fGUfPb2zQ8rDSgUo0HLMGMUG=EThO-Q@mail.gmail.com>
Subject: Re: [PATCH v13 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Matthew Wilcox <willy@infradead.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 4:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 13, 2024 at 9:02=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Changes in v13:
> > - Replace `bool::then` with `if`. (Miguel Ojeda)
> > - Replace `match` with `let` + `if`. (Miguel Ojeda)
>
> Personally, I would also use the early return style in both of these,
> like in C.

My personal preference is to leave it as-is as the return keyword
isn't used anywhere in this file at the moment. I don't mind you
changing it if/when applying, though.

> I think you may also omit the parenthesis in the first one.

Oops, you're right.

