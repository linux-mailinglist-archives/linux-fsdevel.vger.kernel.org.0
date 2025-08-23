Return-Path: <linux-fsdevel+bounces-58879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD128B327AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CDF7B81CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AF23ABB0;
	Sat, 23 Aug 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYw45MI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C331F0E3E
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938587; cv=none; b=VoEaXIt+cRGAeYpnLd4PVJD9PFC+DTG2SV23gJEgg6uFnXwShMkCXkO1/yLHAFbGENywaVg54TGrdNJsvUtRZfRtRE7f+EtEPYAkQ6PPej/h7nonnZP2xdp9jv8iMev4b4tz5RT21lnBLfjAogZF0aXiEHu7uDo0PFr9056DNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938587; c=relaxed/simple;
	bh=37X3jjXwUHjejovSWpjADkwKpBcCQqf/BM1PK964nAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQJUqel01dd8u5Q7ffWhOiPXQE56TLNP70CQcsPbX265uMKAObmpZFiRGe18DwA6jMlcvfQMo+Y8YYdZYILzqIzWz9GSfusUQXKQs8bPTblFCXSLSFi9ksMRz0I4+DF4WIm5zaEYf2sx+zNCI3sqhVDNSbt71X0uR+Nc4amT4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYw45MI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FnRHJFSV3SreC1w0p6QNKVoKyAgLeDGHlww9MpDPB0=;
	b=HYw45MI/SfOEzMMiruhlfDk1FqwMjJcSRi9souKhcexGApxVGG+yJ4oez3MpO9agSie0xj
	NAjc0lspNu7wV9sKgQF1+Dg5SbJG17P5sJDpcRrFJNUfB9ne5wksyITBW2A7fctp7PgOkK
	XJiQo6GZX4l07DuEv16sQx6briQlC0s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-6HiIPj5lMJCVeQGr3e7hqw-1; Sat, 23 Aug 2025 04:42:57 -0400
X-MC-Unique: 6HiIPj5lMJCVeQGr3e7hqw-1
X-Mimecast-MFC-AGG-ID: 6HiIPj5lMJCVeQGr3e7hqw_1755938577
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0045a0so18511085e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938577; x=1756543377;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FnRHJFSV3SreC1w0p6QNKVoKyAgLeDGHlww9MpDPB0=;
        b=cW6Ibsja4z6DM7RHJ2nff0N5SVrhHRPcvtKDqKzOmhttyD7hJS2y802yMujKW1vLQF
         hKEyXdq3/a2q3L0CuggP1CSrIpq+tVnQnRJE1z2GteQS5njMJs3alhFLOQrHn7uNMHWw
         VKXYsujPxy4DzRVR7y86eoYjQdv0BVDTvMmHKvzS8uSfmiVG74YJMpsrxHvcKNJMEt7f
         rzM1eOiKYNzhJD1JNQVDzlR3kgTFsGuxvzRyiCTrAFlkmeaKFxeVoSa7PbUdz8cwRnrx
         +PtoDoOc3JpwMR+9T1ANlGrqqHNubwLYQP8DfHWS2mjRYyUMDaHjU8p3ZqSgxqZhtFG9
         4gUw==
X-Gm-Message-State: AOJu0YxZHkQvUyBq8xlUygmdAgf2sMJ2VyNeaU7OSHkEXtwYvPMT+gHl
	wrvFQqQ1cVqmSEb5Yzxrk5EepfFUkyRDAIZXB91LrIJRIxX7zwU/V31xWjapebUMQb03gLH091s
	1y0JvyyW0DDZNe9P4DjhWBY3MQZWcadkAUjVND2yK3//rdo5cQJP/XuGGUOlLsg+Hd+E=
X-Gm-Gg: ASbGncsXzjkBQhNXfPy+umJMhv1OTGbubmUTzetdzM1o2ey2Y+oOw3iautyLajgsy5c
	ORdKTgpXo9coWjlapRdC0PuEr/gk+03/D8OX5sBQMmTfQh1Wftxi0MOQ2/z32yxdWNOr6PcCnsK
	IfilF61cNfJ2GctFLwLigJbd3bP8i0zdDIE/NMpN7Cs0T6ioYeiXCPokFFbvctr9iNR/tuMxbha
	gvZMiwLnJIjVV0n5WOtz4EHzhv3WRWQLew94+6Prk6tA4LsU/frRKCRxPN7Czlvc9AUmyzrY9t6
	kNecMJo4AYPWyC63/axssTrcqGjVcsjDMWPaAOZUBb/M98uTJqQ=
X-Received: by 2002:a05:600c:5493:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b53af6c77mr48705545e9.6.1755938576705;
        Sat, 23 Aug 2025 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6NjHGHYqMJ8ulZ9is0JehUqd1MHmd37Qkuu9GJeF/qPZl1+eYwVAU/3Y3IK1AImm7nVQHsw==
X-Received: by 2002:a05:600c:5493:b0:459:d709:e5a1 with SMTP id 5b1f17b1804b1-45b53af6c77mr48705185e9.6.1755938576230;
        Sat, 23 Aug 2025 01:42:56 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57444963sm31535055e9.3.2025.08.23.01.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:42:55 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:42:51 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, wangzijie
 <wangzijie1@honor.com>, Alexey Dobriyan <adobriyan@gmail.com>, Christian
 Brauner <brauner@kernel.org>, passt-dev@passt.top, Al Viro
 <viro@zeniv.linux.org.uk>, Ye Bin <yebin10@huawei.com>, Alexei Starovoitov
 <ast@kernel.org>, "Rick P . Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] proc: Bring back lseek() operations for /proc/net
 entries
Message-ID: <20250823104251.49a8caba@elisabeth>
In-Reply-To: <20250822160904.6c5468bce2200cf8561970d7@linux-foundation.org>
References: <20250822172335.3187858-1-sbrivio@redhat.com>
	<20250822160904.6c5468bce2200cf8561970d7@linux-foundation.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:09:04 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 22 Aug 2025 19:23:35 +0200 Stefano Brivio <sbrivio@redhat.com> wrote:
> 
> > Commit ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek
> > as ones for proc_read_iter et.al") breaks lseek() for all /proc/net
> > entries, as shown for instance by pasta(1), a user-mode network
> > implementation using those entries to scan for bound ports:
> > 
> >   $ strace -e openat,lseek -e s=none pasta -- true
> >   [...]
> >   openat(AT_FDCWD, "/proc/net/tcp", O_RDONLY|O_CLOEXEC) = 12
> >   openat(AT_FDCWD, "/proc/net/tcp6", O_RDONLY|O_CLOEXEC) = 13
> >   lseek(12, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(13, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   openat(AT_FDCWD, "/proc/net/udp", O_RDONLY|O_CLOEXEC) = 14
> >   openat(AT_FDCWD, "/proc/net/udp6", O_RDONLY|O_CLOEXEC) = 15
> >   lseek(14, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   lseek(15, 0, SEEK_SET)                  = -1 ESPIPE (Illegal seek)
> >   lseek() failed on /proc/net file: Illegal seek
> >   [...]
> > 
> > That's because PROC_ENTRY_proc_lseek isn't set for /proc/net entries,
> > and it's now mandatory for lseek(). In fact, flags aren't set at all
> > for those entries because pde_set_flags() isn't called for them.
> > 
> > As commit d919b33dafb3 ("proc: faster open/read/close with "permanent"
> > files") introduced flags for procfs directory entries, along with the
> > pde_set_flags() helper, they weren't relevant for /proc/net entries,
> > so the lack of pde_set_flags() calls in proc_create_net_*() functions
> > was harmless.
> > 
> > Now that the calls are strictly needed for lseek() functionality,
> > add them.  
> 
> Thanks.  We already have
> https://lkml.kernel.org/r/20250821105806.1453833-1-wangzijie1@honor.com
> - does that look suitable?

Sorry, I didn't spot that one. It sure does!

-- 
Stefano


