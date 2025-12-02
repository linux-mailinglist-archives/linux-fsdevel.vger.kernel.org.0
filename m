Return-Path: <linux-fsdevel+bounces-70442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB685C9AD9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 10:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68433A3400
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 09:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4930BF6D;
	Tue,  2 Dec 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6GBhcqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B230BB95
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667685; cv=none; b=ayUpZTbP7mJC4KA9LJiNxai7GmoBD9OBB/NZZSmy1M7pJTHP2GQYYWCBemQfop0lgTxKPMOIqs8ODjYvTEWGt+K9CCcL22Sc5xGT+scBrsRKnF6b8e3OAK65i2JY0atbZ42EUoFCSvqX0Mn3QyxZMaS/9yKfg2ksZUsLEivQ6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667685; c=relaxed/simple;
	bh=ALKxOQGDiq6TJiJp918BA4PLxzPhU5JjIc6pN9INkpQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qE6GcXlgGDG3ZGouzr/EnSsOafr/COyA/Dxg4PjWZj45jQD4upuXSZvtlYGryqZ4B7+koX5rfDOTlbV0xivM13hAE0CbQ9OZoP0Cjm/jirlB6whi34rAhnlUKEJT/zlMn7q1pzEa3uS6sY/vIWLafhsJof7s0CZitEfuf4mhmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6GBhcqg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso3325685a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 01:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764667682; x=1765272482; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HmmW+Jhye/qNjrMRfLOBQADv37wzt0h3IlCtF41J1c=;
        b=C6GBhcqg7VjhyEoMRrdGDpTmaiUtWpqob6AeC6PLs76Uv0k5kChswmeDXjEjXXjYJa
         lw2JJiecOhScgrbZ1sEHIeXK8PSnLU2Vk0WEdk9ZINUjRO4UoBiFtxJAy+yqf0N91dEC
         h1PZkpw5g6NNLZBGCrKgN0kW9OZIZ5mI1ZBcEI+4K40vIfk+xK49e47fG6C6EjQyTdN4
         9MS7qSXPkK+JUnMHibEFGt5f3RGoyrohrRpB7jE9Th/SnbkAF46bBvnFLRpUIfWoUfNN
         B75CenQPmUH0UA3VXtwjAyeUPgJ5z5QEeOBBWakUaX06o1o05hbU+ZswNiSbUzvTkZq8
         35nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667682; x=1765272482;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HmmW+Jhye/qNjrMRfLOBQADv37wzt0h3IlCtF41J1c=;
        b=SR5uUuNwi7seBnojndfpmiNO7RMoBHTci+mPxXn6C2GhB4FJdxRSyEWLjcJ5DXA7th
         Vu/GlZA2fXVxiEUI/OC2hQD2yPb7FV9cmj76TovCdKDAXwwyeyrCtvvgVwwZ+L9X7IM6
         xH5hcfTXl+/QMwU1KaD+5kUqyditFo+vFCqtW3BOs71uaZWSGNDqLYTsjdgaV9oqM0/v
         CdM7V6G98zxdheGLaB5FL54MOCR6Oedsh1xj+qZr7zV3IcqASf3+VZh+U2/hvTsvIODe
         B0aOrh7WDALnRTQALVSjBAU56r1D33hAbEYdH322MdLRf/tqbNQPR07xM4zZE/0PDS/c
         Ox/w==
X-Gm-Message-State: AOJu0YxBn5BrJwuW8JWn/9xrH7vF/qVxCzsOSBy0J9AScD0Vfdscq1sp
	rK3irHQSfXFub+wwWK9sgMS6dDZIJwuXBteJGvLn6DRS8ZjX2OlmrFs0P1bYzEq7tYbJ1WBm12k
	ivwRQTg3+XSmFbIjbISsLvYHxkmH4qq49+Tlu
X-Gm-Gg: ASbGncvhTf3bV+UWpSb2vLH+zFF/y7ruqLec4fLK4IyqllViVVnICLNaGJfcgeeBD9l
	i7kxnu+Z5TphEY8IzBxMFdJ+tFTAqT0rfL5qbQwMn1isyBbgPOT35SY9npuBB+SIJSRGbmycjNu
	lKHeaYt7ByGUaXNKraKZtI8zG+hb1Ogl2aAoRo4H+zvKj9ITrnXF9DAhEg/iwTfv2g4OBcrCZHG
	TYV5Ov2zgDCDm6CYbXBFaAdszEwYAJNUrLppCfU1UM8gVslIRTV9ARbSIvazu9edKnSJnbpGQ67
	1RRoh37oHpeX0a/AFRARVDfndQ==
X-Google-Smtp-Source: AGHT+IHCzlf9DSYnOHT0ulbF0Vk5JTE1Ia/QQJswbA9JgQ2DJJWrXZa4LnxTZFXYoLrNCCQlu9RGzRPbqMx7d14Uwa4=
X-Received: by 2002:a05:6402:26cc:b0:640:9997:a229 with SMTP id
 4fb4d7f45d1cf-6478925bed5mr1852284a12.3.1764667682182; Tue, 02 Dec 2025
 01:28:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Dec 2025 10:27:50 +0100
X-Gm-Features: AWmQ_bnTF7kOKeha8A1I3WriAk4yp2EgCf1byPM554R_VtpGDM5JrM3Q-ivB2OI
Message-ID: <CAGudoHGZuXdh0xC1h4BBfy73qQOax7ghGnKN3pT05zWkFHT0MA@mail.gmail.com>
Subject: realpathat system call: the good, the bad and the ugly
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The subject is a little bit of a clickbait as there is no "good" here,
my apologies. Also a warning that there is no patch in sight.

Quite some time ago I posted a "request for flames" concerning the
syscall [1]. It resulted in a small discussion, but ultimately nothing
was solved.

I looked into this again and came up with a tolerable solution to woes
I mentioned there, but also discovered another issue to overcome. As
is I don't know if I'm ever going to get around to writing a
productized version of the syscall, but I can at least describe things
hoping someone(tm) will pick up at some point.

In this e-mail I'm going to reiterate justification for the syscall,
outline problems and finally sketch proposed solutions. Spoiler: while
conceptually trivial on the surface, the entire thing is vile.

Ideas up for grabs. Bonus points if you come up with something better.

While an implementation which takes references on dentries is already
an improvement, the end goal should be a state where the fast path
gets away without it thanks to rcu and sequence counters. That would
be both faster single-threaded and fully scalable, but *at the moment*
there is no API to do it.

1. justification

realpath is used *a lot* by gcc and it boils down to repeat calls to
readlink building up to the full path name. The number of calls is out
of control.

Example:
#include <stdio.h>
//#include <stdlib.h>

int main(void) {
    printf("Hello world!\n");
}

$ strace -cf cc -c hello.c
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
[snip]
  9,10    0,001661           3       474       466 readlink

but if I uncomment stdlib.h:
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
[snip]
  9,36    0,001673           1       936       928 readlink

Important remark is that while most calls to readlink along the way
fail with EINVAL, things turn into ENOENT towards the end of the path
name. For example:
readlink("/usr", 0x7ffe4a75ee60, 1023) = -1 EINVAL (Invalid argument)
readlink("/usr/include", 0x7ffe4a75ee60, 1023) = -1 EINVAL (Invalid argument)
readlink("/usr/include/x86_64-linux-gnu", 0x7ffe4a75ee60, 1023) = -1
EINVAL (Invalid argument)
readlink("/usr/include/x86_64-linux-gnu/alloca.h", 0x7ffe4a75ee60,
1023) = -1 ENOENT (No such file or directory)

This is of note because of a most regrettable extension in glibc: if
realpath fails with ENOENT, it will populate the resolved path up to
that point. There is no way to explicitly ask for this behavior or
forego it and gcc is penalized with it. For the syscall to be viable,
it needs to implement this feature.

So there is no question *if* this will be useful, but how to get it done.

2. problems

The tempting easy way out looks like this: call user_path_at to lookup
the target dentry, d_path to resolve it and pat yourself on the back.
Per my explanation below, the pat on the back is not justified.

First, the ENOENT resolution requirement uglifies it quite a bit. *as
is* there is no API to get the last dentry you had seen.

The real problem however is dealing with adversarial calls to rename,
which pose problems in two ways: you can resolve to a path userspace
would never see *or* the syscall gets neutered due to constant traffic
on rename seq (of note for later)

Since userspace constructs the path on the fly, if the lookup
succeeded, you have a guarantee the path you resolved to *was*
reachable by the calling thread at that point. Of course nothing
guarantees stability of the fs tree, so in principle that path no
longer exists by the time realpath returns. What however counts here
is that even then found path was legitimate at *some* point and this
needs to be preserved for the syscall to be fully compatible.

To elaborate, in the time window between finding the dentry and
d_path-ing on it there could have been a rename which moved said
dentry or one of the dirs you visited on the way there to another
directory, possibly which can't even be traversed with your
permissions.

Thus if /foo/file is a regular file and you are doing
realpath("/foo/file") and are racing against rename("/foo/file",
"/bar/file"), the current implementation is going to either ENOENT or
return "/foo/file". It is *NOT* going to return /bar/file. But a mere
lookup + d_path will be prone to doing it.

Suppose you detect the mismatch thanks to rename seq. Should you
decide to retry lookup + d_path you can end up finding rename seq
changed again. d_path takes the lock to stabilize the walk upwards the
chain, but you can't hold it for the lookup (even with LOOKUP_CACHED).
Or to put it differently, faced with adversarial rename, there is no
forward progress guarantee.

As a hack one can allow the syscall to return an error like EAGAIN
indicating the kernel gave up and userspace should do things the hard
way. While this hack resolves the issue of forward progress, it does
not deal with the fact that a bad actor can de facto neuter the
syscall by forcing all calls to fail in this manner.

3. solutions

The ENOENT thing would preferably be handled without pessimizing
non-realpath lookups (or at least slow it down as little as possible).
To that end it will need to call path_init() and link_path_walk() on
its own to retain access to nameidata, and even then liveness of the
target dentry needs to be provided. This should be easy for negative
dentries returned while still in rcu walk mode, which I suspect is the
most relevant case.

The rename thing is a real bummer.

Technically one can replicate the userspace approach by canonicalizing
the path one step at a time in the kernel. Even if you managed to do
it without penalizing non-realpath lookup, that's incredibly error
prone and for that reason I'm rejecting this approach from the get-go.

My idea boils down to having a slowpath which records dentry address +
its seq value for each path component and compares the state after
another lookup.

Thus the fast path is indeed just the lookup + d_path. If all the
sequence counters match that's it.

So let's say rename is mismatched.

You allocate another buffer, say 4K in size. That will fit an array of
340 dentry pointers and an array of 340 seq values. You walk the found
dentry up to root and record each pointer + seq of the dentry. If the
path has more path component than 340 you can just fail, this is
already an outlandish size. If one insists a bigger buffer can be
used. Note even if hypothethically someone rolls with these kind of
nonsensical paths in real life, the syscall will work for them in the
fast path.

Once you have everything recorded you do another lookup.

If you found a different dentry this time around, you fail with EAGAIN
-- the user is messing with itself. Just make sure to not return a bad
result and it's all good.

Otherwise you walk the dentry up the chain and compare both pointers
and sequence counters.

If all the pointers are the same and all the sequence counters are the
same, then whatever rename happened did not alter the path you were
looking up and you can safely returned the resolved path.

In this case a bad actor renaming in a loop in some other part of the
file system can in the worst case force you to the slow path, but not
abandon the syscall. If a bad actor is renaming from under itself,
EAGAIN is their problem.

Returning EAGAIN to tell userspace to do the work on its own is
workable because 1. it will rarely happen in practice with the above
solution 2. the code to do it is already there

Ideally EAGAIN would not be a thing, but I don't see a way to reliably do it.

This is the gist of it.

[1] https://lore.kernel.org/linux-fsdevel/CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com/#t

