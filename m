Return-Path: <linux-fsdevel+bounces-24502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A493FCEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988421C21F83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E394216F0E7;
	Mon, 29 Jul 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHC2hQ9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD0E3D9E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275890; cv=none; b=s5sQIvELXk7x4KKDKW2KKJjJedHGYL0+k2n8nkn3QoFqN92ITbFlw9lX3wetJyFhUxcKCxIT65fUuKH1OVjqo8XUaZxmwl/kuSnBwmc/xyXQaK+D8MVV5MFoVOJ5IsfOAGbkgLuUwSr8k+KR2FdoqN+I7zPUt1OD2JjKqCvyFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275890; c=relaxed/simple;
	bh=iNb1vABWM73eK1gwpmKZtAWM2iZX5PGhIEfdkoRN60I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EPq04xPfofqEVsgMcPb4m+0W79g+T6G0W6e9wsSwbiZE75wQWQEW+X9A2XSben86KnGjt0iIOMgMIePUOeXR34652KEBjv8mNSKIr+zVkcn0mM7ZFSVlt+qXfIFW509ZPBiNuTGWcv/4vtsNLt6/GsRRbdl61d2m1YEqJ82d46k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHC2hQ9X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722275887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g+lXxudRO8YdAXYO0uLFUWiyqbc52hz1vv3zUGXlc9A=;
	b=BHC2hQ9XNKpSwnhATUsHP32B2kQ8IQp3tbG0lkJX4ryYaCrOlq7jG498GYWZiSNq5qbHfL
	kACJRXVyBr4pBTbamwIwJ63tyONHHjvLGENaGriqTZ+T/4FtmmOig4NiGvwjgQGT4fEUL7
	smy5P2GL3V5hVcsZnvsOHtlTioZLTOE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-ugOy_DunPhmAoUImdUe3Vw-1; Mon,
 29 Jul 2024 13:58:04 -0400
X-MC-Unique: ugOy_DunPhmAoUImdUe3Vw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81BA81955D4F;
	Mon, 29 Jul 2024 17:58:02 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 532ED300019A;
	Mon, 29 Jul 2024 17:57:59 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: libc-alpha@sourceware.org,  linux-fsdevel@vger.kernel.org,  Trond
 Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
In-Reply-To: <20240729160951.GA30183@lst.de> (Christoph Hellwig's message of
	"Mon, 29 Jul 2024 18:09:51 +0200")
References: <20240729160951.GA30183@lst.de>
Date: Mon, 29 Jul 2024 19:57:54 +0200
Message-ID: <87a5i0krml.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Christoph Hellwig:

> The glibc implementation in sysdeps/posix/posix_fallocate.c, which is
> also by sysdeps/unix/sysv/linux/posix_fallocate.c as a fallback if the
> fallocate syscall returns EOPNOTSUPP is implemented by doing single
> byte writes at intervals of min(f.f_bsize, 4096).

> How can we get rid of this glibc fallback that turns the implementations
> non-conformant and increases write amplication for no good reason?

When does the kernel return EOPNOTSUPP these days?  We do not even do
fallback for EPERM/ENOSYS, those that might be encountered in
containers.

Last time I looked at this I concluded that it does not make sense to
push this write loop from glibc to the applications.  That's what would
happen if we had a new version of posix_fallocate that didn't do those
writes.  We also updated the manual:

  Storage Allocation
  <https://sourceware.org/glibc/manual/latest/html_node/Storage-Allocation.html>

As mentioned, if an application doesn't want fallback behavior, it can
call fallocate directly.

Thanks,
Florian


