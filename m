Return-Path: <linux-fsdevel+bounces-17460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550238ADD0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB18B2216E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 05:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410520328;
	Tue, 23 Apr 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYcTRiX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8461C290
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849259; cv=none; b=NSM0Qvllr7CgJSLO6+gWECb3QTbw2HYrKmbBiKEDWxTgYeNJnRpZ7IL7kENLS3yBLV3t60P+KuwzXhJNQCrEXugmiH5f+XmqzrDKSgCj0JYhRMdgZpImHuJM3RVHhwboauWv0wS7dVpUH7Tx2y71AwLDloCeHRFh5i+XUbcP05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849259; c=relaxed/simple;
	bh=8yyBVKkTgNiqkt7uub3qkGub7eHvgXD6vg1BZ8Og4Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF7/e8Chy1XRKO3wFmxm7NlLedHvqyROvbGAHfebAiEw4s6jofM7Jtu1EfGnz0gdJlMGrRMK80XS8tyLc0lsqQsUgpS+8XhzhgUdDVbCPN33+T+5a4FlBZHx3mSw5Ehn1dHr19Oi6mXmjOIRDBBst4K77b7fajeFPkeBlGZqMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYcTRiX6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5196c755e82so7323724e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 22:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713849256; x=1714454056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty7NAHFgNwCZIkWLvAwoY1q7REtM6G10uSf4N0NR32w=;
        b=HYcTRiX67VAIgvY4Em4VJuqJAuYKDzhV838InLIIQjZjyl9VpPnB6sqZnYTZq6rl7I
         vaWkW8vYQSRNf/TIVQU3aYXQe2qRTeIgko/R1sSYoMDTQr18kjgxjmyCvr6Ec1hGR9Bp
         W6S2Aao5A1EJZN6FK9ujqsgAx849JwXzqG1FY8gAqRW/1c5Vn5xCmRevi/nSOiyy9Omq
         mhWa8talf4YtHl5H7c2vBEXqdKQ0yu9eMeT29GbaM7vnrZbgm9YLEN0mWw0IIUZZao3Z
         hBvt7F0LPxUssdtNpsXIpNdgXDvcCHtaiIIP1rLuMJqGIE1o+jPEwFGxXPwj9Uj9ILAK
         itSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713849256; x=1714454056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ty7NAHFgNwCZIkWLvAwoY1q7REtM6G10uSf4N0NR32w=;
        b=rJ2o3IDrOkNo/MfphImUkKI9qfCXvxm37To1oHbrqJ8MDC9iAgWpNGVkzL0Y8+pdGo
         gQUoXo71o//2LDBGQracJNsD1Jz/EQI8DC2A0+wbNGkyxKthaGrWanv/JrXxbHQkGCBw
         BC8kilwjJ/lT7WL5+tXLVP6mseklz6vCiAVzjEb4dFV/wrLswLdy6mW08R8Qnl38BVv0
         QBrFxXBM2NPL9R6dsCg+5HyMKlZ/YMgegrSnRjOHAWU2ksahkZ9ONZSVw7sS287C1w4x
         69TMxkzrCYkJOo8+ti+oUyK39MVdbUPRJ6JKsMNWws3KS1RBRub886qMks5lGTOeLSIW
         WN4g==
X-Forwarded-Encrypted: i=1; AJvYcCWxnCq/1c9LvBsBdbUUS7CnRAF0pFpqxePFRAqyRN7bJ5KYHg2uei1ps4UwA24DvhDS7tp8kQp2jDwJvjDxmBfSOY9LNsZd+wlTMEqaJw==
X-Gm-Message-State: AOJu0YwN/uHoXmSnrHltPbfH4ToMWZOZiDZZA67XDd3qeH5/k5mXNYrQ
	tiOoEea0XZ1zMOVtRwQgOPp2Q9iTqrnujyubOMRTk6QrCFcejBaJBmyJZf7DxcVJqoz704RnMRP
	hHhtkMImyoEijSRWLzZFLn1z1sEfoTQ==
X-Google-Smtp-Source: AGHT+IG7zpXSAERx4kujPmh8EJVFQFRz1XKFOsDyDh5W2znGsZZNQMhcv3MMBIULL2VA/yXOZVAWQacCe2sST1oZ+3E=
X-Received: by 2002:a19:a413:0:b0:518:e2eb:ca82 with SMTP id
 q19-20020a19a413000000b00518e2ebca82mr7140102lfc.41.1713849256288; Mon, 22
 Apr 2024 22:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416180414.GA2100066@perftesting> <Zh7g5ws68IkJ1vo3@casper.infradead.org>
 <c7jgzgwy74tr4e2l53mrp7p76kmtthkexnydtuigipmqzgjuu4@edux2yftjn7p>
In-Reply-To: <c7jgzgwy74tr4e2l53mrp7p76kmtthkexnydtuigipmqzgjuu4@edux2yftjn7p>
From: Steve French <smfrench@gmail.com>
Date: Tue, 23 Apr 2024 00:14:05 -0500
Message-ID: <CAH2r5mtppyq0z1hmfCgY8jk8_pzWRot4DwdWXKcBREijPSCU0Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 4:12=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Apr 16, 2024 at 09:34:47PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> > > I would like to propose we organize ourselves more akin to the other
> > > large subsystems.  We are one of the few where everybody sends their
> > > own PR to Linus, so oftentimes the first time we're testing eachother=
s
> > > code is when we all rebase our respective trees onto -rc1.  I think
> > > we could benefit from getting more organized amongst ourselves, havin=
g
> > > a single tree we all flow into, and then have that tree flow into Lin=
us.
> >
> > This sounds like a great idea to me.  As someone who does a lot of
> > changes that touch a lot of filesystems, I'd benefit from this model.
> > It's very frustrating to be told "Oh, submit patches against tree X
> > which isn't included in linux-next".
>
> I think an even better starting point would just be (more) common test
> infrastructure. We've already got fstests, what we need is a shared
> cluster (two racks of machines?) that is dedicated to automated testing
> on _any_ kernel filesystem.

Yes - this can be very helpful.  Although we have to deal with many types o=
f
non-Linux servers with cifs.ko (MacOS, Visuality, Windows, Azure, NetApp et=
c.)
at least we have two Linux servers that could be used as test targets
easily (e.g. with localhost mounts).   A lot of what I struggle with though=
 is
how to sanely automate testing of pull requests to branches (as large
projects like Samba) and the automated backports of fixes, and
handle good automated collection of traces/logs/dmesg when tests fail.

> I've got the code for this all ready to go, as soon as someone is
> willing to pony up on hardware.
>
> That would mean people like Willy who are doing cross filesystem testing
> would have a _lot_ less manual work to do, and having a cluster that
> watches our git branches and kicks off tests when someone pushes (i.e.
> what I already have, just on a bigger scale) would mean that we'd be
> full test suite results back in 5-10 minutes after writing the code and
> pushing. That sort of thing is amazing for productivity... no more
> sitting around twiddling thumbs waiting for the evening test run...

I agree ...


--=20
Thanks,

Steve

