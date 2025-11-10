Return-Path: <linux-fsdevel+bounces-67655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD284C45BB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19A53B903E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C952EB859;
	Mon, 10 Nov 2025 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi6cSRbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B52E9EC7
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768159; cv=none; b=pgh9Lr71lME2+7O6xgV6EZz85o2jciqE+mZYceg6DDHNAbCSMyLMIO1uRRseIE+scQgU8dCecsUbdEOjWCwKwHUF9pubsV5lKy8NdojUe6ySLwRoEHYu44Ol7MRpKZfZKSOdc2nJWvHxhPEPK8IB0b6ntX00hen+++Lik7Scil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768159; c=relaxed/simple;
	bh=4+Zj2BU1j2wK80risJQd5n1m5a0sXAPbpBY19p5Lr2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tW7uur6IKOXzo/NcXf94c9qA2DLdy7RnaBierHq8UhetHfHREpcIjTbFNymdIIE6ZuEQ1oC4l1rvBKi1JtLgs+9vdpnffnV4OV4Gg1aqnUeoHpSQjcZAGl3a+Mg5jixy/p56iJ6hhnhNWJjZjNacmaBOn8+cEB11S0RIXTuu5d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gi6cSRbJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762768157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lkfcWxT5UtiKBoOJs1xCAcqAmUWc+tgnOGeH494ceRg=;
	b=Gi6cSRbJDvLA/ea42cQJhSCYCeYpOYJkhZFRSVNk7UDxOknVoLgyABEYsHQBa3lsdw8Rxy
	hGyFsgK6Z3WM3rNK/dTBytnvzWmCbXEFxwUOd7tk2dkw9yGAvTINKDmlhy1M175t1DRYJM
	dNtLyv+TbexBAcYnoExc+BGkebMQCoQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-18-EGaxYOISd_qSeUwuIaw-1; Mon,
 10 Nov 2025 04:49:13 -0500
X-MC-Unique: 18-EGaxYOISd_qSeUwuIaw-1
X-Mimecast-MFC-AGG-ID: 18-EGaxYOISd_qSeUwuIaw_1762768151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F5D31956095;
	Mon, 10 Nov 2025 09:49:11 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 871D5195419F;
	Mon, 10 Nov 2025 09:49:07 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>,  Hans Holmberg
 <hans.holmberg@wdc.com>,  linux-xfs@vger.kernel.org,  Carlos Maiolino
 <cem@kernel.org>,  Dave Chinner <david@fromorbit.com>,  "Darrick J . Wong"
 <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251110093140.GA22674@lst.de> (Christoph Hellwig's message of
	"Mon, 10 Nov 2025 10:31:40 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<20251110093140.GA22674@lst.de>
Date: Mon, 10 Nov 2025 10:49:04 +0100
Message-ID: <lhubjlaz08f.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Christoph Hellwig:

>> Maybe add two flags, one for the ftruncate replacement, and one that
>> instructs the file system that the range will be used with mmap soon?
>> I expect this could be useful information to the file system.  We
>> wouldn't use it in posix_fallocate, but applications calling fallocate
>> directly might.
>
> What do you think "to be used with mmap" flag could be useful for
> in the file system?  For file systems mmap I/O isn't very different
> from other use cases.

I'm not a file system developer. 8-)

The original concern was about a large file download tool that didn't
download in sequence.  It wrote to a memory mapping directly, in
somewhat random order.  And was observed to cause truly bad
fragmentation in practice.  Maybe this something for posix_fadvise.

Thanks,
Florian


