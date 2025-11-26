Return-Path: <linux-fsdevel+bounces-69879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDEC89886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7A334985F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BC322A3F;
	Wed, 26 Nov 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itENpZKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FC322740
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156697; cv=none; b=ooAfJ+/jqgqKiVhkJnV892lZ4AJOJ0PAgVSvoTDMQcey7Gt3e3ktWGg4Mi+4E4pPEDAsF73/+kpUrqTzVw7FLGBdnDf3EgWjERhJfwMxeHn5DmuGHQjChtj2E27CINJ8C/tZS8zmtUFOnCv4zQEdVE/ja7Y8vLAaK47zQ6Hwj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156697; c=relaxed/simple;
	bh=DYyD/p5TxHRA+6U8qmE0B4qTQBu+r7An69CEbw7jNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLBhFIWfKzlx30nzkBgSj45Xg2lF3h8ciutMEvHpSYFb3l25Lzb8Ij3gJA+gkYdkKp8BDnC12SC32+19gX5Ko4riFMUv5M8pgfwUv2BOF8UJyyXPtIF/wTc4OKnxQ5guXj3bnjGe5h2JU1geHXR1HiXnadgX3IZSPe8jXej7axU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itENpZKh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso11148076a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764156694; x=1764761494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxpAOZp93TQa2PO+Fjc9mRu2Wb0BTI1kTLTUwaqDySc=;
        b=itENpZKh97QW8SElzGBmMkjZAJd4A5gzsqtOq6Y8ZTs1dlawCGlX7IQ/go/oy90sNF
         YLJZIK54Z2Upc+RTMkr/LlNVK/3O4aQkemSN/CmN+7+0v0hgIfq/7B7XCObdzCdWi6B+
         JnpWY3zfwTjTQvvM6I4tZRbFyr8nLjyKI8iNOhLdmI11tIjzGIo7gLZx4ueh9C027y0Q
         mvmdR7/RFEYY1jrP/ezZQXwcX+WZ676LesoRkH/6Fg7O1LT8Hk2MZeR0P0uYQ4w6oqWv
         OANjh4hdUfw5DlfBDvoklNodYqEfb+zVviErnVEmgql8fbQOaFMOhfDKZvA7YgSFSsi2
         FGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764156694; x=1764761494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxpAOZp93TQa2PO+Fjc9mRu2Wb0BTI1kTLTUwaqDySc=;
        b=D9eTifMHMSOs04redn+R2gA6IlqX8WyKACoBKEdxIUO/4u7Q7x71Z9erx8hJBL65vJ
         a3T361Pv3zNJnlkzmP9F+OLxwWcvc8LAnvztaJJzcImseTeHswO5bYtyzq3TuvHVIu8y
         lj8T8DUu/8+7RoMYhgFsYQcN+1Q/ouNz76XiEcekNAh7UaxLe8BFc2tPb/QlW3Ho4h9K
         eZicVYZMcFQHVNeS3lnNl8/P2Yr5UBXSxUNXoSGCtvj0p7vRgjod62QmcGrvcqZZhK3A
         QgRpjpv3/GjoG5VZ2j5reg5StMve65qbUHSHkwjpH1hFg+DEKO3mzfokjG3EQMoKkvst
         F4NA==
X-Forwarded-Encrypted: i=1; AJvYcCU7o7DJrU8z+HF42zytcYenBm3jutgTcoAHEFgEGzyL6oksUYIxbx8l6I/6e0X07c8jeD6omxtYrSdETFUy@vger.kernel.org
X-Gm-Message-State: AOJu0YzymTAsBw5YbOKut8mctAzNUi5D9Avkyns3uMxnt0T0iCiHRMar
	+8gRbkrr5ssCKffD/hGwwrhf4RDLEifrVhxLROZzoIcNISO0Z73aB1cz/nmBtTN//kbdVrGiKsg
	z+o9VU2VW1+jPivUalQNjyQcq0v7hxkU=
X-Gm-Gg: ASbGncskHj78VtFVEsTbUSAUQJ2/XTcFleIuRvd2MKtXbJmP70gLrVBqv20mWLkCjUu
	TbwU73Lr4RoHA0cX437qCEXzxFP6vg41xpwoLfijY6P9gmNPTbzLeEaf7XmfmGun7gxnAKX4QM3
	TTIsUxKX16k4bECEbIiwMIN2yqXE5nZvMnslFOq65qv/ysGPXZrU0sP6mOJr733wGTa/mFi9JSP
	cqLmyAyr8ppMTTLX7t781XYPo4nlJ/UBE2OgzcOUZT/IECOSddrkqe7htzoOuXcEFHF+tAo1LQi
	QfpusAXVJhQBPhQeBb9dE9dMGQ==
X-Google-Smtp-Source: AGHT+IHjCnUSYipW7ZDYaodcyHWhh2tEk6wixN+zRinjYnYjuklr01SkWmXo4+9xqJXCfv3bK9rD9sZxt46t48oFCpM=
X-Received: by 2002:a05:6402:1d50:b0:640:a03a:af98 with SMTP id
 4fb4d7f45d1cf-64554685738mr17095569a12.18.1764156693747; Wed, 26 Nov 2025
 03:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119144930.2911698-1-mjguzik@gmail.com> <20251125-punkten-jegliche-5aee8187381d@brauner>
 <CAGudoHHzXjvMXUZhCKMvdPxzwg71MOAUT+8c6qgiKhUfS0UoNA@mail.gmail.com> <20251126-vermachen-sahne-c4f243016180@brauner>
In-Reply-To: <20251126-vermachen-sahne-c4f243016180@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 26 Nov 2025 12:31:21 +0100
X-Gm-Features: AWmQ_bnInxHzWcWPx1VHiPpFAVTlbM3QjIDRWLJM6bxyroCdykN-0QBxDZvJAOI
Message-ID: <CAGudoHFLYVXTJg5332fOSBVT+zgzhU3s-nvwzZHPCpaOY6gR-g@mail.gmail.com>
Subject: Re: [PATCH] fs: mark lookup_slow() as noinline
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:08=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Nov 25, 2025 at 10:54:25AM +0100, Mateusz Guzik wrote:
> > I'm going to save a rant about benchmarking changes like these in the
> > current kernel for another day.
>
> Without knocking any tooling that we currently have but I don't think we
> have _meaningful_ performance testing - especially not automated.

so *this* is the day? ;)

Even if one was to pretend for a minute that excellent benchmark suite
for vfs exists and is being used here, it would still fail to spot
numerous pessimizations.

To give you an example, legitimize_mnt has the smp_mb fence which
makes it visible when profiling things like access(2) or stat(2)
(something around 2% on my profiles). However, if one was to whack the
fence just to check if it is worth writing a real patch to do it,
access(2) perf would increase a little bit while stat(2) would remain
virtually the same. I am not speculating here, I did it. stat for me
is just shy of 4 mln ops/s. Patching the kernel with a tunable to
optionally skip the smp_mb fence pushes legitimize_mnt way down, while
*not* increasing performance -- the win is eaten by stalls elsewhere
(perf *does* increase for access(2), which is less shafted). This is
why the path walking benches I posted are all lifted from access()
usage as opposed to stat btw.

Or to put it differently, stat(2) is already gimped and you can keep
adding slowdowns without measurably altering anything, but that's only
because the CPU is already stalled big time while executing the
codepath.

Part of the systemic problem is the pesky 'rep movsq/rep stosq' usage
by gcc, notably emitted for stat (see vfs_getattr_nosec). It is my
understanding that future versions of the compiler will fix it, but
that's still years of damage to stay even if someone updates the
kernel in their distro, so that's "nice". The good news is that clang
does not do it, but it also optimized things differently in other
manners, so it may not even be representative what people will see
with gcc.

Rant aside on that front aside, I don't know what would encompass a
good test suite.

I am however confident it would include real-life usage lifted from
actual workloads for microbenchmarking purposes, like for example I
did with access() vs gcc. Better quality bench for path lookup would
involve all the syscalls invoked by gcc which do it, but per the above
the current state of the kernel would downplay improvements to next to
nothing.

Inspired by this little thing:  https://lkml.org/lkml/2015/5/19/1009
... I was screwing around with going through *all* vfs syscalls,
ordered in a way which provides the biggest data and instruction cache
busting potential. non-vfs code is not called specifically not be
shafted by slodowns elsewhere. It's not ready, but definitely worth
exploring.

I know there are some big bench suites out there (AIM?) but they look
weirdly unmaintained and I never verified if they do what they claim.

The microbenchmarks like will-it-scale are missing syscall coverage
(for example: no readlink or symlink), the syscalls which are covered
have spotty usage (for example there is a bench for parallel rw open
of a file, while opening *ro* is more common and has different
scalability), and even ignoring that all the lookups are done against
/tmp/willitscale.XXXXXX. That's not representative of most real
lookups in that there few path components *and* one of them is
unusually long.

and so on.

That rant also aside:
1. concerning legitimize_mnt: I strongly suspect the fence can be
avoided by guaranteeing that clearing ->mnt_ns waits for the rcu grace
period before issuing mntput. the question is how painful it is to
implement it
2. concering stat: the current code boils down to going to statx and
telling it to not fill some of the fields, getting some fields stat is
not going to look at anyway and finally converting the result to
userspace-compatible layout. the last bit is universal across unix
kernels afaics, curious how that happened. anyway my idea here is to
instead implement a ->stat inode op which would fill in 'struct stat'
(not kstat!), avoiding most of the current work. there is the obvious
concern of code duplication, which I think I can cover in an
acceptable manner by implementing generic helpers for fields the
filesystem does not want to mess with on its own.

that legitimize_mnt thing has been annoying me for a long time now, i
did not post any patches as the namespace code is barely readable for
me and i'm trying to not dig into it

