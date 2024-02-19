Return-Path: <linux-fsdevel+bounces-12056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0785ACB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 21:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B799FB2457E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBEA5478B;
	Mon, 19 Feb 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="C5oqa2b0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9A54675
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372751; cv=none; b=BxN72oPTXTYa6xlG1ozi0yfmkHe8IaIb2sT2XFKIDiJDybhfdUOHab0K3m40fIEL4BRp2H2Vmf2l8EXIMcAfSMFx9q8I483VA0ZwM4szPsydY6vNDQqk1k57SACQKXMvHk/mFcMzJ5hd1YHlmv5NsP2y2BS47T1MHgIKWXtL3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372751; c=relaxed/simple;
	bh=ofjInoWHKA5k7Bh2Hd1BX7kszhP5rQ6joRa/kjdDVVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKKFIljzIlpLaR6D4hXREL/no2Z1hyFsDiE11xp6r/mxv9bp9TrH7rCBZzmJB+hBt6jKoz+jXd7k9haOlwdJ9oVRBlq+1aCJb94eUo0J5C8D9w3UJ9IuV0gCTA3w3EgR2aiOVSHX/llt5iRNv612jR73mcNjczBGsdbpqxBGYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=C5oqa2b0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512b84bdaf1so1438482e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708372747; x=1708977547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGvC62IGF3u3yi/URM7lyrZg3XibNCK1lsVTIkk+gFY=;
        b=C5oqa2b0vXH89aS+ZfD1cqcV+n7Q6k1aBwuNDYHPWo1WxItLoW0iqqYfDc6e7wxV5c
         RLHtMFuYjd5wS+Wi+ca5P3lecVkHLatL+AFaOj1L8UZcIaPGxPRaLWb4FUAOlkbpj5Fc
         Yx8ONzU6iOvgPoav8grtJJnROS2YkuBgq46Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372747; x=1708977547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGvC62IGF3u3yi/URM7lyrZg3XibNCK1lsVTIkk+gFY=;
        b=vB89bR3zFX/N7w5iMN2CzuyK/yfO3vHMz7JPu5H+TOgvD17nl32nTD2yQOQkDI0xRl
         qBv9rgD9o3XWZO01lXHT+vbf36TLmyOIDUUqMtdYcR0A9Wzf7+S1Dt9OrhlPldxeLQAA
         rU94fgdSe6IhHf8DiZoS0Wfiz36hA/3RfGwf9N4QfbBF3CARknXRRkolvvslKHcRrghp
         g11ZxD0cwVlUc+orTmWA9DjPvyodtSM2Twy1+NCMUNwyFt3Io0FmDw6CGF8GuT7FGTxd
         KzowzIb9cSGE4hYxi6xYNiOmjz6O+O4aQnlWGpnDF35V1B2eM24Tae8fHHXu5mzWCVaY
         8wPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJLcbhyycvEX+EJdv0l5bgUDtpBDAqvLH2FQIuEbWJZ5ZYXe3cxNYR96CpTWCiGoSMOti5REIRJJZ12Fh2oR+hfMMqdi3W3lcfk41WCg==
X-Gm-Message-State: AOJu0YzCf0+UPN2luQOJNYI5T8tpRVyJI2IOzl3/W+l2o9CimUr/a3XR
	M3SoJzd6Vg0FpbBLcp3tj+fWK0sZPIqEea+XlGNJvRVoikoPoEX5HyFv97EWfr4Cz+4BzP12PsM
	jxGRnbg6IBPwdfgKzSXDFEMEppxAj+ESjjr85S+/Vxj829YAc3OU=
X-Google-Smtp-Source: AGHT+IFrqbY0boOgYQoJljY9NUPsrocT0RXCr2QyYsnrZXgv+eT6Bo4ASt3NfJWz7o/1kNtCD6Uj8V/4/bV4nO7M/Js=
X-Received: by 2002:ac2:5584:0:b0:512:a899:34e9 with SMTP id
 v4-20020ac25584000000b00512a89934e9mr4139621lfg.58.1708372746765; Mon, 19 Feb
 2024 11:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
 <b9cec6b7-0973-4d61-9bef-120e3c4654d7@spawn.link> <CAOQ4uxgZR4OtCkdrpcDGCK-MqZEHcrx+RY4G94saqaXVkL4cKA@mail.gmail.com>
 <23a6120a-e417-4ba8-9988-19304d4bd229@spawn.link> <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm>
 <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com> <8fd58ae6-164c-4653-a979-b12ee577fe65@fastmail.fm>
In-Reply-To: <8fd58ae6-164c-4653-a979-b12ee577fe65@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Feb 2024 20:58:55 +0100
Message-ID: <CAJfpegvgwZsoFpEUnqPkAXCST3bZYgWNy4NXKHOfnWQic_yvHw@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 20:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/19/24 20:38, Miklos Szeredi wrote:
> > On Mon, 19 Feb 2024 at 20:05, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
> >
> >> This is what I see from the kernel:
> >>
> >> lookup(nodeid=3, name=.);
> >> lookup(nodeid=3, name=..);
> >> lookup(nodeid=1, name=dir2);
> >> lookup(nodeid=1, name=..);
> >> forget(nodeid=3);
> >> forget(nodeid=1);
> >
> > This is really weird.  It's a kernel bug, no arguments, because kernel
> > should never send a forget against the root inode.   But that
> > lookup(nodeid=1, name=..); already looks bogus.
>
> Why exactly bogus?
>
> reconnect_path()
>                 if (IS_ROOT(dentry))
>                         parent = reconnect_one(mnt, dentry, nbuf);

It's only getting this far if (dentry->d_flags & DCACHE_DISCONNECTED),
but that doesn't make sense on the root dentry.  It does happen,
though, I'm just not seeing yet how.

Thanks,
Miklos

