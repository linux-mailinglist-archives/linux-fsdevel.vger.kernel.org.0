Return-Path: <linux-fsdevel+bounces-67348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B8C3C7E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73634189540E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0334D4D6;
	Thu,  6 Nov 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqgaN4QW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94F329378
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446705; cv=none; b=I2yC0mayyL6JNMT/d3imJNTpP0KAw48uV5dtekrPn3uq9zTCu+tPX0HV++LHM4u5O2v1HXonZ78gk9umSBvoNk9uMpDO88yhf/QiugRi+vyMaso+evYpWnyowFdbgnXvFwq9Bhu3QaaOV5PxG631WRVoRmvNq8uvI+CTZ8Gf54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446705; c=relaxed/simple;
	bh=mHsw22qvoUn8BNsltylWxuUHy6Ate8i2qX8bCfUjMPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nY/ricd1w5IZHomAm1CpSBCes3Y5I6ZdBnsNIk4sAi3vEpv+OziPmiSshVXbdi/KbbBJe1p3lv4N4/FRi+A/nRRBLpfSUgTLOFpe2nPouEkhK5icNVueC7/viuH5xtvKB11fM2Cry/y0WVn8AbGktzkVb4Xd5tIHxJggSPzA2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqgaN4QW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwzkm+v1gtKVPuRw/kAUlsMgFI4I+9PdJpOVJqEwSzA=;
	b=BqgaN4QWILOqXUUldGDxKjlqaj05rQoY4i7ef9hEtnpYZ+DGnukSxlpnmlAzQ45UkXeeiN
	j62AUtZ516SQKN2ybjeZKdEDgR8s11SdHMQIhfn7clwZ6l65ONj+f7DL8dr+mkR8oxdJWq
	RvWp/MtOtj0YA5AaeRJfW6zLSuZx8gk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-8Q9rj2z3NNaU_pgt6vTISg-1; Thu,
 06 Nov 2025 11:31:38 -0500
X-MC-Unique: 8Q9rj2z3NNaU_pgt6vTISg-1
X-Mimecast-MFC-AGG-ID: 8Q9rj2z3NNaU_pgt6vTISg_1762446696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB9F01955E7F;
	Thu,  6 Nov 2025 16:31:34 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB62F1800346;
	Thu,  6 Nov 2025 16:31:30 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,  Hans Holmberg <hans.holmberg@wdc.com>,
  linux-xfs@vger.kernel.org,  Carlos Maiolino <cem@kernel.org>,  Dave
 Chinner <david@fromorbit.com>,  "Darrick J . Wong" <djwong@kernel.org>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <aQyz1j7nqXPKTYPT@casper.infradead.org> (Matthew Wilcox's message
	of "Thu, 6 Nov 2025 14:42:30 +0000")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
Date: Thu, 06 Nov 2025 17:31:28 +0100
Message-ID: <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Matthew Wilcox:

> On Thu, Nov 06, 2025 at 02:52:12PM +0100, Christoph Hellwig wrote:
>> On Thu, Nov 06, 2025 at 02:48:12PM +0100, Florian Weimer wrote:
>> > * Hans Holmberg:
>> > 
>> > > We don't support preallocations for CoW inodes and we currently fail
>> > > with -EOPNOTSUPP, but this causes an issue for users of glibc's
>> > > posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
>> > > writing actual data into the range to try to allocate blocks that way.
>> > > That does not actually gurantee anything for CoW inodes however as we
>> > > write out of place.
>> > 
>> > Why doesn't fallocate trigger the copy instead?  Isn't this what the
>> > user is requesting?
>> 
>> What copy?
>
> I believe Florian is thinking of CoW in the sense of "share while read
> only, then you have a mutable block allocation", rather than the
> WAFL (or SMR) sense of "we always put writes in a new location".

Ahh.  That's a new aspect to the discussion that was previously lost to
me.  Previous discussions focused on cases where the kernel couldn't do
the pre-population operation safely even though it was beneficial from
an application perspective.  And not cases where the operation was
meaningless because of the way the file system was implemented.

(Pre-allocating CoW space as part of fallocate appears to be difficult
because I don't see how to surface this space usage to applications and
adminstrators.)

It's been a few years, I think, and maybe we should drop the allocation
logic from posix_fallocate in glibc?  Assuming that it's implemented
everywhere it makes sense?  There are more always-CoW, compressing file
systems these days, so applications just have to come to terms with the
fact that even after posix_fallocate, writes can still fail, and not
just because of media errors.  So maybe posix_fallocate isn't that
meaningful anymore.

Thanks,
Floriana


