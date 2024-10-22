Return-Path: <linux-fsdevel+bounces-32585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B649AA2DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4819B22702
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970A19E96B;
	Tue, 22 Oct 2024 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqwdd9/s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AC19C57F
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602975; cv=none; b=ZcrndhdcoO6E70FBYb4WujYW48i1V8F4NvBNGKGUmxxkuiNRoWATXts63srXPfDUYM68E/VuuAy5RifJbYgTOijKrCHWyYoi4xv8kExJFHUnSx9FmIxyDcXRA5o6nTmcfNPECiSZK3aya8TQ9Ob74vyODL8Zv81qHU5w6XtwSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602975; c=relaxed/simple;
	bh=an2fgpEHPgFu2bbjwUVyykvh8oENlVpHOZcpO5yq0uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWLVBMdZRattesMSVQxiJ3qTPALtIQJOEtzYFBHhYe5b2a143l/m0wbTXmQ/QpbCSQh/hh9IyJ+wWTaE8m8ti170HeQcBe57ENJW2pW7JNe5F9osYNUUu1tN+7e/hCUtnpuSgF0Qlbb2vi0W/JMMUKdu2hI5kDkEOEZJniKYDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqwdd9/s; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d3ecad390so4785375f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729602972; x=1730207772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw05C4LIcfbHmLjgP4I0kCt4vdOINYRK7YS+ZwSWoE4=;
        b=dqwdd9/sru63tKfZ+6R5zE6ZnR4yB6HPoyNtJDzGFdmDhMMxrN/C8rL/K5yENnQeNT
         jd5aEenyBHR4lmeGa6cyvMI1nYyHdEeEA09tRfywRl8VXNju0g1MDtSEeXyChESvHwle
         s+Yfyx9P92pHQ9z7VNbGyztVUy7ZTqG26rCTSDX9TItjMugzWEnjqpcNOEKxV62QtI58
         03Z3h715MPtT/MxzwazDNmjIh8AIBMStEyKPktzl5W+73m1EsuunAgNC0jwY0ThcWgAW
         BC7/2VDBYee8YgcpEq2TsgVfInjfbThcYy3QZw2iYgSG+BsWgr9JIb9JQSzPCUpaYtMH
         6pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602972; x=1730207772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw05C4LIcfbHmLjgP4I0kCt4vdOINYRK7YS+ZwSWoE4=;
        b=fQlcn2xo7rwfdwweMgGtJlR6Da8wEbe0xilt+O9hwAp0HPtJcfEm4wRyaHrCnNZTFb
         tQq6RnvJYqaUsZsBjDbFpdeh58+mYfi/uZlefiqmQTHLSWyXg855LuLXVJ+g5jkLL4D5
         n6/i3/AsuVTX6lTWePLS+wvbv0J60H/J4j0lTG1crsapML1ehcz/mEV0ouCQ3XMs0SiG
         hn6x0JfTYzjLvkZyAbt/+brUWTvuasN8gVkKFG/3kNYGX1Uyv+XMNR1wUYB28viziyl8
         DrKWKlGK8kldIw+d3P7uHUB7sYPck6hle7d/suhYSOcjdoqdpT4jl9o5FY9WhCuta6A0
         IFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/tD82X929sw27VWwN1gSPbm9qF1+WuByd7Htr6JCM1RqEeOQeDn4sDoKnSrM9RwcNEPfqOGLkoavzOLFV@vger.kernel.org
X-Gm-Message-State: AOJu0YzErHWs9ZMAi7mJkQdHMfVB2zGJakQQYEnHQvM+bR8n8iabNvX1
	Za2lW9OhBcICNXNxizDZXqnGY/al5SdwZcR/cNynIV8ozn5jsa8Q5xO9jksE4os+hmVEZSeVggx
	EvL/qJwGh6EmYprYHZyg91MA8YSXVd7d3Cqp3
X-Google-Smtp-Source: AGHT+IHgqiuJFEU7vtl2SnJqoDn/HNwk3Io65wBFJrGlF7dpeonK0ePJNTKvzfJF8k8z0iTM0280y4VenZXGzuWqUqI=
X-Received: by 2002:adf:e44b:0:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-37ef14e5cf5mr1963851f8f.23.1729602972010; Tue, 22 Oct 2024
 06:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <CANiq72kOs6vPDUzZttQNqePFHphCQ30iVmZ5MO7eCJfPG==Vzg@mail.gmail.com>
In-Reply-To: <CANiq72kOs6vPDUzZttQNqePFHphCQ30iVmZ5MO7eCJfPG==Vzg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 22 Oct 2024 15:15:59 +0200
Message-ID: <CAH5fLghub3KcFKg5Q-4yvNp6pRjPgO=c2r_yp+YR-U2b2FRpYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:34=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Alice, Greg,
>
> On Tue, Oct 1, 2024 at 10:23=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > +            compat_ioctl: if T::HAS_COMPAT_IOCTL {
> > +                Some(fops_compat_ioctl::<T>)
> > +            } else if T::HAS_IOCTL {
> > +                Some(bindings::compat_ptr_ioctl)
> > +            } else {
> > +                None
> > +            },
> > +            ..unsafe { MaybeUninit::zeroed().assume_init() }
>
> With the lints series queued for the next cycle, Clippy spots the
> missing `// SAFETY` comment here...
>
> > +unsafe extern "C" fn fops_open<T: MiscDevice>(
> > +    inode: *mut bindings::inode,
> > +    file: *mut bindings::file,
> > +) -> c_int {
>
> ...as well as the missing `# Safety` section for each of these.
>
> It can be seen in e.g. today's -next.
>
> I hope that helps!

I sent https://lore.kernel.org/all/20241022-miscdevice-unsafe-warn-fix-v1-1=
-a78fde1740d6@google.com/

Thanks!
Alice

