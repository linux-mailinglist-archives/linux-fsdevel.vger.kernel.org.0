Return-Path: <linux-fsdevel+bounces-27571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAF96270E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128BD1C217A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF2176233;
	Wed, 28 Aug 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pZhFFwvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579B16C859;
	Wed, 28 Aug 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847987; cv=none; b=OCyd4dLUMQjKwxLuH+oVXZl11wpmbuxew/UFZ3AZGQokradMWQXf+yRamhr+SBlerJxTFp9GapSxvFHrNTb41FON2kG/ZJWAvP2Wt086TTvH4wyukhvShmWeT53HJDkGni5uusjIOYzINULQdIBzvTFJLMUqWvUInPomF6Q+aEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847987; c=relaxed/simple;
	bh=1flW7GCzzsPh16d1yPD4h41cC6zIzhxJDTsj3ZwcKZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KByFglBWxE1Dm3ub7RQ190kZhRT/LtFd6h7LLEU9xrfwE7RiSes2/vtN2r9WLV4ZaP7HZrAz2NOrBbjr3D3DAnYgRyyS/PSnFVgEYOmdpeOtd/WQyTti48UDApo4Bvx0ufNORZiIklDi6Nrf8PevMyZkBRJ4fri4hP71ZEGqKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pZhFFwvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BEEC98EDB;
	Wed, 28 Aug 2024 12:26:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pZhFFwvf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724847983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uEFEGqQJQMz8Ub4wy+aep50eWmgdp8pcSL8AmUjJ5J8=;
	b=pZhFFwvf2+rUCk0mnu74yzuq8D0OlV5RRX3O/pUcL2EJirk1lWLjJ7T+VmJhAB+Nwuqruo
	5w43+j7738kAhUtF/Op+T7PkY55MvhYmMEm2AulNbOZOm5YzBQVDPiZl6Xd1e0lo4jpoA9
	0Tg6/x3YqzwUs/XLZ+j/psnPUsH+3wQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a699d10f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 12:26:22 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-27018df4ff3so4910521fac.1;
        Wed, 28 Aug 2024 05:26:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURXtByFUqqUn01GwdQRMnNmmh17KxzSjZwR4CWstb5JeTywOt+zGaxYyE0DuWOZ5jG4vHkRa8rcQlzeWtW@vger.kernel.org, AJvYcCVDToxFmv9r1s9rhL3G4itdOjZHOyydMFVF/hLIEfT5fDAjSHHionQd8uGrKJ1o0Ic49XwFnVeRgBqqYlHpMw==@vger.kernel.org, AJvYcCVREVXiBUsIXTVICUsG2yJCj6eNustd0FOFrXcUB5kp6GboY0v9iaBKmkXwmh/k2WX/iqB3yVdIZe7O@vger.kernel.org, AJvYcCWaPnfSqC0DKCKNHHpQw1UCOKccq/VD0K8UYjc9xcSXzA2wPv12KCJU2PrxdEQEjQV7oJl26T5D32pE8ZT+7jems/3L@vger.kernel.org, AJvYcCXH5tHVJ8knZppEDz5G9ZvQcUfjTq+LMhBQrPYtBYaKvyNJvo8aBxP0NUKnUyJhH/k+C/rfMqbPzGItBL6j0Y6P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YOs8LDGHfWIvCp3Suv4io2RBW6nDT337BcXPqteSdwEev7zy
	pIv/EQb7OSndvq1kPVW0WENeiVgVfU97PNB//aJBtIy+ek6uUOh/PSQjsP35HIVl55kqD5VnSW+
	p4BwJydemrhP/dkVAwTLn1m7KBmk=
X-Google-Smtp-Source: AGHT+IHXO1KZEIb1pBgGn7dKx8LC6G7ifrWZYsusE/oKQVZmO1hrOeMVz7hy7j/rnnH9GmqVmjbXApoOhTEeHD761oc=
X-Received: by 2002:a05:6870:1713:b0:25e:bd9d:b1cb with SMTP id
 586e51a60fabf-273e667ed95mr19307401fac.40.1724847980462; Wed, 28 Aug 2024
 05:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain> <20240827225330.GC29862@gate.crashing.org>
 <Zs8HirKLk-SrwTIu@zx2c4.com> <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
In-Reply-To: <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 28 Aug 2024 14:26:08 +0200
X-Gmail-Original-Message-ID: <CAHmME9rjH4Ek3e8jmBvRp3wy+mrzJAeYxk5=o+OHjoT5sTOQPg@mail.gmail.com>
Message-ID: <CAHmME9rjH4Ek3e8jmBvRp3wy+mrzJAeYxk5=o+OHjoT5sTOQPg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
To: Arnd Bergmann <arnd@arndb.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Eric Biggers <ebiggers@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 2:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Aug 28, 2024, at 11:18, Jason A. Donenfeld wrote:
> > On Tue, Aug 27, 2024 at 05:53:30PM -0500, Segher Boessenkool wrote:
> >> On Tue, Aug 27, 2024 at 11:08:19AM -0700, Eric Biggers wrote:
> >> >
> >> > Is there a compiler flag that could be used to disable the generatio=
n of calls
> >> > to memset?
> >>
> >> -fno-tree-loop-distribute-patterns .  But, as always, read up on it, s=
ee
> >> what it actually does (and how it avoids your problem, and mostly: lea=
rn
> >> what the actual problem *was*!)
> >
> > This might help with various loops, but it doesn't help with the matter
> > that this patch fixes, which is struct initialization. I just tried it
> > with the arm64 patch to no avail.
>
> Maybe -ffreestanding can help here? That should cause the vdso to be buil=
t
> with the assumption that there is no libc, so it would neither add nor
> remove standard library calls. Not sure if that causes other problems,
> e.g. if the calling conventions are different.

From https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D90701:

| You need -ffreestanding but that is documented to emit memset and
memcpy still.

