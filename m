Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B528F5A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbgJOPQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 11:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388086AbgJOPQQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602774974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V8hWGYgIvpxPZeV0khWMAperQupwbHKdzJCNracXQOs=;
        b=aSobyQfB349f37WARukQF1ak9kkOGd63TMKuMMrwR1lQ4L9LRzJ/c9Al6GMWj3sCNzy1x9
        K29+q+ou4UEpZSy/kAeUSGJSwa9e1+nR4DmBTe4HTQXgZcYlX47F+1pt0lfOCTOBCpLmdc
        jW9JFkZgWWLjP8oPmXt8QX/ury5WWvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-_V9ivtmpNju9G9P6E60dxQ-1; Thu, 15 Oct 2020 11:16:10 -0400
X-MC-Unique: _V9ivtmpNju9G9P6E60dxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DC2F1019626;
        Thu, 15 Oct 2020 15:16:08 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-118.rdu2.redhat.com [10.10.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64E6060C07;
        Thu, 15 Oct 2020 15:16:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D5270223B17; Thu, 15 Oct 2020 11:16:06 -0400 (EDT)
Date:   Thu, 15 Oct 2020 11:16:06 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <cai@lca.pw>, Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Possible deadlock in fuse write path (Was: Re: [PATCH 0/4] Some more
 lock_page work..)
Message-ID: <20201015151606.GA226448@redhat.com>
References: <CAHk-=wgkD+sVx3cHAAzhVO5orgksY=7i8q6mbzwBjN0+4XTAUw@mail.gmail.com>
 <4794a3fa3742a5e84fb0f934944204b55730829b.camel@lca.pw>
 <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9Eu-gNHzqgfvUAAiO=vJ+pWnzxkv+tX55xhGPFy+cOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 07:44:16PM -0700, Linus Torvalds wrote:
> On Wed, Oct 14, 2020 at 6:48 PM Qian Cai <cai@lca.pw> wrote:
> >
> > While on this topic, I just want to bring up a bug report that we are chasing an
> > issue that a process is stuck in the loop of wait_on_page_bit_common() for more
> > than 10 minutes before I gave up.
> 
> Judging by call trace, that looks like a deadlock rather than a missed wakeup.
> 
> The trace isn't reliable, but I find it suspicious that the call trace
> just before the fault contains that
> "iov_iter_copy_from_user_atomic()".
> 
> IOW, I think you're in fuse_fill_write_pages(), which has allocated
> the page, locked it, and then it takes a page fault.
> 
> And the page fault waits on a page that is locked.
> 
> This is a classic deadlock.
> 
> The *intent* is that iov_iter_copy_from_user_atomic() returns zero,
> and you retry without the page lock held.
> 
> HOWEVER.
> 
> That's not what fuse actually does. Fuse will do multiple pages, and
> it will unlock only the _last_ page. It keeps the other pages locked,
> and puts them in an array:
> 
>                 ap->pages[ap->num_pages] = page;
> 
> And after the iov_iter_copy_from_user_atomic() fails, it does that
> "unlock" and repeat.
> 
> But while the _last_ page was unlocked, the *previous* pages are still
> locked in that array. Deadlock.
> 
> I really don't think this has anything at all to do with page locking,
> and everything to do with fuse_fill_write_pages() having a deadlock if
> the source of data is a mmap of one of the pages it is trying to write
> to (just with an offset, so that it's not the last page).
> 
> See a similar code sequence in generic_perform_write(), but notice how
> that code only has *one* page that it locks, and never holds an array
> of pages around over that iov_iter_fault_in_readable() thing.

Indeed. This is a deadlock in fuse. Thanks for the analysis. I can now
trivially reproduce it with following program.

Thanks
Vivek

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/uio.h>

int main(int argc, char *argv[])
{
	int fd, ret;
	void *map_addr;
	size_t map_length = 2 * 4096;
	char *buf_out = "Hello World";
	struct iovec iov[2];

	if (argc != 2 ) {
		printf("Usage:%s <file-to-write> \n", argv[0]);
		exit(1);
	}

	fd = open(argv[1], O_RDWR | O_TRUNC);
	if (fd == -1) {
		fprintf(stderr, "Failed to open file %s:%s, errorno=%d\n", argv[1], strerror(errno), errno);
		exit(1);
	}

	map_addr = mmap(NULL, map_length, PROT_READ | PROT_WRITE, MAP_SHARED,
			fd, 0);
	if (map_addr == MAP_FAILED) {
		fprintf(stderr, "mmap failed %s, errorno=%d\n", strerror(errno),
			errno);
		exit(1);
	}

	/* Write first page and second page */
	pwrite(fd, buf_out, strlen(buf_out), 0);
	pwrite(fd, buf_out, strlen(buf_out), 4096);

	/* Copy from first page and then second page */
	iov[0].iov_base = map_addr;
	iov[0].iov_len = strlen(buf_out) + 1;

	iov[1].iov_base = map_addr + 4096;
	iov[1].iov_len = strlen(buf_out) + 1;

	/*
	 * Write second page offset (4K - 12), reading from first page and
	 * then second page. In first iteration we should fault in first
	 * page and lock second page. And in second iteration we should
	 * try fault in second page which is locked. Deadlock.
	 */
	ret = pwritev(fd, iov, 2, 4096 + 4096 - 12);
	printf("write() returned=%d\n", ret);
	munmap(map_addr, map_length);
	close(fd);
}

