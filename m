Return-Path: <linux-fsdevel+bounces-18852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3F8BD477
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42941C220BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0148158A1A;
	Mon,  6 May 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ewDyr2d8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D665158856
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019492; cv=none; b=DdTfiHdqfA/emgNL68qro5gI5Z6RCilqzqXibHR7QP/dencuUBZUJfrAxarLmDSMW/vAWsBEbAdUgQfmUK9hoeaCkFKe+D+rBq4SXwSxluJ78F8Txqtqsx4NhnrRnehfYM1LgFuYstPqQIE9vQhvlxr2cX2l5zFj3Kk4bGYlb1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019492; c=relaxed/simple;
	bh=J58UG9l/MEB8rWLccvOKjiXOqbcr3dWlMVB6Uc18RIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugGmDTLinwR8AUAsOup4ZvZGYAZc/l06mwOboER1kGH7GrY+tCsBNe0I3ZQVDbluQBe/ckbbRWLe4BealSmE5cz2OhE8ak8NWLXGOEXupV3Vvab27oQ5ywkKgkXQEexoEMK3g6U9cx6iSKBjWR+KNQ1xRALmI/aoUDoan0yt+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ewDyr2d8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572adaa172cso3878640a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715019489; x=1715624289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6q7UkdOxzhbeF8E3EB8/oVmwWLDDbJfhhsW1gzY2H6M=;
        b=ewDyr2d8aM/QJtcTXb9bnE/sAdUXwat8dssr8Hh5PbYQfpOmiDK7LxY7Id3xzwCcHV
         TpNQiYgRpnW2LdtesuMK+vyMmwyHMuDZMeDZsbZPcJ752MOeFdrKHybX1s9WZaB3qtZb
         wB8Ay0uZX+xkZssJc3XK4xRakaQPfBLq96Wd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715019489; x=1715624289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q7UkdOxzhbeF8E3EB8/oVmwWLDDbJfhhsW1gzY2H6M=;
        b=c0qij1VWewQtgOS2IZS3xhEpZzQIHDS+zk6pRQ8772VGXNwi6lbuMXG96e7liRuoy8
         4VWJuFKPoZj9qLNmXhtTZCUbV34CmRRHQHA0lQR2htMP+75twvg+0pxHJ7ltTDahj0yj
         Om3jTfyVMbrnEYwjqJsJ8grbLWFLymycXCTYfYZn0JlsdFV95DOxQXVEm6FqL6XfzRqQ
         ZrkKc7oqDj5SV4ALoI4V1G5RmDmk86YaU/2aiuHlystQB/46daRmjdE9ve0yy0fLfTT4
         GO8MXw4rbRjPyMfAUq9LmORCelbtXq5QtPkHEGJDqbjJ7OdLZyWnjgOvjmTQRGYYaEhY
         ViAw==
X-Forwarded-Encrypted: i=1; AJvYcCVOv7LN9lCA5eHJ6PvYKrs1Dpr4gnDkkYEpXEXrGVCiTHHxdFKr9OYw3XFaIjhKQ0nzwVFcioQBrJQt87LcSmYjx1AADdWIqtOZ4i6jmQ==
X-Gm-Message-State: AOJu0Yw99Hv+5FToUCjF0E75AYFH9tSsLDi92er+P1xhxrfa7/FJ9/Ps
	tmGU6H1jcla4LODls9E4P5SRZi+i4cHF6sSPl69g4vBCp2YhEbIERp0HWyz1mQKWxLVOB+jIeFk
	UhuvUdw==
X-Google-Smtp-Source: AGHT+IGFmJH3SweLdwXdAHfPv3SOIQD9DgEkxZv8Ttk/XQOa13u50D/xcSqB3IA+xLGx1TfV04kWGA==
X-Received: by 2002:aa7:cfd2:0:b0:571:bc22:e32 with SMTP id 4fb4d7f45d1cf-573110235e3mr382551a12.8.1715019488694;
        Mon, 06 May 2024 11:18:08 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id w3-20020aa7dcc3000000b0057204902580sm5428813edu.48.2024.05.06.11.18.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 11:18:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso7882848a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 11:18:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe9HJLjQBhwHkORBRMU6eC70uBlTHsb7ZyStBUCXGSfH2H8LnYGD4dKBv5g9Yo/3SYRZVC8wp1vO2CWNt3j2w9ZDOE4wJ7pK2x8MMG4A==
X-Received: by 2002:a17:906:e49:b0:a59:91a0:df46 with SMTP id
 a640c23a62f3a-a59e4e862d2mr29381966b.31.1715019487019; Mon, 06 May 2024
 11:18:07 -0700 (PDT)
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
 <20240503211109.GX2118490@ZenIV> <CAHk-=wj0de-P2Q=Gz2uyrWBHagT25arLbN0Lyg=U6fT7psKnQA@mail.gmail.com>
 <501ead34-d79f-442e-9b9a-ecd694b3015c@samba.org>
In-Reply-To: <501ead34-d79f-442e-9b9a-ecd694b3015c@samba.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 May 2024 11:17:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBVkwFryz5-DOAxNKYOy5RwPpQkZHQSs1Oe806Xo6yeg@mail.gmail.com>
Message-ID: <CAHk-=whBVkwFryz5-DOAxNKYOy5RwPpQkZHQSs1Oe806Xo6yeg@mail.gmail.com>
Subject: Re: get_file() unsafe under epoll (was Re: [syzbot] [fs?] [io-uring?]
 general protection fault in __ep_remove)
To: Stefan Metzmacher <metze@samba.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <keescook@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Bui Quang Minh <minhquangbui99@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, 
	syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>, 
	io-uring@vger.kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Laura Abbott <laura@labbott.name>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 May 2024 at 10:46, Stefan Metzmacher <metze@samba.org> wrote:
>
> I think it's a very important detail that epoll does not take
> real references. Otherwise an application level 'close()' on a socket
> would not trigger a tcp disconnect, when an fd is still registered with
> epoll.

Yes, exactly.

epoll() ends up actually wanting the lifetime of the ep item be the
lifetime of the file _descriptor_, not the lifetime of the file
itself.

We approximate that - badly - with epoll not taking a reference on the
file pointer, and then at final fput() it tears things down.

But that has two real issues, and one of them is that "oh, now epoll
has file pointers that are actually dead" that caused this thread.

The other issue is that "approximates" thing, where it means that
duplicating the file pointer (dup*() and fork() end unix socket file
sending etc) will not mean that the epoll ref is also out of sync with
the lifetime of the file descriptor.

That's why I suggested that "clean up epoll references at
file_close_fd() time instead:

  https://lore.kernel.org/all/CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com/

because it would actually really *fix* the lifetime issue of ep items.

In the process, it would make it possible to actually take a f_count
reference at EPOLL_CTL_ADD time, since now the lifetime of the EP
wouldn't be tied to the lifetime of the 'struct file *' pointer, it
would be properly tied to the lifetime of the actual file descriptor
that you are adding.

So it would be a huge conceptual cleanup too.

(Of course - at that point EPOLL_CTL_ADD still doesn't actually _need_
a reference to the file, since the file being open in itself is
already that reference - but the point here being that there would
*be* a reference that the epoll code would effectively have, and you'd
never be in the situation we were in where there would be stale "dead"
file pointers that just haven't gone through the cleanup yet).

But I'd rather not touch the epoll code more than I have to.

Which is why I applied the minimal patch for just "refcount over
vfs_poll()", and am just mentioning my suggestion in the hope that
some eager beaver would like to see how painful it would do to make
the bigger surgery...

                   Linus

