Return-Path: <linux-fsdevel+bounces-36768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332F9E929A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BD6161A38
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7972206A5;
	Mon,  9 Dec 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOs7hffk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCA189B85
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 11:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744328; cv=none; b=nZvQ31AhvrP7RGLna+s6M4rHqtVt5jvrBDCkkQRFI8YuqWrKmJLCPPhtXmvmXFZ8cr3ZSM0V+ssQnnhsRkCCTZnsPfLrZ0DxfSX+6lY6i3JpcmM3PJZlTSd/v+IQbt1sV9x98k+JXmk/2Uc5cVDWPCrEXvYrPQxOcZHxqqdtBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744328; c=relaxed/simple;
	bh=TIQOHvlPe7EaliHf+oU8rkKxEUJHqdGAQhL9uCvZsKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VC/mnoDmeU4+Wy1wKdf6y/fqbXlsF1w43OKEod1xHOU5JRWpQuaRp1dZN5OTJE4WYgT8O2WbSMzGksJPkk6AWybnZviASa4shu6UKXNXaLKcXNrdI5q4fqoA+etac0QGKmnFisVKd0Y6IHdxLDSY7lyFUBd4ihHctOEIHvDIlQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOs7hffk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2167229f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 03:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733744325; x=1734349125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkFF8qREOWmj8BwHObK5LagoNCyflkty6l96N/dPuUI=;
        b=UOs7hffkovZGiMSkM205ON6ZP7ylG70vN/J52M4awSAV0S0rYs4af0gihIp/v8CM4n
         sUxhuiW/yRaBc41iMokloOwgLiy7yx1ri+sA+YhRXzoPx37N3uDpFcmmqh/VeYUeVinC
         u9CdNR+THc3TJk4BBLQDb5ojHQlGAsKB9VPC9zecPv3+PNzFcHHKiWAgqMuDN8sOXImI
         zrPonLwaxsglvQMCXSTgnBENxZnBrt9AHe3PeYzjqPD0xWoKgRXWTMekYkELIsyjBmtA
         V3f4Ssxkykf1C1J1jPu5KI5GjwwC1uCQtkoayfGsAptKBIMQKCVFB6Lmm7Xe/2u9jljY
         dskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733744325; x=1734349125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkFF8qREOWmj8BwHObK5LagoNCyflkty6l96N/dPuUI=;
        b=vG9K3u2Wx0M/e5+Ax0T5D4IGQVBsmx2IeFvTlHkGLraODDOoL4yc36nBynMrqdlhsx
         kcpZ8w/EFyvfxIpSHPiy/ooi4I2WtjIUZoh3c6ymcrOQKy1HD+tyFz+79W8qRpyIAcaD
         XYN+bOYVZbA2F//s58qtc92/CMjEfdF67/VsroCeqkHHiMd9bhm+cGAZwkoSsiIU3vL5
         QW/Epkeka5IbGb40IiG7A7HtmgfCnvzsoV/Lrp0ccUWcl+/Cp5IOps7mR+llW3iiv/ri
         u4IXepZ8RcFBLf0eXNSEaouhXrApXS5xXrumCVBWDCVX2IDlsc43Pu/JmwDt/NAmcLn4
         5iCA==
X-Forwarded-Encrypted: i=1; AJvYcCWQCwm1efcCFTWtlu1fASBOB68pz5h7zNxMgKpdFM1SMPlnBNCdb+iqRDaD0BaSuXGpjrBuUeqHIFB9o6aB@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTKIO+n76TYJno/2+paha/JE/4W2/uyUOD67RL45dk7jYKp2i
	r04d+Nn1S6uaQl/qXMPMSlcR8YmkTZqD0U2vxWb3SFEHBqxGCt8PtWkMPQxZZtSA0jPmRPuJOm/
	MaI0IJRBuKQDeips+JRw3rB8/5QaCwpqWCvmm
X-Gm-Gg: ASbGncter7SEGM10FmefOn4O15cYmjFNK8dBuMIV143BigcBb/wyuCrpgJxrbURpRy3
	8o4MZ9ng/hC+ihsCz/qklTRNZkEucj12fhUwPtDatGiBrG/FC/6hl192stGhE
X-Google-Smtp-Source: AGHT+IHn8seJRcLF6izN+Y5EGQwWjRMYR7lzRrioW8o6E6jaM1e1rAvz6kVtJykoRdXO1RIQPifWBV23kwAXF0wNSYo=
X-Received: by 2002:a5d:64ce:0:b0:385:edb7:69ba with SMTP id
 ffacd0b85a97d-3862b335324mr10793035f8f.1.1733744325101; Mon, 09 Dec 2024
 03:38:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh> <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh>
In-Reply-To: <2024120954-boring-skeptic-ad16@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 12:38:32 +0100
Message-ID: <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > Providing access to the underlying `struct miscdevice` is useful fo=
r
> > > > various reasons. For example, this allows you access the miscdevice=
's
> > > > internal `struct device` for use with the `dev_*` printing macros.
> > > >
> > > > Note that since the underlying `struct miscdevice` could get freed =
at
> > > > any point after the fops->open() call, only the open call is given
> > > > access to it. To print from other calls, they should take a refcoun=
t on
> > > > the device to keep it alive.
> > >
> > > The lifespan of the miscdevice is at least from open until close, so
> > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> >
> > How is that enforced? What happens if I call misc_deregister while
> > there are open fds?
>
> You shouldn't be able to do that as the code that would be calling
> misc_deregister() (i.e. in a module unload path) would not work because
> the module reference count is incremented at this point in time due to
> the file operation module reference.

Oh .. so misc_deregister must only be called when the module is being unloa=
ded?

> Wait, we are plumbing in the module owner logic here, right?  That
> should be in the file operations structure.

Right ... it's missing but I will add it.

> Yeah, it's a horrid hack, and one day we will put "real" revoke logic in
> here to detach the misc device from the file operations if this were to
> happen.  It's a very very common anti-pattern that many subsystems have
> that is a bug that we all have been talking about for a very very long
> time.  Wolfram even has a plan for how to fix it all up (see his Japan
> LinuxCon talk from 2 years ago), but I don't think anyone is doing the
> work on it :(
>
> The media and drm layers have internal hacks/work-arounds to try to
> handle this issue, but luckily for us, the odds of a misc device being
> dynamically removed from the system is pretty low.
>
> Once / if ever, we get the revoke type logic implemented, then we can
> apply that to the misc device code and follow it through to the rust
> side if needed.

If dynamically deregistering is not safe, then we need to change the
Rust abstractions to prevent it.

Alice

