Return-Path: <linux-fsdevel+bounces-55496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D88B0AE66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 09:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7E21AA66E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACDD2309BE;
	Sat, 19 Jul 2025 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebDygrVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB71EB3D
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752909534; cv=none; b=hennnZUhh0yTUAEKqWR8v/wHRoBeehbPaoKjJcm8hJrEy/8XFSjRvMap6F+FtWayw8ieji8dMJiqeJm7tui/WdXBLMnrw3ptuJdzYF4pWowrAZ+M1mTGPgYFDImYJ2Ds0Y/W6dnVnRykttKxvRp8MklsKZkbm8vWC4N2SLfSCwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752909534; c=relaxed/simple;
	bh=RcV4ofaMD0ln0QQrrtaMhnyBiVUB5wuO5AM4vEVJWkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNxgBKtSLo0pLJSOHdbKOTieOCFD0un9ZanAALMuTDSZSWQUw03GNlICFptW2Q5llhPkA5Vo/tn22WBq3a9/ynFPiBSpeL6jUEVEHWxrxDrs8RgaaailDYN7FDji5xdw5sXuS4Y/V7kAwC0jmRSQFnddeEpzcm0dUZVPdRoyBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebDygrVo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso5565505a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Jul 2025 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752909530; x=1753514330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZoZLO8sCZIr37sqQ1tOZx8PcuQASs+TWLCu6eWfo9U=;
        b=ebDygrVoHXCVMCdoYyCtXkunyas8Ef5nIKXCq9tkVhe5Q78A+sIUV/DYjefAkd+VFI
         MSwDkbdmejYPoewW2cj/LanQ3tCWItRvKmvPk7u/gDCgH2XvUHAgxJt3DyPFRCdYUeIE
         9E3awKzUIoKYJiU0qI2ieR6U729+MD+zadZE9oNMhoY8LF47uRWUrAI8BMMKR5IPOT6J
         u5SJDlug8Ki3h59otN0iGcZr5DJltdCwBwwz9i1iS9HEA1GP9ICFY/ZbRLnWFc2cHTcF
         L2kOXqcj/B+D0wzX0v1I/bv5NrzWewzHGeI/aptMEOHCZhPxf63R7rGDDCVwCDjbMXVf
         5dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752909530; x=1753514330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZoZLO8sCZIr37sqQ1tOZx8PcuQASs+TWLCu6eWfo9U=;
        b=OzFjAU3nTDARG8g1HkTppwdJfHNvGZ2kUS8UY5Q7MNRBdUrwKTNrRSccf+KDDsRS9n
         ZkhBOQbmK8amkPj3DirE/OpcHiwZw/MIqXsQj1/9NUonSNJuupGKOuTw51HWfQfSK/Na
         mZjqotV4aVb3CqOCmnsabAJbEaFvM0C+26C/1SBnNypvb1p5c7hfJLd8MlhaUdUAVSkT
         unslptdA2iBKax3q2JQ4aBPWlku9OmlgOhMUKxj7pfSF2i7gxHxhd1vF4GyKfjJiapS7
         dKqTm5f9/YQZpowu0dha4oE8TTUpInNUrDyobZQcmh7joBV+F5W/xHmr7X1MPBbBH3NK
         mOJw==
X-Forwarded-Encrypted: i=1; AJvYcCVHc8hc6hcvKUqvTgFLrAHDPk6oL5YbRVTPIg9IepGXa9HaGGhMCWIIDVenBQPL9Cu00cyF7wjxP1iK+kg3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7VVwaDm/DMAOlVvDS6PgEOczkwqh6j+izPTl3kuB6m+tIfwg
	CXq5kvKkCvUFosULa7Yb/ZwLga5YZNpzeogZYC84ACxEcOeO9v+fMK7FyEjUybqjnmeTrYwJhfx
	InLRooRqILndC5Z6Y54ybyflD/Q4+4Rg=
X-Gm-Gg: ASbGnctAB3lxFOJBEwRhZaFimbZPFwfhWr3qZkFhs0DbNl+lsJ7dIiPnJuPq0Okzii0
	0zRnKSagijrD/J5tS7J9AkiEWMIAP+k5cjquqcfwmpvJkID0qZ5fDFeH5KMk9Y7q0USMaXuEK7t
	8rOAyU+Zwa84CVW8ctfdr2whCfQhseGeYZuXvJNLCfAyBFxPGA8zDeD2IT3+7fdBKaO8JUKjn92
	m/eQlLnoX5oeipSjA==
X-Google-Smtp-Source: AGHT+IHnqy1bbhlzExtnDXpCnrSKAeO/FJ3xDhyoYXT+bIV0gSDI2/cQi5+kRLBYKCAflEQUBjR1TUccZIplU3b/LFw=
X-Received: by 2002:a17:906:c9d3:b0:ae9:928d:f285 with SMTP id
 a640c23a62f3a-aec4fc88bc1mr729757266b.55.1752909529780; Sat, 19 Jul 2025
 00:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs> <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
In-Reply-To: <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 19 Jul 2025 09:18:38 +0200
X-Gm-Features: Ac12FXz5r5-_yZuak27TKoRMmmh6XcEXdPEwkTvHteb-6Thlm_At41ZlQTDQTak
Message-ID: <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	John@groves.net, miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 12:23=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.or=
g> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > generic/488 fails with fuse2fs in the following fashion:
> >
> > generic/488       _check_generic_filesystem: filesystem on /dev/sdf is =
inconsistent
> > (see /var/tmp/fstests/generic/488.full for details)
> >
> > This test opens a large number of files, unlinks them (which really jus=
t
> > renames them to fuse hidden files), closes the program, unmounts the
> > filesystem, and runs fsck to check that there aren't any inconsistencie=
s
> > in the filesystem.
> >
> > Unfortunately, the 488.full file shows that there are a lot of hidden
> > files left over in the filesystem, with incorrect link counts.  Tracing
> > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > commands that are queued up on behalf of the unlinked files at the time
> > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > aborted, the fuse server would have responded to the RELEASE commands b=
y
> > removing the hidden files; instead they stick around.
>
> Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> of synchronous. For example for fuse servers that cache their data and
> only write the buffer out to some remote filesystem when the file gets
> closed, it seems useful for them to (like nfs) be able to return an
> error to the client for close() if there's a failure committing that
> data; that also has clearer API semantics imo, eg users are guaranteed
> that when close() returns, all the processing/cleanup for that file
> has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> the server holds local locks that get released in FUSE_RELEASE, if a
> subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> grabbing that lock, then we end up deadlocked if the server is
> single-threaded.
>

There is a very good reason for keeping FUSE_FLUSH and FUSE_RELEASE
(as well as those vfs ops) separate.

A filesystem can decide if it needs synchronous close() (not release).
And with FOPEN_NOFLUSH, the filesystem can decide that per open file,
(unless it conflicts with a config like writeback cache).

I have a filesystem which can do very slow io and some clients
can get stuck doing open;fstat;close if close is always synchronous.
I actually found the libfuse feature of async flush (FUSE_RELEASE_FLUSH)
quite useful for my filesystem, so I carry a kernel patch to support it.

The issue of racing that you mentioned sounds odd.
First of all, who runs a single threaded fuse server?
Second, what does it matter if release is sync or async,
FUSE_RELEASE will not be triggered by the same
task calling FUSE_OPEN, so if there is a deadlock, it will happen
with sync release as well.

Thanks,
Amir.

