Return-Path: <linux-fsdevel+bounces-24509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403FA93FE30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 21:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71DB61C225AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF0187330;
	Mon, 29 Jul 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsVl4PQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA184D34
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281016; cv=none; b=EMzikVDQUfcsAj/X/VOsbLS8s5JIKdnuQBwx1duLxt93fnz+Hn1qv6Y3Wmiv8Of6ah1Sga6GpsiTgGn/+7m5FlYS3fFRWJTJNajQoHGBdONoHisHI5Vy8V9o4Xh20eNdMtb39wHEP/oApbN6s66+Xm7G5rK/bbHePcfBkvimyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281016; c=relaxed/simple;
	bh=A69wVZs7q5rzKpSUtGJ4xaqa+T9n87amotF3TGKUXqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOLFxw8MWCWy3pWlW6irSkjLyncT8oX6ykHRTIaIFtfz9vxU74hK6BQWHOizlb5V7cnAO/HUTyVscCfItPIcTrPiGQZmX3Pp4iCwh8fgWnmH5O6KZUNfUcAEZkLS3C8HTtbmjj5mRrKxf2q5VZZs9wapbYxYha+Ra80ySoOsJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AsVl4PQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722281014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mor0denRSc2nnwZnpNdvxqnufAwwt941CiEvNfKQM/c=;
	b=AsVl4PQ6oJCXfqlzEeQMg464iTJGKcWyCpY1I+p3BkfTETm892s+DmYKsd87R9knZX4Tof
	OMZX3MD7py2w1CuLse1bqHtqN4ktJsD3x5/HW1YEZ4yv4uHTFM63vH263Go/WrY+u/ySvi
	2vrdjXtRuEffF85oKHYtCsHZULnYPfE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-lMhmP0c4M7ahHKAAsQoYbQ-1; Mon,
 29 Jul 2024 15:23:29 -0400
X-MC-Unique: lMhmP0c4M7ahHKAAsQoYbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 167F61955D4D;
	Mon, 29 Jul 2024 19:23:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C67AC19560AA;
	Mon, 29 Jul 2024 19:23:25 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: libc-alpha@sourceware.org,  linux-fsdevel@vger.kernel.org,  Trond
 Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240729190100.GA1664@lst.de> (Christoph Hellwig's message of
	"Mon, 29 Jul 2024 21:01:00 +0200")
References: <20240729160951.GA30183@lst.de>
	<87a5i0krml.fsf@oldenburg.str.redhat.com>
	<20240729184430.GA1010@lst.de>
	<877cd4jajz.fsf@oldenburg.str.redhat.com>
	<20240729190100.GA1664@lst.de>
Date: Mon, 29 Jul 2024 21:23:22 +0200
Message-ID: <8734nsj93p.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

* Christoph Hellwig:

> On Mon, Jul 29, 2024 at 08:52:00PM +0200, Florian Weimer wrote:
>> > supporting fallocate.  That's is generally the wrong thing to do, and
>> > spectacularly wrong for file systems that write out of place.
>> 
>> In this case, the file system could return another error code besides
>> EOPNOTSUPP.
>
> What error code would that be and how do applications know about it?

Anything that's not EOPNOTSUPP will do.  EMEDIUMTYPE or ENOTBLK might do
it.  Any of the many STREAMS error codes could also be re-used quite
safely because Linux doesn't do STREAMS.

If you remove the fallback code, applications need to be taught about
EOPNOTSUPP, so that doesn't really make a difference.

Still it needs testing.  It's possible that key software doesn't expect
posix_fallocate to fail.

Thanks,
Florian


