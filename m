Return-Path: <linux-fsdevel+bounces-72535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E3CFA760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8092A340AA9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879B361DC6;
	Tue,  6 Jan 2026 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9dMYRvs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA7361DB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723014; cv=none; b=IUsUvg30Hu1qaFxq0d3xOS4beIHBxoxZ9zXgXUuhlesNsGbZuavwo/BSlNFT1gmrDmzphDZDm6V9ePVX2ZMRaNgVTcxhGlsBLXYEOsDz6VHMThDkwRMiaKR9yDub4k+QHXXCvC0DU6WWFKHHiNZKhzh+R0nQim6Z/95+P3G863s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723014; c=relaxed/simple;
	bh=FA5K1h59DamYmHfd/3KzrftMB3SlzXiq6xZrqAtXpUY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qb8bB8NThPgMs21mYCXNd3wY5tuipwhjwgh9M0grlOVm7vXTlWbVYXD1bl80KKaVTPOKvalQugQiwbVb4GkPC6/nIGCOcRSQfWhKQg+B/0F2FJaS3zUreeG9n+8Ae4GyifDvjiZD5BGXjY4OhhmKjPMP90/JoYbzEW0bDU0dWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9dMYRvs; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-559934e34bcso396996e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767723012; x=1768327812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FA5K1h59DamYmHfd/3KzrftMB3SlzXiq6xZrqAtXpUY=;
        b=W9dMYRvsvPwdGns0U+luJdewM1L8cdAuYRl8upNWUEI/a6yoQSaJDrUcc5ah9e6Sg6
         SZoYuoBNbWApAm5khR/vExg9NUTP7YPnE1kmz/NN7Vn5ckBeVAnijAAst1MukfkcDumP
         Bi/3JvyADxr+vwCEnCfT+i4qu37/nBq7qcRC5O8kYZfNitY7vN2SC21bsX85jSHzqLwv
         TJXuggUnOpQ3tYu8/+qoiRhP3Fld8SV7gomzatsky4CnRREsK1SQAqG49ieZfz+ek5+O
         RYa0IiCrBv0RmpBUQ8cYSiDPY6zaQaIgmMH+laI5YtJm6yOBnRBVnQFA2tu7Sh7qisuU
         o3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767723012; x=1768327812;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA5K1h59DamYmHfd/3KzrftMB3SlzXiq6xZrqAtXpUY=;
        b=w6HStnh9grFJwOu6YNshb4FZCubOXESNc+d6wiG1E7MegeomfDLZNxxS0KKAFkf6Fs
         ZMPCK3Tx5gWG1leQk3XuuzPZi594GrfVVZokOE6jX1sgfI7SGxVu5QmB2kOsub7Xts1H
         4rqjwNnHro74DpAD1eC4/6hWxVP7BYqwCKCWLyjs/H3i4Ycilo6X8/UMcyRYQSUFJpQJ
         XNdMmgqd4gc5686+7EZA6zh4ejDwzjWHswYeUX4t0awjANvgeQSn4F8h/2xEmKH2Cgl1
         y/+OhrGiGew7DThhQ0o4Xh5Z3l8ApdiGXn89FeG4lX42Dbljt9bCPH8OFOezztKRr3GR
         7A7A==
X-Forwarded-Encrypted: i=1; AJvYcCX3UC6nlNh1ypQR/AbNHaBvrxRy+EmIZnyyU9K9b5XHJm9HzxTzyvTEgnMDb84f2HB9GFCIUf5n2rhYS6xo@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQZMPvnp8o8GHs4RWCuraXWKbipIPIRZQZScqZ4ILdvIz1z1R
	I61uLwT59QunZyaqJ614XS1Ho7H3JKe7O79gPfX+Oo7TkNZKFfbpuo0jxJAeHYmOOv59fiG9kY/
	mKDc8mO/iSPBUs9pTLsFuyFtT/tbeo9c=
X-Gm-Gg: AY/fxX4jw9dMGT9eVMlEQb8qXY/KKi2fELEaraCZh0N+BGptS/fjzgbRWvmTpLed79G
	R3kEoAX4WKN4KCieWmSH7mNv8sihoEvh2h2a20PNE/D7hoYk2nhGG2p+MNMcLXg/6JgHp7r8V+F
	OesswAvdW8vO/3rIUJIIjj5b4pRfXzX525my8Ddoez7+XAR2nmPiAAv/SzsjDD8yUMthWzZ9G+A
	S5KehY5Yx1lmD8hwcl2ojKbd63OkMa93DWR7E++McsY6B9hH5ahezzphyxOqCHp/u98yg9fE0pz
	4JJknOIFiZuQfhZrG5Cy6I6eA3o4kvC3a7a2iF7Q+Wmf6A+3Bl7zsdq0GNZZLE/YmrMxvw==
X-Google-Smtp-Source: AGHT+IEzM6uzsby5xONrmyvo79KKv1khmsEtcrKCNxTZYO6PGVmqS5XUVYGCBnifuoNVlHpFc1b1YTr3dML32FKLJb0=
X-Received: by 2002:a05:6122:4588:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-5633961d29emr1258483e0c.19.1767723011623; Tue, 06 Jan 2026
 10:10:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jubilee Young <workingjubilee@gmail.com>
Date: Tue, 6 Jan 2026 10:10:00 -0800
X-Gm-Features: AQt7F2p086qc5pwBemh62_ewB14pkoVXXEKa-ORCn_rynkROkTW0RdWFPTK7cp8
Message-ID: <CAPNHn3o4hKBf-BSNxRzsboYifWL-3ULwxGCOBhZ-r_5g-oKzTQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
To: peterz@infradead.org
Cc: a.hindborg@kernel.org, Alice Ryhl <aliceryhl@google.com>, anna-maria@linutronix.de, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, brauner@kernel.org, catalin.marinas@arm.com, 
	dakr@kernel.org, frederic@kernel.org, fujita.tomonori@gmail.com, 
	Gary Guo <gary@garyguo.net>, jack@suse.cz, jstultz@google.com, linmag7@gmail.com, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lossin@kernel.org, lyude@redhat.com, mark.rutland@arm.com, 
	Matt Turner <mattst88@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, richard.henderson@linaro.org, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, viro@zeniv.linux.org.uk, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Can you cite a practical, real-world example of a target where this is the case?
And is this a target that the Linux community has a strong consensus
it should support?
Would it be able to boot with the existing Linux codebase? Could it
then run software?
For example, plug in a USB device and pull images that were written by
another machine?

Jubilee
Rust compiler team member

