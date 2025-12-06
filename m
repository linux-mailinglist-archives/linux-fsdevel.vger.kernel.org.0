Return-Path: <linux-fsdevel+bounces-70932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3728CA9FA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 04:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60DB5316FD10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 03:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC81229B799;
	Sat,  6 Dec 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hU6VFt3c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426813790B
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Dec 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764991776; cv=none; b=m1xjitZEnWsLAwCzkIMjzJm8/s74J2r8Om8+PT18qEd0WdPexH5cfq9HOhbBKK6unml7oIvkomC6mOe+DBCWIABJXOWLu19G7tdM7a0xYa8V/k14PfbMNn6jvKe7zZ4NlRkwKuS/rfyN0IqZdlGGjF6BlaAy/s2PF0j0oHxrnTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764991776; c=relaxed/simple;
	bh=sSUoJ4jJ/gjhl/k3WbdQeml9Aj9UFrDPCTK0+fCUaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOCe6NOQKF4T7i9aC7o27qZcYEGqdzMn+Av7dKI24VF+AkrWj5WJEbWx3EW+pwDsFDEHdaW5XGZnmVvhpJpuI52bZWwSQhXiExIPSxHdBQ4/hBGOW5Nclnd3Jb1hsukLc4j2LS2FAgNv4vUkmTAmxVTeFOpyiJjx/T3cZJNpE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hU6VFt3c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b713c7096f9so423847466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 19:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764991771; x=1765596571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9rDMdbOZeHeRA1HNsLadcwrVejqh1fXDe4muFQaGK/s=;
        b=hU6VFt3c2ysFzNkVQMxspJnZT9sohaJOGOKKEvxDBbC6FGK4nG641nVk8EMPnCeNYO
         FHCLzgQy656ZZflzxcZ4oY2WqebeA3lbZE0OrAYjex9z+Y4gdrcc/UTJqcPQob0xuXM9
         q6QgMFaVQ7PNfbYrSkmA8zH2zzVx4A6I79Ywo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764991771; x=1765596571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rDMdbOZeHeRA1HNsLadcwrVejqh1fXDe4muFQaGK/s=;
        b=ad71oKcFlrIuOfPsrf0sFSgXGKePpMRNnGfJNhXc6HxzCiOPm0NZO11RX+gXy2iU4K
         Zk27x+3vI7Ec6Q+PKFoKlf4vLmBX9avitb3x43UsIqI7lGl2PtXoPwgM9/44+fBVrRf4
         PmKGca66ukJSclyKQlSOSGccYUmDRlchXPVAJ9LrfEFN9LEnZ9J5t4Fx12JzylDxyfMK
         ivHNioNmQCMn22wAde+7lXkxaFf9Buexrzx7iw7oOK9S6unxoZKbzeBHBh0hEDqRV3l+
         hmJaau9odZDgBIC/G5QLsksqXGgNAqJhfk8CkPBNz0IYzHmTXxHnqEKY2s14icOj5P4W
         TANA==
X-Forwarded-Encrypted: i=1; AJvYcCW03wVW7H+8yc/OcFlVr7bd7z7fs6GDM6NcRy+62m+mivWzdIUT9YGMPHueMyNgN7zKUXWR4u7rCVFH0pz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7q+4s2dHUao74vtEbCtcSX3ZdmTNmTBnoKafGisYqTEy8tvc0
	y+NEHB+XQHDdvJa16YsRcDYZPDlb5Z3qNJ7eQoArB/v6VB90GLjpYKzk2Gp/xNJtEv5qggg8vi4
	xrZq2krnYUw==
X-Gm-Gg: ASbGncsTMTCx9QjiNnLDOl2ely3gZ3pBuqybkLkNP3jsXvnjbBmMWbZTVPr2Q2xMtk8
	+YhGAZiyepegu7BwrDxnCyFUuOW1L37dTAy88Sn6obLOqJwyW7my0ddkN/9eBIRIsKMbsPQlgIx
	Z68A0SwFPDtE59Shsv9NXNdYJfU3qJgTlxnRrY+bc+TdE8KfslijqMTZ0Q9+uCNSqbJBYYLRjfe
	6x3fPl2ySxpllc6wXf+UiP1/zlWaUGBRPoFdhG76YaJh45m5xoXavBKuWUsa7hWz/HjgD9tFb4C
	r3G8F13fxuUnCr9ME4vGhLtXs+L5wya0kvln/4p3coCs0DhIx/MtgYFphRqv5+ftFtgqc23zEV6
	RTGzQ4sg9XRYUTCVdU+L7lL26/o63aAGBx8NGsHSwfkCt/8RSMltOl1WzTzIvqkBmLdpuRoMVX1
	geN3aP5psD+ir+8fWGDeDIUMp8P6S4adrMzzCGXo06FS37br3ctqQ2TMrN/7gD
X-Google-Smtp-Source: AGHT+IGNUZoVCLc8J/lfGzD6Duisg87Kfbick5J2v/CkirgPw0ZS48d1+z2fMrGn+CuG4/DKgvExKA==
X-Received: by 2002:a17:906:eec5:b0:b73:9792:9199 with SMTP id a640c23a62f3a-b7a247f4220mr123182466b.37.1764991771303;
        Fri, 05 Dec 2025 19:29:31 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4a15660sm524949466b.63.2025.12.05.19.29.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 19:29:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so4097247a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 19:29:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTDiBi3XieOd601v+hQNNSGdnlvV9NkIX/8Se/cbUJePaL4Wu4wYSuB6fNLgyk/Sg+2uD44jNFU7F2Re8n@vger.kernel.org
X-Received: by 2002:a05:6402:2812:b0:639:ffb5:3606 with SMTP id
 4fb4d7f45d1cf-6491ae36920mr913745a12.33.1764991770305; Fri, 05 Dec 2025
 19:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV> <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
In-Reply-To: <20251206022826.GP1712166@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 19:29:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
X-Gm-Features: AQt7F2rHiQRDyUvrJTfVxksoZ3VYbBvONyF2g8PMKDYqdoRr7weqE2kjeVvWVdM
Message-ID: <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
Subject: Re: [GIT PULL] fuse update for 6.19
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 18:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Sure, ->d_prune() would take it out of the rbtree, but what if it hits

Ahh.

Maybe increase the d_count before releasing that rbtree lock?

Or yeah, maybe moving it to d_release. Miklos?

           Linus

