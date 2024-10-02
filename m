Return-Path: <linux-fsdevel+bounces-30705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4E698DB52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76CE281A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 14:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649FC1D174E;
	Wed,  2 Oct 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3FwGaVG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3912C1D0B8E
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879113; cv=none; b=FmNsYvtvptGZfszFafdZTbOpa6c/2bKjfPQHi+FL2yAe7+6khO8Cn1Kqw7PPD2MkCnfzMHOgaCm/ocq89XePEwdoi9QxYpo6Ut6FIyGkQNus/s732oro9HXjXMrOiOzQMReDa9my3R2Y+I6dWHIgd3M4BrU6lVnVHucrFgqkTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879113; c=relaxed/simple;
	bh=11c9+skVhSQQTYvdZiQN82DEoOrJFKtPIJ2Y7tyy0LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N99MX7Rn9VlOfwRjwCEtB1xAhtX1KOrkqG1Eq27psCM8ceIbBvCu57q0GbUQ9Tc0AHQ5bZ5DfNOM1DYZRRzqTFLr07/7bXJj5HQZKi9m9dm2KmjTEVz+LRNUF2xBHu25sfI+g/zQV73Nr1QeLmu4+vsHQK4ToHWsgWxAZAV+JHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3FwGaVG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so62243325e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727879110; x=1728483910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLIijbTkj+R7CFzI+4k2tzicH9WSgStlBUdWyvgwEL8=;
        b=P3FwGaVGgKJ107BSNzt8PyXqlgH1aN1/3dQw2thMxTfD+7zIQ93ensUjr0xUa0w9bZ
         NswumaczDDPIzw5BGbpWqljWNLZ8gEepcQDxZUUM239/Nc0U+2IdsU7f3UwpKo5K76fQ
         VuoThY/4me4w8ystD7heSHpKegQ40XqCPpMXacknXDXgdTx4mNP+yG43Pf5es3lYTGBj
         Bf8oNjGrXAvuhKtGexfTtluMCEXAFJnhENyDc1E+WK++pQOfkajE2XicQrzm87qocPMj
         D7/Au/cAQu6R9DBximCnnEwqGV8imkfQg275IeOv1OAc0uvJujzVHdjL5uIAB9KePHvp
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879110; x=1728483910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLIijbTkj+R7CFzI+4k2tzicH9WSgStlBUdWyvgwEL8=;
        b=YExXp0uNCDeS+zaDv4mmRqj3QkXaJOqQqHCJCWWRgJ8/X7hFZgHajiNYN3On0gEdlj
         NfVO2LfsLd7+R8mAJqA31xaz4iv5J+8vR7d4OYvPuR1eO2uF+5LTjg3Ms6XLx8zsslyF
         GkR1HKNvGG0yfPlawN+H+JnOnLhyhES5uwwkx43KBzMFzcufud5hwgsaPzirh+VB8FPs
         8iNb5bX0UBN4KznlILQsFtOiB6/g/C9k0FQw0/yaZasNVDnFqRDv2OnkrqhGHawsLTFp
         xA0pRAY1/5XyKsTXge6tNQNqB8mJdz6qJZif+zeMA4SBUQ/sMfiGAnB2KO0HBeTr/zVm
         IRkw==
X-Forwarded-Encrypted: i=1; AJvYcCWG0mEWMjd/RNJSQzjtlt7oTmA88eCY81G6QHErNwYFqJPbsMu0v1bqUrJOQItXT0h+XZCALM8fuiMPaQeC@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzsWgPwihLSpy+iQ7igZn8q3shd0LBgsq4I3R7nCJYufyBZOz
	C4o8/kcD/38REwW5iyKf07GV0PurWfEcjGTVige/iJvV8wms7yfX6L/sF8JUG1tfSllXTWpy1nk
	o7wubvqMqFw+WiJMALUHu5ZppGM3P+UsjY6zy
X-Google-Smtp-Source: AGHT+IE8fhayJ/byHt403K86wlifiHDxJ7PqBwaWtoMQa1LaZUPqyM0ibcB/oisdTpcU3SI9Hac1wup+psHyLM7EcJA=
X-Received: by 2002:adf:ce09:0:b0:374:c621:62a6 with SMTP id
 ffacd0b85a97d-37cfba0b391mr1899784f8f.47.1727879110267; Wed, 02 Oct 2024
 07:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <20241002-ertrag-syntaktisch-6c18b81d6c90@brauner>
In-Reply-To: <20241002-ertrag-syntaktisch-6c18b81d6c90@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Oct 2024 16:24:58 +0200
Message-ID: <CAH5fLgjm=u_im776f9cTrqjKCYQ31F4t=_Dg6mDzCoSEGoJm-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:06=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Oct 01, 2024 at 08:22:22AM GMT, Alice Ryhl wrote:
> > +unsafe extern "C" fn fops_open<T: MiscDevice>(
> > +    inode: *mut bindings::inode,
> > +    file: *mut bindings::file,
> > +) -> c_int {
> > +    // SAFETY: The pointers are valid and for a file being opened.
> > +    let ret =3D unsafe { bindings::generic_file_open(inode, file) };
> > +    if ret !=3D 0 {
> > +        return ret;
> > +    }
>
> Do you have code where that function is used? Because this looks wrong
> or at least I don't understand from just a glance whether that
> generic_file_open() call makes sense.
>
> Illustrating how we get from opening /dev/binder to this call would
> help.

Hmm. I wrote this by comparing with the ashmem open callback. Now that
you mention it you are right that Binder does not call
generic_file_open ... I have to admit that I don't know what
generic_file_open does.

Alice

