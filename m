Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288292BBF7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 15:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKUONe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 09:13:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbgKUONe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 09:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605968012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=68yRiVfVVpt7TlJCZFKp5hXfldJHSbETOnNAn+/uyt4=;
        b=bfV1KcqDC95ZEmdA6P7NByxF53VLlDo9NlVbboj8x03NesRdaBLOId4+Gpar6Yy6gQtdaF
        H/twIlSuA4ieoQfpfzlqgei1dc4QDRaizPrIO8jebrE8AC9RuZJ8acU32peb1w4NA1HaUy
        T8k4jGO21N8v9GPo9n4146sstf5+0PM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-ULntg__0PTWeHllSKybCTQ-1; Sat, 21 Nov 2020 09:13:27 -0500
X-MC-Unique: ULntg__0PTWeHllSKybCTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC5F11DDE7;
        Sat, 21 Nov 2020 14:13:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57E946064B;
        Sat, 21 Nov 2020 14:13:22 +0000 (UTC)
Subject: [PATCH 00/29] RFC: iov_iter: Switch to using an ops table
From:   David Howells <dhowells@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 14:13:21 +0000
Message-ID: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Pavel, Willy, Jens, Al,

I had a go switching the iov_iter stuff away from using a type bitmask to
using an ops table to get rid of the if-if-if-if chains that are all over
the place.  After I pushed it, someone pointed me at Pavel's two patches.

I have another iterator class that I want to add - which would lengthen the
if-if-if-if chains.  A lot of the time, there's a conditional clause at the
beginning of a function that just jumps off to a type-specific handler or
to reject the operation for that type.  An ops table can just point to that
instead.

As far as I can tell, there's no difference in performance in most cases,
though doing AFS-based kernel compiles appears to take less time (down from
3m20 to 2m50), which might make sense as that uses iterators a lot - but
there are too many variables in that for that to be a good benchmark (I'm
dealing with a remote server, for a start).

Can someone recommend a good way to benchmark this properly?  The problem
is that the difference this makes relative to the amount of time taken to
actually do I/O is tiny.

I've tried TCP transfers using the following sink program:

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <fcntl.h>
	#include <unistd.h>
	#include <netinet/in.h>
	#define OSERROR(X, Y) do { if ((long)(X) == -1) { perror(Y); exit(1); } } while(0)
	static unsigned char buffer[512 * 1024] __attribute__((aligned(4096)));
	int main(int argc, char *argv[])
	{
		struct sockaddr_in sin = { .sin_family = AF_INET, .sin_port = htons(5555) };
		int sfd, afd;
		sfd = socket(AF_INET, SOCK_STREAM, 0);
		OSERROR(sfd, "socket");
		OSERROR(bind(sfd, (struct sockaddr *)&sin, sizeof(sin)), "bind");
		OSERROR(listen(sfd, 1), "listen");
		for (;;) {
			afd = accept(sfd, NULL, NULL);
			if (afd != -1) {
				while (read(afd, buffer, sizeof(buffer)) > 0) {}
				close(afd);
			}
		}
	}

and send program:

	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <fcntl.h>
	#include <unistd.h>
	#include <netdb.h>
	#include <netinet/in.h>
	#include <sys/stat.h>
	#include <sys/sendfile.h>
	#define OSERROR(X, Y) do { if ((long)(X) == -1) { perror(Y); exit(1); } } while(0)
	static unsigned char buffer[512*1024] __attribute__((aligned(4096)));
	int main(int argc, char *argv[])
	{
		struct sockaddr_in sin = { .sin_family = AF_INET, .sin_port = htons(5555) };
		struct hostent *h;
		ssize_t size, r, o;
		int cfd;
		if (argc != 3) {
			fprintf(stderr, "tcp-gen <server> <size>\n");
			exit(2);
		}
		size = strtoul(argv[2], NULL, 0);
		if (size <= 0) {
			fprintf(stderr, "Bad size\n");
			exit(2);
		}
		h = gethostbyname(argv[1]);
		if (!h) {
			fprintf(stderr, "%s: %s\n", argv[1], hstrerror(h_errno));
			exit(3);
		}
		if (!h->h_addr_list[0]) {
			fprintf(stderr, "%s: No addresses\n", argv[1]);
			exit(3);
		}
		memcpy(&sin.sin_addr, h->h_addr_list[0], h->h_length);
		cfd = socket(AF_INET, SOCK_STREAM, 0);
		OSERROR(cfd, "socket");
		OSERROR(connect(cfd, (struct sockaddr *)&sin, sizeof(sin)), "connect");
		do {
			r = size > sizeof(buffer) ? sizeof(buffer) : size;
			size -= r;
			o = 0;
			do {
				ssize_t w = write(cfd, buffer + o, r - o);
				OSERROR(w, "write");
				o += w;
			} while (o < r);
		} while (size > 0);
		OSERROR(close(cfd), "close/c");
		return 0;
	}

since the socket interface uses iterators.  It seems to show no difference.
One side note, though: I've been doing 10GiB same-machine transfers, and it
takes either ~2.5s or ~0.87s and rarely in between, with or without these
patches, alternating apparently randomly between the two times.

The patches can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-ops

David
---
David Howells (29):
      iov_iter: Switch to using a table of operations
      iov_iter: Split copy_page_to_iter()
      iov_iter: Split iov_iter_fault_in_readable
      iov_iter: Split the iterate_and_advance() macro
      iov_iter: Split copy_to_iter()
      iov_iter: Split copy_mc_to_iter()
      iov_iter: Split copy_from_iter()
      iov_iter: Split the iterate_all_kinds() macro
      iov_iter: Split copy_from_iter_full()
      iov_iter: Split copy_from_iter_nocache()
      iov_iter: Split copy_from_iter_flushcache()
      iov_iter: Split copy_from_iter_full_nocache()
      iov_iter: Split copy_page_from_iter()
      iov_iter: Split iov_iter_zero()
      iov_iter: Split copy_from_user_atomic()
      iov_iter: Split iov_iter_advance()
      iov_iter: Split iov_iter_revert()
      iov_iter: Split iov_iter_single_seg_count()
      iov_iter: Split iov_iter_alignment()
      iov_iter: Split iov_iter_gap_alignment()
      iov_iter: Split iov_iter_get_pages()
      iov_iter: Split iov_iter_get_pages_alloc()
      iov_iter: Split csum_and_copy_from_iter()
      iov_iter: Split csum_and_copy_from_iter_full()
      iov_iter: Split csum_and_copy_to_iter()
      iov_iter: Split iov_iter_npages()
      iov_iter: Split dup_iter()
      iov_iter: Split iov_iter_for_each_range()
      iov_iter: Remove iterate_all_kinds() and iterate_and_advance()


 lib/iov_iter.c | 1440 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 934 insertions(+), 506 deletions(-)


