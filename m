Return-Path: <linux-fsdevel+bounces-67632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89155C45023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 06:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2191718883BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076132E8B8A;
	Mon, 10 Nov 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ohpy9K+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DB2E8B76
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752475; cv=none; b=c9hDj99uZxZq24GLQaQLwc5H2fU70+IC6HgjVLfooyUI5tqRbzPPFbONn1KeNUfJWASD1BsI6Q2+3Kb8OU7l5ihwzAeZIQrDpgolJtcicJlaCE5ApAP1DnSk1QbNj4BWhpsr9Q4Yys7WmyLTDJ7Y+S6afhQq0rF/VlIwZoEiboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752475; c=relaxed/simple;
	bh=LuInKEPEl2ys46XxoeOB3tKtYVOsRfSS1QKkpuJK1uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pj/+1RPmbtWfMiEiUn/VENoFGkZf0NQc1Dq337pa3C1pedngSOrtV38cuTStc9n2s0vXllKN7kpLABap1okle+KDCPfwfLmjhnWmW6t926GJ1oHPf5DlIndeC4NZENF9qb6mnCKOsDmRFJ3jVoRC5G2bBfNPzgX1Wzqo68+PuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ohpy9K+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762752472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NUawKOblVKphUWRlTO8Axse3jvatM5IY8Z8XqqfUKbE=;
	b=Ohpy9K+VvxujhP3l1BFHMJ74Sj1G/FWAQUevQhZnwp42dkoT6+H5+UPsztLFnvZGpQdOe6
	a+LrYYmAM/JdKI/zK1WsigvmdWPwvZz6Q33Z57MhgcVtP8ACHxyHNWw675sOL4LfL2BXZ9
	ARn1vqz8cMg7O5fsGBp/oYGNDJphrH0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-a3WWnvxJOaa2UrzdpP0oWg-1; Mon,
 10 Nov 2025 00:27:50 -0500
X-MC-Unique: a3WWnvxJOaa2UrzdpP0oWg-1
X-Mimecast-MFC-AGG-ID: a3WWnvxJOaa2UrzdpP0oWg_1762752468
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D21C1195608F;
	Mon, 10 Nov 2025 05:27:47 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE4E319560B0;
	Mon, 10 Nov 2025 05:27:43 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>,  Matthew Wilcox <willy@infradead.org>,
  Hans Holmberg <hans.holmberg@wdc.com>,  linux-xfs@vger.kernel.org,
  Carlos Maiolino <cem@kernel.org>,  "Darrick J . Wong"
 <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <aRESlvWf9VquNzx3@dread.disaster.area> (Dave Chinner's message of
	"Mon, 10 Nov 2025 09:15:50 +1100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<aRESlvWf9VquNzx3@dread.disaster.area>
Date: Mon, 10 Nov 2025 06:27:41 +0100
Message-ID: <lhuseem1mpe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Dave Chinner:

> On Sat, Nov 08, 2025 at 01:30:18PM +0100, Florian Weimer wrote:
>> * Christoph Hellwig:
>> 
>> > On Thu, Nov 06, 2025 at 05:31:28PM +0100, Florian Weimer wrote:
>> >> It's been a few years, I think, and maybe we should drop the allocation
>> >> logic from posix_fallocate in glibc?  Assuming that it's implemented
>> >> everywhere it makes sense?
>> >
>> > I really think it should go away.  If it turns out we find cases where
>> > it was useful we can try to implement a zeroing fallocate in the kernel
>> > for the file system where people want it.
>
> This is what the shiny new FALLOC_FL_WRITE_ZEROS command is supposed
> to provide. We don't have widepsread support in filesystems for it
> yet, though.
>
>> > gfs2 for example currently
>> > has such an implementation, and we could have somewhat generic library
>> > version of it.
>
> Yup, seems like a iomap iter loop would be pretty trivial to
> abstract from that...
>
>> Sorry, I remember now where this got stuck the last time.
>> 
>> This program:
>> 
>> #include <fcntl.h>
>> #include <stddef.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <sys/mman.h>
>> 
>> int
>> main(void)
>> {
>>   FILE *fp = tmpfile();
>>   if (fp == NULL)
>>     abort();
>>   int fd = fileno(fp);
>>   posix_fallocate(fd, 0, 1);
>>   char *p = mmap(NULL, 1, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>   *p = 1;
>> }
>> 
>> should not crash even if the file system does not support fallocate.
>
> I think that's buggy application code.
>
> Failing to check the return value of a library call that documents
> EOPNOTSUPP as a valid error is a bug. IOWs, the above code *should*
> SIGBUS on the mmap access, because it failed to verify that the file
> extension operation actually worked.

Sorry, I made the example confusing.

How would the application deal with failure due to lack of fallocate
support?  It would have to do a pwrite, like posix_fallocate does to
today, or maybe ftruncate.  This is way I think removing the fallback
from posix_fallocate completely is mostly pointless.

>> I hope we can agree on that.  I expect avoiding SIGBUS errors because
>> of insufficient file size is a common use case for posix_fallocate.
>> This use is not really an optimization, it's required to get mmap
>> working properly.
>> 
>> If we can get an fallocate mode that we can use as a fallback to
>> increase the file size with a zero flag argument, we can definitely
>
> The fallocate() API already support that, in two different ways:
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_WRITE_ZEROS.

Neither is appropriate for posix_fallocate because they are as
destructive as the existing fallback.

> But, again, not all filesystems support these, so userspace has to
> be prepared to receive -EOPNOTSUPP from these calls. Hence userspace
> has to do the right thing for posix_fallocate() if you want to
> ensure that it always extend the file size even when fallocate()
> calls fail...

Sure, but eventually, we may get into a better situation.

>> use that in posix_fallocate (replacing the fallback path on kernels
>> that support it).  All local file systems should be able to implement
>> that (but perhaps not efficiently).  Basically, what we need here is a
>> non-destructive ftruncate.
>
> You aren't going to get support for such new commands on existing
> kernels, so userspace is still going to have to code the ftruncate()
> fallback itself for the desired behaviour to be provided
> consistently to applications.
>
> As such, I don't see any reason for the fallocate() syscall
> providing some whacky "ftruncate() in all but name" mode.

Please reconsider.  If we start fixing this, we'll eventually be in a
position where the glibc fallback code never runs.

Thanks,
Florian


