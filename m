Return-Path: <linux-fsdevel+bounces-29204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A821497714C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 21:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F34E1F24D57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 19:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FD1BE85C;
	Thu, 12 Sep 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0+7Y9IY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949E91BFE02
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168332; cv=none; b=HGgk9/SPSqxIoId2znDAL5myOomUZvrcf8xXSUJWTmVgZRIoyTH05O0bQOvX/ZVbAYHPJ7ju2Rd8AEPnm7KsR7hdfrzzR7HpgMTU+rvN8BMPYX6PNzYVwoVeeTmn6RwaqbjKxtDPgt7+ovi8e0JQxyUySEZquNa5WuR9o9uknnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168332; c=relaxed/simple;
	bh=/M2IpRl+lu/5oIFubP5jWUgw0bkkbDFTr2zLK16691M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1hzVdmzMROgQZi+7yRABW6GMpkG16sN5xQFlENFwYIZOm659kfqQp6A7VN8bDmnnOclXmK8uX7Egf4nPuXCeEtqzXSc/HodHtWdAtl2fM6t5zHAfVRurFxU3NVm2y46CwHmtFBTlHh4xnGK/POfFxK6MDiOgHJ7LjcGic+ok9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0+7Y9IY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726168329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvbR9pTYN0+0VwKrLy9DuxNd8JvV1gwfKMo7AQzTn/Q=;
	b=Z0+7Y9IYqU4zn4YW+bSM/Bwiku5ZQkpCaBv84JwGCWk/MUDPB0ET49ulTYizoUtcoxoEwq
	oZxlsc3xjMKjV+QBEOC0eshKb32NxB7muGDMZZqYgPz2GrX4rlk7kWxwDQS59V8aaP0JDB
	2A7/1kqRH/9TUvaLoOf9RlAssIFJHY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-BGHi3n3UNGmz565UDixh6w-1; Thu,
 12 Sep 2024 15:12:06 -0400
X-MC-Unique: BGHi3n3UNGmz565UDixh6w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B41A41955D4E;
	Thu, 12 Sep 2024 19:12:03 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 217F81955D4C;
	Thu, 12 Sep 2024 19:11:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Neil Brown <neilb@suse.de>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andreas Gruenbacher <agruenba@redhat.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Alexander Ahring Oder Aring <aahringo@redhat.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Date: Thu, 12 Sep 2024 15:11:55 -0400
Message-ID: <B51C0776-FF71-4A11-8813-57DD396AF68B@redhat.com>
In-Reply-To: <D0E3A915-E146-46C9-A64E-1B6CC2C631F4@oracle.com>
References: <cover.1726083391.git.bcodding@redhat.com>
 <244954CF-C177-406C-9CAC-6F62D65C94DE@oracle.com>
 <E2E16098-2A6E-4300-A17A-FA7C2E140B23@redhat.com>
 <D0E3A915-E146-46C9-A64E-1B6CC2C631F4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 12 Sep 2024, at 14:17, Chuck Lever III wrote:

>> On Sep 12, 2024, at 11:06 AM, Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 12 Sep 2024, at 10:01, Chuck Lever III wrote:
>>
>>> For the NFSD and exportfs hunks:
>>>
>>> Acked-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle.com>>
>>>
>>> "lockd: introduce safe async lock op" is in v6.10. Does this
>>> series need to be backported to v6.10.y ? Should the series
>>> have "Fixes: 2dd10de8e6bc ("lockd: introduce safe async lock
>>> op")" ?
>>
>> Thanks Chuck! Probably yes, if we want notifications fixed up there.  It
>> should be sufficient to add this to the signoff area for at least the first
>> three (and fourth for cleanup):
>>
>> Cc: <stable@vger.kernel.org> # 6.10.x
>
> 2dd10de8e6bc landed in v6.7.
>
> I suppose that since v6.10.y is likely to be closed by
> the time this series is applied upstream, this tag might
> be confusing.
>
> Thus Fixes: 2dd10de8e6bc and a plain Cc: stable should
> work best. Then whichever stable kernel is open when your
> fixes are merged upstream will automatically get fixed.

So you want "Fixes: 2dd10de8e6bc" on all these patches?  Fixing the problem
requires all of the first three patches together.  My worry is that a
"Fixes" on each implies a complete fix within that patch, so its really not
appropriate.

The stable-kernel-rules.rst documentation says for a series, the Cc: stable
tag should be suffient to request dependencies within the series, so that's
why I suggested it for the version you requested.

What exactly would you like to see?  I am happy to send a 2nd version.

Ben


