Return-Path: <linux-fsdevel+bounces-15122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E27887400
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 20:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A8FDB21E9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCBC7EF11;
	Fri, 22 Mar 2024 19:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nwxJph4F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2D7EEE7
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711136816; cv=none; b=Na+oYwrFuRvauPpqlyIPt/LGJFi0M9EfIOfNmfPP/GM3/M2EqU3i7il5DMLWvsaVZXjWQXUd19gC174XoQYWh8Jn19+JK3oqtEy5qTKK7ztz0rkZOpHtmNrHD7FgS6nmHqWpzXpn/QTDP5PqeX+iatluOqrTRHMIc2wFHz1f9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711136816; c=relaxed/simple;
	bh=U7eZoHi3uHnPeiiWjIrWr64IsGQF0wptDk5u+PKR+OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKBOKglb7Mjy3QuCbvY7Fh3SQbvoEAhHR+xDZmfGPPSTxpyWAzx0fBgBOadApGAAJqyjSAEecs3bUQzEAvV5kchUkhpSFDWsec0XYNWZnHoIjyoCjORPMSY3D9K7RrCoKC9Zuu9/RgYUg7TSMghVxzXBGudtJB9BqIJr1g3ucWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nwxJph4F; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a467d8efe78so304835166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711136812; x=1711741612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DgSSYjlN4+EDU0hEA5qrEbHHQ7GX2ErZACZlkqCEZ+A=;
        b=nwxJph4Fk6QUjHMrTgATgnSKHU4KRBy7OYgOHhNLs+7PilnlqKXB+OiIb91nwi5gfT
         bGHaR4cSw9nFKtOi9fbEuqHUQrUG9n6gOC6SnR19OAiN8FH6qReffoz/p1UgFC0DAW0Z
         Q6d4vl0gK3xMEU0+t9Hst138AR7M58qhy0LwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711136812; x=1711741612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgSSYjlN4+EDU0hEA5qrEbHHQ7GX2ErZACZlkqCEZ+A=;
        b=GJwtKnoLIVevkLqMj+8aofJNG9Leerm44wZF7NlPHodwOsYzxm1RyaK1bxaeLewRHL
         8M8d1uIXS5NAAcKpCgu2GadGrcY9ZWwaPvOElXW3ruhbmlI09zAViYsXfdbsZetfG2w1
         JWazWvgYvI2QU6t1GXP2MLtQKC9unk6Z+SuWCiU96VFbqa6inXQRg0pekfSfS8vgSvzB
         KedftN7RB6QRtZiGwvRyRFWUBndKwNJhErYBkuK9hjRGfBGCh50PYXrGUIY2izjp81BH
         3XdQqi0laYt4XCCpojcBiVRgbVzLjWJuodhcj1pbNDnmnT+yGdNcnEaJNtHQJwvdqzPt
         +8LA==
X-Forwarded-Encrypted: i=1; AJvYcCVfVPYWniBywiXqNlKgMNXPk1mJ48ohemojIvXGc5Yp+CcsClrhjse4xeCUtsny+AT8LynCZBuM0bRcdVKr3n3PxzTHgoxZSP2WyPIB1A==
X-Gm-Message-State: AOJu0YyB5/Di6vJs56+t1ceOoBP7kKILHK9vmz3q087lvC+2909R83q+
	rxy4PfmEONjH/6uvkp7cr2jr9s5NULUbvsTDxxY3cz5Dy/jsFIRUGzi0ivXxVtZxCOKcdPHJEvV
	1u03faZAXs/gDfqvsdEjez3N4Z9zkB1I+JDFH+w==
X-Google-Smtp-Source: AGHT+IG+hLVuzSz1xNzlyW3HKUHdwEY6Nk4mkZw/FiNiVTqnWPqumkuOIWEw3KgJCkSCJ8+TFRk6s8gjzxX68YelxYk=
X-Received: by 2002:a17:906:61a:b0:a46:5f04:134 with SMTP id
 s26-20020a170906061a00b00a465f040134mr512071ejb.70.1711136812445; Fri, 22 Mar
 2024 12:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com>
 <CAJfpegu8qTARQBftZSaiif0E6dbRcbBvZvW7dQf8sf_ymoogCA@mail.gmail.com> <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
In-Reply-To: <c58a8dc8-5346-4247-9a0a-8b1be286e779@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 22 Mar 2024 20:46:40 +0100
Message-ID: <CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in fuse_copy_do
To: David Hildenbrand <david@redhat.com>
Cc: xingwei lee <xrivendell7@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>, 
	Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 16:41, David Hildenbrand <david@redhat.com> wrote:

> But at least the vmsplice() just seems to work. Which is weird, because
> GUP-fast should not apply (page not faulted in?)

But it is faulted in, and that indeed seems to be the root cause.
Improved repro:

#define _GNU_SOURCE

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/syscall.h>

int main(void)
{
        int fd1, fd2;
        int pip[2];
        struct iovec iov;
        char *addr;
        int ret;

        fd1 = syscall(__NR_memfd_secret, 0);
        addr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd1, 0);
        ftruncate(fd1, 7);
        addr[0] = 1; /* fault in page */
        pipe(pip);
        iov.iov_base = addr;
        iov.iov_len = 0x50;
        ret = vmsplice(pip[1], &iov, 1, 0);
        if (ret == -1 && errno == EFAULT) {
                printf("Success\n");
                return 0;
        }

        fd2 = open("/tmp/repro-secretmem.test", O_RDWR | O_CREAT, 0x600);
        splice(pip[0], NULL, fd2, NULL, 0x50, 0);

        return 0;
}

