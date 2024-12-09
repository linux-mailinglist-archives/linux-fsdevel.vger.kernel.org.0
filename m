Return-Path: <linux-fsdevel+bounces-36784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 176579E9519
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD61E280238
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE61228CB9;
	Mon,  9 Dec 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FZ4li0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29B22D4CC
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748840; cv=none; b=ouG/VYhM51MbwVUJM8Cr4mtbUxCTA3KDT8FCRo5rAzgosntILq8sN4rjR8w+252R1nvW6Bnh9aZhxOyg2m8eY4WKTt1brLz9lGFQNbegM838zPhieILIeu9JRse1yWTPgZdQhISP/YY4SKL+2perWCRYCmellsqeofx/uE/lBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748840; c=relaxed/simple;
	bh=obrx4jcL33/kWWozeiQoPtk4e9tIpEL93T5ZUqbYrio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r79kISx0lEfcnK9vYza/heuP3ybhnIagaS4/RryFoKW/EbAzBrFJ1fF/b0b3+NGRLTe2ue6I8ejnENQryaGD2/KbubBR44dVM2tugS89QDxNmvxgLXsq7K3o+z5PKRoG0YP3fff7BJeGZgozSiz90wmV3V9eBYbK+I+uCwHsnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FZ4li0/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a766b475so42234715e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733748837; x=1734353637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i5SAc+98oEk5ukKLfbKKuEDIk6TYm+EWYT8/y8W4Ek=;
        b=3FZ4li0/55aH3CrZCdfucHt8WkJ6v3B8qR+cN5e5jX4/kiSNs+T9y8huMEF83yuDWw
         GtLP/lsLZyNilGuVNxJ9Wq9bP2vPzRfvpKaNQMpMKSa4KlRiq6PBNcNsNEAbEtj5v836
         fWgMaqhw00D2bQrOyN+ZSmeSLq0wY+n9JatwogOlVO3oM8y2tx2SCI7yya0A9GJ10pSR
         iHxQtpAptd2hM5zX8R7uCDKFfUUH2XRVxOc9/An75ZWzkrAJ0Q3bv3n/VaNGGDHq4QvO
         8AFac53t04t2m8g5ajPHKHrTZMs/0s4jqESFslh6HEPYDRNRj0lL6fAQ4dBYeDip7M5y
         za7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748837; x=1734353637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i5SAc+98oEk5ukKLfbKKuEDIk6TYm+EWYT8/y8W4Ek=;
        b=RY0qjn3+eg+TbW0+3/NsZbW41SBXEn0r1otqmIEWFOCYknZRoe8/jCTrc7vDnsaMxP
         0SpdNdqwG86nSBklybW7S8+yctt0GN4QxKiSAbeM6WdbFOgfunayEMP/rd46ctDo4fvd
         kybM+olxpCSpKOuv9DTnhiBL6+41IEql/N23wYVSUlhob5FIv5iygCxgJhMuwn4bcS7w
         u3+4HQbtB43wUZN8pAvTdTC9ALdhBCXk3zjvEz8DhY92vKwj2SHAoBZNihV3eWrvV4wG
         fi9lidIi9SmWUytAHLYn0rfTXnLIA/3JkKd7YiZMXn3GC6oaZbwU/v6Ys1LrxUczoJft
         XjHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvK1a1HHqZz83fvR+PffAuuFT5ND0htQpmtYQ2FLkjERXWoP0VESScocBoJp/x2b2B9a2//1fXfVbCxWLV@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7PVfpLDlNVaPDaQ81149wTqQp1WhlGv3MVPMXEQl4b/YfStW
	pKu4xX8IcJ40TJj+vNuWV3hkR9c+lYIHwibqejKxrwlS26GXg0lT2CNFw5eoKGpGG47mM+ndZTi
	akIS+/ZYh2gpIzOhTyRefAs2FGxRPBnZN3mHD
X-Gm-Gg: ASbGncuSNK1ftvjC+0zMGPeGXlNKKSvPLTW6I/qtK95LZwVxF0xa2c80K4rH0bOfwBG
	F2g7g7gSow2DYMn2HQaTDnegaqOBi5/CbsLdUn+5/Ttg7fY1Ra0LJnA5xlqat4Q==
X-Google-Smtp-Source: AGHT+IEuEI+4Zj+0nladgNqpgiOV2r8smTtTysfeQSoMAfpfFTFz6wYeGiz3rgawD6ECY00uZeOog1XRL6/cxhViFl4=
X-Received: by 2002:a05:600c:4f85:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-434fff30c48mr3250905e9.5.1733748836596; Mon, 09 Dec 2024
 04:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh> <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh> <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
 <2024120908-anemic-previous-3db9@gregkh> <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
 <2024120939-aide-epidermal-076e@gregkh>
In-Reply-To: <2024120939-aide-epidermal-076e@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 13:53:42 +0100
Message-ID: <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
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

On Mon, Dec 9, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 12:53=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > > > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > > > > Providing access to the underlying `struct miscdevice` is u=
seful for
> > > > > > > > various reasons. For example, this allows you access the mi=
scdevice's
> > > > > > > > internal `struct device` for use with the `dev_*` printing =
macros.
> > > > > > > >
> > > > > > > > Note that since the underlying `struct miscdevice` could ge=
t freed at
> > > > > > > > any point after the fops->open() call, only the open call i=
s given
> > > > > > > > access to it. To print from other calls, they should take a=
 refcount on
> > > > > > > > the device to keep it alive.
> > > > > > >
> > > > > > > The lifespan of the miscdevice is at least from open until cl=
ose, so
> > > > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > > > >
> > > > > > How is that enforced? What happens if I call misc_deregister wh=
ile
> > > > > > there are open fds?
> > > > >
> > > > > You shouldn't be able to do that as the code that would be callin=
g
> > > > > misc_deregister() (i.e. in a module unload path) would not work b=
ecause
> > > > > the module reference count is incremented at this point in time d=
ue to
> > > > > the file operation module reference.
> > > >
> > > > Oh .. so misc_deregister must only be called when the module is bei=
ng unloaded?
> > >
> > > Traditionally yes, that's when it is called.  Do you see it happening=
 in
> > > any other place in the kernel today?
> >
> > I had not looked, but I know that Binder allows dynamically creating
> > and removing its devices at runtime. It happens to be the case that
> > this is only supported when binderfs is used, which is when it doesn't
> > use miscdevice, so technically Binder does not call misc_deregister()
> > outside of module unload, but following its example it's not hard to
> > imagine that such removals could happen.
>
> That's why those are files and not misc devices :)

I grepped for misc_deregister and the first driver I looked at is
drivers/misc/bcm-vk which seems to allow dynamic deregistration if the
pci device is removed.

Another tricky path is error cleanup in its probe function.
Technically, if probe fails after registering the misc device, there's
a brief moment where you could open the miscdevice before it gets
removed in the cleanup path, which seems to me that it could lead to
UAF?

Or is there something I'm missing?


Alice

