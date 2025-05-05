Return-Path: <linux-fsdevel+bounces-48127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E3AA9CDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882B3189E4CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B99F2701BE;
	Mon,  5 May 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOBIClqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BB25D90D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746474944; cv=none; b=TZ5Uc6hp15UMIR19y7k+RUNlmIXK1cXoP9NvxN5SxbADvQZR98ApyATCiFz9OqzHItRjFgzFexREu7JbsZSBnmwh3QwrFVxNG2Eox3RQBiCwszbHGKAgYhKzRcupXP1w0tmJTJq/ANcXHkOShM7iIMCiaSaMOigEi526Eb1Rsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746474944; c=relaxed/simple;
	bh=1UZNVu+b9bvr9I0FIDS71I4X0A0GfOc6/oCA9X6xlOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO837HpH7sOaS5Y4bPivh6JtikHbqv2gIaT1QP/Z8OCRGsIcxl9DHFrIK43G1XaKlSWvXP2QY46JEWXZwfAK1PoBmvHJzRzgIwn3flloEl0+bS/cRh3K7uRV9j4PXTKS+L5GYqOxSMJgPUo1LE5JdZNSkcft+XGIYvcL2OQeTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOBIClqI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so2696a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746474941; x=1747079741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke7UfvlKVWzYGxpI611l9JMPD+xd8a3CsyHj59ifFBo=;
        b=aOBIClqIE9QImX7CJVsXtVb7mdGlTdS/lAinz3lnT9D8u6bXmN69jUS/MJAT9WNIKe
         g4D9qu3muaGVXZHY2880CwNJ4wf8KNDgl2/JSMr7tkvyKISPGEUpb2talF2/qYUUsrvq
         JBkgNpRiu1DCIX/FNTk88rV3djzM83ChoHJ7rkaXkY3U+Bb6yckaDE8TBm7eyOXLRL6j
         ojjYd0snAYkKYd5Eh/eR9vlwK8z7I6bCIjmXs/03ekwKuZdzgVZGzjqSBEGcQnOIhit4
         QhGPpjKCuFmoEiZ+5V20EFdcvnL8GWzQ76CEdOPWT5OCHRC27cg4f+ps1beAetwdSsl1
         FlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746474941; x=1747079741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke7UfvlKVWzYGxpI611l9JMPD+xd8a3CsyHj59ifFBo=;
        b=Gme5bnpxiu5qbsAtcuqAvSVq/DN7WBCGqnVSvBxFAUVnuVg7/goGvYV9uPyH2P43UH
         9d7uYG54SgKzCOd/MQRxB0SeI2hdOmdcroxyDxOpro4OwzbR70WD2wJm5TsoITRzmdZA
         IWRYlsWDsNtP9lOHyvSL7Pn1t3jgJ/1po2JX29gA3//3VbYCvj+QtFU2XeuQyAysDhQa
         vJjF6r8zCmiPxJ2e74YLlIbe317+nNMMMKpGI2PAOZoDiwXf5/JEWzJvxHttL0hsSjEn
         IqL9a8PIco+bvu96e1x3P/ZXHBfOkfLBbMWUZpsOEmJjtHuhN7vOyPJOlT+DX6WzOqqj
         jT7g==
X-Forwarded-Encrypted: i=1; AJvYcCX0RJdv1Pb+sO//Pq88YbaqD07emmMeZuiO+k3DXF9VkKU/ARmdhg4OVCxwlHLm9IQRq3+rFGJJ3npm2pMH@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtzFeHeA9Ua9T3XyOUejln9QmuYZ9wmXmJZEqAt6Sn+5iRdxN
	leEh5Ijx9IOUEvLh10QKVLrB+Bws8tkb3v7LCcSceKgprE+g6cmG74ErBQnuWl53WTAV1Nxqeiz
	GzQDHL7OPVxoBrOtPpLztCuKcc2PC9m9RUAY5
X-Gm-Gg: ASbGnctw27gG+o6RUw4k5VsBeEZB3L+orLEK+DIf2I6N1bUl78jQ36Rgr7QF7mpjHAb
	OhBvCbo7nimNE3Qi5H5CvA1HalJkedr2UteDha3Pxy5XYUO2S4ltJ3q5NRtvzqz23yIahkY1sdj
	3/YGnp9knHrjAfDK2Uhg+HRSuWfhvteP7kbYIYADNtI+rmyfHSvQ==
X-Google-Smtp-Source: AGHT+IGpkY9fdkwpJJBS9Lbop+RX54Zzy8r2G/LTjC8IwFgVV1qvNdA1TuIs8KVN+O7yfulsBZG54ZY/n7ZbBSMEs1Q=
X-Received: by 2002:a05:6402:2043:b0:5fb:5fbc:4937 with SMTP id
 4fb4d7f45d1cf-5fb6c96a6b1mr13731a12.6.1746474940461; Mon, 05 May 2025
 12:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez35FN6ka4QtrNQ6aKEycQBOpJKy=VyhQDzKTwey+4KOMg@mail.gmail.com>
 <20250505193828.21759-1-kuniyu@amazon.com>
In-Reply-To: <20250505193828.21759-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 21:55:04 +0200
X-Gm-Features: ATxdqUH7FnmeFeFfdQZqGbFu4D6tPM1Ky3HDMk7LBe0AvXEbwwwNhZ2DfT9CwaQ
Message-ID: <CAG48ez1TePJ87PKNt_xFTSKs=N4z06d1mG9iUA7M9pgvbXPPMw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, brauner@kernel.org, 
	daan.j.demeyer@gmail.com, davem@davemloft.net, david@readahead.eu, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 9:38=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
> From: Jann Horn <jannh@google.com>
> Date: Mon, 5 May 2025 21:10:28 +0200
> > On Mon, May 5, 2025 at 8:41=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon=
.com> wrote:
> > > From: Christian Brauner <brauner@kernel.org>
> > > Date: Mon, 5 May 2025 16:06:40 +0200
> > > > On Mon, May 05, 2025 at 03:08:07PM +0200, Jann Horn wrote:
> > > > > On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner=
@kernel.org> wrote:
> > > > > > Make sure that only tasks that actually coredumped may connect =
to the
> > > > > > coredump socket. This restriction may be loosened later in case
> > > > > > userspace processes would like to use it to generate their own
> > > > > > coredumps. Though it'd be wiser if userspace just exposed a sep=
arate
> > > > > > socket for that.
> > > > >
> > > > > This implementation kinda feels a bit fragile to me... I wonder i=
f we
> > > > > could instead have a flag inside the af_unix client socket that s=
ays
> > > > > "this is a special client socket for coredumping".
> > > >
> > > > Should be easily doable with a sock_flag().
> > >
> > > This restriction should be applied by BPF LSM.
> >
> > I think we shouldn't allow random userspace processes to connect to
> > the core dump handling service and provide bogus inputs; that
> > unnecessarily increases the risk that a crafted coredump can be used
> > to exploit a bug in the service. So I think it makes sense to enforce
> > this restriction in the kernel.
>
> It's already restricted by /proc/sys/kernel/core_pattern.
> We don't need a duplicated logic.

The core_pattern does not restrict which processes can call connect()
on the unix domain socket address.

> Even when the process holding the listener dies, you can
> still avoid such a leak.
>
> e.g.
>
> 1. Set up a listener
> 2. Put the socket into a bpf map
> 3. Attach LSM at connect()
>
> Then, the LSM checks if the destination socket is

Where does the LSM get the destination socket pointer from? The
socket_connect LSM hook happens before the point where the destination
socket is looked up. What you have in that hook is the unix socket
address structure.

>   * listening on the name specified in /proc/sys/kernel/core_pattern
>   * exists in the associated BPF map
>
> So, if the socket is dies and a malicious user tries to hijack
> the core_pattern name, LSM still rejects such connect().

This patch is not about a malicious user binding to the core dumping
service's unix domain socket address, that is blocked in "[PATCH RFC
v3 03/10] net: reserve prefix". This patch is about preventing
userspace from connect()ing to the legitimate listening socket.

> Later, the admin can restart the program with different core_pattern.
>
>
> >
> > My understanding is that BPF LSM creates fairly tight coupling between
> > userspace and the kernel implementation, and it is kind of unwieldy
> > for userspace. (I imagine the "man 5 core" manpage would get a bit
> > longer and describe more kernel implementation detail if you tried to
> > show how to write a BPF LSM that is capable of detecting unix domain
> > socket connections to a specific address that are not initiated by
> > core dumping.) I would like to keep it possible to implement core
> > userspace functionality in a best-practice way without needing eBPF.
>
> I think the untrusted user scenario is paranoia in most cases,
> and the man page just says "if you really care, use BPF LSM".

Are you saying that you expect crash dumping services to be written
with the expectation that the system will not have multiple users or
multiple security contexts?

> If someone can listen on a name AND set it to core_pattern, most
> likely something worse already happened.

