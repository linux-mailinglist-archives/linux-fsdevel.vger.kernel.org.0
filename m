Return-Path: <linux-fsdevel+bounces-55621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1648B0CC8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 23:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062DA3AFFF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26223241131;
	Mon, 21 Jul 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PE+R3/tZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F061917F1;
	Mon, 21 Jul 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133100; cv=none; b=Q5TXlYnoz9pg7kFa1PqzcY91cnRAKCml45t2/VmftJmQUJdotHJro1ncUl3T7kyJ3bWImhUWhu1gsUBBGZTIx/s+BRLGYnAlKGpAe34qLE06KJ8lRXXklJX2ICAropctigXgrrFXt1R8URaVrY8Xf1s6O/Okdyj3EFu91rDyCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133100; c=relaxed/simple;
	bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tex1Krzbcl1AgggMjridpPxPZoV7XPq1Zu9Y8rko5AdhpHcPAWiUmddUG29oE/1sSO9Hi1I+6NfYTVVsNpoUxDjn34nm6SsT3ChmcddcuhGE14z4XY//le4Mabc6UQSmJzjNTI1lwbS854eoXFZVBphm/SQVY3mXmzZTV1daVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PE+R3/tZ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313067339e9so942416a91.2;
        Mon, 21 Jul 2025 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133098; x=1753737898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
        b=PE+R3/tZyqhwQOlpgSV33dTVqT3DNpgMpvaAAz0gvK5oHFZy09B7AMl4fKI3XfX0y2
         pvUTYY5zQZNdK4lx3oP0s+7hGu5Wk53G0MEo6MLrp/VZ+F6H02/Il3QWJaKoTM1BYTR+
         cuO/1SWyusGvXWxIdAqB6ebecanLRMu8tMq/1CXQfnUbIOPurPiIAi7x73W+QNGkMk4q
         6XJHqDut0JkEqwhaCFkT051oZZuKlKJgBsJr3L7GiWNi+S/fhDlja2pVUYRrXNHKqHVe
         6S0XanLh9ufpbNVTxrl/s2/qu4mXAbb/0+HsrqGl0fKtf2+ewp+rlDTYekQXQbuBlm1r
         rzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133098; x=1753737898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iFLdp2ndiNM8RNps+ppve+VMxv1HIOTDVN1LN5NGOw=;
        b=RTMDhW9UTFfCI3JMQbaKvs6FjD6QVkWJF5rGMkpWZq4vP928Gpgggv7Wzt9AkosGQN
         2RBHCTtPnKAhQfWZjur61Aqj4gUTggDIUQQ9xQTXrG2crFpob7dm5dZ7rou3yPTj3HJR
         optRPm9HWOkTexeuarLsAmUqeblzpE2ezW80DmofTTfPpHw75xICH2xYN1zP1xQyzIiU
         DuQt11iJtUyMJs2wfYG/6U/jg58g62ulm5UAhm4NrjpjInnZMYRbid0CVdPOUslrKXqQ
         Whc+ofYsv94J+YsYcWag6O4ny2w/I/yre0fEh8vFr1PeXXA8kDAlr7KVJEAk0O8hpwqu
         g5VA==
X-Forwarded-Encrypted: i=1; AJvYcCUhU48E7cbg/BF8X6CzfWSroPRFiBqNmIKY9+jXgERrVkcs5F+G5LlR4s464BszqmCu4HYyk/HWpzJlR7JZq9s8@vger.kernel.org, AJvYcCViublJbrU5hEBVk9puwLMCHbSPcHND/wyZ+IbyJY6NzDPLqsHPJdth9Sz60Lhj8NWyWFgD2YsYZmY+ppt4ZQ==@vger.kernel.org, AJvYcCVkYmTiTLBJ3XSkFR769lo4nvKsbCxBlwUbkWq85XBybLjApMaM0hz/56CEXoyk4r41WxuyOLsaPhzQMQ==@vger.kernel.org, AJvYcCX28vXVjVz19S3jlNfXZODsT6Im651v++BuCLcGS0AFT0H/e/o5mRS8rwEm0+DcN885xTeFQMZ2G4LQ5QXJnrk=@vger.kernel.org, AJvYcCXaL3xjfr+/ii+Z7TcLAS/f0eYytY3T4cgbG2zTeZZO8lEbL4uThzGuCMBUFAShnypcUgwH32LuKsV/CoN3@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQcYUDRuJlkDyaXvJ9lYZzT8ZAAatS8OfiOLy459fijsaWdpd
	4Jmas12eo+TS0WRhLhhubhDxswGxCHtErOlrJPNleZA1+bgIFjOhllhMcj6j4cz5DfY0ULf7X+m
	0hOFuuOBmMfWotk32Z8njepHM+RuWtsw=
X-Gm-Gg: ASbGnctQS5e/AYhaXMjk0TBoBOIuoyLXk7GKJcFe6LgWt1ozpXkDMjRX4M+ov/vhWxC
	1BZ2h85sJAfOvvHfA02mklKSktT94RmyPnB2LyGtXFkqaH8D15dVQfQ/Sf5sR5awpphD4wunKGB
	Bgr+cT701Fj2xMxOAp5JT8QguOwtUnQNPNNwSKiVlYXBYKe8cyf4oBEWb8L66m0NM5qW81ysyya
	rL0kmTK
X-Google-Smtp-Source: AGHT+IE0OY7j57nPCKJ0BdsYahqNyN4nWsTb/RzoD5KDOD/WbbJfSbNPT9Nrk4IsCyqaxcHOFNn3XGvOFDRdAz5jjUw=
X-Received: by 2002:a17:90b:1cc3:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-31c9e7767fbmr12172720a91.5.1753133098418; Mon, 21 Jul 2025
 14:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com> <20250719-core-cstr-fanout-1-v2-5-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-5-1ab5ba189c6e@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 23:24:45 +0200
X-Gm-Features: Ac12FXyOfRpHyH2Hg4yjOdknVbhdKtQMd07LdKW2ll06eE6NGx73z6HhQYfeb4A
Message-ID: <CANiq72=wxjOwpbSKvmRV4Nb1Na_fsvajGYCbaiCdD7NwZkgc7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] rust: file: use `kernel::{fmt,prelude::fmt!}`
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

