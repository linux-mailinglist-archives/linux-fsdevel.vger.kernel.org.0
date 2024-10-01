Return-Path: <linux-fsdevel+bounces-30439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B95E498B6A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 10:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C12FB22069
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8519ABCB;
	Tue,  1 Oct 2024 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4YSsT6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65A199FB7
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770846; cv=none; b=nD63xgwSlRncWgNOpDkTdlQxTUJj6QWYMWDl/gqQSf9w2kXJWI6cgcux2Kg0M8u5Lg7m5svdBFESZSo1UWVur+5ZSvaJtIJLrhxVWJxi7mhGu6H/FvvcTbzSlTVC6dSfIUPqFAbqWJN6UdyKR/yoGTeQNEoVStZIkzQ238t9djU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770846; c=relaxed/simple;
	bh=4N+ibs1sFppJJYULH32Paj5So960irpOMdhYsZRhbhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYT4HcUcSCcQ244YyKA61eQTuJ71ckHUV544L+Klpy7tbEGb7ZS6G848PJFPE3GqjI5jOBduxm8Wiq4c1/zUg4Q/ARBw1oLWlxPVFr9NE6EgSpX3Uv7Iz8rL7azsXBLcBm8EXU8qQIoSOtVEp1zGLXrIpY2iuWU5z/bb7H638w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4YSsT6q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ccd81de57so3239690f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727770843; x=1728375643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwjqJSGgG+H6oyeqtpNUfZYxj/aohEl0owqW2NF032o=;
        b=r4YSsT6qtHAkYGO6butlfCotkL7AKlufq12Un7TQfcgtRy4iJWkW4QmPS6kouuGOuR
         ZWs0zDfZfHw8r9LxlPvlryF6GuKS1XmKe3DN6WiZlcm+ZT8iTCMOodv3fS+C3x6X95tH
         37lF0p9MQ8Y1+/t+ekAv6OieFaEpsGc4PuDfCD9NkI41k86FABa+3ofiiJlsDgCZ0d+c
         0jBVvFNjU3FO9/wRvEpAwmuMiONOfzyH5KoY5UJd/a9AZJRMhGK/Nhz7Y/5gva9DpOkT
         0w+11t4U7vzMeS41cT6ixYPNjOHBqnbH8XqI4OEEDK4Ps1JFpkq3jDiqqDqTZ82+cAHF
         QX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770843; x=1728375643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwjqJSGgG+H6oyeqtpNUfZYxj/aohEl0owqW2NF032o=;
        b=rPVpoCPhFOkWfw6ogT8afWGXnnV5M6DVpc3JKbZTBhsz+5r2FawKv4xst6q0jMEiS8
         6TcLOnOsD8kHfJy4oj830kSzbrVrxbB0updWTk5XHp9sdvkeNw/Z2INmv10dy5cY5oTK
         JzaDC2HIMMfQ+fC+21okzJ5to+kMcBfq+OVrNq+0+rFtNFMXbZrn3bp4fTyG0kTb9vMr
         hbHATBmmIlv5ncfV40h+IsgxZu5FSJ2EGJsjwrPnJXawSyd3C/1W2N1UM7P7bySmvfZm
         p3KF+BRdDs86xvb95ebtQNXZi+gBtKq4uapLGWYxEpQODckPTHdcXdKQMUctd5BJ6SUS
         a7TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMrp6g/WHpbVhb7ebXMCuv63RMPKFpJOZv3gqMzccSwA+f2g3Ba6SneeapBIZ8qoZDqqG6J3iT3Xz0nkru@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+B1r9ER88ilGSKWl/+ARrsIfKJ6S+N5fVA5QWrhkuWoYG0p1h
	nmV/F23t+xrpP73ph7TUzSWb/26ZeJRstlsaIJGrOIvyQx4K2O/VOuyh6jwT++TC3Wq5wosemgA
	tAL8CUG54Ltv4D2o+VgRbp+7SQaXVfUmWlVTx
X-Google-Smtp-Source: AGHT+IEuz+NLxVqHubfGTHjcpcw7MR71fHOixLslnBUog2WWIigqb2G698IyoTMJG2l/y5i+sVBXfSl/bEc8RDk46kg=
X-Received: by 2002:a05:6000:d02:b0:374:d130:a43b with SMTP id
 ffacd0b85a97d-37cf289b98amr1332507f8f.4.1727770842386; Tue, 01 Oct 2024
 01:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com> <20240926220821.GP3550746@ZenIV>
 <20240926224733.GQ3550746@ZenIV> <CAH5fLgick=nmDFd1w5zLSw9tVXMe-u2vk3sBbG-HZsPEUtYLVw@mail.gmail.com>
 <20240927193809.GV3550746@ZenIV>
In-Reply-To: <20240927193809.GV3550746@ZenIV>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 10:20:29 +0200
Message-ID: <CAH5fLghqptxk5LiY3a+k1WX8pf73kJTLf2VxRJBiOPwxZtNmtw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 9:38=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Fri, Sep 27, 2024 at 08:56:50AM +0200, Alice Ryhl wrote:
>
> > Okay, interesting. I did not know about all of these llseek helpers.
> > I'm definitely happy to make the Rust API force users to do the right
> > thing if we can.
> >
> > It sounds like we basically have a few different seeking behaviors
> > that the driver can choose between, and we want to force the user to
> > use one of them?
>
> Depends...  Basically, SEEK_HOLE/SEEK_DATA is seriously fs-specific
> (unsurprisingly), and pretty much everything wants the usual relation
> between SEEK_SET and SEEK_CUR (<SEEK_CUR,n> is the same as <SEEK_SET,
> current position + n>).  SEEK_END availability varies - the simplest
> variant is <SEEK_END, n> =3D=3D <SEEK_SET, size + n>, but there are
> cases that genuinely have nothing resembling end-relative seek
> (e.g. anything seq_file-related).
>
> It's not so much available instances as available helpers; details of
> semantics may seriously vary by the driver.
>
> Note that once upon a time ->f_pos had been exposed to ->read() et.al.;
> caused recurring bugs, until we switched to "sample ->f_pos before callin=
g
> ->read(), pass the reference to local copy into the method, then put
> what's the method left behind in there back into ->f_pos".
>
> Something similar might be a good idea for ->llseek().  Locking is
> an unpleasant problem, unfortunately.  lseek() is not a terribly hot
> codepath, but read() and write() are.  For a while we used to do exclusio=
n
> on per-struct file basis for _all_ read/write/lseek; see 797964253d35
> "file: reinstate f_pos locking optimization for regular files" for the
> point where it eroded.
>
> FWIW, I suspect that unconditionally taking ->f_pos_mutex for llseek(2)
> would solve most of the problems - for one thing, with guaranteed
> per-struct-file serialization of vfs_llseek() we could handle SEEK_CUR
> right there, so that ->llseek() instances would never see it; for another=
,
> we just might be able to pull the same 'pass a reference to local variabl=
e
> and let it be handled there' trick for ->llseek().  That would require
> an audit of locking in the instances, though...

Okay, thanks for the explanation. The file position stuff seems pretty
complicated.

One thing to think about is whether there are some behaviors used by
old drivers that new drivers should not use. We can design our Rust
APIs to prevent using it in those legacy ways.

For now I'm dropping this patch from the series at Greg's request.

Alice

