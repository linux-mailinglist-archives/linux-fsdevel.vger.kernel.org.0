Return-Path: <linux-fsdevel+bounces-65561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF7FC07A14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18525580074
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A1F347BBB;
	Fri, 24 Oct 2025 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9MoNn9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5B3451C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328953; cv=none; b=LUVxVooXerzkFe11wKqTNeyZxVZbd2CQswHEU8F+t79BKnd7N90JYQQWF354EJyNGaIivhIJxoYkzmQ5ykzgWL5f0iP56Aat8gOb95RIE+ebAv/6Oh0gi+f/1j8+7QI1GuDzGgGCUdcTHPcb4PtgrEYGfpXuzw1wmvSEKAlFbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328953; c=relaxed/simple;
	bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9MhP2ifDx878j6g3uBqzBEZhALCt9sgaMjQrZEXPpdg9CN4K9uOzSGI20UfhV0qkcjBsl5O8C5caWso9HDjlyPmDf1nm/K/fY0Uri6Fj58CrC+4X5mKwa9vGIr/UTr6m7M4oyzWDqqbzHqEx7QVESrWtju30zRQqGcpunxFrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9MoNn9J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eca7297a7so3073985ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 11:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761328951; x=1761933751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
        b=U9MoNn9JMoV+ejoI9l7i2tBdHgVTB1X42wQkQ/RvY36W7RueHRauazQL9niaJmZHsZ
         octavXG2A7Sk/UdosBZV6lKwpJ+Qk+P5uYLwoCbEDMzYhe/uWAjl1nYEduWAm6MHAPZw
         RojdrkuoSsx07slerizWuEzac879W+sQnn9x113e6B5KlhifUgywkc0wGb4UsMFAhVh+
         von4uMpMz+0/JVur296QBGDC9SwOETAbDCT7JplmeZ6sK4N7GOCKuNBDAW56wFobynJV
         6I7rffhwtrQMSL5tVNQyRGAJVrCsI9G6LDg3fVdX3CtSQ3HtOtlDOy55CnRmPBPGzCjH
         Y83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328951; x=1761933751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqIgJcJa2diXyLKkZeV5zTmt7c/3DcWq0YdvpFsQs1U=;
        b=ARnqa1tcTI+mdYhNcfQyv+ulMpcyK/GHVwISFb1KHkUaxdbU6TXW0JgI71Wi1xjInz
         187kIy71vQ1WLNTPLlj/ftC+T97je3mLBubjKK9urM9cGkkov0WTcS5EuompYMz3hPDK
         aBAl89ZjqhzRo6uo5deqdOevZMJevWTrCgY5m86RhLCljNbLZ43ccTivlSbHmAOtrIu9
         0i/AQ5LUS/ZvmDLqT2xtXSc2yJmQOLx6pCMDTqJCd+qpB3YJmgmNYv92z//7Vhdn90S3
         1vy/BVp8veVPJXMIHsjN+QTzgmVvDrL0xQ+08ws9E3HDCE18UyWorK8fT6A1VZZvVege
         V/hA==
X-Forwarded-Encrypted: i=1; AJvYcCU4vyKxD+v7TogxcVfrvHV+7m+H/ev9ui0apAhhvxt/hJ0kBGCBNHmjG8cjAmfIZK3z++Om/Y6psthjfb8S@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeM3u9HlysIQaUnfY6qmTgMkj34j++fobBkB/INELjtbTef2P
	GmFywj4yySbNLau/xlMWjTXxCMVNfl/OmdTn9clpVWtnwseTfEe3nYgvPZ4cIuFc6MmBh/6mzMY
	Y81SSiNICCo7Je2QF6DP8z5n+91JXFR8=
X-Gm-Gg: ASbGncu4Xa2+11PDioyLQX1Zsl6m8tVxT95NEcnc0+IHDrGmVgXXMRuqWtJB4Lrbw/Q
	PPdzCG/hHjmnXwiuhTmqYRqkL8ZdxmbEetVk3qUpEPLH4fZoztgDEuXl0fgX4Db1JjegGLvEY9c
	iDf3M/H735DTbt8uNiMy5GZE/bpvCMKAdTRbIZW6sVYJD+jJp3TD0BtXKkkLjxRja9pD3EKjobG
	UwH37GvrtEEcLtDsQj/CuQBl30FCSMna1q0z5MALcQXd1RDPKYhC1OJ/2dlqycVERiIN0JRaXjd
	9wAy/I9rcWLvmmF/mPTZlvxG40ofydloJgzkASWMpbbDjyIEYD0Qe+jXGBAZdp72ufBWbcaS+aX
	hpY17kSmuvpGNEg==
X-Google-Smtp-Source: AGHT+IFXN036gyk3u8TwThknCoOvSHyTdnq5f+a1361AXFhp2hDWxvNZ+IEnVkZLJJwnHPwu6ofnzTCYlg9/mxn7rEg=
X-Received: by 2002:a17:903:f87:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-292d3fbbf0cmr97350035ad.7.1761328951021; Fri, 24 Oct 2025
 11:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
In-Reply-To: <aPoPbFXGXk_ohOpW@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Oct 2025 20:02:18 +0200
X-Gm-Features: AWmQ_bknF0O4glT__QBpD7EtGbQw3f2JbbITF9mBVx4ARFlGbB71froz6CcT2AE
Message-ID: <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:20=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I would love to have infallible conversions from usize to u64 (and u32
> to usize), but we can't really modify the stdlib to add them.

I don't have a link at hand now, but we already (recently too, I
think) discussed having these "we know it is infallible in the kernel"
conversions. Maybe there was a patch posted even.

Otherwise, I will create a good first issue.

Cheers,
Miguel

