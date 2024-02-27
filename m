Return-Path: <linux-fsdevel+bounces-12990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEBF869D2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A12B26914
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA002032D;
	Tue, 27 Feb 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4CjP2Mi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9F1EB40
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053643; cv=none; b=bQV4DfgqE19qjFpA/t9R9v1jW0Syhuph2+JuKcLiJgCPEdiSMWqI9kLXj1LZOKoMM36Cz22HomQmMad/oPXaayJL/vy1Q+WimHidqB/tcNO6l5V9NzG3I2TPQI5ww4jYD8Urq1ai4oOXPfOQmGl+CI47Fs0P58zijxanTJNZ9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053643; c=relaxed/simple;
	bh=K+MX4UsYzykSQKf5lH+buL8cZOlTeVNO4Ces0kHsxQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGvITG9ebO+W85SRudddMqqyOWkiMlc4pcNDVIrdSb6Yi8QetuC7yPBK9t6DdsseEeQCIqphEIU7PgIgv+XbhgBK3Cq+IL5cALTtFplarNgNSkxzoHw2nSDjHsK+lX99cMm6xx3stl3sQHZeUEMhSK1D7J+CzKImShIN7bPZQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g4CjP2Mi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so467536666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709053639; x=1709658439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/sCQUZqJ++E2MM2dGI2EtUj2dCzGG1wAz32eBvlulLI=;
        b=g4CjP2MiXmsCbDie2kXOXFqB+dtwyTr60go7lxnvduDeo1wGZMW5XerCKy6id/qWQr
         WThGfJE3ot4pKkMtYtRcnqKxwVOLTj8blE3PC7sYrwNDM9cVeGYtID8OX6s3CarEJYlH
         XL2ekiZx5R/uMDoP9bJjkiKbsMb7RdPRaAsFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053639; x=1709658439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sCQUZqJ++E2MM2dGI2EtUj2dCzGG1wAz32eBvlulLI=;
        b=eT5eZyBgxJQtujGpzcZnfQqvEboY1Fie4NnGPONUDkAClwaERzcsek0Hlz1AhjhU9e
         JtxqCG73AK+777BXvhGZGYtyQvbji6pT0frNiOQwzPODEcGupD5Vao11ylX0uS+Tn5Zg
         7H6mljy1LwLEJj2DNpQhJIoHdIQrOjZrzHWedLwvi38xjwf/fpKyVTykk4d+xzL2RMSY
         0u3l8Lev2FTB0QfbgK7/KfiWwkRe7jn8AWHTbAz+G+IaZX7fSpgCr4FFMecjzPMOyM/O
         2BVinKfPFlHIKuuv11CCtQhXpk9LYozhqj2Lz3bqc5PECZsW48dX6Fbs+6/lu03GqfwH
         Ip1g==
X-Forwarded-Encrypted: i=1; AJvYcCXGMTkYld8SiRZUouXyErmMlp5qfDBUvTy29W0PGg33eF5T8cYiA+DjMJ7jlCnpOSYrGN2hL/G7TmCDKMgEqbnhnjTQl75cSIKdoUg8KA==
X-Gm-Message-State: AOJu0YwRWdyJQ392SZkABboBcqT7Z2baeDGOl9vG8lqSKoR5bMd58550
	TMmzFaPgZGbiUyFVVgsE4lACS2yPa/97nC7/5kq5N2Rdt4WZifvcidbYztM6SgHjzCXWAj5cn+U
	y9nCi7A==
X-Google-Smtp-Source: AGHT+IHJrDtDSsaWnr3na9cjiGS6Dh9x0ebcfLifqy+ffp70TrOlWLvbre9NtO24fujv594cy5yEIw==
X-Received: by 2002:a17:906:57c8:b0:a43:7c1b:3542 with SMTP id u8-20020a17090657c800b00a437c1b3542mr3209390ejr.73.1709053639413;
        Tue, 27 Feb 2024 09:07:19 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id gz8-20020a170906f2c800b00a3e5adf11c7sm941628ejb.157.2024.02.27.09.07.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 09:07:18 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ee69976c9so567008966b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 09:07:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiwxWXcpUvwPbgSsyYhzewZK7WB3wy36Ixe62bmkdHc8MljqP3XAwdJSLHwJyn5rDniW834QQN/9qXNEqwY8CForN8jXbSo0S/B66jpw==
X-Received: by 2002:a17:906:c350:b0:a43:82d0:38f4 with SMTP id
 ci16-20020a170906c35000b00a4382d038f4mr3423215ejb.11.1709053638529; Tue, 27
 Feb 2024 09:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zduto30LUEqIHg4h@casper.infradead.org> <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
 <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com> <hnmf36wwh3yahmcyqlbgnhidcsgmfg4jnat2n6m2dxz655cxt7@gm7qddu2cshm>
In-Reply-To: <hnmf36wwh3yahmcyqlbgnhidcsgmfg4jnat2n6m2dxz655cxt7@gm7qddu2cshm>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 09:07:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wii2MLd3kE1jqoH1BcwBBiFURqzhAXCACgr+FBjT6kM6w@mail.gmail.com>
Message-ID: <CAHk-=wii2MLd3kE1jqoH1BcwBBiFURqzhAXCACgr+FBjT6kM6w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:47, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Like I replied to willy - the "4k" was a typo from force of habit, I was
> doing 64 byte random reads.

Ok, can you send the exact fio command? I'll do some testing here too.

                  Linus

