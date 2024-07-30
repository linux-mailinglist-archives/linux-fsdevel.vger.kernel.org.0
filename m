Return-Path: <linux-fsdevel+bounces-24626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9C941C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D832824B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9B189537;
	Tue, 30 Jul 2024 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfHnAzJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0C1A6192
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359059; cv=none; b=YKmfhrh8Y7BGNI3H36cGZUpDv2is6BvpqKVPsnFCCP3IabeFEXfOvKNseDacEDy+nGCONkemPyyqbi1NWx7I73wdJIeabiP9AhmPd6YpKUPySlTg9RSBV8T9+OKaU+E7STkdfAFL2EbMtnDC0Ue9vX+lfOuJoXj/vUsdJMzvR6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359059; c=relaxed/simple;
	bh=d2s53vr9d9WumetRi7ElU1LScF+8hO1ZsDdGdQyeyeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5ZCdx5JCKnyh5gSxu+MjFCAG7DajNcH1TvBOBSWBmQQny1H0vhXss9/IGSEsPVa7HOYn6mKYIBSr68Ai+sSeC1NP0GVvVUqd1bu13evOe8Wprk721bxz4SQ9p6c1GMzcHXSheqG0DHI6t3w+3TcOuYAgmAc5gGyi7wob8lX3pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfHnAzJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722359056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CbZPTgEfnxvJQRY0OI7cIGcoviZzOgV/sQ4M+bCXjTo=;
	b=bfHnAzJ2ovejulNYIU5OavyRU9pPHsS1ErBEdgYe3gcJ8ZB3duVkX7ArAW14aFYH1uo3sC
	VIqUCoDLSQHxgW1ow+0kOYS9aQUSuGW7oSn2MUUkEL+PuU7VEE0Ya1vnUG+YJCxAbGo+gl
	173ukHQqVimJYbqB3mXBp25VxjUHnUI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-FPgYcWPVOqCtMbpnYdz1kg-1; Tue,
 30 Jul 2024 13:03:57 -0400
X-MC-Unique: FPgYcWPVOqCtMbpnYdz1kg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 498811955D4A;
	Tue, 30 Jul 2024 17:03:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35C381955D42;
	Tue, 30 Jul 2024 17:03:53 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Eggert <eggert@cs.ucla.edu>,  libc-alpha@sourceware.org,
  linux-fsdevel@vger.kernel.org,  Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240730162042.GA31109@lst.de> (Christoph Hellwig's message of
	"Tue, 30 Jul 2024 18:20:42 +0200")
References: <20240729160951.GA30183@lst.de>
	<87a5i0krml.fsf@oldenburg.str.redhat.com>
	<20240729184430.GA1010@lst.de>
	<877cd4jajz.fsf@oldenburg.str.redhat.com>
	<20240729190100.GA1664@lst.de>
	<8734nsj93p.fsf@oldenburg.str.redhat.com>
	<20240730154730.GA30157@lst.de>
	<e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
	<20240730162042.GA31109@lst.de>
Date: Tue, 30 Jul 2024 19:03:50 +0200
Message-ID: <87o76ezua1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

* Christoph Hellwig:

> On Tue, Jul 30, 2024 at 09:11:17AM -0700, Paul Eggert wrote:
>> It would help glibc distinguish the following cases:
>>
>> A. file systems whose internal structure supports the semantics of 
>> posix_fallocate, and where user-mode code can approximate those semantics 
>> by writing zeros, but where that feature has not been implemented in the 
>> kernel's file system code so the system call currently fails with 
>> EOPNOTSUPP.
>>
>> B. file systems whose internal structure cannot support the semantics of 
>> posix_fallocate and you cannot approximate them, and where the system call 
>> currently fails with EOPNOTSUPP.
>
> As mentioned earlier in the thread case a) are basically legacy / foreign
> OS compatibility file systems (minix, sysfs, hfs/hfsplus).  They are
> probably not something that people actually use posix_fallocate on.

It's more about a file copying tool doing this by default on behalf of
the users (perhaps Midnight Commander?).  If I recall, posix_fallocate
is also used by file-sharing clients, and those might be used with
external storage media that have older file systems.

> The only relevant exception is probably ext4 in ext2/ext3 mode, where
> the latter might still have users left running real workloads on it
> and not using it for usb disks or VM images.

Why doesn't the kernel perform allocation in these cases?  There doesn't
seem to be a file-system-specific reason why it's impossible to do.

At the very least, we should have a variant of ftruncate that never
truncates, likely under the fallocate umbrella.  It seems that that's
how posix_fallocate is used sometimes, for avoiding SIGBUS with mmap.
To these use cases, whether extents are allocated or not does not
matter.

>> Florian is proposing that different error numbers be returned for (A) vs 
>> (B) so that glibc posix_fallocate can treat the cases differently.
>
> The problem with a new error code is that it will leak out to the
> application when using a new kernel and an old glibc.

If we removed the fallback code from glibc today, it would just be
EOPNOTSUPP that leaks to applications, so it's structurally the same
issue.  The error codes that glibc's posix_fallocate can produce are all
different (unless write on the file fails with EOPNOTSUPP in the kernel,
but that would be quite unexpected).  EOPNOTSUPP would be equally
surprising.

Thanks,
Florian


