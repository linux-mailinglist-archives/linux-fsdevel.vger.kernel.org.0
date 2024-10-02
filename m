Return-Path: <linux-fsdevel+bounces-30670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56998D210
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B12F2815C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 11:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8D1EBFFC;
	Wed,  2 Oct 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9gygmqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002219D07D;
	Wed,  2 Oct 2024 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867542; cv=none; b=KpU44n3rBrBTS2s4ZRaiayM38f/JCEAueUIFdMR94/nuXlydKoOlN1cFr0iSnopW9ckdilsuvRySpt3779Se00tkgd1LyOhkLcL5fva1Ij7qDm0+CDjOKwSm3MCayQnLXlgkxbNGtm5OhtKAo3BmMROgUL13/SfPtd8ij4Ndr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867542; c=relaxed/simple;
	bh=5vN0FKCJY7Bs5943KeAecQOYX6VBY2Bk/nhQqeDuA88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMAtuDh/RayDsChLyWiE/3Gjcs7qV1ZYshkJP7HCjpLx0AQmINq1lueQU9/CAqEy8e4HcoT100khLUWHAvPxfu8x280DCeRrCwiGupl/CNlhtIO/HpaAHAEuVA2EbP5F/HIttn0Lw7MtUiJPcofsRHx7TT3El6dcPsACzxYjg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9gygmqK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7e9cbd25337so15696a12.3;
        Wed, 02 Oct 2024 04:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727867540; x=1728472340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB+nsD2+9MJf31TGlfwMYkDJKpDgVU8UBg71/5sugvU=;
        b=h9gygmqKJPSn7e3H1gcgzPN7xqBci0zaXKhmOkQWa521wFYzuNWX6N45HuBFg694MT
         IRmHhAae7mUE/xQb4ZkSTQDymTIpFtNWpZzmLI48sivQth+BV5Q4HJuIyTtzmzrKgO3u
         qWX7UPi7NlgrO/gSL7WWWjOy7pYkagVoGLeM71i054wMEEttmxZRimng2RxoH2zDAgCT
         Gf307HH3RBYfiC3DJoXCNIdm3+3rkn2IxqCd8Nuld7VlYcssEaZmsFfPvXyisen+PP5r
         VUo+EAYnoybrp7Teg1fDAYccPAaWSRrCagGzMJ6+nWxk0HZtHwb35rehTSdNVBqz/0Kj
         Twlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727867540; x=1728472340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qB+nsD2+9MJf31TGlfwMYkDJKpDgVU8UBg71/5sugvU=;
        b=KdpKGnqcZShGHgKR6uaM1IiNMgvcsPJ5J9vmCodwRjPQKRExr0sXm3dalZhm0XcRl1
         ieBd6kaQlR1MzIZAyCWZosLL6L3WhYzR61S0LUTWM3S6mik6A1HLKJQ0t7BSbZ2ULUEs
         7eqcSedF5lt/ilMwuGM2gV8v8fM9K3tV/CwM3hYlEry+9yVo6fByNdVXOe6YMzyS/Cd4
         yuGKe98OFe/nlf/G2p2v6EKdpZu/SgoGI2rWX9KbuPO1gCM/ZfOGf1n8voQZ3MpVUEU/
         ounZVWM726vw5e5Ia4eMCr2CwAF0POZcY5omLvDkmqF6+wYM8CdUWiLSuXj+C9SIU1Xl
         0I6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYtQ5a6x+mik6/yHe+aZL9l0DfeUVTpAW1rc3f9yZk6jovHyFDP9eomuzDVUXpjjaXf3c3r06KTR/XnuuJ@vger.kernel.org, AJvYcCUkGgKeYv2XoNI9NwTMQ1si6QGYu4cvo19GbzZJ4zQoTykvsumMnr4CG2i3WYx1Nw9+CZnBhuv6ttrqZFcMFWTroNiWggDr@vger.kernel.org, AJvYcCW3vaOxP1czwoxF7R9CxWTuISJ+m7zmxxbuhX1Sk9rdAt8es0yXqOOOGkUP5j3MHwaUyICjOw3DxZnFgv8t@vger.kernel.org, AJvYcCWjgMJuBFxV1M+RTZmHasHWn8q8FDA9IRXM7X+wsrvkVRaMBgMv5wVdpzgr9Eq5YAq5o+AwkxNJYf5IrmFQ0S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdfLb+lQCJOqZ7aj51C9H0qaYBHK7lzPS5HpqjEDHtDntkaQq
	HicHi+yZSJDAs6cibqRHJAIxtTUN6ImxQqNPDLGWiZvCnkFCZtcme6Iq8Fs02WBZLYy7oSyyAmD
	wyRfsvxfbyaM8tadBd1Er9ImE9c8=
X-Google-Smtp-Source: AGHT+IEXKjcRQAr6yvtLLxnWNOyfOQZWq0d5nh/tpvciPGIRYgaJQmd5wkvF2MSAYinYB41YBd77uXdWcoKxZKTZRjM=
X-Received: by 2002:a05:6a00:3920:b0:710:5243:4161 with SMTP id
 d2e1a72fcca58-71dc5d6026amr1827408b3a.5.1727867540474; Wed, 02 Oct 2024
 04:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-brauner-rust-pid_namespace-v4-1-d28045dc7348@kernel.org>
In-Reply-To: <20241002-brauner-rust-pid_namespace-v4-1-d28045dc7348@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Oct 2024 13:12:08 +0200
Message-ID: <CANiq72my2N41wRWGFpPhJk_zTTaLJcuvYFekWFyoWrhQRLEfDQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: add PidNamespace
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:00=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> +        let pidns =3D unsafe { bindings::task_active_pid_ns(Task::curren=
t_raw()) };

Missing `// SAFETY` -- I mention it since this will be a warning (thus
error in `WERROR`) soon.

> +        let ptr =3D unsafe { bindings::task_get_pid_ns(self.0.get()) };

Ditto.

> +            Some(pidns) =3D> unsafe { bindings::task_tgid_nr_ns(self.0.g=
et(), pidns.as_ptr()) },
> +            None =3D> unsafe { bindings::task_tgid_nr_ns(self.0.get(), p=
tr::null_mut()) },

Ditto.

Cheers,
Miguel

