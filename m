Return-Path: <linux-fsdevel+bounces-36829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3E9E9A04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957D0188696E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A251BEF64;
	Mon,  9 Dec 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEUiRvS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE481A23B8
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756704; cv=none; b=M8SV7hJu/VFSZmdsiFK+kD2sGvmHIavxxZ1Xq6t9GpMEVxLV0+3gk8qVmDhJ/dUoSHZq1Rlu/HRbEj91eNq6x49eNmwTK0axs7vtIPTAo7JshbPVDL/xnUsTLVNDT5vnpaOKF1tX3yh2ELckTGs8719HWy2TLXAYo3eXu4o2qzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756704; c=relaxed/simple;
	bh=GOOKCiRNospXnF+RV+ncUhx7aYYZcIfAvAE0jNhSHKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QObceW5dS1nbTOdV0KSbZ93vTjyaV2Qit3Xkdw9RPHCIwcVMgt1ZI7Ita2u0Du6nQksgS7AcTJ3snKcV7aLBC8rsxbzuNbJxYja3vwEIf5P5s4zuWe/SXAEAzUk7/4ibDxgPVywk86Ws54GP477CbmWP9c4iLcUpuizsL5dCZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEUiRvS1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a2033562so42777035e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733756701; x=1734361501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezn89nmMHt3a4Gk2YmXU8FyBpaEaviUGfCoPxT8X+qU=;
        b=OEUiRvS1g13/DgQNKbb5N9cF0nIcuBPX5O4qcIbz8jX45MhJ9otTn1BukRb39KIH5q
         JEejevWllgTrfrx31zGMlBwIDVneEt34G9K9MyO+9ZwMCcssHMMjKz70FVaRvIO9Y+3K
         d8fmNz95DJCtvHYWDi6BtgPkL/lru6RGQcvX7OtEOOaY3ZyX5AI4NA+mMwwjQuZfWPDd
         Wpdiss/hMQ4XDviuTPKjyqSUc1joj3y631Cv5ql3sgZhmFYwscNBHsMP47Kgt5bu514i
         QsLWIrTRihv2i1P8QpoRRbsH0pAtsgfRsgBRUetkfvL8NVC1pVcWt+cvHFkKBD1En1H/
         ggBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756701; x=1734361501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezn89nmMHt3a4Gk2YmXU8FyBpaEaviUGfCoPxT8X+qU=;
        b=K/hRzyYGxc0iA+bFmJenws3xebvcOZ+8Yp47aGQ6/u14cJiLczaFYYv4coYyhu0inA
         C2Qxabj/708qzUclAR1T6HpSyFoXsb4beWLO4LdDYpTXuq5z9Bmh17lYmCp2rOmtm/sn
         sOP7dbfd6bqm/iAwYEgWoqrrPvinPh4nr/OUZ4jNCdEpGzKss2P92c7pvAHxSb4qvnIC
         oUHt1xNEGwn+1T4xSihaVzY4MyNkDbtBWP+vZKIpz0mOfMgs4+Nc1mwspVuWJGDLTWa4
         fsgHdr7qUbeyr3za19w9ZlCrj8tkGj9v9NVoqBBhSilNs6WF9x7PXNnXLhuDMJY4PUxQ
         aWeA==
X-Forwarded-Encrypted: i=1; AJvYcCU+NQ5xcNTlNmQ+1vI9ctwzsoll9LS2c7QGbRy7rjko1eS+oyoKhvhMXUBn8j0P1R3EGyRFRb3QxmHhx2B2@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7xEMMRq4cS3N425OYyMJpTw1ZgyKXBmkrOGsgICaJ3qgJpxZ
	IV6dP3VdROfR7t2KYAsW8q7cemSoyYXyW0S0JSUctoNGYQMqD0AW6q+nAqPpLWKKwxxX1gNmmIh
	Ebo2/JBj6/ckmt1v5ptvpnt/hi0RAck+iDrRc
X-Gm-Gg: ASbGncvvbeMiW5ZrZgdxYH+fFzNqWorYgBQ+QKTnNSbV49aicIayHc4VJUxSPjtx0io
	rr73HwKEIKg0QLgQbXQAj6yG3TFykz9ptcFXFDVmbQC5WrthU/dRL2XyfQJTmvA==
X-Google-Smtp-Source: AGHT+IHARy2pp+mkARCLjvba0y2x8gM4wwzt9yhM7UBN8pF5mt6au3buMyrotXz1sOrdemtnJyYsbglTDwW+Xa2zG04=
X-Received: by 2002:a05:600c:a48:b0:434:9fac:b158 with SMTP id
 5b1f17b1804b1-434ddeae4d6mr91859435e9.1.1733756700704; Mon, 09 Dec 2024
 07:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024120925-express-unmasked-76b4@gregkh> <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh> <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
 <2024120908-anemic-previous-3db9@gregkh> <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
 <2024120939-aide-epidermal-076e@gregkh> <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
 <2024120951-botanist-exhale-4845@gregkh> <CAH5fLgjxMH71fQ5A8F8JaO2c54wxCTCnuMEqnQqpV3L=2BUWEA@mail.gmail.com>
 <Z1cGWBFm0uVA07WN@pollux.localdomain>
In-Reply-To: <Z1cGWBFm0uVA07WN@pollux.localdomain>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 16:04:48 +0100
Message-ID: <CAH5fLgisVC15muFB0eThiMveFBoauB4jUVwW9Zez3cKT0Q=_iA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Mon, Dec 09, 2024 at 02:36:31PM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 2:13=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 01:53:42PM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > > > > > On Mon, Dec 9, 2024 at 12:53=E2=80=AFPM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > > > > > On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
> > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrot=
e:
> > > > > > > > > > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartm=
an
> > > > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl =
wrote:
> > > > > > > > > > > > Providing access to the underlying `struct miscdevi=
ce` is useful for
> > > > > > > > > > > > various reasons. For example, this allows you acces=
s the miscdevice's
> > > > > > > > > > > > internal `struct device` for use with the `dev_*` p=
rinting macros.
> > > > > > > > > > > >
> > > > > > > > > > > > Note that since the underlying `struct miscdevice` =
could get freed at
> > > > > > > > > > > > any point after the fops->open() call, only the ope=
n call is given
> > > > > > > > > > > > access to it. To print from other calls, they shoul=
d take a refcount on
> > > > > > > > > > > > the device to keep it alive.
> > > > > > > > > > >
> > > > > > > > > > > The lifespan of the miscdevice is at least from open =
until close, so
> > > > > > > > > > > it's safe for at least then (i.e. read/write/ioctl/et=
c.)
> > > > > > > > > >
> > > > > > > > > > How is that enforced? What happens if I call misc_dereg=
ister while
> > > > > > > > > > there are open fds?
> > > > > > > > >
> > > > > > > > > You shouldn't be able to do that as the code that would b=
e calling
> > > > > > > > > misc_deregister() (i.e. in a module unload path) would no=
t work because
> > > > > > > > > the module reference count is incremented at this point i=
n time due to
> > > > > > > > > the file operation module reference.
> > > > > > > >
> > > > > > > > Oh .. so misc_deregister must only be called when the modul=
e is being unloaded?
> > > > > > >
> > > > > > > Traditionally yes, that's when it is called.  Do you see it h=
appening in
> > > > > > > any other place in the kernel today?
> > > > > >
> > > > > > I had not looked, but I know that Binder allows dynamically cre=
ating
> > > > > > and removing its devices at runtime. It happens to be the case =
that
> > > > > > this is only supported when binderfs is used, which is when it =
doesn't
> > > > > > use miscdevice, so technically Binder does not call misc_deregi=
ster()
> > > > > > outside of module unload, but following its example it's not ha=
rd to
> > > > > > imagine that such removals could happen.
> > > > >
> > > > > That's why those are files and not misc devices :)
> > > >
> > > > I grepped for misc_deregister and the first driver I looked at is
> > > > drivers/misc/bcm-vk which seems to allow dynamic deregistration if =
the
> > > > pci device is removed.
> > >
> > > Ah, yeah, that's going to get messy and will be a problem if someone =
has
> > > the file open then.
> > >
> > > > Another tricky path is error cleanup in its probe function.
> > > > Technically, if probe fails after registering the misc device, ther=
e's
> > > > a brief moment where you could open the miscdevice before it gets
> > > > removed in the cleanup path, which seems to me that it could lead t=
o
> > > > UAF?
> > > >
> > > > Or is there something I'm missing?
> > >
> > > Nope, that too is a window of a problem, luckily you "should" only
> > > register the misc device after you know the device is safe to use as
> > > once it is registered, it could be used so it "should" be the last th=
ing
> > > you do in probe.
> > >
> > > So yes, you are right, and we do know about these issues (again see t=
he
> > > talk I mentioned and some previous ones for many years at plumbers
> > > conferences by different people.)  It's just up to someone to do the
> > > work to fix them.
> > >
> > > If you think we can prevent the race in the rust side, wonderful, I'm
> > > all for that being a valid fix.
> >
> > The current patch prevents the race by only allowing access to the
> > `struct miscdevice` in fops->open(). That's safe since
> > `file->f_op->open` runs with `misc_mtx` held. Do we really need the
> > miscdevice to stay alive for longer? You can already take a refcount
> > on `this_device` if you want to keep the device alive for longer for
> > dev_* printing purposes, but it seems like that is the only field you
> > really need from the `struct miscdevice` past fops->open()?
>
> Good point, I also can't really see anything within struct miscdevice tha=
t a
> driver could need other than `this_device`.
>
> How would you provide the `device::Device` within the `MiscDevice` trait
> functions?
>
> If we don't guarantee that the `struct miscdevice` is still alive past op=
en() we
> need to take a reference on `this_device` in open().
>
> I guess the idea would be to let `MiscDeviceRegistration` provide a funct=
ion to
> obtain an `ARef<device::Device>`?

Yes, you take a refcount on the device and store an
ARef<device::Device> in your own struct. You would need Lee's accessor
to obtain the device refcount:
https://lore.kernel.org/all/20241206090515.752267-3-lee@kernel.org/

Alice

