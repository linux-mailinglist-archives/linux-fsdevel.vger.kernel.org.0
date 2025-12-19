Return-Path: <linux-fsdevel+bounces-71711-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E5CCE6B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 05:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD765305847F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E87275B15;
	Fri, 19 Dec 2025 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="AbvvuX8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EA1F94A;
	Fri, 19 Dec 2025 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766117391; cv=none; b=csq6iEbSAN7DNuKmjZKev+5nKhxDCUeeNc9rNVnAf+56XwD6XkcVzhmxr2icLP+U2AYuTaiDW1uyRlZxclCT1otAObD5G7TPNdwg2tKF9tznQNbwIsYtFeQX2Z2hK6UYEjRq+jsEkqxjtA+RCj67PecGSUjRFLso+4ridlc9STo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766117391; c=relaxed/simple;
	bh=Wi+GDgLQdfomzyXSkmStofi1HG8wgq+mtbSOw7S7prM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRQk92+YzA9WKZjoaZlAqHPxC9N6LuSHPIrsVOXpc6iJ/UC/jjmavQs6jjeUFwpvUpyZeVQMROxXnyIICD4laZktiUYtRQr0neicfFpZfA8SUA6ctn1KYWgFHSzXtTUXYQ/Pw1Kuuy7X2Prd9vQTUXU7ZgnlpdjwasdRp8EKZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=AbvvuX8y; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9806E14C2D6;
	Fri, 19 Dec 2025 05:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766117386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1+j68WVGSoDLdkBbwAPrMbtBRRlrN8f73RzPERtgEs=;
	b=AbvvuX8yyxNioHvl8g5wM0NtG1QfmrLGGkSuyeknMXSDpz3qSvcZk3RrUeJxgzWW80rhCJ
	dRpwb4Z8f44zvD9jQxmc5QxL/P8ptlhBrQMxXpEcU22JbLK5jpbfoV3mNEvZRIQLtqNZ3v
	6h0forviUwPbWi88lJkLTAAAKkTdT2u4qL0GtQCivDeIox4mIFwGKoi97E+oixPAIInhwx
	2aqsk2gv1MI91OyT8D610CYVuQWRkzEYzq/m6D8t2iSwwu0r5vP7zJVyknL9j9LK89HnNt
	lgEU7hVqN1lAKQluc0Qjzmb75XK9eljmMq+ZxRoNxkN1YGXSwGn0uFoIjPhOiQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 0fb38c94;
	Fri, 19 Dec 2025 04:09:41 +0000 (UTC)
Date: Fri, 19 Dec 2025 13:09:26 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: 9p read corruption of mmaped content (Was: [PATCH] 9p/virtio:
 restrict page pinning to user_backed_iter() iovec)
Message-ID: <aUTP9oCJ9RkIYtKQ@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aUMlUDBnBs8Bdqg0@codewreck.org>
 <aUQN96w9qi9FAxag@codewreck.org>
 <8622834.T7Z3S40VBb@weasel>
 <aUSK8vrhPLAGdQlv@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUSK8vrhPLAGdQlv@codewreck.org>

David, would be great if you can find a minute to look at the netfs
trace below.

asmadeus@codewreck.org wrote on Fri, Dec 19, 2025 at 08:14:58AM +0900:
> Christian Schoenebeck wrote on Thu, Dec 18, 2025 at 04:14:45PM +0100:
> > > Won't be the first time I can't reproduce, but what kind of workload are
> > > you testing?
> > > Anything that might help me try to reproduce (like VM cpu count/memory)
> > > will be appreciated, corruptions are Bad...
> > 
> > Debian Trixie guest running as 9p rootfs in QEMU, 4 cores, 16 GB.
> > 
> > Compiling a bunch of projects with GCC works fine without errors, but with 
> > clang it's very simple for me to reproduce. E.g. just a very short C++ file 
> > that pulls in some system headers:
> > 
> > #include <utility>
> > #include <sys/cdefs.h>
> > #include <limits>
> > 
> > Then running 3 times: clang++ -c foo.cpp -std=c++17
> > 
> > The first 2 clang runs succeed, the 3rd clang run then always blows up for 
> > anything else than cache=none, various spurious clang errors on those system 
> > headers like
> 
> Thanks, I can't reproduce with this example, but building linux with
> `make LLVM=1` does blow up on debian... even with cache=none actually?

Sorry that must have been because I still had cache=loose on the system
mount, even if the linux repo was mounted with cache=none; I agree this
doesn't happen with none (which agrees with the following, because mmap
wouldn't be allowed in the first place...)

> I couldn't reproduce running the same rootfs directory in a container so
> I don't think I corrupted my image, it appears to be reading junk? short
> reads perhaps?...
> (Interestingly, it doesn't seem to blow up on an alpine rootfs, I wonder
> what's different...)
> 
> I'm now getting late for work but at least there's something I can
> reproduce, I'll have a closer look ASAP, thank you.

Curiosity won over work.. So I straced a failing clang command, and it
seems to always fail on a file that's been mmap'd:

120129 openat(AT_FDCWD, "./include/linux/vmstat.h", O_RDONLY|O_CLOEXEC) = 3
120129 readlink("/proc/self/fd/3", "/mnt/linux/include/linux/vmstat.h", 4096) = 33
120129 fstat(3, {st_mode=S_IFREG|0644, st_size=16755, ...}) = 0
120129 mmap(NULL, 16755, PROT_READ, MAP_PRIVATE|MAP_NORESERVE, 3, 0) = 0x7f697182e000
120129 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
120129 close(3)                         = 0
120129 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
120129 openat(AT_FDCWD, "./include/linux/vm_event_item.h", O_RDONLY|O_CLOEXEC) = 3
120129 readlink("/proc/self/fd/3", "/mnt/linux/include/linux/vm_event_item.h", 4096) = 40
120129 fstat(3, {st_mode=S_IFREG|0644, st_size=4526, ...}) = 0
120129 pread64(3, "/* SP...", 4526, 0) = 4526
120129 rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
120129 close(3)                         = 0
120129 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
120129 brk(0x55665820c000)              = 0x55665820c000
120129 brk(0x55665822d000)              = 0x55665822d000
120129 brk(0x55665824e000)              = 0x55665824e000
120129 write(2, "In file included from ", 22) = 22
./include/linux/vmstat.h:616:1: error: unknown type name 'ons'

(fun fact: the error line seems to always be file's total number of
lines + 1 line.. but I assume that's just luck at this point)


Unfortunately that's as far as I got anything clear...
- I tried a couple of variants around doing mmap() close() and accessing
data but couldn't create a simpler reproducer
- I took a dump of dmesg (with debug=65535) and tracepoints (netfs, 9p),
and it looks like the mmaped file IO is mostly correct? -- a TREAD is
issued with the correct size, I'm seeing the data is collected... and..
what is that ZERO SUBMT with the same size? Could it be related?
David, could you please have a look?

This was a different occurence from the strace above, that time was the
0x5fb2 read (24498 bytes) -- I think I got everything related to it here:
----
           clang-318     [002] .....  3031.183402: netfs_rreq_ref: R=00001b55 NEW         r=2
           clang-318     [002] .....  3031.183402: netfs_read: R=00001b55 READAHEAD c=00000000 ni=157f3 s=0 l=6000 sz=5f
b2
           clang-318     [002] .....  3031.183403: netfs_folioq: R=00001b55 fq=1edf roll-init
           clang-318     [002] .....  3031.183403: netfs_rreq_ref: R=00001b55 GET SUBREQ  r=3
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00000-00000 read
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00001-00001 read
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00002-00002 read
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00003-00003 read
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00004-00004 read
           clang-318     [002] .....  3031.183404: netfs_folio: i=157f3 ix=00005-00005 read
           clang-318     [002] .....  3031.183408: 9p_protocol_dump: clnt 18446612686390831168 P9_TREAD(tag = 0)
17 00 00 00 74 00 00 14 00 00 00 00 00 00 00 00 00 00 00 b2 5f 00 00 00 00 00 00 00 a4 81 00 00

           clang-318     [002] .....  3031.183408: 9p_client_req: client 18446612686390831168 request P9_TREAD tag  0
           clang-318     [002] .....  3031.183445: 9p_protocol_dump: clnt 18446612686390831168 P9_RREAD(tag = 0)
bd 5f 00 00 75 00 00 b2 5f 00 00 ff 3f 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 a4 81 00 00

           clang-318     [002] .....  3031.183450: 9p_client_res: client 18446612686390831168 response P9_TREAD tag  0 err 0
           clang-318     [002] .....  3031.183452: netfs_sreq: R=00001b55[1] DOWN TERM  f=192 s=0 5fb2/5fb2 s=5 e=0
           clang-318     [002] .N...  3031.183454: netfs_sreq_ref: R=00001b55[1] PUT TERM    r=1
   kworker/u16:2-233     [002] .....  3031.183455: netfs_rreq_ref: R=00001b55 SEE WORK    r=3
   kworker/u16:2-233     [002] .....  3031.183455: netfs_rreq: R=00001b55 RA COLLECT f=101
   kworker/u16:2-233     [002] .....  3031.183455: netfs_collect: R=00001b55 s=0-6000
   kworker/u16:2-233     [002] .....  3031.183455: netfs_collect_sreq: R=00001b55[0:01] s=0 t=5fb2/5fb2
   kworker/u16:2-233     [002] .....  3031.183455: netfs_collect_folio: R=00001b55 ix=00000 r=0-1000 t=0/5fb2
   kworker/u16:2-233     [002] .....  3031.183456: netfs_folio: i=157f3 ix=00000-00000 read-done
   kworker/u16:2-233     [002] .....  3031.183456: netfs_folio: i=157f3 ix=00000-00000 read-unlock
   kworker/u16:2-233     [002] .....  3031.183456: netfs_collect_folio: R=00001b55 ix=00001 r=1000-2000 t=1000/5fb2
   kworker/u16:2-233     [002] .....  3031.183456: netfs_folio: i=157f3 ix=00001-00001 read-done
   kworker/u16:2-233     [002] .....  3031.183457: netfs_folio: i=157f3 ix=00001-00001 read-unlock
   kworker/u16:2-233     [002] .....  3031.183457: netfs_collect_folio: R=00001b55 ix=00002 r=2000-3000 t=2000/5fb2
   kworker/u16:2-233     [002] .....  3031.183457: netfs_folio: i=157f3 ix=00002-00002 read-done
   kworker/u16:2-233     [002] .....  3031.183457: netfs_folio: i=157f3 ix=00002-00002 read-unlock
   kworker/u16:2-233     [002] .....  3031.183457: netfs_collect_folio: R=00001b55 ix=00003 r=3000-4000 t=3000/5fb2
   kworker/u16:2-233     [002] .....  3031.183458: netfs_folio: i=157f3 ix=00003-00003 read-done
   kworker/u16:2-233     [002] .....  3031.183458: netfs_folio: i=157f3 ix=00003-00003 read-unlock
   kworker/u16:2-233     [002] .....  3031.183458: netfs_collect_folio: R=00001b55 ix=00004 r=4000-5000 t=4000/5fb2
   kworker/u16:2-233     [002] .....  3031.183458: netfs_folio: i=157f3 ix=00004-00004 read-done
   kworker/u16:2-233     [002] .....  3031.183458: netfs_folio: i=157f3 ix=00004-00004 read-unlock
   kworker/u16:2-233     [002] .....  3031.183459: netfs_collect_folio: R=00001b55 ix=00005 r=5000-5fb2 t=5000/5fb2
   kworker/u16:2-233     [002] .....  3031.183459: netfs_folio: i=157f3 ix=00005-00005 read-done
   kworker/u16:2-233     [002] .....  3031.183459: netfs_folio: i=157f3 ix=00005-00005 read-unlock
   kworker/u16:2-233     [002] .....  3031.183459: netfs_sreq: R=00001b55[1] DOWN CONSM f=092 s=0 5fb2/5fb2 s=5 e=0
   kworker/u16:2-233     [002] .....  3031.183460: netfs_sreq_ref: R=00001b55[1] PUT DONE    r=0
   kworker/u16:2-233     [002] .....  3031.183460: netfs_sreq: R=00001b55[1] DOWN FREE  f=092 s=0 5fb2/5fb2 s=5 e=0
   kworker/u16:2-233     [002] .....  3031.183460: netfs_rreq_ref: R=00001b55 PUT SUBREQ  r=2
   kworker/u16:2-233     [002] .....  3031.183460: netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
   kworker/u16:2-233     [002] .....  3031.183460: netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=c
   kworker/u16:2-233     [002] .....  3031.183460: netfs_collect_stream: R=00001b55[0:] cto=5fb2 frn=ffffffff
   kworker/u16:2-233     [002] .....  3031.183460: netfs_collect_state: R=00001b55 col=5fb2 cln=6000 n=8
   kworker/u16:2-233     [002] .....  3031.183460: netfs_rreq_ref: R=00001b55 SEE WORK CP r=2
           clang-318     [002] .....  3031.183462: netfs_rreq_ref: R=00001b55 GET SUBREQ  r=3
           clang-318     [002] .....  3031.183462: netfs_sreq: R=00001b55[2] ZERO SUBMT f=000 s=5fb2 0/4e s=0 e=0
           clang-318     [002] .....  3031.183462: netfs_sreq: R=00001b55[2] ZERO TERM  f=102 s=5fb2 4e/4e s=5 e=0
           clang-318     [002] .....  3031.183463: netfs_sreq_ref: R=00001b55[2] PUT TERM    r=1
           clang-318     [002] .....  3031.183463: netfs_rreq_ref: R=00001b55 PUT RETURN  r=2
   kworker/u16:2-233     [002] .....  3031.183476: netfs_rreq_ref: R=00001b55 SEE WORK    r=2
   kworker/u16:2-233     [002] .....  3031.183476: netfs_rreq: R=00001b55 RA COLLECT f=103
   kworker/u16:2-233     [002] .....  3031.183476: netfs_collect: R=00001b55 s=0-6000
   kworker/u16:2-233     [002] .....  3031.183476: netfs_collect_sreq: R=00001b55[0:02] s=5fb2 t=4e/4e
   kworker/u16:2-233     [002] .....  3031.183476: netfs_sreq: R=00001b55[2] ZERO CONSM f=002 s=5fb2 4e/4e s=5 e=0
   kworker/u16:2-233     [002] .....  3031.183477: netfs_sreq_ref: R=00001b55[2] PUT DONE    r=0
   kworker/u16:2-233     [002] .....  3031.183477: netfs_sreq: R=00001b55[2] ZERO FREE  f=002 s=5fb2 4e/4e s=5 e=0
   kworker/u16:2-233     [002] .....  3031.183478: netfs_rreq_ref: R=00001b55 PUT SUBREQ  r=1
   kworker/u16:2-233     [002] .....  3031.183478: netfs_collect_stream: R=00001b55[0:] cto=6000 frn=ffffffff
   kworker/u16:2-233     [002] .....  3031.183478: netfs_collect_state: R=00001b55 col=6000 cln=6000 n=c
   kworker/u16:2-233     [002] .....  3031.183478: netfs_collect_stream: R=00001b55[0:] cto=6000 frn=ffffffff
   kworker/u16:2-233     [002] .....  3031.183479: netfs_collect_state: R=00001b55 col=6000 cln=6000 n=8
   kworker/u16:2-233     [002] .....  3031.183479: netfs_rreq: R=00001b55 RA COMPLET f=103
   kworker/u16:2-233     [002] .....  3031.183479: netfs_rreq: R=00001b55 RA WAKE-IP f=102
   kworker/u16:2-233     [002] .....  3031.183479: netfs_rreq: R=00001b55 RA DONE    f=102
   kworker/u16:2-233     [002] .....  3031.183479: netfs_rreq_ref: R=00001b55 PUT WORK IP  r=0
   kworker/u16:2-233     [002] .....  3031.183482: netfs_rreq: R=00001b55 RA FREE    f=102
   kworker/u16:2-233     [002] .....  3031.183482: 9p_fid_ref: put     fid 20, refcount 2
   kworker/u16:2-233     [002] .....  3031.183482: netfs_folioq: R=00001b55 fq=1edf clear
----

If you know how I could also track the page fault from clang I'll be
happy to try to grab that too

Thanks,
-- 
Dominique

