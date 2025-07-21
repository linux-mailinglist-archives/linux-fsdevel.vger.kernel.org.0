Return-Path: <linux-fsdevel+bounces-55622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDAB0CC93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2435217006E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C8241670;
	Mon, 21 Jul 2025 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciXzeXz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE75123E358;
	Mon, 21 Jul 2025 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133124; cv=none; b=ZX2od0wc3TmOXeTiKUVn2wa+nzUE4CC04zG42H1Ptq1HOK9XURHWzn1VbtySvyEKc5eCHYnZS9ODqv/TGTL7gPm8ZA01/qVf8dT0qz9KkHct2zANJJwAopSDQJ5bnx26/JbVqOVvZyWl0zZph5Gh6XCK2HJsj8n2fsfArok/epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133124; c=relaxed/simple;
	bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP8BC0ISefFz18dxbfgONbDKvYC8D3+7Eg6Nmrh997pd2H9x4sxxbKnN0YVvZhsmQ0wSb5aNBVm3eLlGPmbfLVyJi2orjrscHaGvPu7iPWWvnTJnaUo3BM++ShGBik+gJsjKoa2dATnDgB72QPvLIMN83HnlBqYTFa2Y/ufrlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciXzeXz2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31308f52248so745603a91.2;
        Mon, 21 Jul 2025 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133122; x=1753737922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
        b=ciXzeXz2l5/LnMlD7TRQFXAcKOZDEBC1vSi1ho+XcqmJTYfXC7C7CzsU5FF/H2EBC0
         2SUQ7OOdz/LCyExlHVCk2BHMPrVKHQ6zfEHBN15dtTTGxZWPTruMGlVuOmkjd0skhY4M
         MjqqgT8ykTrlnvmZjiXTfsjbPwACLZMrEkMSIRaO4duQK1Xcazr5OcanxHmERLRHzV1V
         zPx4ZMNa3a7Jmc9RJGhbpthz1CMLEC99oK+6iAjZgwQVfIcySC70xAXrWsGBm+kw8l3j
         c6Dp5zwdTfHV6CmQc3BD4VEFdl+AJcOcSr+FPAt0rXBwh5ieWeQ76NhjZe4x+IJRIeGY
         bYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133122; x=1753737922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
        b=Bdq1PYXBpZBklcSS0K9GOccSa8heVq9av9ChBTRSIEAsEY0X8Rr2bvLbC0TmM00y9+
         khwMQrGS2idCrEsMgPxO9rTbusbte2B46P7HTimlRvFiToXScJAa9swtf+v8Tgr5CPRr
         Yr8WcBS8MU7zRqPubhA+KjI77+MkjqntwlyZiD9TwXXMaiajONmgkLOYgG9M4/6a//z6
         JxKUSFUTTE8F8JSWK0vgFrTRck1ln5pX3x9d0THVtYcw3Ms95h/LHuydj9qLyPT4BLwI
         sVjlaaAm2s5w3DO6R81WOImw1FPOZ8zplzdqJvW5Gc4qT3txaedcBcdY1AY4gwYEkhWb
         jiGw==
X-Forwarded-Encrypted: i=1; AJvYcCUyUIMQFviCy3OE/fpOBbvRIX+dPxIGBZ/k19Mogh3TFis/YYb1Y5A2GR9qKqw5PHgYmwjmLaMxI3MYCcYNa3c=@vger.kernel.org, AJvYcCXMJ2DZhXOcnn27KV43LMylnGKWXj11SHNaot3QNLi9Ce7b8LXAG4ig1DDp0yt5hfZMMHgqhRP+6JfQ0w==@vger.kernel.org, AJvYcCXSsCfiYjF5EpF/EOVFKie5ghEObYkw38n56vdwocnK9JcwehvhOE62FgCuDQZ531hEF9xJnI8zHwz31E24Vw==@vger.kernel.org, AJvYcCXlsvjc/Fsz21LzZTVdUDmKk1IkWNIuLm9GhAykp/T+VjWFgrzqBpSesYqqpp1HM958ooIWWgg+Z+J/UVz31xIK@vger.kernel.org, AJvYcCXrI8tuN+Vg6O1kMfcyLnLoHGHphEoTU1ykn/3AHFwh6NeGoAS3LrYi1K2FmTB16jt/ZwDHlJXEdqL6swLq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9yjiVolq0DzkADSTQJZF7PuuyriiZNBdMf01HBi54O0EwhTA
	o9kg7UpeHfZE4QAj9aXEvc/VekaGcU61gm7GFX6k1lKibCacDz3obg8rbQ6fER2mZbmSbsQmlVM
	SXMdS32ceQ4xY7vE4PRShOFyM/Nn46P8=
X-Gm-Gg: ASbGnctnFJmAdhypwX3spsJ3ey/E6TLG4Ud2E9IUB45IiBRpYnh2XAM/SHpYjIGKcrR
	BCZmeRYoplpfiIIlCtHvS1aZF4aHX0/WB4UF85UiRi1TFmq/OwAEqkHYzcR+Vt19wRD+IllGGcV
	QtJmW825Cr6CLFVL91qlMhQYM1ber6K9LS1Jq9c2atKG0fxSap6mpLeFFthlYklOI7hPnJsrmce
	4XGb8R+f55KIc4bd4s=
X-Google-Smtp-Source: AGHT+IGMwqakNKOUFXVAu2/3PXle8MucW9ApQqtEvS19+SeB54BAypNZzC2R/JPDOK0p7gPei/ELcvNLwjB5DUmNGHY=
X-Received: by 2002:a17:90b:4a85:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-31c9e7a47d2mr12006266a91.7.1753133122141; Mon, 21 Jul 2025
 14:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com> <20250719-core-cstr-fanout-1-v2-7-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-7-1ab5ba189c6e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 23:25:07 +0200
X-Gm-Features: Ac12FXx1fxLwm1B3q35hYDSm0FBUzbFOkBoCCwDTqVlcqaSOlmPogm9Pbry1ihw
Message-ID: <CANiq72nQT=uX4E997rVDOjNGzVbEx0_kqpa70OkAXPHy7bffSw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
To: Tamir Duberstein <tamird@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 12:42=E2=80=AFAM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

VFS should be Cc'd on this one, so doing so here.

Christian: I will eventually apply this series, so please let me know
if you are against this one (Acked-by's appreciated, of course),
thanks!

Cheers,
Miguel

