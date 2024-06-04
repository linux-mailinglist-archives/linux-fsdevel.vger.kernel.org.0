Return-Path: <linux-fsdevel+bounces-20988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E938FBC75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42ADC1C20CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AA14A636;
	Tue,  4 Jun 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="K7J+s4o+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C8801
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717529069; cv=none; b=p+8d4t5LeWQzdd9j4ZzNsGsWmceoBQE8nzqy14w08U75Zs8B/b4JrW9cpVPtdC1rICldGOHwTitMcT4TVDoPv0bzZ/P5hr9wsNi6l6Qo9tMGW2TMRzU6Q1NVDZwMvmhPkl642OtLqpGTGtgQoalgU0Q4jfoQW9m8QcYZNcK6hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717529069; c=relaxed/simple;
	bh=3rVZnrQbHV6sIGTDna845o+kDJnGm/y0bheCff2jbCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiDAT2EC+8mtwR112vfewNLfoB4JN2grQYel0axLPpAT6boOEyHIMl6wRFRycJnwZYkYyefSewziulGMvQgMGW2llsslpbg9lqNv/9LNV2ID0Gh4Iqz45jcMRQqf0sTugQJdA7Hk6fD4sWYsRbv0HtymlSq8Avl/NiJrHOzNGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=K7J+s4o+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a626919d19dso32299766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717529065; x=1718133865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rVZnrQbHV6sIGTDna845o+kDJnGm/y0bheCff2jbCI=;
        b=K7J+s4o+SSPu+6lnkPyMij4I429mrLLTtxmuSvdwz/1msDoVm0Ion4XkfyUePLYT5C
         6HeboMU4aK4y/dhmQXUVfX+RWvBRPjMOwofg/jTILyNO/L4uodwurg2FMEJ0mlELPfOs
         u06JXg7kposZDypI0rnncxwwHZK5SA9l1TTZn1WLVKXQNvjNhT4cbWdk6D6jz6Xx0jye
         KaO9kV8JRTb34KSwqexLy27UjFmaPL6AUpqOl0R9YQjn0logsICV04kS2SQBUNp+hsHX
         inPa3SEuuwlqYk3Zz2YLvpEJ3LwnHdn/wMqeMBnlDTIkpa+2D4wW3f+u6ahO4ZBQ8ai1
         rSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717529065; x=1718133865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rVZnrQbHV6sIGTDna845o+kDJnGm/y0bheCff2jbCI=;
        b=BNcvrisYxTpB/vJHz6Ob4TFaY4gS4tVYI5BpJhj7hX2bYjbGMi0uk517EAmzx/XOlu
         5BDw9ABQExqcVvb7eAxPzpOo8IqLFxdQCGyM8H/vlB4XOdNJaBj/qfcVJ9us9RodcQq4
         Nk6E7xKvpdxO25xeRIy8bpCjrNcoLXUT6L31+srDFsWoozYcqukUcipyp0PQtq1XLZIT
         j+9csPNcF7ACSFn0AQn44DPDpV0v1zPIyFNhi95F4UeJUNzm4PihpDKKslrVCqldtRjD
         29rISRRyqr3TSDlefJ6fD9t0aYI84hA7g0NFQzOpt6lolfP5lqSXlMx6r1GG4VYXooOs
         FUwA==
X-Forwarded-Encrypted: i=1; AJvYcCV0buxem5Zs0xaJNkfiOF65taQXNhA1Jo0eoQV5Wd5KB6lmFx7qJCltZm/Fj2QqkCjHfXtVpi+2iOiVoA70VnA6jilysBkHB/5n98Jfyg==
X-Gm-Message-State: AOJu0Ywn9a72bXRdotDrm6FioGOVnjJJpEkwX9SdDXPpIj7sUhbPT9aE
	SkcgwG1C1iDrDegsLYylS2UqxcMAnuAmgHqlGAJQrO5dnIxRbaK2aSkRMBvyUwTaXJEBduWeT58
	dsksLdPZ62ftgCDI6kK2zlXA2/B/A3pG5pOMp2w==
X-Google-Smtp-Source: AGHT+IEkwotyRJzNSFiRw/0IwXxB3N7KGGcZ8wp3PQfJ+EraUS+ZcOTgatCzmMEAO1ab+3EVBYX3VP+W+kJt6DRM3ew=
X-Received: by 2002:a17:906:c357:b0:a5a:5b1a:e2e4 with SMTP id
 a640c23a62f3a-a699cfb9170mr46834666b.20.1717529065473; Tue, 04 Jun 2024
 12:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604092431.2183929-1-max.kellermann@ionos.com>
 <20240604104151.73n3zmn24hxmmwj6@quack3> <CAKPOu+9BEAOSDPM97uzHUoQoNZC064D-F2SWZR=BSxi-r-=2VA@mail.gmail.com>
 <20240604132737.rpo464bhikcvkusy@quack3>
In-Reply-To: <20240604132737.rpo464bhikcvkusy@quack3>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 4 Jun 2024 21:24:14 +0200
Message-ID: <CAKPOu+_Ry45cJYjje_WcGsjzN55uyfVqdbLvXJDO0OHbWL3FZQ@mail.gmail.com>
Subject: Re: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after
 data was read
To: Jan Kara <jack@suse.cz>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	hch@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:27=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> OK, so that was not clear to me (and this may well be just my ignorance o=
f
> networking details). Do you say that your patch changes the behavior only
> for this cornercase? Even if the socket fd is blocking? AFAIU with your
> patch we'd return short write in that case as well (roughly 64k AFAICT
> because that's the amount the internal splice pipe will take) but current=
ly
> we block waiting for more space in the socket bufs?

My patch changes only the file-read side, not the socket-write side.
It adds IOCB_NOWAIT for reading from the file, just like
filemap_read() does. Therefore, it does not matter whether the socket
is non-blocking.

But thanks for the reply - this was very helpful input for me because
I have to admit that part of my explanation was wrong:
I misunderstood how sending to a blocking socket works. I thought that
send() and sendfile() would return after sending at least one byte
(only recv() works that way), but in fact both block until everything
has been submitted. That is a rather embarrassing misunderstanding of
socket basics, but, uh, it just shows I've never really used blocking
sockets!

That means my patch can indeed change the behavior of sendfile() in a
way that might surprise (badly written) applications and should NOT be
merged as-is.
Your concerns were correct and thanks again!

That leaves me wondering how to solve this. Of course, io_uring is the
proper solution, but that part of my software isn't ready for io_uring
yet.

I could change this to only use IOCB_NOWAIT if the destination is
non-blocking, but something about this sounds wrong - it changes the
read side just because the write side is non-blocking.
We can't change the behavior out of fear of breaking applications; but
can we have a per-file flag so applications can opt into partial
reads/writes? This would be useful for all I/O on regular files (and
sockets and everything else). There would not be any guarantees, just
allowing the kernel to use relaxed semantics for those who can deal
with partial I/O.
Maybe I'm overthinking things and I should just fast-track full
io_uring support in my code...

Max

