Return-Path: <linux-fsdevel+bounces-66503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7447C214DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509C31A66A5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7E33655EC;
	Thu, 30 Oct 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlMB7Dxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA32EDD50
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843019; cv=none; b=GkXEza+oAgXmXO7Jj+zM6m7wIPFuT0J2J2aA2E/VwROtSXE4JUiO0Me4B8ycxIkVKk5Wg0teCZDTCer3VjXK9z1GQdGQj7ccvfao3Cbgf8ACl6o0BTlVsWtNC19LLfNebVjJzLckD+dTds1w+LYAuhaL1PvAaJlAjhShua9xzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843019; c=relaxed/simple;
	bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkK9bBZIfws9okvRrc5KulOB0rXMEA7EW3qBeh2uZEwpZSs/7ra/MDdDOHeFb/oFeWh/UjCHK4oihE29zDHLF05AsMUBlQpuGB4IwgnkTEpQ9miesFwRgsI+Gao23QkX0decip4gfNhWGthDWSbMYrz8dsGAw5Hb16w97eBvfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlMB7Dxw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26987b80720so1710065ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843017; x=1762447817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=QlMB7Dxw+aVrAdbSUWU0bipn23Xfve7pppXiQG79QFpCrpXyoMO8KZBNoq7a1rtmbS
         4gxFGT15a65Fa8TM8upk3VOQqJZ5+VbO7fjKGR8abQX3rkTCSXPaP1yOnflhCMKpEgcO
         +3cy3G2+WLq6HNbhVZHDlbKmvgZoXkttFBiI1iBPqSF4RVCgoFK3Svji5aq7nLJBixog
         Qg6bDb6tpIU7GTKMq+Y0EHmyfgfwhq3mzPbmmjNlXw23muzhxx7hGoalRFR2UQShT5oY
         DTuB+/obSiIxwhudLi7GcUKBacHSmw/s5yKkiN+NVzuBoBzVyDMFb6ZQSdxvPFOE3n5C
         AreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843017; x=1762447817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=OulU6+QVBddfcsNn9S35GQDyJiY5Z7LTi6XXMCEma3xggZnzGlClP0mp+kFUcBY0kv
         ZH7NsE+oJQ8ItdUbvdVBBlHEjXy/+2zPAwEiUMvq70nGT1rrxVfxI0jNh7atolKAk4vl
         h4+pDx4N5Sn2KTlMXz9MZQaxMHH5oBc5BCwoU3AFQNaKuqHMj0c32DRnsFHlOA+/gvnl
         5RlYiI/IEhe4Jjp1RbhOAB65GO6vTnZj5QHNDMj7SQ246ys/SzRiySMRBHPi0fjbjres
         cOTrbv1CRkq41ogfK7giJ5lMXZLXszxJpwXffmTTOWXGvIuTmCy1dntClnxic6fnx3cG
         6HJA==
X-Forwarded-Encrypted: i=1; AJvYcCUmkA2QO9d9xANz+lpkdVxuVj6RiE/HPZBLYxmebgZGcENdmJbMc/BjDdgtFGYzBdN0cEgjlNVYnjOgHxXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+ANvPP7uY8OOZ/dhLo3KRGc2dJzwqBquS1FOcSz3OBBRNHYv
	lwjd2t3V+Can78dFWtYI27OKosusCSOavndBzNbCiA41miKrawiZDLmsebddkS/T8gK98WCSVeH
	g8bjPAL5Qy1x+TuqmpVTODB5hCgBCNIk=
X-Gm-Gg: ASbGnctg64pxFaRcymCBcT6sJ38Cei/yhaSGpoVSfKNAEQRzKj2DFH6mG3XlXFwxYmo
	y0MhntjOcOZX7eWbVFGEf1Y265Gt0ZJ+07E+oFT3ZqXYy5xLGhOsisychDEF4l2R8HanXpLwW96
	OkNAkPzZOA0At9uovH7cD0ImYsAYcm/Gd1j6KbAS7MNpbDp15wU1EK9bimquF6zIG+Yjl3se7Hk
	pBEnfaSqo+8oMTv7lHoPGDcbDQ4xHCDHUuYzqXIuNwqZgyXh+zbbfDE+AQ7hUMBjK4Vvo3iArjd
	FCdocFgFAO8eaxqRNg3WsFb6oBbTSvuIWA4pdB8wraIWSfJkyKPwGjwIB+SGyG2lJv2hKyu8VYk
	/cvQ=
X-Google-Smtp-Source: AGHT+IHIwOHRSXqelvV1Sdf63ytImuxsi6mN867ttFRk6bB9U4Bt6FvCqQWaRN3cWMuEbnRRwlVbLx8M4DZOhZxBczg=
X-Received: by 2002:a17:903:234e:b0:294:b58e:6580 with SMTP id
 d9443c01a7336-2951a545f7fmr2497775ad.10.1761843017022; Thu, 30 Oct 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me> <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
 <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 17:50:04 +0100
X-Gm-Features: AWmQ_bkaCQLlBdplFGaXs_s6rBEi5hnyY5mzRPNbjRg2sfBfQKwQOTLK3O0jQnQ
Message-ID: <CANiq72kuRNvovHK5r24kh23mo5wp2bpx-EjGMOyNBOF1YzukvA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Since this patch touches so many moving parts of the rust tree, it is
> going to be a cat and mouse game regarding rebasing this thing. It also
> touches a lot if peoples code. I am not sure how something like this
> would merge. Do we need ACK from everyone @Miguel?

Yeah, any rename (or generally namespace/path change) is always
painful due to the flag day change, and thus ideally best avoided if
there is a practical way to do so (e.g. keeping the old name for a
while).

And, yeah, treewide changes generally need Acked-by's from the
relevant maintainers.

Cheers,
Miguel

