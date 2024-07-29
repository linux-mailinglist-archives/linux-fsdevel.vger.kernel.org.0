Return-Path: <linux-fsdevel+bounces-24506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916193FDBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2E5B21844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD96186E2D;
	Mon, 29 Jul 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f51CE1tC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F757CB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722279134; cv=none; b=AVn9FPKH+dSHOwqbfaB2We2cbjxqx0YFkq/2YWfPM0kjrigXkzo5K0t0UHjVCV162sz5ns401FxbGzU2Jl25nQAnyhnrYzMm1c8qwvwbmvYoNEiHeZULQG6TyDNWy6nwwVgQ9VF+a4rpDYEO5YvmcKCycRbQm/NPsVUyRR61pig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722279134; c=relaxed/simple;
	bh=G67oN5+WTVUK6WnGRkk7RWmpQqDpJc6mwIXKnsb3UBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhk/jXwRQXbxYbNhZ1oXmE/eT6osSkx3Sc59K0tm/msuAvpVVGh+SCKcH256V2mqmLpXEHP7ftJrmLSuGJggudtGCGS1+F3LPFSZoTWHIBAnJmb0WlnvmKNfNbw2Vwv74uSOGbYa5Tpd2olPxjP7cNmP7eiM/sHFL1FniPjaGbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f51CE1tC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722279131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=woXnGJ2FefZ0i/LfFS//feW7ePRaSh2BIl0uOQOK+SY=;
	b=f51CE1tCwf4lH9lwSVLDG2QemZ7EfviR29lfGIzWm3n3SnR/50YavhL1z5jZza0BDpUJcw
	3374i/Q9NFctf4EozJMTNeFNrG7HdUIPWrusFTUPkMrbPXHY9a+1RsFPvm0H1HCcgkvZJK
	YwDzIEX1lwsh6Dl65LK1fgPonf7BJgQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-9MngdyftMwCFGGVqlS4OTA-1; Mon,
 29 Jul 2024 14:52:08 -0400
X-MC-Unique: 9MngdyftMwCFGGVqlS4OTA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FF3419560AA;
	Mon, 29 Jul 2024 18:52:06 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0CE19560B2;
	Mon, 29 Jul 2024 18:52:03 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: libc-alpha@sourceware.org,  linux-fsdevel@vger.kernel.org,  Trond
 Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240729184430.GA1010@lst.de> (Christoph Hellwig's message of
	"Mon, 29 Jul 2024 20:44:30 +0200")
References: <20240729160951.GA30183@lst.de>
	<87a5i0krml.fsf@oldenburg.str.redhat.com>
	<20240729184430.GA1010@lst.de>
Date: Mon, 29 Jul 2024 20:52:00 +0200
Message-ID: <877cd4jajz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Christoph Hellwig:

> On Mon, Jul 29, 2024 at 07:57:54PM +0200, Florian Weimer wrote:
>> When does the kernel return EOPNOTSUPP these days?
>
> In common code whenever the file system does not implement the
> fallocate file operation, and various file systems can also
> return it from inside the method if the feature is not actually
> supported for the particular file system or file it is called on.
>
>> Last time I looked at this I concluded that it does not make sense to
>> push this write loop from glibc to the applications.  That's what would
>> happen if we had a new version of posix_fallocate that didn't do those
>> writes.  We also updated the manual:
>
> That assumes that the loop is the right thing to do for file systems not
> supporting fallocate.  That's is generally the wrong thing to do, and
> spectacularly wrong for file systems that write out of place.

In this case, the file system could return another error code besides
EOPNOTSUPP.  There's a difference between =E2=80=9Cno one bothered to imple=
ment
this=E2=80=9D and =E2=80=9Cthis can't be implemented correctly=E2=80=9D, an=
d it could be
reflected in the error code.

> The applications might not know about glibc/Linux implementation details
> and expect posix_fallocate to either fail if can't be supported or
> actually give the guarantees it is supposed to provide, which this
> "fallback" doesn't actually do for the not entirely uncommon case of a=20
> file system that is writing out of place.

I think people are aware that with thin provisioning and whatnot, even a
successful fallocate call doesn't mean that there's sufficient space to
complete the actual write.

Thanks,
Florian


