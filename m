Return-Path: <linux-fsdevel+bounces-24628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701A941E8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B111C23D07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D4189B85;
	Tue, 30 Jul 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaRWYqcx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CF154C18
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360605; cv=none; b=Htfwg0tapVjUgy3vpq6Pk5PRfs8sS5gKCVuyp5lGWW5oMhdNofOf9/beE9WqdJ7kNyUhjtQQ91WF7AwFt7xC/VMn2yObwuDaap/eh/+sS3OOp/LNuP2E5fxRe+RfxYO9vOvNXgq4VrS+upyY89R6zw1auFJxUgLwtZoIdAFYecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360605; c=relaxed/simple;
	bh=iNS9nkBUS9TqOZAZYgpEpvPT/wdOtH8TXF9vh9wsr20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfPXPEySWwfH9lgNLCHiIeRZiGPu3J6w7bbG2id+xTDuL4iXJNrQCg7wuM5CsOBt0PohvfjS0xSnHw+ZU0t3vzX7ApBedn+vTIXOfuEhPziWJSBylF2nF23ujYujDMXJtUqpn//MAkS3iJWF49qIrQ06rySU1Es9EXK1vwZymeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XaRWYqcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722360602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgdBfdWZAffO+AbOuvKZQidTAMwolyy2vLIGUnSKA1s=;
	b=XaRWYqcxOKXR3rqa1rFk3j1nwdTeTHmuBsTSHLX6vktIHVVTmJlnRZ+E3dqE2usS/t5NpY
	v63j/P1KkQ0PvL/O5gfXDik2p00/cBGTUJKgjzB+4BeHyUfwLanZxoAmuZs+tU4fFjftFL
	za5FyPjopLnt0egLTaJFHwLc9h824BI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-Sp2-N6tuPKa194--ZmtlgQ-1; Tue,
 30 Jul 2024 13:29:59 -0400
X-MC-Unique: Sp2-N6tuPKa194--ZmtlgQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4F9E1955D44;
	Tue, 30 Jul 2024 17:29:57 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 287DC19560AE;
	Tue, 30 Jul 2024 17:29:54 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Eggert <eggert@cs.ucla.edu>,  libc-alpha@sourceware.org,
  linux-fsdevel@vger.kernel.org,  Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240730170831.GA31915@lst.de> (Christoph Hellwig's message of
	"Tue, 30 Jul 2024 19:08:31 +0200")
References: <20240729160951.GA30183@lst.de>
	<87a5i0krml.fsf@oldenburg.str.redhat.com>
	<20240729184430.GA1010@lst.de>
	<877cd4jajz.fsf@oldenburg.str.redhat.com>
	<20240729190100.GA1664@lst.de>
	<8734nsj93p.fsf@oldenburg.str.redhat.com>
	<20240730154730.GA30157@lst.de>
	<e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu>
	<20240730162042.GA31109@lst.de>
	<87o76ezua1.fsf@oldenburg.str.redhat.com>
	<20240730170831.GA31915@lst.de>
Date: Tue, 30 Jul 2024 19:29:51 +0200
Message-ID: <87frrqzt2o.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Christoph Hellwig:

> On Tue, Jul 30, 2024 at 07:03:50PM +0200, Florian Weimer wrote:
>> > The only relevant exception is probably ext4 in ext2/ext3 mode, where
>> > the latter might still have users left running real workloads on it
>> > and not using it for usb disks or VM images.
>> 
>> Why doesn't the kernel perform allocation in these cases?  There doesn't
>> seem to be a file-system-specific reason why it's impossible to do.
>
> Because in general it's a really stupid idea.  You don't get a better
> allocation patter, but you are writing every block twice, making things
> significantly slower and wearing the device out in the process if it
> is flash based.

I would assume the applications that do pre-allocation before mmap with
random writes had a good reason to do it even when it was slow.

>> At the very least, we should have a variant of ftruncate that never
>> truncates, likely under the fallocate umbrella.  It seems that that's
>> how posix_fallocate is used sometimes, for avoiding SIGBUS with mmap.
>> To these use cases, whether extents are allocated or not does not
>> matter.
>
> I don't see how that is related.

Open file, posix_fallocate to the desired size, then use mmap, seems to
be somewhat common.  More often, people use fruncate, but that can
unexpectedly shrink the file.

>> If we removed the fallback code from glibc today, it would just be
>> EOPNOTSUPP that leaks to applications, so it's structurally the same
>> issue.
>
> Not really.  EOPNOTSUPP is a valid error code, that has historically
> been returned by other operating systems and even other libc
> implementations for Linux

I don't see EOPNOTSUPP handling code in Ceph, Beanstalk, Bitcoin Core,
or Transmission.  Most of them seem to just ignore errors (except
perhaps Ceph).  This might not be a problem in the end, but it seems
that existing software (even portable software) does not check for
EOPNOTSUPP.

Thanks,
Florian


