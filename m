Return-Path: <linux-fsdevel+bounces-71031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD4CB1CCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0BF03028F6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5230E0F5;
	Wed, 10 Dec 2025 03:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cYfD2nd1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C430DEB2
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 03:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765337750; cv=none; b=Ka9cgKAmktsNNDBmWN3IlHXyOl/xPNcBTUAFUf5+sR0h1OiP55vsaSA+d+NNiYiLPxngeMeFmouVUjYp2BA1Ch7woFIa33rNWpiIoGzdvHrpMIJXpNTfcDv//y0uCxZNxIcJj8LNAv9w3a5+wPkVWuMFjJezT0wa/jQeevHumIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765337750; c=relaxed/simple;
	bh=Xol+iuIYvZWYIOL+5973No6fzwz+93nXjs8TQCArr+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO2yq6GN+wuSDaHpPNcxRnlst++jMowKj6iUW/65Qy/1vqwzmUBi2VXJ5P/0KHnhs1Vnm77QjPiOIB4gInPDYbjnGJjWPe7Kqx4eMDtZVvnkgc3taJAIBEsRaSoocyKXwRzyeTbC4IQX33HwmBBdExFXQ3Oq5or6NTZdR7TLHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cYfD2nd1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297cf964774so10796045ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 19:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765337747; x=1765942547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xol+iuIYvZWYIOL+5973No6fzwz+93nXjs8TQCArr+U=;
        b=cYfD2nd1iG/5QvViB1mo4atcORvmDepg+aA9dr8kk1V3nG6lokkNk1f1FAMfPQzKWA
         ur3RRSti2+mH+c09IdV1MSnyB/0UMzhdkUW1+d9JchS31Em/hDQ2KEyXEmnWTO/KfxTf
         LN1sugty7fpN7Tu129Yd/oiipdP92UiQ6YiTcTzh/yxjCQOQetS53bJ7vylloaV3CLCR
         zii5LvQOdM+8fdSMhXiiaZDZ0s9vzS7SWXp0kQu3IP1psgAI3av+bLI2W77eGWBMAd/p
         baYI9QW6ccaJ6q8MiiO6FdvoHTbPpvCjuhonV/p51R6WpsU38kDx93OXeH5DSBOhcxN2
         vVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765337747; x=1765942547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xol+iuIYvZWYIOL+5973No6fzwz+93nXjs8TQCArr+U=;
        b=IXTqVFQqA4+hXdaspVw41i3RtZB2lDSK4IaR8T103kka2qY/3Nd/pQeomVIV5/Ma3i
         84c3RuAuYE95KpARh2YS5KYHDinsc2Mwgn2xpXAy+BBCNHCc6iPrPcK1r6MurS6WNKIU
         NKuHY4r9YncUD/pByZM+o6sL29JciKWTCSNmB1OnFdVD8zW5K18kOJnOOJ3rSkapdMUh
         1/7luOJUYBX8VXVV32OhGEVHv9xWvPmJt69iulvv/lu83E+nBYM/ChDcXoN2X8hKmlv0
         Ln/5YOC7KNLhAtX3KljcaCpwnuVxPM1h6VboSTG0yZXKuUq8zg4huHyEC8qY07XP8wEJ
         oM3w==
X-Forwarded-Encrypted: i=1; AJvYcCUnk/3O5HZVLtB3ciyW2UtB2mTONCVoCcq8rj2EfDhAoMdWIq68J3vmGXR02KyKdyxuO0rscbgqc8cqtqLp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuiqyz9Fqk8tbwFM129X2gFBXUWL2RnQ1aOsYqSoxm4GkMqeIl
	T/TmSbO+txc6IFvw0LuEGTF0XUg1FqoiGIQUmtNm7sr0y3/RxIx+LyUbByb2Og0jTxPG3qntZqN
	bx32/MBI/imzsy7aRGDUfLos+wEjWZGH180zL9EyoKA==
X-Gm-Gg: ASbGnct7UnpSg9E0vWK4f1l1zeR8BP0MFit4NPBP5Ibbum4rX1j11mIik+cwUvtya3G
	Tu927OjRzzxSHKOI73Dc+TAm1r4U/0DoT2vlw8WaVGa7ts5GuK2KchXlxP+YzRBh4ipqjbV/pEK
	6uLcwZ5JdsVObR+8/bgXXgEtD3mpvgmxUo7i4nWnlRpQ/UNv8g7ijS1PlvMryxFb/GV1cSdRGoz
	CLjWvwT4EtnLexpXGz6N+jnu3obU8S5CQdhQrvIV/7z8rapxv2Vm5ccemhrk/MKSQBN/3Q9873/
	1M+aCeU=
X-Google-Smtp-Source: AGHT+IHeQBaQ81Ge8ppIKmo2wz8sj/9ALb3NU1XQiA2jP92O2HvLRiSC53CGUBBiktuLATlmRLw4dMNRfHCO1Q4W3Xs=
X-Received: by 2002:a05:7022:60a9:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11f2966a2f7mr410601c88.1.1765337747057; Tue, 09 Dec 2025
 19:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com>
 <20251203003526.2889477-8-joannelkoong@gmail.com> <CADUfDZosVLf4vGm4_kNFReaNH3wSi2RoLXwZBc6TN0Jw__s1OQ@mail.gmail.com>
 <CAJnrk1Z_UZxmppmXXQr3joGzMSdU4ycnnGt=SacQT+6DbALDmA@mail.gmail.com>
 <CADUfDZov3Nk81k8cvdz1ZoXrbTDJfJryHjNza3ZUJyXtfE5YgQ@mail.gmail.com> <CAJnrk1ZmJ8V3MOpcEYks5i3dG431C7PmB14J7N2k22rn41ROuw@mail.gmail.com>
In-Reply-To: <CAJnrk1ZmJ8V3MOpcEYks5i3dG431C7PmB14J7N2k22rn41ROuw@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 9 Dec 2025 19:35:35 -0800
X-Gm-Features: AQt7F2pIpZZvs8dsA_IHdvMoyQGHgKU7_q05nwIJwBpzHSjOdD0Nn46-9bYvvVI
Message-ID: <CADUfDZqmj0X0e+DzFG-8W7cOkjj1emNzovitCL4E8SyLHmR4Ag@mail.gmail.com>
Subject: Re: [PATCH v1 07/30] io_uring/rsrc: add fixed buffer table pinning/unpinning
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:07=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Dec 3, 2025 at 5:24=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 3, 2025 at 2:52=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > On Tue, Dec 2, 2025 at 8:49=E2=80=AFPM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > > >
> > > > > Add kernel APIs to pin and unpin the buffer table for fixed buffe=
rs,
> > > > > preventing userspace from unregistering or updating the fixed buf=
fers
> > > > > table while it is pinned by the kernel.
> > > > >
> > > > > This has two advantages:
> > > > > a) Eliminating the overhead of having to fetch and construct an i=
ter for
> > > > > a fixed buffer per every cmd. Instead, the caller can pin the buf=
fer
> > > > > table, fetch/construct the iter once, and use that across cmds fo=
r
> > > > > however long it needs to until it is ready to unpin the buffer ta=
ble.
> > > > >
> > > > > b) Allowing a fixed buffer lookup at any index. The buffer table =
must be
> > > > > pinned in order to allow this, otherwise we would have to keep tr=
ack of
> > > > > all the nodes that have been looked up by the io_kiocb so that we=
 can
> > > > > properly adjust the refcounts for those nodes. Ensuring that the =
buffer
> > > > > table must first be pinned before being able to fetch a buffer at=
 any
> > > > > index makes things logistically a lot neater.
> > > >
> > > > Why is it necessary to pin the entire buffer table rather than
> > > > specific entries? That's the purpose of the existing io_rsrc_node r=
efs
> > > > field.
> > >
> > > How would this work with userspace buffer unregistration (which works
> > > at the table level)? If buffer unregistration should still succeed
> > > then fuse would need a way to be notified that the buffer has been
> > > unregistered since the buffer belongs to userspace (eg it would be
> > > wrong if fuse continues using it even though fuse retains a refcount
> > > on it). If buffer unregistration should fail, then we would need to
> > > track this pinned state inside the node instead of relying just on th=
e
> > > refs field, as buffers can be unregistered even if there are in-fligh=
t
> > > refs (eg we would need to differentiate the ref being from a pin vs
> > > from not a pin), and I think this would make unregistration more
> > > cumbersome as well (eg we would have to iterate through all the
> > > entries looking to see if any are pinned before iterating through the=
m
> > > again to do the actual unregistration).
> >
> > Not sure I would say buffer unregistration operates on the table as a
> > whole. Each registered buffer node is unregistered individually and
>
> I'm looking at the liburing interface for it and I'm only seeing
> io_uring_unregister_buffers() / IORING_UNREGISTER_BUFFERS which works
> on the entire table, so I'm wondering how that interface would work if
> pinning/unpinning was at the entry level?

IORING_REGISTER_BUFFERS_UPDATE can be used to update individual
registered buffers. For each updated slot, if there is an existing
buffer, it will be unregistered (decrementing the buffer node's
reference count). A new buffer may or may not be registered in its
place; it can be skipped by specifying a struct iovec with a NULL
iov_base.

>
> > stores its own reference count. io_put_rsrc_node() will be called on
> > each buffer node in the table. However, io_put_rsrc_node() just
> > removes the one reference from the buffer node. If there are other
> > references on the buffer node (such as an inflight io_uring request
> > using it), io_free_rsrc_node() won't be called to free the buffer node
> > until all those references are dropped too. So fuse holding a
> > reference on the buffer node would allow it to be unregistered, but
> > prevent it from being freed until fuse dropped its reference.
> > I'm not sure I understand the problem with fuse continuing to hold
> > onto a registered buffer node after userspace has unregistered it from
> > the buffer table. (It looks like the buffer node in question is the
>
> For fuse, it holds the reference to the buffer for the lifetime of the
> connection, which could be a very long time. I'm not seeing how we
> could let userspace succeed in unregistering with fuse continuing to
> hold that reference, since as I understand it conceptually,
> unregistering the buffer should give ownership of the buffer
> completely back to userspace.

I'm not quite sure what you mean by "give ownership of the buffer
completely back to userspace". My understanding is that registering a
buffer with io_uring just pins the physical pages as a perf
optimization. I'm not aware of a way for userspace to observe directly
whether or not certain physical pages are pinned. There's already no
guarantee that the physical pages are unpinned as soon as a buffer is
unregistered; if there are any inflight io_uring requests using the
registered buffer, they will continue to hold a reference count on the
buffer, preventing it from being released. The only guarantee is that
the unregistered slot in the buffer table is now empty.

Presumably fuse must release its reference count (or pin) eventually,
or otherwise there would be a resource leak? I don't see an issue with
holding references to registered buffers for the lifetime of a fuse
connection. As long as there's a way for the fuse server to tell the
kernel to release those resources if they are no longer needed (which
it sounds like already exists from your description of aborting a fuse
connection).

>
> > one at FUSE_URING_FIXED_HEADERS_INDEX?) Wouldn't pinning the buffer
>
> Yep you have that right, the buffer node in question is the one at
> FUSE_URING_FIXED_HEADERS_INDEX which is where all the headers for
> requests are placed.
>
> > table present similar issues? How would userspace get fuse to drop its
>
> I don't think pinning the buffer table has a similar issue because we
> disallow unregistration if it's pinned.

It sounds like you're saying that buffer unregistration just isn't
expected to work together with fuse's use of registered buffers, is
that accurate? Does it matter then whether the buffer unregistration
returns -EBUSY because the buffer table is pinned vs. succeeding but
not actually releasing the buffer resource because fuse still holds a
reference on it? My preference would be to just use the existing
reference counting mechanism rather than introducing another mechanism
if both provide safety equally well.

>
> > pin if it wants to modify the buffer registrations? I would imagine
>
> For the fuse use case, the server never really modifies its buffer
> registrations as it sets up everything before initiating the
> connection. But if it wanted to in the future, the server could send a
> fuse notification to the kernel to unpin the buf table.

This seems to assume that all the registered buffers are used
exclusively for fuse purposes. But it seems plausible that a fuse
server might want to use io_uring for other non-fuse purposes and want
to use registered buffers there too as a perf optimization? Then it
would be nice for the process to be able to update the other
registered buffers even while the kernel pins (or holds a reference
count on) the ones used for fuse.

Best,
Caleb

>
> > the code path that calls io_uring_buf_table_unpin() currently could
> > instead call into io_put_rsrc_node() (maybe by completing an io_uring
> > request that has imported the registered buffer) to release its
> > reference on the buffer node. For ublk, userspace can request to stop
> > a ublk device or the kernel will do so automatically if userspace
> > drops its file handle (e.g. if the process exits), which will release
> > any io_uring resources the ublk device is using.
>
> Fuse has something similar where the server can abort the connection,
> and that will release the pin / other io uring resources.
>
> Thanks,
> Joanne
>
> >
> > >
> > > >
> > > > >

