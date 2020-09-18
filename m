Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8126FC6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIRMZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 08:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgIRMZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600431953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0fKfZIIzGiatJHAcexj7+1Kf9KYS0KSYRXI+7NGJPas=;
        b=L0NMEwbE5qOxU4aI+flcWfw2zZKJFthFSkrx1vBfiatIfWEQNxdgz3m+YQj+LysLGdoYJd
        GKEZejoxyXG+m8vgM+npbRW0jS3Pb2gOrPDtW6wtt52K/ZEeAYpqROoTiyee2FY8pEKtt1
        nipe1ooQwFn5RhMaIcCZ4tUkSkoCHpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-K_BGBupBP_WSZIuNASCbwQ-1; Fri, 18 Sep 2020 08:25:44 -0400
X-MC-Unique: K_BGBupBP_WSZIuNASCbwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD6128B8C31;
        Fri, 18 Sep 2020 12:25:31 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D428183597;
        Fri, 18 Sep 2020 12:25:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 08ICPUcX006150;
        Fri, 18 Sep 2020 08:25:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 08ICPS9s006146;
        Fri, 18 Sep 2020 08:25:28 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 18 Sep 2020 08:25:28 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: the "read" syscall sees partial effects of the "write" syscall
In-Reply-To: <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2009180509370.19302@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com> <alpine.LRH.2.02.2009151216050.16057@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009151332280.3851@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com> <alpine.LRH.2.02.2009161451140.21915@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gFz6vBVVp_aiX4i2rL+8fps3gTQGj5cYw8QESCf7=DfQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

I'd like to ask about this problem: when we write to a file, the kernel 
takes the write inode lock. When we read from a file, no lock is taken - 
thus the read syscall can read data that are halfway modified by the write 
syscall.

The standard specifies the effects of the write syscall are atomic - see 
this:
https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07

> 2.9.7 Thread Interactions with Regular File Operations
> 
> All of the following functions shall be atomic with respect to each 
> other in the effects specified in POSIX.1-2017 when they operate on 
> regular files or symbolic links:
> 
> chmod()    fchownat()  lseek()      readv()     unlink()
> chown()    fcntl()     lstat()      pwrite()    unlinkat()
> close()    fstat()     open()       rename()    utime()
> creat()    fstatat()   openat()     renameat()  utimensat()
> dup2()     ftruncate() pread()      stat()      utimes()
> fchmod()   lchown()    read()       symlink()   write()
> fchmodat() link()      readlink()   symlinkat() writev()
> fchown()   linkat()    readlinkat() truncate()
> 
> If two threads each call one of these functions, each call shall either 
> see all of the specified effects of the other call, or none of them. The 
> requirement on the close() function shall also apply whenever a file 
> descriptor is successfully closed, however caused (for example, as a 
> consequence of calling close(), calling dup2(), or of process 
> termination).

Should the read call take the read inode lock to make it atomic w.r.t. the 
write syscall? (I know - taking the read lock causes big performance hit 
due to cache line bouncing)

I've created this program to test it - it has two threads, one writing and 
the other reading and verifying. When I run it on OpenBSD or FreeBSD, it 
passes, on Linux it fails with "we read modified bytes".

Mikulas



#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <pthread.h>

#define L	65536

static int h;
static pthread_barrier_t barrier;
static pthread_t thr;

static char rpattern[L];
static char wpattern[L];

static void *reader(__attribute__((unused)) void *ptr)
{
	while (1) {
		int r;
		size_t i;
		r = pthread_barrier_wait(&barrier);
		if (r > 0) fprintf(stderr, "pthread_barrier_wait: %s\n", strerror(r)), exit(1);
		r = pread(h, rpattern, L, 0);
		if (r != L) perror("pread"), exit(1);
		for (i = 0; i < L; i++) {
			if (rpattern[i] != rpattern[0])
				fprintf(stderr, "we read modified bytes\n"), exit(1);
		}
	}
	return NULL;
}

int main(__attribute__((unused)) int argc, char *argv[])
{
	int r;
	h = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, 0644);
	if (h < 0) perror("open"), exit(1);
	r = pwrite(h, wpattern, L, 0);
	if (r != L) perror("pwrite"), exit(1);
	r = pthread_barrier_init(&barrier, NULL, 2);
	if (r) fprintf(stderr, "pthread_barrier_init: %s\n", strerror(r)), exit(1);
	r = pthread_create(&thr, NULL, reader, NULL);
	if (r) fprintf(stderr, "pthread_create: %s\n", strerror(r)), exit(1);
	while (1) {
		size_t i;
		for (i = 0; i < L; i++)
			wpattern[i]++;
		r = pthread_barrier_wait(&barrier);
		if (r > 0) fprintf(stderr, "pthread_barrier_wait: %s\n", strerror(r)), exit(1);
		r = pwrite(h, wpattern, L, 0);
		if (r != L) perror("pwrite"), exit(1);
	}
}

