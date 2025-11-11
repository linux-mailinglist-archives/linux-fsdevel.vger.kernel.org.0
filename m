Return-Path: <linux-fsdevel+bounces-67874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E308EC4CABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8FA4334F3BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A32F3605;
	Tue, 11 Nov 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGLCsF9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B12F28EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853446; cv=none; b=oTCGsKnbNc/mrjiWVIAp3SvjX/lqXoZjGfBmSRO9LbJz8JYLSV7CSHcJ6ehKE9b96nh4HPUN5AD5kjAp0nLbfEa4bJZprrmdR2eIR6uy01HuMhqLy5N27hxSq9HIH9klG+ZQs2AsGPfsVSJI+soqrcxOC4HI9k3kLUZJGQYPgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853446; c=relaxed/simple;
	bh=Pl1O2aK3f7SCaGDeT7WJAGlIhfq/1h/E92nrNOSzuQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/p62F7C6ktIN/GoppxNR6e4a4B5RgJZxXaedvgmO6qMTlWK5OCjaRvXQ5NFFjF6TiZcUlfyJrgmPMUpsAiaKuPynugFR8asV3z5zaKcSOrxZhkyrTtaaCcnXJWKabaCXIwSpIvglg4fUzRTWdJOD92yyrxBuQxAcwtQvnFqjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGLCsF9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762853444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yfmBGDXPeWaCMkaY7wTnRtorjcH8kduY0v5fCrRVaTM=;
	b=WGLCsF9IpniM4DfQ3bLkOYoBiVdKZsoySUCehdPL3yn8Jra18sdY7dsJEi3t0jsCBCkKMd
	jmxp9m1dZM3UYky4B+ReGzt3Yb9BmPeuE/p4qRf0DGzPJBjPW4/PeR9AyfhYHzsRwWRkru
	Zki+kqQR0hZvochaMrqXYeklUZLkNZA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-h4Aesh9ZO8SI9YmjnIdt6w-1; Tue,
 11 Nov 2025 04:30:37 -0500
X-MC-Unique: h4Aesh9ZO8SI9YmjnIdt6w-1
X-Mimecast-MFC-AGG-ID: h4Aesh9ZO8SI9YmjnIdt6w_1762853436
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED8F318002CF;
	Tue, 11 Nov 2025 09:30:35 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3AA530044E5;
	Tue, 11 Nov 2025 09:30:31 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>,  Matthew Wilcox <willy@infradead.org>,
  Hans Holmberg <hans.holmberg@wdc.com>,  linux-xfs@vger.kernel.org,
  Carlos Maiolino <cem@kernel.org>,  "Darrick J . Wong"
 <djwong@kernel.org>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <aRJaLn72i4yh1mkp@dread.disaster.area> (Dave Chinner's message of
	"Tue, 11 Nov 2025 08:33:34 +1100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
	<20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de>
	<aRESlvWf9VquNzx3@dread.disaster.area> <20251110093701.GB22674@lst.de>
	<aRJaLn72i4yh1mkp@dread.disaster.area>
Date: Tue, 11 Nov 2025 10:30:28 +0100
Message-ID: <lhubjl8kjbf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Dave Chinner:

> I don't see how a glibc posix_fallocate() fallback that does a
> non-desctructive truncate up though some new interface is any better
> than just having the filesystem implement ALLOCATE_RANGE without the
> ENOSPC guarantees in the first place?

It's better because you don't have to get consensus among all file
system developers that implementing ALLOCATE_RANGE as a non-destructive
truncate is acceptable.  Even it means that future writes to the range
can fail with ENOSPC, contrary to what POSIX requires for
posix_fallocate.

Thanks,
Florian


