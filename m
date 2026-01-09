Return-Path: <linux-fsdevel+bounces-73083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B27D0BD69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 19:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61519303C610
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D5366546;
	Fri,  9 Jan 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPJDQBRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944C365A1A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983354; cv=none; b=JoBLt2fn4gaqOOKT6P9raLwtRHutmlRpCAlSjTYTvERvJeu1vvWAMc5WxqsEACLI2jt9OH1Fd11IXxgFgwI53dWpOZcxc/l5cf7ZnfppwXHYf7orSDAPT3DrqqbSXtJGTK/AIN94mh99ezOqHSWXhnLlhBvFx/sAIWKvPeowNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983354; c=relaxed/simple;
	bh=gULrGtwXTAPRy+8OxBRogUTqQoGyIVHLqsdnpZks/kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG9cEj4w9X8FeXKsj4nZGQvvfHtGWrqNx7Es3AoURxhfIxKRrExLRi3F3CWCcn9pb1H/Xz4QQWEjPYJ7DCKxkDYbOkz7YILr7NOaNgN+GvZ0OrO6Uk+SrUywAC+WuSr7PcASVT6czzcrhoXltlEywHAFzh6RfvitmvPnHYFxEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPJDQBRr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so8048991a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767983352; x=1768588152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LFlk87MY4BgVDFcPrcEaHbyHfSLfak2VXkUEp3KfkM=;
        b=mPJDQBRrqgsGUZnyeXN5yzRnT+et2XTbLjDMe5ZDW+cyD+JUEb8GCutVJvUBn0OYYz
         2W/ecs66/0ULobhnEAZLDKUETXM2Adj1VmhAP+LHPTv7KqXLCP83IVzU0CzkMPFYOr3u
         96uVRogSWj0b+KJbEUzd52RmzDFVFYokOfzjOZ62jDWqcYLNKkQxgRXzXt24prbWdl8M
         POJ6GT8Fsp//Q5bLWtRzrkR5wOIoc829TmGWttv8tqQS7SPQWij42esQW0yRiS2aSrt4
         uQElOBnOR1e9tzNgY7CA/gFyZ1+kGDy75yXdoJmg6qOIFRM+CRND8NjMNRFRwxsV+1P4
         St8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983352; x=1768588152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LFlk87MY4BgVDFcPrcEaHbyHfSLfak2VXkUEp3KfkM=;
        b=CBa0xasj0tTeaGSrXsy4MXxQlheg/lvqsBG0IYGD+tb6i65MPxIwOilay98R9EVgC4
         Q0wSgxRTZEY5CLSIxfANj0xxxqekvokn7ClSpz4wMojQVtmDG7cdxVHwAg6mpEK4ua/m
         FIqdfIaWL72K4Qb/TbSyCXu2GAljXsdn0dI85j3vyg+/Fu9IATd/1AV2ZD2jN4Py+MN0
         mYNUC8TaduOIAwItY8H5rOmNkRd3zckb2GZ9de8tH+cOi4yawz2wdTqiYWnv0eunE13S
         uUrYG+dx2qc9X1e2udcWvGVlahvH9uZRua6VUZ6fOnit3M1Hw+HQ228eF0DvWB3cGc3k
         2irQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3J3Ay2navmdCOQO5iVF1ekc8FUvHw2Ui6CWuG4VOPLtmzHuu+MkBCgZHvwBay0m1uHKa9/6nE/giA0d9l@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9D+vVN24hd8/pU8scAsdrbzUBjYneuL6tpigvbWZI5u+1X57
	13xKSCWKdJkA5Tk4rQqAxI4wS1qMXSozsTJTPS/EF0XBlX+Wr8u/3RFBGsl5nJSO0UWhLInBGDB
	2cgDRX9rCXhrKV/8ztoD3Fr5Adqoco9Q=
X-Gm-Gg: AY/fxX7PZgWLI7PJXfAkf78pw1ttxtMnr0rLqF/7fkXkBkaE1H489LlW/890JRDer+R
	eGIDhjul4TicCJ5O+NSzPa7jUGpZ9eoVKJ3EQWVOislk4rmwcG24NbbpomhO7/pr7+HG7zLMAPt
	h4PfStRGCVe9UyJYlIMFQg2RDm9JVIh7u+nVc//LAoPl1PrfaoxyPCSNzONDBKtBCNgdgUcAmVe
	Y5E69eadngRVStAOziiru8cP0LIo5sYwjqKzoxh5Jtbt7dQFiY/Puv4NG4YwHM51CSICCjDus3q
	K3d5V88wZcH/zruMcrZEbaQkUzfg0Q==
X-Google-Smtp-Source: AGHT+IEGyTeRNohLfHt9UUB+haTpFFKkf6E65ilqjPe0/PKzLT4i9aQ5J3dRRn5IzivUSdWu2G1COcGRMoxPv/0T8CI=
X-Received: by 2002:a05:6402:278c:b0:64b:7ab2:9f83 with SMTP id
 4fb4d7f45d1cf-65097e6b614mr8352336a12.31.1767983351630; Fri, 09 Jan 2026
 10:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com> <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
In-Reply-To: <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 Jan 2026 19:29:00 +0100
X-Gm-Features: AQt7F2oDZjQ-wkggomL1K6hbBcB9PbFjmcJhzGeKc3O-2yU4uVXIcdjCWv3dhOc
Message-ID: <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Luis Henriques <luis@igalia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 4:56=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
>
>
> On 1/9/26 16:37, Miklos Szeredi wrote:
> > On Fri, 9 Jan 2026 at 16:03, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> >> What about FUSE_CREATE? FUSE_TMPFILE?
> >
> > FUSE_CREATE could be decomposed to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPE=
N.
> >
> > FUSE_TMPFILE is special, the create and open needs to be atomic.   So
> > the best we can do is FUSE_TMPFILE_H + FUSE_STATX.
> >

I thought that the idea of FUSE_CREATE is that it is atomic_open()
is it not?
If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
it won't be atomic on the server, would it?

> >> and more importantly READDIRPLUS dirents?
> >
> > I was never satisfied with FUSE_READDIRPLUS, I'd prefer something more
> > flexible, where policy is moved from the kernel to the fuse server.
> >
> > How about a push style interface with FUSE_NOTIFY_ENTRY setting up the
> > dentry and the inode?
>
> Feasible, but we should extend io-uring to FUSE_NOTIFY first, otherwise
> this will have a painful overhead.
>
>

I admit that the guesswork with readdirplus auto is not always
what serves users the best, but why change to push?
If the server had actually written the dirents with some header
it could just as well decide per dirent if it wants to return
dirent or direntplus or direntplus_handle.

What is the expected benefit of using push in this scenario?

My own take on READDIRPLUS is that it cries for a user API
so that "ls" could opt-out and "ls -l" could opt-in to readdirplus.

I hacked my own server to use open(O_SYNC) indication for
directories as a signal to choose between readdirplus and
kernel readdir passthrough (not plus) and I have applications
that opt-out of readdirplus.

Thanks,
Amir.

