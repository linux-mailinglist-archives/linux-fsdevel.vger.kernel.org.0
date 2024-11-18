Return-Path: <linux-fsdevel+bounces-35120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204D9D18DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 20:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F071F21ECB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BE1E5721;
	Mon, 18 Nov 2024 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ggvmb8Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE41E5005
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957994; cv=none; b=jWPiNB/A2I2jh1ib+01r8kwK4cflqTybzudbe538Kv85J2NOaHkhZ8kKU8rTJUR5SGyJSWz55NzwoxHB0MIoHnrWia65J8xcqiYhDzHQqBZFs08+00BKZtpIxIiOPMd++KuOR+iew8rwFCL5XWkXFP5zmqjhXIhv34KkCYHhfWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957994; c=relaxed/simple;
	bh=zUVH/uAD+IJTLUQDBYc09NFu0bSjr4OlrRtyJAhnrBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2xVKZ99jSJ9tcG+4HUAT1l2z2OI7OA2L6z+bgejd8otaRqvh8EKXKkYVVHJgRESwOZenMFnf4qFcUPNDA0Im3uXA7+ZtRxBNCMR/VNKBEOa3kh7mM0fhwthrHbZ1TKQGg0OA6f0Fsr9Aon31mxtugxTTzAHpxdfBLJp2RP5uHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ggvmb8Mc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa1e51ce601so472127766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 11:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731957989; x=1732562789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JYCS3Z6MiUnPrDvgzVamv2lmS38BP+UrcMAAY23BZP8=;
        b=Ggvmb8McADv0dJS5a1c+bREFDDd2pmnuS6SCw18hzYkx7Nz3UtZka8bWh6x0SWc5vG
         uZmYbDmy4n1v6jQKAuOwTXUUtgC/YYVhT5BgTcWIsTUvMlFMIyX7/rslfJtl3oLiibBD
         CHLK874swKbu0j5236YgyzUdCsvqWh5V4cn1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731957989; x=1732562789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYCS3Z6MiUnPrDvgzVamv2lmS38BP+UrcMAAY23BZP8=;
        b=rjnLPr5r2sw2YlP9wazFH3vWEEf5itMwGgaQ8F6kzwb5PQtWAzar9zGTUoTtGA/eF+
         Ulo7mGm6w0PFjrMzphC4F/M28anqvCUGNlIKcm6aR/7Uzlz+0U7J/bdoEo5gkvL8g4nw
         tKKyAyOKxAqITJgQkYzxH4vSRX3UwUqGizNTsuucorAp5F/8WbP3aEPAQ6CbvSoMeEgA
         wkvDaC/2jjnW/kT8JoRk8P/EiY0rKgKAuNqSstpBMclIaqg/zmZv2qqF9r0xNPE0RLfi
         78xjkIk6I06bz9Y/TcxncB3HuzYZ/ilpeTYqFp2LpftWHpmpg47d+VCFTH9p0xmfHGdU
         AxkQ==
X-Gm-Message-State: AOJu0YwlYFnjSGTQthaaqPLsPtvtPSDcVpO2Krt5oGyzAO/j0xE8X5C1
	iFu9Vz8E23vl7odrvsKGZNP71R1u6cd7QgH/UDLR6dYsw058pWBfcT/ub4jsrQcmWBU3syKLcJU
	qItLwhw==
X-Google-Smtp-Source: AGHT+IHgEhgmWrg5cSDGqvJj1WMMHtDdb4CM57jUC9UT/7wGZ/3a++pwdrHou31SvuqtvVBQ1iYuyQ==
X-Received: by 2002:a17:907:1b02:b0:a9e:d7df:8a7e with SMTP id a640c23a62f3a-aa48347c883mr1290677366b.31.1731957989544;
        Mon, 18 Nov 2024 11:26:29 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfde8b7287sm77926a12.42.2024.11.18.11.26.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 11:26:29 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa1e51ce601so472122466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 11:26:28 -0800 (PST)
X-Received: by 2002:a17:906:d7cb:b0:aa4:c8f0:6ea1 with SMTP id
 a640c23a62f3a-aa4c8f06f4fmr18763766b.54.1731957988223; Mon, 18 Nov 2024
 11:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115-vfs-tmpfs-d443d413eb26@brauner>
In-Reply-To: <20241115-vfs-tmpfs-d443d413eb26@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 18 Nov 2024 11:26:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>
Message-ID: <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs tmpfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 06:07, Christian Brauner <brauner@kernel.org> wrote:
>
> This adds case-insensitive support for tmpfs.

Ugh.

I've pulled this, but I don't love it.

This pattern:

    if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
        d_add(dentry, inode);
    else
        d_instantiate(dentry, inode);

needs an explanation, and probably a helper.

And

>  include/linux/shmem_fs.h            |   6 +-
>  mm/shmem.c                          | 265 ++++++++++++++++++++++++++++++++++--

I'm starting to think this should be renamed and/or possibly split up
a bit. The actual path component handling functions should be moved
out of mm/shmem.c.

The whole "mm/shmem.c" thing made sense back in the days when this was
mainly about memory management functions with some thing wrappers for
exposing them as a filesystem, and tmpfs was kind of an odd special
case.

Those thin wrappers aren't very thin any more, and "shmem" is becoming
something of a misnomer with the actual filesystem being called
"tmpfs".

We also actually have *two* different implementations of "tmpfs" -
both in that same file - which is really annoying. The other one is
based on the ramfs code.

Would it be possible to try to make this a bit saner?

           Linus

