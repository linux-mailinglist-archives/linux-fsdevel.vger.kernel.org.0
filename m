Return-Path: <linux-fsdevel+bounces-36797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4E79E9748
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8AE2808FB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816E11A2395;
	Mon,  9 Dec 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI5hiY8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCF233130
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751407; cv=none; b=kppNua40+F30/67bQk9728VjLWU6abjQWKv/3/HDxWO6Zr00NXayaz4pRRZ+ZxqB7vN+OUHTUFL8N4ZGZqITJ/6LNcqQyrA4aUKcq4VRiuKaR3xJYbauqxxrl9uQa9AGmDPXBvajQFa3t9iu/X8uQ7bNaLMU3KDj9+TLQeHrp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751407; c=relaxed/simple;
	bh=PV3swLLaZFbq5Ed0HulEMUcYN8M5aQHtK81H3Ykrktc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/VEqF/1Bs7du8ibyt9JCxB7nbtBy2sdphLBjQjLNO2rUZQyRhvvbWbxB4pfBQkFWc2EL25V4DVa9k6yaEkwE0DoFiEM9xu8TCZDR8J4JFyP8r0pgRpkB47G6aC4JOXp9v8DYmRlQYO3mMo4n+Mr2T9+7zD57YgacfgbEhHw3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI5hiY8i; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434e84b65e7so21709585e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733751403; x=1734356203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+VHqIDnt8Wv3OGUBLOJUgJWhgz6X3cxGKC5LCFSJCI=;
        b=ZI5hiY8ixVmpZiAZSTnLReoeNmTsmx+Za0Lp5z7btb7n5lYJVjqtYDc3FT6QnTJTsA
         ElpJ5kVx4kGKtYwkmQnyVg/qTV3gW3wGWpCKa972Mc/YpeTjyA5xxaM9ksdBvS+aUX1C
         qnwx62dhCsfFvEMLndgJ7B2UmgrArLrxHppuQJU9FERyhuRWbiVWqkEvxTWG+BY//kvq
         u1q77r1yZrOQrPYPrTOZB36mHg3MZDF07STG0pGKfN7b8yl3VpwCRaBOYki1we93cC8G
         IQBWhpDxy0wgCDYqwGOSTHZ3G7iCfvK/npCUdMAZT28V8lx8cXtM5IGlwZksI4i2LQtI
         4SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751403; x=1734356203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+VHqIDnt8Wv3OGUBLOJUgJWhgz6X3cxGKC5LCFSJCI=;
        b=nl2JFJd0kYeQItdQASVAdj4SybbJ5wnbaj8OAtvQYkpXqPV8teqJ9dowSUS+pa9vDy
         O52g0cBxXYjULkHpXLixR8Ghy1RqKFJr5i7npy87sUqC7QynMgWryHk0cX1U/liJ4o/i
         fFRmt56HfEFbdMIFe3j/lVuk2qfLlOxMN58NdFaRJSKPBTpsxE0p/SUukgfBHOqo4BLc
         DWG+s+PagV4b13bhHuxye3vlfnJhdL2yWBjoNDo1vOOLdtYy8iWUgQZpi0GQq5+WGuCP
         KVoybojOtrc6jq59Z64QYzho53aB7kmGXkuwoLsqz2rncmYrCfJab2V9hpUh42TiF4VW
         NxBA==
X-Forwarded-Encrypted: i=1; AJvYcCWabgfxoz4tC7KceiRN/fUD3N2/EQueTjdCQ5limI4q1iEYMPHzNa8U+zmCOMXspe81plY74FQm6sevxsJZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YWG1nyaAnEIfk+UYiZK9ABAEYH5yMrT0FSxhIPV3Y/U7eGRK
	SeasB4xkW1o9vFLu+LAxiNnPEEb4cCU1QSYhH2vkU9reIgnX8kcq4njW7Y9y0eexDPtKK4wFd9u
	qWuFVMANC035xnuHTFod9KWQHsEY7aLsUfW2X
X-Gm-Gg: ASbGncuqSb4v59tRGpWhnZ6KgRGruPTbIdtHvsB6vs5Y7UQhXmjLqvox3grXO8m7SvK
	sWNoWkrmvKcxFrsJzi23XjO0tDcIil1GvrMIVdeLi9iUaaJMchaK1eMKXx3+Jfg==
X-Google-Smtp-Source: AGHT+IE7YPRtYqw6B9Sd4Da3qjLLdZdmKlRYBghjFQ7MKut61TVgKPVxX4YTRFc9GBG27aRLXeKOje3KGVAm3f42yTA=
X-Received: by 2002:a05:600c:3783:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-434f5c03c29mr35461235e9.29.1733751403274; Mon, 09 Dec 2024
 05:36:43 -0800 (PST)
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
 <2024120939-aide-epidermal-076e@gregkh> <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
 <2024120951-botanist-exhale-4845@gregkh>
In-Reply-To: <2024120951-botanist-exhale-4845@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 14:36:31 +0100
Message-ID: <CAH5fLgjxMH71fQ5A8F8JaO2c54wxCTCnuMEqnQqpV3L=2BUWEA@mail.gmail.com>
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

On Mon, Dec 9, 2024 at 2:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 01:53:42PM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 12:53=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > > > On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > > > > > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
> > > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrot=
e:
> > > > > > > > > > Providing access to the underlying `struct miscdevice` =
is useful for
> > > > > > > > > > various reasons. For example, this allows you access th=
e miscdevice's
> > > > > > > > > > internal `struct device` for use with the `dev_*` print=
ing macros.
> > > > > > > > > >
> > > > > > > > > > Note that since the underlying `struct miscdevice` coul=
d get freed at
> > > > > > > > > > any point after the fops->open() call, only the open ca=
ll is given
> > > > > > > > > > access to it. To print from other calls, they should ta=
ke a refcount on
> > > > > > > > > > the device to keep it alive.
> > > > > > > > >
> > > > > > > > > The lifespan of the miscdevice is at least from open unti=
l close, so
> > > > > > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > > > > > >
> > > > > > > > How is that enforced? What happens if I call misc_deregiste=
r while
> > > > > > > > there are open fds?
> > > > > > >
> > > > > > > You shouldn't be able to do that as the code that would be ca=
lling
> > > > > > > misc_deregister() (i.e. in a module unload path) would not wo=
rk because
> > > > > > > the module reference count is incremented at this point in ti=
me due to
> > > > > > > the file operation module reference.
> > > > > >
> > > > > > Oh .. so misc_deregister must only be called when the module is=
 being unloaded?
> > > > >
> > > > > Traditionally yes, that's when it is called.  Do you see it happe=
ning in
> > > > > any other place in the kernel today?
> > > >
> > > > I had not looked, but I know that Binder allows dynamically creatin=
g
> > > > and removing its devices at runtime. It happens to be the case that
> > > > this is only supported when binderfs is used, which is when it does=
n't
> > > > use miscdevice, so technically Binder does not call misc_deregister=
()
> > > > outside of module unload, but following its example it's not hard t=
o
> > > > imagine that such removals could happen.
> > >
> > > That's why those are files and not misc devices :)
> >
> > I grepped for misc_deregister and the first driver I looked at is
> > drivers/misc/bcm-vk which seems to allow dynamic deregistration if the
> > pci device is removed.
>
> Ah, yeah, that's going to get messy and will be a problem if someone has
> the file open then.
>
> > Another tricky path is error cleanup in its probe function.
> > Technically, if probe fails after registering the misc device, there's
> > a brief moment where you could open the miscdevice before it gets
> > removed in the cleanup path, which seems to me that it could lead to
> > UAF?
> >
> > Or is there something I'm missing?
>
> Nope, that too is a window of a problem, luckily you "should" only
> register the misc device after you know the device is safe to use as
> once it is registered, it could be used so it "should" be the last thing
> you do in probe.
>
> So yes, you are right, and we do know about these issues (again see the
> talk I mentioned and some previous ones for many years at plumbers
> conferences by different people.)  It's just up to someone to do the
> work to fix them.
>
> If you think we can prevent the race in the rust side, wonderful, I'm
> all for that being a valid fix.

The current patch prevents the race by only allowing access to the
`struct miscdevice` in fops->open(). That's safe since
`file->f_op->open` runs with `misc_mtx` held. Do we really need the
miscdevice to stay alive for longer? You can already take a refcount
on `this_device` if you want to keep the device alive for longer for
dev_* printing purposes, but it seems like that is the only field you
really need from the `struct miscdevice` past fops->open()?

Alice

