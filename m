Return-Path: <linux-fsdevel+bounces-41492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C35EA2FFBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1F316431D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F193EA98;
	Tue, 11 Feb 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xew9GMqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6314F6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2025 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235289; cv=none; b=KIY1CXcKNAcHOXAr5f3l7maJIfgE7d7trYeUu3T+S/bd3tFTqGKM4sFGVUzoMWJB/eGLbV4xopiqVkmCuLwduUw8089dxpbWFEfLnWj/yA9rDE90EydK4DLx8BWxT4terLB420OYaNLMYtSML5Er+43krcQwHZtwFFhI21vxzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235289; c=relaxed/simple;
	bh=RZ8eFCh4V/SoIarOEinEaswqTqbkgU8QuFJ1FEXGQGA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Ekhj7geXqslKkajrLTHv/7KQjlk8+OREgHRh2CDIuJgUptQ6JTpLbmXWsjEiL6l6JaK5xStzACj8n1X6d7AiVh8TSG2RuD7lmznkAl8WBJG4kq6jeXB+InTkdodWFDUWmqtQ1gQKumBCJpMbDXasgz4RA77ehSXxcjDh6OpHGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xew9GMqb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739235275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MPriy2oqUpTiqI5i/JMHT2p0Ii9dY/LdlrCBRZmpjw=;
	b=xew9GMqbE8xgfZEKcOax9eSSQELiDijA9iX4/o7RWAzh2FD5urcg1Ckw0eT4oaE0/Vdy0Z
	thqkfNrnWUvFd7y15LAKQN8Ljb0LhHlRH4wHDEJ8A2uSh34mAwN60nWGZ/7A7CWvfXzEmJ
	q18pvZYn8j7/kOTrKU7g8tQDKcfDM1c=
Date: Tue, 11 Feb 2025 00:54:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <84a8e6737fca05dd3ec234760f1c77901d915ef9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] netfs: Add retry stat counters
To: "David Howells" <dhowells@redhat.com>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>, "Steve 
 French" <stfrench@microsoft.com>, "Eric Van Hensbergen"
 <ericvh@kernel.org>, "Latchesar  Ionkov" <lucho@ionkov.net>, "Dominique
 Martinet" <asmadeus@codewreck.org>, "Christian Schoenebeck"
 <linux_oss@crudebyte.com>, "Paulo Alcantara" <pc@manguebit.com>, "Jeff
 Layton" <jlayton@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, bpf@vger.kernel.org
In-Reply-To: <3210864.1739229537@warthog.procyon.org.uk>
References: <8d8a5d5b00688ea553b106db690e8a01f15b1410@linux.dev>
 <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
 <3173328.1738024385@warthog.procyon.org.uk>
 <3187377.1738056789@warthog.procyon.org.uk>
 <2986469.1739185956@warthog.procyon.org.uk>
 <3210864.1739229537@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On 2/10/25 3:18 PM, David Howells wrote:
> Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>
>> Done. I pushed the logs to the previously mentioned github branch:
>> https://github.com/kernel-patches/bpf/commit/699a3bb95e2291d877737438f=
b641628702fd18f
>
> Perfect, thanks.
>
> Looking at the last record of /proc/fs/netfs/requests, I see:
>
> 	REQUEST  OR REF FL ERR  OPS COVERAGE
> 	=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D =3D=3D=3D =3D=3D =3D=3D=3D=3D =3D=3D=
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	00000a98 RA   1 2001    0   0 @0000 2000/2000
>
> So the request of interest is R=3D00000a98 in the trace.  Grepping for =
that, I
> see (with a few columns cut out):
>
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 NEW         r=3D1
>  test_progs-no_a-97: netfs_read: R=3D00000a98 READAHEAD c=3D00000000 ni=
=3D2ec02f16 s=3D0 l=3D2000 sz=3D17a8
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET SUBREQ  r=3D2
>  test_progs-no_a-97: netfs_sreq: R=3D00000a98[1] DOWN TERM  f=3D192 s=
=3D0 17a8/17a8 s=3D1 e=3D0
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET WORK    r=3D3
>  test_progs-no_a-97: netfs_sreq_ref: R=3D00000a98[1] PUT TERM    r=3D1
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET SUBREQ  r=3D4
>  test_progs-no_a-97: netfs_sreq: R=3D00000a98[2] ZERO SUBMT f=3D00 s=3D=
17a8 0/858 s=3D0 e=3D0
>     kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D4
>     kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA COLLECT f=3D2021
>     kworker/u8:2-36: netfs_sreq: R=3D00000a98[1] DOWN DSCRD f=3D92 s=3D=
0 17a8/17a8 s=3D1 e=3D0
>     kworker/u8:2-36: netfs_sreq_ref: R=3D00000a98[1] PUT DONE    r=3D0
>     kworker/u8:2-36: netfs_sreq: R=3D00000a98[1] DOWN FREE  f=3D92 s=3D=
0 17a8/17a8 s=3D1 e=3D0
>     kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT SUBREQ  r=3D3
>     kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA COMPLET f=3D2021
>     kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA WAKE-IP f=3D2021
>     kworker/u8:2-36: netfs_rreq: R=3D00000a98 RA DONE    f=3D2001
>     kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D2
>  test_progs-no_a-97: netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=
=3D17a8 858/858 s=3D1 e=3D0
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 GET WORK    r=3D3
>  test_progs-no_a-97: netfs_sreq_ref: R=3D00000a98[2] PUT TERM    r=3D1
>  test_progs-no_a-97: netfs_rreq_ref: R=3D00000a98 PUT RETURN  r=3D2
>     kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D2
>     kworker/u8:2-36: netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D1
>
> You can see subrequest 1 completes fine, the subrequest is freed and th=
e ref
> it had on the request is put:
>
> 	netfs_sreq: R=3D00000a98[1] DOWN FREE  f=3D92 s=3D0 17a8/17a8 s=3D1 e=
=3D0
> 	netfs_rreq_ref: R=3D00000a98 PUT SUBREQ  r=3D3
>
> Subrequest 2, however isn't collected:
>
> 	netfs_sreq: R=3D00000a98[2] ZERO SUBMT f=3D00 s=3D17a8 0/858 s=3D0 e=
=3D0
> 	netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=3D17a8 858/858 s=3D1 =
e=3D0
> 	netfs_sreq_ref: R=3D00000a98[2] PUT TERM    r=3D1
>
> and the work happens again in kworker/u8:2-36 right at the end:
>
> 	netfs_rreq_ref: R=3D00000a98 SEE WORK    r=3D2
> 	netfs_rreq_ref: R=3D00000a98 PUT WORK    r=3D1
>
> but this doesn't do anything.
>
> The excess buffer clearance happened in the app thread (test_progs-no_a=
-97):
>
> 	netfs_sreq: R=3D00000a98[2] ZERO TERM  f=3D102 s=3D17a8 858/858 s=3D1 =
e=3D0
>
>> Let me know if I can help with anything else.
>
> Can you add some more tracepoints?
>
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect/enable
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect_sreq/enabl=
e
> echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_collect_state/enab=
le

See here: https://github.com/kernel-patches/bpf/commit/517f51d1f6c09ebab9=
df3e3d17bb669601ab14ef

Beware, uncompressed trace-cmd.log is 37Mb

>
> However, I think I may have spotted the issue: I'm mixing
> clear_and_wake_up_bit() for NETFS_RREQ_IN_PROGRESS (which will use a co=
mmon
> system waitqueue) with waiting on an rreq-specific waitqueue in such as
> netfs_wait_for_read().
>
> I'll work up a fix patch for that tomorrow.

Great! Thank you.

>
> Thanks,
> David
>

