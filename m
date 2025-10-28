Return-Path: <linux-fsdevel+bounces-65924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA72DC151B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6490F643CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA4335094;
	Tue, 28 Oct 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs+v+du9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E8330D2A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660488; cv=none; b=ePhQDdBNRJ0CLucM8sf9czGXd3+TGlwDnw0IhJ8ev1R3dZwji8guq0L7Mn0hu6j+INFWib6XU1uCAjI3wD7xGn0tm3fvZyUS4VWFjnRBjVBMGLOm4LK2L0y2LtpWCRdVHjQK/Rx3CQjIcJx6+kOsd4GASmkuZmN1pdYjCOcdm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660488; c=relaxed/simple;
	bh=fMF0uIkYb/9nO13E6JYrBSQ890ln/OCNesZioeraOmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LemDF+kRGli/JjRqrZKOAmuo2t3Ehf9ZoCcAezO8XXWjsLuRZnUWv5B/Hc41PulcWhR3+t69sfxftjG3EEHOOyhsGPoRM1WEDIr+ZMSF4BXvKUGDCR3gnL4yXQym+mKN6TLHDZbHhZ28oLGolv8skgoWVWYa73XDOPfzz2sdBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs+v+du9; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a282157018so400373b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660486; x=1762265286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzXgE/2ulluXjiz3ioXFP7iSLQps3543DNUEOIb/jE=;
        b=Xs+v+du9ZOHdzUiAMuYwTh1/08eRl4NhuSxRLah9OOjGGsdTNBtE/h8NRZ5JMxPfIY
         sDQnwm6eGd+f/18L6254ORJyvHhGBtu8sJ+KW4AQ8+SduGskg6lnRgtuNlRN4730jYdK
         eRyom9Jwvyj7+lgs+iZ7UQQF7yzUYr+b2uam4HExNsw/0Le66D6YqFXPHTW0/fc+iikI
         TY4YWXRe3G10CrpaVzeeB165Ls9aHDxXWDVHMgDLDO0aOuVWrI0/HkzOTpi3ur3ES1ov
         HP0hgK8RyOy1UDBMKye+NLj28ADcEH4sx6PVIoDQ8vRAxQLShaef2Tn5c+6XrTARBb+C
         CYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660486; x=1762265286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUzXgE/2ulluXjiz3ioXFP7iSLQps3543DNUEOIb/jE=;
        b=Z99kk4D1+8Io4FQSnelG07EbyhuBB0jY7ahhAMso6SblvJCWYMtYEFfxpzOmYF7+bl
         /RcdWndGaHAmOReUT916Ps/iFGYjcWZr7GWS+UPqSB8U6tpJilr4G8gZqSsDu/HE7tQg
         IU9qQrYXrKqgSM+lzTlTTT7tI7/26YGpusLzX52GFibJ1hztdY3is5G3ZO/+5WfG6LHb
         iECm5gPUG6vrT16Jt+rNFQxzeQ9YvzE4a/w8QbA/mm1VpZRP45LqgvgXuwdF4zPKRJS7
         d1wjVGlKt4B/DDna1+FVOoXUjepv1YvnVwdq2l1GJCZlPMIvf1NI2uCB3wnvOewkU9aT
         uV/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL+nPpdcfgLvv/8DZkSP8i1JB87DMk3vR8Ulc4jiALVGJsFTbUDPibqn5tzRdsygEXkjHdCVbjoERH2KQI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MtqKHXqgAXljnoArGZjipDBII5wmzsTMkYzDL9rQ4djmq8EU
	RhdsfMO1jQLpC87EYPEZhVmB+ok4cE/qko/qS/Mvh3ma80Lt+2ziTb5c6zh8+fvMNUnqi3uLr+3
	Mk7ACLqwFyPtszTB4oUgbgJKe1K8aTuw=
X-Gm-Gg: ASbGncvIY+mvUiO2gXp0o447Jn/H8Y3Fd2snxELFos+lUhsK1XjqEkHSpn4DAJw71H4
	RfZFh+JaW2PfVhIu9kZd5z3ioK8Tlwt0fd+frVdUICHH56EDJBacu+P7d04z1Pu88hrdlecyCaV
	zUXD8kqtJoeGFjIyiY6R1wbLgaTmXpwh0ID9WXHDlYx/3BhCDWdGIuKB6kFbnAMtJHHJu1mIwdw
	Qt7OFqgGVyIEXPOkFFSV1L6hylQvT4OjMcuDEvmRMS3Ry/6Ap9w7+rrsK1sjAOOUB194mmKDHew
	KyynvU8XepezLxT207Ce+VkeKWaFklAju1tjz43RBlbB3nxWQ1JcLhBvqL8jWonOx68YugZhnPv
	wbYFrrHT8piNJHTf1YvuKsfNK
X-Google-Smtp-Source: AGHT+IFPYxm7Iv4twcBkyDxsullgCK2usL+8ZhZ6m8nxIuIYLEU/zp2pI4QxufDx3UwrpPIFp1nbPHFcQdYwIBQVGLg=
X-Received: by 2002:a17:902:f60b:b0:269:85aa:3776 with SMTP id
 d9443c01a7336-294cb529a2emr23559855ad.11.1761660485414; Tue, 28 Oct 2025
 07:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-6-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 15:07:53 +0100
X-Gm-Features: AWmQ_blGIJf-tyLY251Px79mQs7BFIvZw2hoOs4uL1EAENTEQ7C2qSl70-fFndQ
Message-ID: <CANiq72nii94XPR_vkE6NBYmpfz=AJS+5gr0t3Hbc1ewdEZ_jeA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> +    /// Writes raw data to this user pointer from a kernel buffer partia=
lly.

We use "user pointer" in a few places (including another of the added
ones), while "user slice" in others -- shouldn't we just use "user
slice"?

By the way, for new APIs with several arguments and potential paths
due to the `offset`, it wouldn't hurt to have an example (even if
build-only) with a couple asserts to show how the API behaves. But I
can create a good first issue for that if you prefer.

Similarly (another potential good first issue), should we use e.g.

    #[doc(alias =3D "simple_read_from_buffer")]`

?

Thanks!

Cheers,
Miguel

