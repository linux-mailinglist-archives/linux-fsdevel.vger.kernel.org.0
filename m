Return-Path: <linux-fsdevel+bounces-42858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FADA49C0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00071895455
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE15B26E158;
	Fri, 28 Feb 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtrrADsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6B1C331E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753096; cv=none; b=dqnCrxzCSsNczWvnfBYb+9Ww2zJDMidfm1Z6ndi8CGvfjmYuwzqkyweLJP3yj2fl7l0rWjjEOh2kFpp8qoDVPUiHX9DemsMw/+dEdSDOHLQsVZPYvY4AbNpMjqv/DplgWDUEiQTUQHVKNzrz8Zwv+NN+CuL2jPn9F6xhr9En1R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753096; c=relaxed/simple;
	bh=+/OUZI85hwg/k2cEtTz1GWdTVoAX/aYCdClr+Dfppbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hH9e9hEczkKP4JHcWe8fH5sGth3kxps8zfwdr+zS3Bq2k+tOzN29OfUUo1pPQSbJWq+q9hdggm3zFF7nSzm6CwJ7TrRY+rJIv6n5FWQUmNdoP5EPmdqBj6dme8C6DEVunSE3IPJUofcLqIv2u5BZMYBSbuDmm3pG+3ZelC2FDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtrrADsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740753093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N4P9XwbgzvwWISqRS8OTNHyqORHJErzBhWoB7f4E7V8=;
	b=PtrrADsR70s/VH4NJLRYpDxqmaVOwVwidMJXNEl1Z7vDQZHRb5V+y3k0dsjNrdx1r2sfKH
	M/NKNcGhCHulBDoWZYCKLbsatmNnICRD26m4gV7Z7t2iH6zgwCpmVBq8+f5u7i7sNLP9M6
	b9u/FVaoLBfDMJhOpsz2A3GDnWKfkcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-owaju6uZNceD0Fni1ZR7Cw-1; Fri,
 28 Feb 2025 09:31:31 -0500
X-MC-Unique: owaju6uZNceD0Fni1ZR7Cw-1
X-Mimecast-MFC-AGG-ID: owaju6uZNceD0Fni1ZR7Cw_1740753087
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5665F180087A;
	Fri, 28 Feb 2025 14:31:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.184])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AB5B819560AB;
	Fri, 28 Feb 2025 14:31:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 28 Feb 2025 15:30:56 +0100 (CET)
Date: Fri, 28 Feb 2025 15:30:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	Neeraj.Upadhyay@amd.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250228143049.GA17761@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <e813814e-7094-4673-bc69-731af065a0eb@amd.com>
 <20250224142329.GA19016@redhat.com>
 <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com>
 <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 02/28, Sapkal, Swapnil wrote:
>
> Yes, I was able to reproduce the problem with the below patch.
...
> I found a case in the dump where the pipe is empty still both reader and
> writer are waiting on it.
>
> [ 1397.829761] E=1 F=0; W=1719147 R=1719147
> [ 1397.837843] RD=1 WR=1

Thanks! and I see no more "WR=1" in the full dump.

This means that all live writes hang on the same pipe.

So maybe the trivial program below can too reproduce the problem on your machine??

Say, with GROUPS=16 and WRITERS=20 ... or maybe even with GROUPS=1 and WRITERS=320 ...

Oleg.

-------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <pthread.h>

static int GROUPS, WRITERS;
static volatile int ALIVE[1024];

void *group(void *arg)
{
	int fd[2], n, id = (long)arg;
	char buf[100];

	assert(pipe(fd) == 0);

	for (n = 0; n < WRITERS; ++n) {
		int pid = fork();
		assert(pid >= 0);
		if (pid)
			continue;

		close(fd[0]);
		for (;;)
			assert(write(fd[1], buf, sizeof(buf)) == sizeof(buf));
	}

	for (;;) {
		assert(read(fd[0], buf, sizeof(buf)) == sizeof(buf));
		ALIVE[id] = 1;
	}
}

int main(int argc, const char *argv[])
{
	pthread_t pt;
	int n;

	assert(argc == 3);
	GROUPS = atoi(argv[1]);
	WRITERS = atoi(argv[2]);
	assert(GROUPS <= 1024);

	for (n = 0; n < GROUPS; ++n)
		assert(pthread_create(&pt, NULL, group, (void*)(long)n) == 0);

	for (;;) {
		sleep(1);

		for (n = 0; n < GROUPS; ++n) {
			if (ALIVE[n] == 0)
				printf("!!! thread %d stuck?\n", n);
			ALIVE[n] = 0;
		}
	}
}


