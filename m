Return-Path: <linux-fsdevel+bounces-54921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9BB05386
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C103B8444
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E8270EDE;
	Tue, 15 Jul 2025 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0lHkNhXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF22E3703
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565431; cv=none; b=Vo4fGJK25o01P+rgQkpOiZhGzWkgsEnmW2rReLF517nM9XfzD9D++kvpJ8IOa7coVZJdva6q4zkrIJMRxWHBOaP/rkr7l6SAOOnbrK9ZaUIWNrgXzfWZ1hsbgT7+jVTuLFsaC/bxuDR2sk15F6m2W9jC7CZjS1O6uznhEQzTRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565431; c=relaxed/simple;
	bh=S6ZBbnBRdm61eYlM0P1O6TiMquJdOsVhEn0le3DpHeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bvb9JtJqg8YBLw3G/va8zeMYX62T0HaHpQPWic0CUzAHY/TbhnRVdqpulRwo8jQg24185RXp3Kzi6GkoQwIr3UO/vX1uSP6WMikPW7Mu405g8qFis6La9LWC37wF6PIYJI+C8GhPfB9QBFRRhc08Uje5T/w+5AuKGl8DxEv6/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0lHkNhXN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so36028015e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752565428; x=1753170228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOEo0Mg2XI7OcoOFqG5XTj/kjS9gvP/PzpP2FvhjQ20=;
        b=0lHkNhXNaHoEFJNmP7V19ubrjB5uQzXC6dfboaYirhEF5FQFGGt4ucfiHF/v/QwzbU
         Tn6CM749w2KXChAB0pn3qjyshN652FEvEKV1CfyhUp8QjpJ24/AkmOPK4/bJl6Bopcto
         RfWjsAu95qr4jTlqBmrrDaMQ8ojhiLXgBEAfzV81B3bNVkCtj9h4uuhhpLDI7iZz89Wj
         l9Nr1H7POoQqUN2AvKbhIkZvq/+5rSfEKdViE+0Q3SdNynGs7baJYdrsofepELfHkwL7
         Xov/IqizLh4e+E49XWwOKsuDRoRkhB8oJWCbjyoT4RVor4XolxB2an3RUGTA7FrjDu4S
         EQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752565428; x=1753170228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOEo0Mg2XI7OcoOFqG5XTj/kjS9gvP/PzpP2FvhjQ20=;
        b=evfQHt0hwiq/C13/L7o/A5TVhe6RPk/shY9cqaj3OJrHitd0qP5BsAz4NY0xvrrokr
         NQRxsKw/czngtkifEjW4sK4+5THcQd3x18flHL0nrxc31D1iXsrfZWEDIlJThEe7rel+
         F3b6EYKO7oeJirDSGEjNfdkqpONNpvp68p7DIdvOk2Hddia9c1YV8asbfdXMYPLzZdqO
         NC1GOg9H6HTGPTTStBgyfky8Z8h4eSYaKRdpmqBmtEXLAX84u0j0rJIuV4gthF9AxOtb
         sg8fLB6Qd9wXxrS5lwHZM7JpxiYbMcHb+coHoBiqg7ZsNHFiYuikeYH5nGg03FuZ7vfa
         RtYw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Zt2A+GUEur0iTLrSc0LpA1S3G9fxB3MZsOeEF/rySOOPQIgqcQ33Rt1YeFYjtjkMHwy/8loTCInwj5fG@vger.kernel.org
X-Gm-Message-State: AOJu0YzAO5KIVdNBiquk6C25ttxThIrUaBrH7tKcVfWsBZJaz18j0WUM
	HkMqAD/yeBYbLmpdoKW1t3bF6WJV3SGoHCbXVo6M6NH+4sYiFelH8gDGbDa/N46J5Jj1JkADhmE
	IOPAJYbT/h9zpR7Q8PTlPWo+IpXxLyF0iwJg6FPVc
X-Gm-Gg: ASbGncs51fHINl/eu0p6lpi6zRo/pYtk9gH3SCIobpCDbiyoI+b0DUW/x0AbsMlAzjn
	s965jDFftKaBF+e9gJHDu2yW0EkiP4TVuAXpzx9MBdZvyf16bwqXGv1eY1SnXEhAoBkpO0V7ooH
	APhV5tqerk+h6l0F2wj2lfVibyRwMSuFI5maPB5hswYNYFaokVkgH8pnsneLsMHFFfVcZQhHCSd
	6qSoiBo
X-Google-Smtp-Source: AGHT+IHKOjN/sac0fVVUzXU6SWIDaibaKPn5EMHPr4B2QK4ix+5qA6E1C5pV5zapc/cBUs3NTC3X0j1Puzdh+W5+uro=
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-4555f89f507mr181921355e9.10.1752565427632; Tue, 15 Jul 2025
 00:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714124637.1905722-1-aliceryhl@google.com>
In-Reply-To: <20250714124637.1905722-1-aliceryhl@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 09:43:35 +0200
X-Gm-Features: Ac12FXxKYM27WKloFSX7QfkGMGrcwA4IyJa2dCd9Yy0ZhdKGcFXHCyK325MyFag
Message-ID: <CAH5fLgh=kGj2shvChkPD4LHyHrmJ7ZCeWVpM-ZE3dG5NRMLWXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: add Rust files to MAINTAINERS
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 2:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> These files are maintained by the VFS subsystem, thus add them to the
> relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> relevant changes.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> +F:     rust/kernel/fs.rs
> +F:     rust/kernel/fs/
> +F:     rust/kernel/seq_file.rs

I guess we may also want to include rust/kernel/sync/poll.rs ?

Alice

