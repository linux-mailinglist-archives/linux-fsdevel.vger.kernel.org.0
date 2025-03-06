Return-Path: <linux-fsdevel+bounces-43382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6704A556C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0C7189078D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFE026989C;
	Thu,  6 Mar 2025 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuv8V1ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15391A2567;
	Thu,  6 Mar 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289637; cv=none; b=Z6i0LGdJ8AbaH1CF6hwe6+gqDYS2BxkMpHfrPTLfV3rSJVCqrVxkdD5quusB41TxeIWw6nxJzZjbHeAqWpykKKw8MB9wyq7hEhG0yM9CVyL8dIF20xb7JIrP1ovQandhSPTpoSmId7eChWUShiwX9j/q0mKYs9VSk+Rb/gZd8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289637; c=relaxed/simple;
	bh=g90aOnFrSeO2c3qSFIGztCZs1BE3D5b4awit5XcGjDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPWl82uSkElyIqg5DNnpLc3PFOkploay/WCgSvNcWfzLB5nzmA+DlEVHWFWtP3nUhbvdwakgXExPKsvkVokYEqkVh4jZQ8wwG51BC3M6ao2zbRJwwUm13nwV/xMQRZXk4dAtBmDeBdA4eFf5HUCwceK4KXXaQC3M8d/vQVJTDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xuv8V1ts; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff66327419so267529a91.1;
        Thu, 06 Mar 2025 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289635; x=1741894435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g90aOnFrSeO2c3qSFIGztCZs1BE3D5b4awit5XcGjDM=;
        b=Xuv8V1tsHwnKnGpbT8/LE6O9kMk1hYcXvcQWhdlVGAhioXdXx+ttlg9kNyXs3K8mdf
         sG2o5u7yqKOo1w4MCgVJa9a1VHmlxU8qL/UlhuAU9//TQI0/rx1541K5QiDd7+DQsCqL
         6HJhAZIxnA0eatnWjkKKnNX2odvE+CgZPICDSCCZIrr/oqQ/isEnzrivvkCIKuCIq7Nl
         zolBpZrB6kRmGiEbJaqKmlYvDkBwoAxfOExhgNtJW9L5vNT7u3Fyfrw/aeQch45UGZhc
         XA+8kBcQiV6+y2vFa14XOMqSjzizWueqCgA0ybe70nuCYbdw7OO8vw694Nm2y+BDJOve
         N1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289635; x=1741894435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g90aOnFrSeO2c3qSFIGztCZs1BE3D5b4awit5XcGjDM=;
        b=N/1bEz0GtJImRCt4iVPjnp3es/hSHd+iuBnU1MxFHkdd6EgsM4OrgvxvRozHiZks9i
         qNx7tgSRIvlCM12e8morsnvk2pVw6LXWQHk0xo/551Q7I5b1Rk8E/E/HyFI6yT5pn5BP
         h7awoSoP2ENMrpXEf1Z+p7bTZNUhAw42A1xY3iAoZd/6SDZxiIxTKCgrrZkbFRGEHBUz
         8ubkFZpKF/Oa+ZZeZaKVpLcowOAF8RLRxhLGGfod6tvKU0dDW0k9Se6fED0/i9+yNvo6
         JBST7TrWHUJG/fSTdFszbBVkOdlICCRMY6wzOFH51tAgiCiy3qS+0r1+XIZVrX0Ev2a/
         V8DA==
X-Forwarded-Encrypted: i=1; AJvYcCUVisvQi58S/vkcG3HVjXpKCwLYotm2EK3gH1Cz43399GpCTMzo4X9NJbIx9GFsVhGh35Yu6bG8HNWlYepW@vger.kernel.org, AJvYcCVJ9/4RWpeYlPIi+J+pxKvCbRBt2Y0nOTARsDsENQReuT6qhCzFWxZlkA07Sz+ZkjOio/13OO3KClVnuB5GqW4=@vger.kernel.org, AJvYcCVwe1TWHsEEbJRtQbdNMBrBiTKdVVn8SYekDjRee1uG82tvXl9t/ByiFmPNHRh95Mq8Kkyed98LToaVokRZ@vger.kernel.org, AJvYcCXGHaLgfS421OM5i4siv0w32lUtv5/E+qSD8FV232ZQjhEPj68IrMZhViYuyR1lOWgqAHKPIn8kNp5m@vger.kernel.org
X-Gm-Message-State: AOJu0YxkpVUrqQIfK9F0DleA8KV1hgcZxsvpHodxOFDYXVgw0fNfR1fQ
	/vRraa5nuRdFIKGsqSqkibMtcodAPmXqZMCdGhmn9ROkPmtmxV+0AcPFww/F95bFShRCB5YUuyA
	gQNSeVa3bmhD15pWxQMYuqj6rIMg=
X-Gm-Gg: ASbGncus19fdRBwbXfQKIqvtJM/ZZZAyQfvb3fYcWFqjFDUpA6q2z+sEEurGiurz0bo
	7vDGE74pNJ6gR/8eXUCwiqTYxha22SstoiJPXToYetugmWauX2L0WmzzPi8psejhm63yIkkz7nw
	5rlYszWj8iQTpk4/RWAvzb5U8dbw==
X-Google-Smtp-Source: AGHT+IF7ki/eNUJhDYP6E+yx3sKJSEdrIY384ifuAyFnKZ9e8rrgUtwTowUoW3Ppb7191vgZ+fBfL0QJpCKGDtkIWdQ=
X-Received: by 2002:a17:90b:1b4d:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-2ff7cd56dd4mr302543a91.0.1741289635093; Thu, 06 Mar 2025
 11:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 20:33:41 +0100
X-Gm-Features: AQ5f1JoXTlg1G4Hu_sowYHOIeywsQ-uh9YmfR7lco01eowaTB9vU1v0OZ30vYJk
Message-ID: <CANiq72nwLsY5k7y4CpAR1GgHHqyTve63pG3opMZr+XF=qzNNMg@mail.gmail.com>
Subject: Re: [PATCH v18 0/3] rust: xarray: Add a minimal abstraction for XArray
To: Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:27=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is a reimagining relative to earlier versions[0] by Asahi Lina and
> Ma=C3=ADra Canal.
>
> It is needed to support rust-binder, though this version only provides
> enough machinery to support rnull.

Willy: any objection from us taking this through the Rust tree, or do
you want to take it through yours?

If we don't hear anything, we will try to get this into 6.16, i.e. not
for this merge window but for the next.

Thanks!

Cheers,
Miguel

