Return-Path: <linux-fsdevel+bounces-61708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F3B59220
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48C77A249E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3599229BDBA;
	Tue, 16 Sep 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT0RQQsl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACEC29ACEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014751; cv=none; b=kYRSf7eEzOZTScTX/6aQzv/yefgFzvpstScc4b9HL+qrgv3F4UXMx17tkgFnJsJE8KWVj91P+WDm7FjAhIwlpEj7nOoAx9EX2rhD8vBIRdFeaAdTzJ7oWxoy9AXaV0kNbYw/m91FPG/51OERjLirZR7C/8RDGGsmCpQnxr+/JHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014751; c=relaxed/simple;
	bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6jpUPzBN8tgrDWLzkV7CbxtmOTu/KAxgHvB8ix4SfzfQ18COoGbwu0jCmmIDY36oKmYVVUXMMdNCa1Jtz96odEuQ5SBphr2PF4Ey6UTCteThfASwXpP7SKZkR9Tb4YTTStkO6qngRLrUK5dY3Zei6lCK+HaiNFJMyCGyVmD4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT0RQQsl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-265f97930baso3460115ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 02:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014749; x=1758619549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
        b=dT0RQQsl5eje7hoAfPCSV5cH16kUHaJsx/OLYQ/4UzEfSN5Y7zVtlbkRz38i+Xbdee
         ftV8068+/eTu47ZV4UFRTANTk2T1XfHXjxJTIa0t05FXfRgE+tBsuDLPTu5TsoE4qzUS
         3tvyTT7vdyW07G73hn/lXzEg9dVEZVWHxjNicVgfiFH3pOXlNuCSGg6G3OGhK84h4a8/
         B7ZPZCgRC/ibUw7LFO+MNHq7Kbm0a2IxPUI1boPQHV1gv9CChl+FYUbENeWRVOPOasTm
         mgstynIf5MNv6meFrxVsuCenfl9kWH8u7oPbimZaG8ARLrYrfuTvPN43mKhAdnfvq+8f
         HbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014749; x=1758619549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaRryEebvbTqiupWQqjYkSHOIl894hb08zd2AGUVKwQ=;
        b=WLcZ2imB4Y5l+krTNEHK9u0jtjB1ipjFYlPCDTN30FHG73WepBVqFvD3tmi521J8em
         a4VSWKCBYw2oYdDOTXcR9oYq4ZmMAInJewweZugh3yKrZpcSLmNWVvK7mZkBWf4oYmfY
         1VsBrkhczpboufDcJpR7k5XDLOJjiaT3/g7bZUVnYw9O/nUP2obbZPhIuTxY2ZTfKjOT
         irR52GSVI23BmuV8rDcQE/2mdxeIa27PLAmHuvNa3rbrYgVsVsgkzOze0OyvHZ/Xui0A
         9ANxfAu3Y9V4ls2C2nlHUpBDbGbffp+9yLP6+4Ez7vNa3xA8bg6Xaa0jn4Z5LoGwadrp
         57Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUPAeoFEChM277J/M2JKakjjsQXnPLIF4w/OGJH2SUtagoznS7I8QyBnQnq+U4cfH0p2QHXRP80RdBXJw+H@vger.kernel.org
X-Gm-Message-State: AOJu0YybUaKiqLlE8TMPhCFauOyCLBg2SoiVC5BT9m2oOQ6ONrY8Wh1L
	EyfvtCwOEY2MrF9rUScz9n3+TrIddrJzu1Ljgm88U2UXp6ByWpsv7dH5tBkQQySoc36wwYfX9r2
	kYycUXarrSfdswXhpEU2Mbaz48gBKhFM=
X-Gm-Gg: ASbGnctc8oo9ZX4CQ/J86gJOSdbL9uPZRbKVbQFBtelfiBZBwYcd5tSzRVoBI58Vapl
	J3FTGyzLyWcTtiVg63IR3b6bRmb79OA1gJwMb/l852hMTtlROicl/LBFZL3VT8OT+a5P0B4FY7f
	8A93OmYdru4w3XIJfq/4Mghrb0g7xticTPFgnBqm4Pzp85O/3M7sfq0ovLLJQBK2/Ju+4AS/ZOY
	+GzSioFqg05szjUykEteLP/7/9pXBlMNdH/nDxN0aI5TZmOJGhCZW9kOBrATtmSC4fHvARGt30+
	egCpIQf1etZGrHibNsQIr334QA==
X-Google-Smtp-Source: AGHT+IFbZW+x9x9wRPjcu0fUDKKV+FI4Ux2olLrfd71XqGlZeb06RKz20GRATJ3RhC04PqeZ4amtqqROnzbUAvJFtis=
X-Received: by 2002:a17:903:234e:b0:267:b357:b63f with SMTP id
 d9443c01a7336-267b357ba4cmr28322155ad.11.1758014749004; Tue, 16 Sep 2025
 02:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-a15eca059c51@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 11:25:35 +0200
X-Gm-Features: AS18NWBte47JR71hFkT2j6pdf07EXnpt9Cw80lEcllpwl7SjI3e6diSfmzb9hqQ
Message-ID: <CANiq72mrY92-msShBgiqqRpewiTqLANb-uH8+nPfAqKivCWjUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
To: Tamir Duberstein <tamird@gmail.com>
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
	Uladzislau Rezki <urezki@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:39=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is series 2a/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

If any maintainer has a problem with this, please shout.

Cheers,
Miguel

