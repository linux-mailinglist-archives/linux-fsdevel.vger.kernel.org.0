Return-Path: <linux-fsdevel+bounces-30184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8A987643
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D35B2898BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094214D2AC;
	Thu, 26 Sep 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpuJXO08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F784D8C8;
	Thu, 26 Sep 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363519; cv=none; b=L1TzQK3BLMyadhhEHwNbLzVMI620nm0CcrTuwq07ew8yKQqKG2Ea1/39mYVE1bFqdiBv1yhMSOxyCZWAwoi5Pfpt6ZgP57Ak1MtVqxmOEEiIbcyUGOV8rCir0S8SzVvHC7RrQIXOGdXsUlc94BVopN5eqSReDVoy0O1vEGAl09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363519; c=relaxed/simple;
	bh=+JN1XomXh/stXMdVt7+mNw2llVeHY0Fee3qmN8UNh0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEM+20RQVIiOd7D6AFmkEvpnaCTkLGS0oYu1FuTpwCeYdHQLb0DLV/zc2tNocgPC7OmzbDqlSKFIjjYSyuuKn5OPQzC3HR5iMg4cqq0tNRQzySfpJ5ggw/TcFF32nKs9oPu5WzPqpLRMzlmuxu6mg6dVbJKojA/KtTPLg1kLo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpuJXO08; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6b38088f6so48405a12.1;
        Thu, 26 Sep 2024 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727363516; x=1727968316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJV7o6ijTzGBnAQQO67SJKTMld4SYzCD0D2hOI0kxeQ=;
        b=JpuJXO08StQ13uWbF+SrskmWaghbilaVONltF8ltAzq1dXUlPUL3tfhRpIxzK7cwy6
         inOLPEU0UP73cBvIDFvKq/RmbBQdfGOeC1r7UQuSTAIwNQdINk2HvecP5/HjKdFThery
         eYkQUOvj5/5d51W2ibXa0Dd4haM1cnJs2vCsvbE7pTtJ/+ikyYTagpidvf8lmUUXW6Dn
         F4sgg5J4eP69YUj486uYYm0dQA5cVkoXQq4Gl1Dn85vGMKgPQ4ENT3LBlUe5M64KF6VF
         YwJFVjQDapi0+wtsqM11XBeJDFdmEVZVlebrE9zSsWAevng6V80x4XF3Vf8SsI1SOWfD
         +FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363516; x=1727968316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJV7o6ijTzGBnAQQO67SJKTMld4SYzCD0D2hOI0kxeQ=;
        b=Cql1ZiczWX+V/W76ckusfWZd+U7R35vnBPmBN580FYX1TJ0jw0HHg+q9kmmMg67wF6
         8iSwd7PW7WFZWCVra/9wNsu9w8ZGaJR3DFNfgf1LDwMkAzomW4qkCM6YJ6thqcpC01RS
         eM8lhxuWiD+5Cgx8GyCiss7cZFvQucrtTxzkp/Nj52OZnsDKOUJ8nRwqtSnMK9BbPCfk
         i+qKlZRRmB9Vqu+mTaF/X8GLIkOsqmZ98VCe1e7LXszcIlVL8vULFOQYbalOUXhzjx9n
         +OwtRmeoSqE7OskfLv0iWxFgLxigELNR86UNR6bje7ChIpme+OlbyFoyIvGbDSonliKi
         ixGg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ9NGr4K3uWUXceZABxgk5165GnsWYRP0B4u0D8aaqdMzkYbzHCzSmMbW1PLhf9OmFgg9gWCV1JWN0E57@vger.kernel.org, AJvYcCWAn+mylDtFGsZ5yrB672ZGmKaw97hcg2jc4+F0pijYFXBbLVTYezKD/oKqXhpgs2gvkODmdVhza0Ra0UFxPUU=@vger.kernel.org, AJvYcCWJ1MqvmdgU4g8MCDDWJw0skQsfx2TkZhXhcD0/njD/lSPTr6R1O9j7lCNsdzTiRBA2sSq14H+7A6YQnJuu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1vtXAXWeE/xce/Zq7NiSDvjt4r+4t40vvJRphUK7+HZ8z+p1Z
	Q8qQ17LBUGPFKhN0g+564FUYvBIhI+flWMWRpj7nIFDsfHBjRgBRsZL0eRAz3xq41+lDyxqqrqh
	+sWI6Q9t3z6Ocrq0u/aIY3B5WI9g=
X-Google-Smtp-Source: AGHT+IFwmkd7MiiYoHfU8/8xM9Q+N8K1XQrqj6/87iUkvMv9WLtMRVWAaGv/cJU4RHKBGG2ah/MF19K2IMN0hL++MU4=
X-Received: by 2002:a05:6a21:9989:b0:1cf:2be2:8dd2 with SMTP id
 adf61e73a8af0-1d4fa7ae0efmr40997637.11.1727363516385; Thu, 26 Sep 2024
 08:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com> <2024092647-subgroup-aqueduct-ec24@gregkh>
In-Reply-To: <2024092647-subgroup-aqueduct-ec24@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 17:11:43 +0200
Message-ID: <CANiq72n81-20t13O_mrx0ZPS=JBDwC-vz1dHRhU0NAts_cw99g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Miscdevices in Rust
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> stack is deep here, but maybe I can unwind a bit of the file stuff to
> get this in for the next merge window (6.13-rc1) if those two aren't
> going to be planned for there.

I think Christian wanted to merge the file abstractions in 6.13, he
has them here:

    https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3Dvf=
s.rust.file

Cheers,
Miguel

