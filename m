Return-Path: <linux-fsdevel+bounces-69264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F8FC76129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D087635CC3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 19:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF130FF03;
	Thu, 20 Nov 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BbMrJwOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086A3242AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666612; cv=none; b=XHuzpxruoBiX+AgSXOYow5W2FSybOljUSIHWxpQrkl9ygqQ4Eg4t1pWWRWXoIs3gHP1EcLxPyDk1iPz7FbKIPJ6MO7KnNCakmnszac+UwP27re886vkXYtyGV3tlCKmBR/b0q4eq9N1oN2jPwf/HrP2w+CjPuHYA+ErCa2kbCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666612; c=relaxed/simple;
	bh=q296xHT139H/nWM6Mg7reqJBxMtKMjHiSyLM9oVB9ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCc9N32aTmmqhyWtSYv75hQ3z2g+1T1jrPPhzn5jj22nDANS5nlBbpuIAoRWkOGY+zZYYPGSLJJETQyhKo+KPtcoUK1ShM7tP9djJFzQoLmuOmn3FE8WcZypOovXAZ45+PKf27f8GvA/fXphr2YCtRbkS1dpl/0HbyhXh2lOfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BbMrJwOL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so2040043a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763666609; x=1764271409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyqJoiBriMQgCPogonFRTQ9rKbbZAaEyFulWYXXm130=;
        b=BbMrJwOLrT3Py4p30cn1WEcybQv43PCIVCm1iXjzIj2p7KNXK6hqeiZBArjEMuE+jX
         Y3Eze+w8xj5wDNzOyI82htIFgBFn0c0tDN46qCmrzH6jZpJbf+F8L3tZR3ob8tA75qW4
         A7vUVtw7aTC1siTO9z8On6ikwjQVYUQLPdno3iaV8cwhMVjgOsns08mU00lcTn0SfT1E
         +m+rHYYxVsxCqPZAcWUSk7BcZFNxg2tgYAusDCG6B/pL//T829mudssUIjiWix6M8I5Y
         Q3Qfj50QZ7sOn6uq0MLQnYBwPmLbIEH1HY91ksC6Y002jFsB7U/oYzCd7wkdtgl9mCiC
         2sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666609; x=1764271409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyqJoiBriMQgCPogonFRTQ9rKbbZAaEyFulWYXXm130=;
        b=CzK0QpVZr1AkC1GzQSOkcNKzMMjAymQx3o3/HQsaucnqfs+qgn7rMAN1d5Ap/1TKtO
         7rSkS4IRXMM8rz1mpYgREjR61D1wh4ODu878eAzGRy9dbjThLKpP4Do+5TB0VZWGubnn
         pUIZYgBFfV9qLrRV8JFf5l3/DmySun4sSuZhQLS2nAMBRDZ8ARG+FjxZcp6gXBpaH3LB
         Fzi8xkVOGU/Iec6Ilc1bp/eWTM0poaEka5ih20tTP3MJdE97s0q+8WmRGpz0XtieDhoh
         MZWhT/wQQ7+WzJAAcwO1pW1Ki17dLlxHuZWVHoD66NtTcwLp2z2sG0bhdJE5yRW4lW2H
         l+tg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gnhY1Ans+HZXdVgGUroYa1AYw5Mh233T1lQArXSPaSSbap5A3903gG0gmcILUwh/XOd8vwD3jzLvFPMf@vger.kernel.org
X-Gm-Message-State: AOJu0YzHKOfJ8DMQBf6fd1h497mknOfltu8ZOdn+HlQ4qv+s9xSDERcc
	PLM4Gn+EGeRQbP9bXsMmsTZifh7s4lE5I4UhpR1c0e9hujvJQZlHdDjxMV94fVV/594ROMminYX
	O9sKZxE4kMpv97TaelnNPzBgQdqXOEQtrnD3NkGPfTA==
X-Gm-Gg: ASbGncv10rCqJJSYTdo9prTnfYZwFgPGr591hKKP6AKOR5LDbOKUjNmk+N6zT91Qw4l
	UVPnYK6n5CZrBQ/iuQ1B11uts4o1q55mr/MoWU+nYqQpNzVjGWrl1o9YGVWB19xxdCQbIY/4Tz4
	v29nBdM9NdRDJm0yQHtvwN6xdwgTnH4hfqsMM1pWPXoFh5Wc87K24L6POpryjM4ePcFTo7EfeQh
	dt3qOTH+YyANQRmuAlKm9ELaopgs4aumRc7X/DafzPWF1dOY8IMk8tRztC2HoFAZpAb
X-Google-Smtp-Source: AGHT+IGJIRbNGCteCBItzQRTIq/UH9PLUTffzANE/lniZXOm3tJP5jtVCSVDjBc5RQYSOrk0+uvnxuTU46FVfmAnAaA=
X-Received: by 2002:a05:6402:34c7:b0:641:4b82:10c9 with SMTP id
 4fb4d7f45d1cf-64536450b6dmr3933635a12.27.1763666608422; Thu, 20 Nov 2025
 11:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-6-pasha.tatashin@soleen.com> <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
In-Reply-To: <CALzav=c-KJg8q8-4EaDC1M+GErTCiRKtn5qRbh1wa08zJ0N4ng@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 20 Nov 2025 14:22:50 -0500
X-Gm-Features: AWmQ_bmAzBC36YkUhEhsUvaEIh48LIbtssnzB0dTWcGpqHev3pMUQm9n-Tz4Sts
Message-ID: <CA+CK2bD4Y3CMHcTGKradmv-hAbdtA7zsw2CYeh7-8LNianYMZw@mail.gmail.com>
Subject: Re: [PATCH v6 05/20] liveupdate: luo_ioctl: add user interface
To: David Matlack <dmatlack@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 1:38=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> > The idea is that there is going to be a single userspace agent driving
> > the live update, therefore, only a single process can ever hold this
> > device opened at a time.
> ...
> > +static int luo_open(struct inode *inodep, struct file *filep)
> > +{
> > +       struct luo_device_state *ldev =3D container_of(filep->private_d=
ata,
> > +                                                    struct luo_device_=
state,
> > +                                                    miscdev);
> > +
> > +       if (atomic_cmpxchg(&ldev->in_use, 0, 1))
> > +               return -EBUSY;
>
> Can you remind me why the kernel needs to enforce this? What would be
> wrong or unsafe from the kernel perspective if there were multiple
> userspace agents holding open files for /dev/liveupdate, each with
> their own sessions?

By enforcing a singleton, we will ensure a consistent view for tooling
like luoadm (which will track incoming/outgoing sessions, UUIDs, etc.)
and prevent conflicting commands regarding the transition state.

This is not a bottleneck because the vast majority of the work
(preserving devicse/memory) is handled via the individual Session FDs.
Also, since sessions persist even if /dev/liveupdate is closed, we
allow the agent upgrade, or crashing without requiring concurrent
access.

Pasha

