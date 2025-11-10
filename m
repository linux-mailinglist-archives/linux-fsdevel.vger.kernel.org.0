Return-Path: <linux-fsdevel+bounces-67658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F6C45CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BACF3B979C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323F302774;
	Mon, 10 Nov 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzDtKtKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448D303A38
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768820; cv=none; b=fF1XWTHb21PP1y4dz9ASiI18xnzpeBzv6I4Ql/u1vIW5pQ8XEQmHOImpnk8nSq2jsdz0vqKOkQab5KTYpliII+YwoP0U4nb8MPMAuBzrzxJI9Mn5NvvovNso0K2mmGULv3QwrkQ90CJdjtcQ0ENvMWbv/onlcPiT4xeW03tkvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768820; c=relaxed/simple;
	bh=EUyWiFScXgn7F+DcQZB+wlycuEGGy1JbALp62E/f+/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHrBgIGVDBq7Zk+ZtA4CwsKVYPsqpQnuYmqx5V5pbWhM7r8xyGFMMWRSex1yDB2480J+m/awjIYAPoNRiDE0kzulGE1RfDapP92NkIT1pf9lWCoPvpu0GzkSfxmTZplD272jlN4OBbTFogiY/hjuvHI8zeU3NfH6Po6ThsRzDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzDtKtKf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762768818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5BK2s5k5pjxYUQWQQfjtI+MbVzxOLhifTPfdi+okfg=;
	b=gzDtKtKfoynXW4APZI847iGCDeLXu2U3p9Z2wd79DNrl2nl2Gl+4e8hvJyf2YOlMfglQYU
	bdXC4sCZ6ujDQL7HceLl34l+Rp+POWVr6JZ/cjvEmLEjiVl6bBoJdjcfAT+TJR4sDfzfu3
	EAJlxaKDdCzJCbXyh9L9bTzA9gn/UAY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-oaolRIKTPUmdDjOW3kvC2g-1; Mon,
 10 Nov 2025 05:00:12 -0500
X-MC-Unique: oaolRIKTPUmdDjOW3kvC2g-1
X-Mimecast-MFC-AGG-ID: oaolRIKTPUmdDjOW3kvC2g_1762768810
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEF01195605F;
	Mon, 10 Nov 2025 10:00:10 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 272901800361;
	Mon, 10 Nov 2025 10:00:05 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>,  Hans Holmberg
 <hans.holmberg@wdc.com>,  linux-xfs@vger.kernel.org,  Carlos Maiolino
 <cem@kernel.org>,  Dave Chinner <david@fromorbit.com>,  "Darrick J . Wong"
 <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  libc-alpha@sourceware.org
Subject: Re: truncatat? was, Re: [RFC] xfs: fake fallocate success for
 always CoW inodes
In-Reply-To: <20251110094829.GA24081@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:48:29 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<20251110093140.GA22674@lst.de> <20251110094829.GA24081@lst.de>
Date: Mon, 10 Nov 2025 11:00:03 +0100
Message-ID: <lhu5xbiyzq4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

* Christoph Hellwig:

> On Mon, Nov 10, 2025 at 10:31:40AM +0100, Christoph Hellwig wrote:
>> fallocate seems like an odd interface choice for that, but given that
>> (f)truncate doesn't have a flags argument that might still be the
>> least unexpected version.
>> 
>> > Maybe add two flags, one for the ftruncate replacement, and one that
>> > instructs the file system that the range will be used with mmap soon?
>> > I expect this could be useful information to the file system.  We
>> > wouldn't use it in posix_fallocate, but applications calling fallocate
>> > directly might.
>> 
>> What do you think "to be used with mmap" flag could be useful for
>> in the file system?  For file systems mmap I/O isn't very different
>> from other use cases.
>
> The usual way to pass extra flags was the flats at for the *at syscalls.
> truncate doesn't have that, and I wonder if there would be uses for
> that?  Because if so that feels like the right way to add that feature.
> OTOH a quick internet search only pointed to a single question about it,
> which was related to other confusion in the use of (f)truncate.
>
> While adding a new system call can be rather cumbersome, the advantage
> would be that we could implement the "only increase file size" flag
> in common code and it would work on all file systems for kernels that
> support the system call.

There are some references to ftruncateat:

  <https://codesearch.debian.net/search?q=ftruncateat&literal=1>

I don't have a particularly strong opinion on the choice of interface.
I can't find anything in the Austin Group tracker that suggests that
they are considering standardizing ftruncateat without a flags argument.

Thanks,
Florian


