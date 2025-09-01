Return-Path: <linux-fsdevel+bounces-59904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89DB3EDF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8A484353
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63913324B26;
	Mon,  1 Sep 2025 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEVtlqqN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8034CDD;
	Mon,  1 Sep 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756751977; cv=none; b=KHC0J6SgkSB+bEQMeSBHkdpvWFotjEg6abAMok8jri3X9a7XlgPJUhkihHULrE7XYq3U7lZ+iKq11Y0J8uS45+Sv5+AJQsRRoZJLjIMB9spihydPsbUedpw4NyapHLn34qi4vPWCO6ylLvXXRLJ87dJLf16b/TxQIWbf66nhlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756751977; c=relaxed/simple;
	bh=B1efNRQOm174YJ981GJzfBCcp9P5sNFLGxsCgQbCU/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIcmKPV6y3oYDvDRTdYZtO9LGnhvfG+gnLY7/AaLcj4dpl4QlKxiD6YiRc6Z12griQJbNhrtIDQ9PYr+77If9lX0jgdmiX9PNS8ACp+TgzQP9xSPaKQrAIKEUEdbqiQ984sAQ0U7WyBvLuBcffzWmMQrqaSARCPiYLCVBKCx4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEVtlqqN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so9919914a12.1;
        Mon, 01 Sep 2025 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756751974; x=1757356774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzIgq2g3RlycrS6fYzK9k6VbjF9ba3Cw79xulaFQz9I=;
        b=IEVtlqqNQl1B+WwuW3bLmVqssb/IgSQrpTmO+Z8lXcEBdgrf/xB5lXCEeAc5l8/HHO
         rgHXziCwC/qIhFLzt/ecHRRGU5ynuTaeS7zVSZ2hEQvsCKqeUjdLzEFTzP4DEoFQqQek
         6O3cNHcQzaoLnIoG84wIEQMo9E/dNWoNrfkQXR1rx2aDPWypTc1v4PltAitRszGgAK+7
         TP+VXDY55Iz06hYnm5Ey0QtauzC9TIHzMO1uFnOc69I7VvkvOZoKK9PBOkHHUsCGOxCY
         ZgwRDnoeXJ+Hub8HAP2TNyvyiOMnyChPxC4QX0C2NdsL/0H2v3clnYRjWia2jIxt4LPo
         Ev9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756751974; x=1757356774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzIgq2g3RlycrS6fYzK9k6VbjF9ba3Cw79xulaFQz9I=;
        b=PBE8bNoQT/2fsm4eYDNWjBGyjZVSXs4QG7ZsDhs9Zz2HXF7Bn86cvkQJN/YZa6B9kZ
         DoPBIE1PUt6lOnqj8CBbmUhm6Ukj6eiXrBZcjYoMXJNTAxvtPRR4cNqb7wvqtIIcKRsc
         6aFs5Jp6JR5Nn8H29mo5xU/2PLQGd/MlRNAG5UGVwdWP+p2796o+hNiPworCWM9tOWFC
         Fse+0zZwqEYSDeVO0p2SSxj5ee7jnDx5C5OASOCcJ05tcfW/A4ksT3O59ftkwmiWP2f6
         OtiLoKwjKO1kn2ECCY4QQTWKV/5RKRYg0lKKJ70tid3aG5CJ6jCjqE+RE5aimebgi66X
         lg9g==
X-Forwarded-Encrypted: i=1; AJvYcCVu/+aLbYihnBZTcYzBPp/EalPWCkCj7iTcouPxk5V0GtAMQEJjOApPjN5iTqWQnndUCkR5tYmxc9rtKtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8iKZT13x0GY0mtU7ARVsy57KwZDIi/usK31Ry+KvzKkmfpwK
	tVijRDkx41AjJdc1bMmNprUbrzMrfU3vLkfs1XcA6DXCMN4P0xmqnuPo
X-Gm-Gg: ASbGncsBKmSL+IGlCTGyodPlOojfsBEfXMob8lJBAuJu1io/6h62B4GZy+FCcO+W7P6
	f63QXhW2Gh7jkjdosZ0Jjk1BsBpZVvuBntrZTfCTtJSpH/xDwEt//c8m2Lb5ba1XoZqoqGI1Mdx
	EMrFRamQOOReeg6zmQM2ghm2T0d5k1UiiIOdk9rps2z5gzcQSZwCaKNgzYFA5Dzz2yzUCQXR/MC
	DUfLZfygP1dadERsIGDzOvNnSZy96odVu0FXpmpk1sUT/1ctSokDO4YJyI7H7tgwUyCgxMstWY3
	w+5UX3vB6jAdX/PjSGhzaWP/+70+xn91TTnxz+HRKGCcJmq2Nkv4+IG0bu7X0XJFv4BU7kh+5Lr
	4ev+tZ8C4jlFLMxdJBMlwiVsc/Vu4gelpdli6FDSnxFqq9Dvl
X-Google-Smtp-Source: AGHT+IFjORG3X7mKcc5B0ao2+rVjEGGIT//XcJU8/kl1ixbbYaTPXIYVn5+mTt3ZMfNJfgt74DrDvg==
X-Received: by 2002:a17:907:7e82:b0:afe:6648:a243 with SMTP id a640c23a62f3a-b00f67e0eb3mr1042209366b.3.1756751974145;
        Mon, 01 Sep 2025 11:39:34 -0700 (PDT)
Received: from f (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61d3174074bsm4628249a12.35.2025.09.01.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:39:33 -0700 (PDT)
Date: Mon, 1 Sep 2025 20:39:27 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>

On Wed, Aug 27, 2025 at 12:05:38AM +0300, Alexander Monakov wrote:
> Dear fs hackers,
> 
> I suspect there's an unfortunate race window in __fput where file locks are
> dropped (locks_remove_file) prior to decreasing writer refcount
> (put_file_access). If I'm not mistaken, this window is observable and it
> breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> in more detail below.
> 
> The program demonstrating the problem is attached (a slightly modified version
> of the demo given by Russ Cox on the Go issue tracker, see URL in first line).
> It makes 20 threads, each executing an infinite loop doing the following:
> 
> 1) open an fd for writing with O_CLOEXEC
> 2) write executable code into it
> 3) close it
> 4) fork
> 5) in the child, attempt to execve the just-written file
> 
> If you compile it with -DNOWAIT, you'll see that execve often fails with
> ETXTBSY.

This problem was reported a few times and is quite ancient by now.

While acknowleding the resulting behavior needs to be fixed, I find the
proposed solutions are merely trying to put more lipstick or a wig on a
pig.

The age of the problem suggests it is not *urgent* to fix it.

The O_CLOFORM idea was accepted into POSIX and recent-ish implemented in
all the BSDs (no, really) and illumos, but got NAKed in Linux. It's also
a part of pig's attire so I think that's the right call.

Not denying execs of files open for writing had to get reverted as
apparently some software depends on it, so that's a no-go either.

The flag proposed by Christian elsewhere in the thread would sort this
out, but it's just another hack which would serve no purpose if the
issue stopped showing up.

The real problem is fork()+execve() combo being crap syscalls with crap
semantics, perpetuating the unix tradition of screwing you over unless
you explicitly ask it not to (e.g., with O_CLOEXEC so that the new proc
does not hang out with surprise fds).

While I don't have anything fleshed out nor have any interest in putting
any work in the area, I would suggest anyone looking to solve the ETXTBSY
went after the real culprit instead of damage-controlling the current
API.

To that end, my sketch of a suggestion boils down to a new API which
allows you to construct a new process one step at a time explicitly
spelling out resources which are going to get passed on, finally doing
an actual exec. You would start with getting a file descriptor to a new
task_struct which you gradually populate and eventually exec something
on. There would be no forking.

It could look like this (ignore specific naming):

/* get a file descriptor for the new process. there is no *fork* here,
 * but task_struct & related get allocated
 * clean slate, no sigmask bullshit and similar
 */
pfd = proc_new();

nullfd = open("/dev/null", O_RDONLY);

/* map /dev/null as 0/1/2 in the new proc */
proc_install_fd(pfd, nullfd, 0); 
proc_install_fd(pfd, nullfd, 2); 
proc_install_fd(pfd, nullfd, 2); 

/* if we can run the proc as someone else, set it up here */
proc_install_cred(pfd, uid, gid, groups, ...);

proc_set_umask(pfd, ...);

/* finally exec */
proc_exec_by_path("/bin/sh", argp, envp);

Notice how not once at any point random-ass file descriptors popped into
the new task, which has a side effect of completely avoiding the
problem.

you may also notice this should be faster to execute as it does not have
to pay the mm overhead.

While proc_install_fd is spelled out as singular syscalls, this can be
batched to accept an array of <from, to> pairs etc.

Also notice the thread executing it is not shackled by any of vfork
limitations.

So... if someone is serious about the transient ETXTBSY, I would really
hope you will consider solving the source of the problem, even if you
come up with someting other than I did (hopefully better). It would be a
damn shame to add even more hacks to pacify this problem (like the O_
stuff).

What to do in the meantime? There is a lol hack you can do in userspace
which so ugly I'm not even going to spell it out, but given the
temporary nature of ETXTBSY I'm sure you can guess what it is.

Something to ponder, cheers.

