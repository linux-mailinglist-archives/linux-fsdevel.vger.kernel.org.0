Return-Path: <linux-fsdevel+bounces-26556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B523E95A672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1752859E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9FC175D30;
	Wed, 21 Aug 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXkwfR/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D6170A3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275339; cv=none; b=rEXx+kv2hpprFLAkuXwKWN5FuNU35pLPN4dTWbnO8XZA+66fPa2vaWyROext9CAQbiGa45EIa/6ifJCShiKVFy9aWcMLGx5w0KX4gcWSxATcSEzqeKCPp+nhVIAVUQZA4HGSbn/hgz2U0s+J9mDQX13ER0zabGR1Jn5VSgSlOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275339; c=relaxed/simple;
	bh=WL80mV1UUyNJSz4OFt4b8PaU0xtyGSYxFPA7bJTkFX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSdBQCh/XZwTyn0vFFGa+67/5aiCBdd4/kFWeNkDM74y2rf1zmzeP6kWiTWjV6JzHmV7vVnuMuvLQlNXkWKMjg8Excg7XlnzsZCV+9s+C/alf58kntqjsMXUMzOK/GrK5n+6oVVtXt8Bfbf58/eleIGdZ0O0Wero1Sxx/6kY7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXkwfR/y; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fdde0c8dcso1156731cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724275337; x=1724880137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj1PhoR9rtoU/lUgrWxnap0uTdahI0KgFEDWZkDpU/g=;
        b=UXkwfR/yurD9Rl3dBIMi2xFtJIPClsu4Dss8YBnStdXXs1xzeDod38KVgjlaEEma9k
         5NYHw7YqBuhuzkZ+Nb2Cf0cFPLNaUiDz0WJ3gBc2pn8kdAzjibRKHoi6P1HNnB4sPV+Y
         ESJeDnFo9GwEvD4o6S7Dr5EtHOXICJFSmwt2nTJXjf0AfBHRuQDiJdYp2RxkwdAPd8Bb
         0sRr3BeqNWEtyuT4/ndNufZHRI5hdGk4SC6W7nv7j7+LuF4E4XEj1LYRSFSeky/5nIuw
         cfBj6SG258wIfZ+PbzxpwUO+pqmeX1GF4tOfme5YNs4HHob8PqLKNkmoTNpMNWWew03l
         QCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275337; x=1724880137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mj1PhoR9rtoU/lUgrWxnap0uTdahI0KgFEDWZkDpU/g=;
        b=uIpmMeGKQUiI55J8kvCskvrQ/OlojLbi2BXP/2uHcISz0nUYSmHIe9vp5RvSJp4oMG
         7n7rH2XR9FR68BO/LzOPGYY0YUTfjBpUWkk3hEvkAHxKTtwpKgCYxsj1nnwP+Rg35rV9
         6binNZWoFlZVW+xA7f6bBgAKd/ZeEXhx6BroPwo/wLua/aanrBsVfWfPs7CT++bXfvps
         PwGD1ka862w8V2mpJxzfDhOcsgyibbwFmnXkkbm04zQ+OoPn8QV3x7aK/4H7zmJ4OSgN
         kR+xDtaGJ2KcfB2wI/u5cBcDKJILPCmtw1YsbAEySOwE4BujhLkMzXcnw3fqOu9cnb+L
         j7+A==
X-Forwarded-Encrypted: i=1; AJvYcCWu4q1HXsfueNG77aQy0dQsF7GX33kjG1uVez2O20HruEWEeIcg1yT+Sstpa172IfO9D/8L7d1Z8rtSFWNE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1/j1+YattuyzRiVSem285Hxq3NPKPU6YHwMU2PfB6j2qssZ/d
	WYeWVftA93Y7cFn3R55XhGxj/3JkTur66NqN2nSu4pgOwIGsqu4Zmd7ucMzbQOi5nZduREAqFgG
	rKViXbqhujhr+KH01Dug67yiG5CVPWuq3
X-Google-Smtp-Source: AGHT+IHmgUFPO1gjdXGN/e3BYhsvWeKiJcA1qcaV7Vl+wSGK4GLB68KXrBNGOZmmpdza/tYOWn79oKj4MWBbtlGydQ8=
X-Received: by 2002:a05:622a:5106:b0:453:74cc:ce09 with SMTP id
 d75a77b69052e-454f21d2e44mr37091821cf.8.1724275336646; Wed, 21 Aug 2024
 14:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
 <20240821181130.GG1998418@perftesting> <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
In-Reply-To: <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Aug 2024 14:22:05 -0700
Message-ID: <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:54=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Wed, 21 Aug 2024 at 20:11, Josef Bacik <josef@toxicpanda.com> wrote:
>
> > "A well written server" is the key part here ;).  In our case we had a =
"well
> > written server" that ended up having a deadlock and we had to run aroun=
d with a
> > drgn script to find those hung mounts and kill them manually.  The usec=
ase here
> > is specifically for bugs in the FUSE server to allow us to cleanup auto=
matically
> > with EIO's rather than a drgn script to figure out if the mount is hung=
.
>
> So you 'd like to automatically abort the connection to an
> unresponsive server?  I'm okay with that.
>
> What I'm worried about is the unintended side effects of timed out
> request without the server's knowledge (i.e. VFS locks released, then
> new request takes VFS lock).   If the connection to the server is
> aborted, then that's not an issue.
>
> It's also much simpler to just time out any response from the server
> (either read or write on /dev/fuse) than having to do per-request
> timeouts.

In our case, the deadlock was triggered by invalidating the inode in
the middle of handling the write request. The server becomes stuck
since the inode invalidation (eg fuse_reverse_inval_inode())  is
attempting to acquire the folio lock but the lock was acquired when
servicing the write request (eg fuse_fill_write_pages()) and only gets
released after the server has replied to the write request (eg in
fuse_send_write_pages()).

Without a kernel enforced timeout, the only way out of this is to
abort the connection. A userspace timeout wouldn't help in this case
with getting the server unstuck. With the kernel timeout, this forces
the kernel handling of the write request to proceed, whihc will drop
the folio lock and resume the server back to a functioning state.

I don't think situations like this are uncommon. For example, it's not
obvious or clear to developers that fuse_lowlevel_notify_inval_inode()
shouldn't be called inside of a write handler in their server code.

I believe Yafang had a use case for this as well in
https://lore.kernel.org/linux-fsdevel/20240724071156.97188-1-laoar.shao@gma=
il.com/
where they were seeing fuse connections becoming indefinitely stuck.

For your concern about potential unintended side effects of timed out
requests without the server's knowledge, could you elaborate more on
the VFS locking example? In my mind, a request that times out is the
same thing as a request that behaves normally and completes with an
error code, but perhaps not?

I think also, having some way for system admins to enforce request
timeouts across the board might be useful as well - for example, if a
malignant fuse server doesn't reply to any requests, the requests hog
memory until the server is killed.

Thanks,
Joanne

>
> > It also gives us the opportunity to do the things that Bernd points out=
,
> > specifically remove the double buffering downside as we can trust that
> > eventually writeback will either succeed or timeout.  Thanks,
>
> Well see this explanation for how this might deadlock on a memory
> allocation by the server:
>
>  https://lore.kernel.org/all/CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZt=
wFeRuYw@mail.gmail.com/
>
> Having a timeout would fix the deadlock, but it doesn't seem to me a
> proper solution.
>
> Thanks,
> Miklos

