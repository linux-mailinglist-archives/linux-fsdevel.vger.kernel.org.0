Return-Path: <linux-fsdevel+bounces-49024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7061AB795E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3476F4A75BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739520C014;
	Wed, 14 May 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1+4u0fA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F91DED6D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264669; cv=none; b=aV4Mk84PKWthe3qnEKvKT1ruAqXe3Qf7PziB6OS5PrYwDgzk7SG6ltV7lmwUTgwF9c64kvQEEAXeu1qheMjH440v+H062Ic0e0ABxKRbdUtqc2ZphxwwW925u500X6hnSsxDPqgrkh//ENiYGvPmJfWjwRnb4HfiDQfRnKLl5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264669; c=relaxed/simple;
	bh=z+V/1MRNuGRyTWd92KjujttH6Qdr1BjiX1XfZiilnkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCOJ/5zFvR5R26kj5u3VWm2sjMNjhIggy3uoZklMrIl6SDBxsNpmvd5MFJpFab9hVnR2f2CCTJGmxodm3aqmuKYaL+CWPZnwVqrtj3pa6Y4ZQPoqI6EeaCZ9nPHHwrqj827nKRXGDVZH0AQ5ILYJutxRuuGugFc64BdUTHRbKug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1+4u0fA; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476af5479feso4498061cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747264667; x=1747869467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+V/1MRNuGRyTWd92KjujttH6Qdr1BjiX1XfZiilnkM=;
        b=F1+4u0fAklu6YwLBzCpBiT24yLfnTXFEGMDIuQoj/mUFTfWS/2tVSGRiZaEd17eRUy
         lB5c3A2gh9m2x0fMO4ewubU5SbzWCXlQaYk05i1oHXqfDrKwikQERDUElDN9KyfzSMTf
         A8dNLXP3ORWmtr+hY43Pb0HGsPkhyICN4T7xm4a4qtCvJb0dwdp4ATOJVV61+QbE5dk5
         lDpxiHhzFDJbfwFKx92Ioa12SBpYyCngPqW2LLq6vxQfe6px3ZSpkJJn3MRa9s7ArosN
         T0Ykso5/JLoKiFDqmEKggvyeLeBsLd1zGxh/lcISxH/+01jMdjuvk07Cu+fgbwa1Vfep
         fCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747264667; x=1747869467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+V/1MRNuGRyTWd92KjujttH6Qdr1BjiX1XfZiilnkM=;
        b=teb1GZmeMIIVVsbqGTtF7DZguX4cg9dPsJu5YHaKAO35zN4Laanfh6HJzDn2vj4GD3
         2UprhjbFcfJPKMVmLUrD5DkGpfFqjaEo4hQtNnoirSayLUH8hPp8EB4gcZQRxA8waml0
         kyEhLEmGnqxJfxWB5tGU215kKBQGLBPBTCQQ4R5LlCYyd9yr3j60fU6784R/otssTHr2
         FbNK+gezMbLIeYGmgr6ojbScU+M+zICdej3lA5DRi6QRuxUXzg7WCzncqlkPj/+fhlgc
         AgvRbNS6hu17aMBx4BwVJVLAQEf+Rj4JrMZdGi+PYuA3Ey3FEx76g8zcn9pvLNHuNegG
         WhmQ==
X-Gm-Message-State: AOJu0YyTcKci7lNARN81JNMF2GmjTAa0793MebnaUulW+4JXZo36qemn
	2yLRE3qGlWoUQ5qhcYSSPFzzSAFpQ1MCtvd/YONLXlrSjHERzxszrXKoK4ORWrDjzVwVQkUzACO
	VIHyzaNuq2O1eT+dbxzLGfn7+vDarAg==
X-Gm-Gg: ASbGncslNwMsqgE+0ii7s2DUwiWq7U5NbqOR1d3skMoeWgPDJq/p5X7oDNQVP8C76lD
	exO8nH+VWcXYZWh3weEpZEP4Dl3rLrd5bTILSAvWmhOCYt6zdms6ZQo7v4fW1eYk2496wNsJO93
	t3UvSSgkIC1tEQh06ysGnNjTX9qAezzYqaSJnnBNesb+c=
X-Google-Smtp-Source: AGHT+IFU/TuVqj6xKQITvm5hghzyMk/ImDiigEOFYyzMJhn8hT0v7suBgpyaSu9aSU2jSlPihb1BZf+sBG+d3UiPhDo=
X-Received: by 2002:a05:622a:4005:b0:48a:c5d8:aabf with SMTP id
 d75a77b69052e-494a33978e4mr7884811cf.30.1747264666845; Wed, 14 May 2025
 16:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com>
 <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com> <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
In-Reply-To: <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 May 2025 16:17:36 -0700
X-Gm-Features: AX0GCFsaOvYmPdcaACo49A7mB70xTBwjnVWbvYpZB6-TUL5eW0jCxd7xvp1eT90
Message-ID: <CAJnrk1aX=GO07XP_ExNxPRj=G8kQPL5DZeg_SYWocK5w0MstMQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 4:57=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 13 May 2025 at 23:29, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > The results vary depending on how IO-intensive the server-side
> > processing logic is (eg ones that are not as intensive would show a
> > bigger relative performance speedup than ones where a lot of time is
> > spent on server-side processing). I can include the results from
> > benchmarks on our internal fuse server, which forwards the data in the
> > write buffer to a remote server over the network. For that, we saw
> > roughly a 5% improvement in throughput for 5 GB writes with 16 MB
> > chunk sizes, and a 2.45% improvement in throughput for 12 parallel
> > writes of 16 GB files with 64 MB chunk sizes.
>
> Okay, those are much saner numbers.

Sorry, I wasn't trying to intentionally inflate the numbers. I thought
isolating it to the kernel speedup was the most accurate else the
numbers depend on the individual server implementation.

>
> Does the server use MSG_ZEROCOPY?

No. The server copies the buffer to another buffer (for later
processing) so that the server can immediately reply to the request
and not hold up work on that libfuse thread. Splice here helps because
it gets rid of 1 copy, eg instead of copying the data to the libfuse
buffer and then from libfuse buffer to this other buffer, we can now
just do a read() on the file descriptor returned from splice into the
other buffer.

>
> Can you please include these numbers and the details on how the server
> takes advantage of splice in the patch header?

I will resubmit this as v3 with the numbers and details included in
the patch header underneath the commit message.

Thanks,
Joanne
>
> Thanks,
> Miklos

