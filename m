Return-Path: <linux-fsdevel+bounces-22188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90189136AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74071B21ECF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 22:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D63D7E112;
	Sat, 22 Jun 2024 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EFrAXF8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACA629E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 22:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719096102; cv=none; b=KUVWwQJGwUVjSrqIp+1u0znjJLwABFMD5EZdRMPBk1eJuTxQYbO2p1IzUayyvPYFWYT8pZPsRcUPMO2OMLGJe2KO9S1dY3DNezvCRjajTPVn/In34gWTeygRlcSWDudCrJlC+wZ0H1MY7fU3eTCtE2gXvre5MSYUZJKHCsC91As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719096102; c=relaxed/simple;
	bh=kqyVjEgP3/7mXzKVNMbYCUNnf3n+IgnYTEx7zPeTiw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL01Ld1kHRfZkiSb3y/rL6t3Hary/ehb+QBiRbGGgbmWhtE3y3CGUynXcFsRpzIw5MLRQHaLmGtAC93tWvngJSG7kfZMIbHrO0x6OIqObKDWJNMwmm07J1QvIWz5/Raejsl0PlDIlrjatGUOn8XiDIi1r+XdSqttXPEJ19Q+WQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EFrAXF8h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso4048648e87.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719096098; x=1719700898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=EFrAXF8h1pSGOwzoYiY+6MYJ5abB/1iVrSeKo7TF2epGiiTgPM19jSh+y47wH9cgmz
         gjxQsa9eCVBo0T1+E8AFf5txp62LeiEOxGsimOLj2zmmiMQuAFMRfuo13MtHT0zNEnmu
         C06HsK6ZiVSChulZyu6nIx0o4HBLbmZs9E12A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719096098; x=1719700898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZntylMGkkO3rfxQI8jPvTsKY/9VRyoYvjHsl0ZwmXlQ=;
        b=E461gvVluoijS04HZPlkSLcDaq8cdGiB5ILCziQNWP57mkK0LD2TKxY7bPN82vMQd4
         d3Rmi9QwKWkVrIV0Bc3eN5rM0PXMZoqx6yMJQ5MxDkaSHy5L++iE6ZUlkfRHeqFClG5P
         gAc96pdNdNcPgKqWv5r0c9aU0B9oXUF7eq9E0pgCpdV4B4KHiF7dthdVFAwl7DaXljni
         7OUoko6g8Rn6+um5k8nQ2bL6ANsOGAdgArXGpdzElYCWCEYeWLY4drcUfZW9kDL0Wlrx
         TkB3w02s8r8RtP7Rg3yR309htIUgYdR6OgfA+0nub1SzqXpnbM4qR8YBXCstcq/2XIrW
         Vv8w==
X-Forwarded-Encrypted: i=1; AJvYcCXwVLZkGYRkBtKJxMa6rfyjIOfg7VCNsRGzY//xegDenGd1x1srJ728X1xMHoW5PdVsMJynr4SVkavsymQpsp2xIz14QqDFuVHUwbRfAw==
X-Gm-Message-State: AOJu0YwSQzIhD8ogNjYVuoYNfwOOsy2/l/ciBiJr+/CRIO7z2hWlbzuB
	aWls3nkb73Mdt/Rp/55+jJNFrRTYg+ifn6B80/uzBTmpzR7m0JHMScs5qX5Nx56qv73Zk5s/lHO
	MkRs=
X-Google-Smtp-Source: AGHT+IEZ05qh7tkcls8AZlUBNa1qeDTzQRM34QFXfIr0h0bmCWElSfNM2nsVlVxMzutalCVdpn4XTA==
X-Received: by 2002:a19:ca0d:0:b0:52c:dea5:7c8c with SMTP id 2adb3069b0e04-52ce1835148mr466120e87.22.1719096098472;
        Sat, 22 Jun 2024 15:41:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72479f360bsm27781166b.173.2024.06.22.15.41.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 15:41:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so3611023a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 15:41:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNdHaD1nj0i9uebH6Vq8pd4v5pN2zlBelbi7F2xpQnuL3APkNt/fLIjj9xDjn5akmlgIpz0xjeD7SRX/+9kl9IkvLeFrKbnzImIR2Msw==
X-Received: by 2002:a50:d653:0:b0:57d:785:7cbc with SMTP id
 4fb4d7f45d1cf-57d4bdbfae4mr617930a12.26.1719096096671; Sat, 22 Jun 2024
 15:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622105621.7922-1-xry111@xry111.site> <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
In-Reply-To: <kslf3yc7wnwhxzv5cejaqf52bdr6yxqaqphtjl7d4iaph23y6v@ssyq7vrdwx56>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 15:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Message-ID: <CAHk-=wgj6h97Ro6oQcOq5YTG0JcKRLN0CtXgYCW_Ci6OSzL5NA@mail.gmail.com>
Subject: Re: [PATCH] vfs: Add AT_EMPTY_PATH_NOCHECK as unchecked AT_EMPTY_PATH
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alejandro Colomar <alx@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> +cc Linus

Thanks.

> To sum up the problem: stat and statx met with "" + AT_EMPTY_PATH have
> more work to do than fstat and its hypotethical statx counterpart:
> - buf alloc/free for the path
> - userspace access (very painful on x86_64 + SMAP)
> - lockref acquire/release

Yes. That LOOKUP_EMPTY_NOCHECK is *not* the fix.

I do think that we should make AT_EMPTY_PATH with a NULL path
"JustWork(tm)", because the stupid "look if the pathname is empty" is
horrible.

But moving that check into getname() is *NOT* the right answer,
because by the time you get to getname(), you have already lost.

There's a very real reason why vfs_fstatat() catches this empty case
early, and never goes to filename lookup at all. You don't want to
generate a 'struct path' from the 'int fd', because you want to never
get anywhere close to that path, and instead only ever need a 'struct
fd' that can be looked up much more cheaply (particularly if not in a
threaded environment).

So the short-cut in vfs_fstatat() to never get a pathname is
disgusting - people should have used 'fstat()' - but it's _important_
disgusting.

This thing that tries to short-circuit things at the path level is too late.

              Linus

