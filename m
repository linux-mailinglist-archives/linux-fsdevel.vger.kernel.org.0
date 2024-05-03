Return-Path: <linux-fsdevel+bounces-18686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08108BB658
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 23:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7571D283E4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 21:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854283A0A;
	Fri,  3 May 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWAXnd37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DD82492
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772563; cv=none; b=U57eoOwrhXoHPu8Gw82HarDAj3nBbOkZ3sojEw7zm3T4LuOXEuAvsQks2N2LCJuc5wdaXzSl064T5jixfePBSVNQKXlI6TH7aVsfKcxCF/JLuXyarADGwuLk/bmGAxR7b2mtTIXweOQB+kfHXb0TbxtOI64GCXAIs6bZJglRA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772563; c=relaxed/simple;
	bh=5kw/vQ2Z4GIERA/PZJO8R5H1So5ym6+6uJIhwrtRtXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUQLAZ0dWLAvhuPY9P8rbB8O2oemPBZBoiJ6ZTxXOduCntpDxPnxmyWMv50SXBQno+FtNbAaZmyP3rBNKDcQWXxD98NCkBXSVjMuQe0cneO/Zggxy1nkso5KhAkwDGD7KCLPuZCJiCot2dAUfipY6MDM0O5y5P+cj0MX/1C7ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BWAXnd37; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a5f81af4so17032666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714772560; x=1715377360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwyBdWufoxKVrcKcsHh2OBVbUooApVD3S23GDedqB7U=;
        b=BWAXnd37oXbnZsHze4We8ZkQ2HKVHWZsPh/SWnlt/VZHjV0RmWa4S4DKTQ+NL27DM0
         nMyoXBjC0O29EriEDpUE8WaETB0t4T89h9M+RrAoO/8hwJ2k/lrg9hT4ucl70xcNtSYA
         XZNEbxPjWWleEcwSiTWkepTDqZISPhB2T2YFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772560; x=1715377360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwyBdWufoxKVrcKcsHh2OBVbUooApVD3S23GDedqB7U=;
        b=RwQ4h3LSYZhDDIgIxwSoSYovRrbkAWyLfNvd21b5C2udS7lndqv4wvBeAg2K6G84/7
         NQYss8HYAxkBlD36C6kTNbG0dxAP0KUBXZn+xsP/CREtEm1txQN17q04o4HPnQZZj7W/
         ZujvyaVZfjNhakCR6aHjOLlDw80QAk95AEcYconuo2+4bHvLrtvbsuq8Ap4IeI7rBnbO
         KdarWCWUdRMBR5khmy3qTa3na1fX2G5NGx5qAY0hxE8zrwu9FFHynvwIyWpH8Yfoy0t1
         Angy0NhoQ1kGnvQ8oCa7WFlG0A30NPqDmGupWca0L0mwZXGcEOzD3uijbc/zRAj7uyEo
         ehLg==
X-Forwarded-Encrypted: i=1; AJvYcCX82glgdKqJgFrHhs3sjSI/IYhL+P2JLX0AfGMQ8dJzsx5v/C/08QqaY0el3U43SYwqKNOEzVPvQ1xMoPlsBKhOg0b1Zct696kQuLWqiQ==
X-Gm-Message-State: AOJu0YxfnZcLORC6SSKUMxEmHUgvAUPfXJSRGncEmjvAdkw3MD5S8D/Z
	BnDHHtdVib4f2LXx2hTVHSXJ3d8d4I5wzXe/AdpNtCv2TgvsMqctQLngO0hyk2Pjzfk5N3rDm6L
	KwbSipA==
X-Google-Smtp-Source: AGHT+IHnhwjEpDRA33A1wzBE6VwuHGX5yZvmXk/wqFaIFsHD33AZi+F5m4ZAAEkOIv8cBaNHGQOwXw==
X-Received: by 2002:a17:907:3592:b0:a58:8ca9:da04 with SMTP id ao18-20020a170907359200b00a588ca9da04mr2267106ejc.64.1714772560213;
        Fri, 03 May 2024 14:42:40 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id b19-20020a1709062b5300b00a59a05a8030sm411252ejg.25.2024.05.03.14.42.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:42:39 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a58a36008ceso15307566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 14:42:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+rQmGr2x0oNxGi+gnN/gaY6Pl6lm4PXnyPa7x6egY/66vJlkO8s/xAzHBzM89TJMsZGkGDeuVZuh1ZaxgGPeTNtBpuyLxhjZ/kDaE8w==
X-Received: by 2002:a17:906:29d4:b0:a59:8786:3852 with SMTP id
 y20-20020a17090629d400b00a5987863852mr2658677eje.55.1714772559064; Fri, 03
 May 2024 14:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002d631f0615918f1e@google.com> <7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com>
 <202405031110.6F47982593@keescook> <64b51cc5-9f5b-4160-83f2-6d62175418a2@kernel.dk>
 <202405031207.9D62DA4973@keescook> <d6285f19-01aa-49c8-8fef-4b5842136215@kernel.dk>
 <202405031237.B6B8379@keescook> <202405031325.B8979870B@keescook>
 <20240503211109.GX2118490@ZenIV> <20240503213625.GA2118490@ZenIV>
In-Reply-To: <20240503213625.GA2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 May 2024 14:42:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRphONC5NBagypZpgriCUtztU7LCC9BzGZDEjWQbSVWQ@mail.gmail.com>
Message-ID: <CAHk-=wgRphONC5NBagypZpgriCUtztU7LCC9BzGZDEjWQbSVWQ@mail.gmail.com>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Bui Quang Minh <minhquangbui99@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 May 2024 at 14:36, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... the last part is no-go - poll_wait() must be able to grab a reference
> (well, the callback in it must)

Yeah. I really think that *poll* itself is doing everything right. It
knows that it's called with a file pointer with a reference, and it
adds its own references as needed.

And I think that's all fine - both for dmabuf in particular, but for
poll in general. That's how things are *supposed* to work. You can
keep references to other things in your 'struct file *', knowing that
files are properly refcounted, and won't go away while you are dealing
with them.

The problem, of course, is that then epoll violates that "called with
reference" part.  epoll very much by design does *not* take references
to the files it keeps track of, and then tears them down at close()
time.

Now, epoll has its reasons for doing that. They are even good reasons.
But that does mean that when epoll needs to deal with that hackery.

I wish we could remove epoll entirely, but that isn't an option, so we
need to just make sure that when it accesses the ffd.file pointer, it
does so more carefully.

              Linus

