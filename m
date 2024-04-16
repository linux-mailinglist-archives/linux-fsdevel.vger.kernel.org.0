Return-Path: <linux-fsdevel+bounces-17056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6A8A71C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6973284309
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F48131723;
	Tue, 16 Apr 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIXy075l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0A2EAF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286734; cv=none; b=nssBWhPrph2jYwpMy474mv9WRhK5icBVJAflykZPIjv6U6MU4HSjmpWyfTJbPdHLjrnczJdr8y6e3ds945rpu/zJRpm/ko/Os7htrA7fBGQzclkVnyClqRuoCgmEo6rccdm0Y9AtYiGGWd0y/QEbG6VckGx5LvAHpwby+1IKsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286734; c=relaxed/simple;
	bh=opPCA+XHxeV0l/Z0FrPaAC14zh+S8xVA6FNWxr5aA8w=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=DzFhcKcFh9av3hklgIWk2wE7p44KqjTP9RHGqvwzP64RbAa07nD5QYXyOWvuvp+egdOEr58bCppYkM6AWdi6l+UaV+VP0dWT47LkPPRPSzEfNFiHoRSt5a2YSXdhCVBFTCC8C6+BLFfyCeqbV4z/q2v/PLghws8NZXUQ/Iz8jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIXy075l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713286732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACuK1BwAPedfa6Ho4auLQQiF3JZp7pyLXmhg4dg7VCQ=;
	b=PIXy075lXq05oo2BlaaFbFgHxXQ04dZ4B8FqCP91kT3NRVMkUl3eZZ8uFQx0wvsVKdq48S
	gfXnJxQInGopSwLGtukIdQ/EeawsVo7bM3BctXoIwy69KUZsWdXgoXXq0NKhcX2kPzR3tz
	4qpb4o0itwCCuGgLZwopiFBntBcXzy4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-B2DbH90MP86kOa52DZy_Jg-1; Tue, 16 Apr 2024 12:58:49 -0400
X-MC-Unique: B2DbH90MP86kOa52DZy_Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F11180591B;
	Tue, 16 Apr 2024 16:58:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 796A12124E4D;
	Tue, 16 Apr 2024 16:58:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com>
References: <14e66691a65e3d05d3d8d50e74dfb366@manguebit.com> <3756406.1712244064@warthog.procyon.org.uk>
To: Paulo Alcantara <pc@manguebit.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix reacquisition of volume cookie on still-live connection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2713339.1713286722.1@warthog.procyon.org.uk>
Date: Tue, 16 Apr 2024 17:58:42 +0100
Message-ID: <2713340.1713286722@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Paulo Alcantara <pc@manguebit.com> wrote:

> Can't we just move the cookie acquisition to cifs_get_tcon() before it
> gets added to list @ses->tcon_list.  This way we'll guarantee that the
> cookie is set only once for the new tcon.

cifs_get_tcon() is used from more than one place and I'm not sure the second
place (__cifs_construct_tcon()) actually wants a cookie.  I'm not sure what
that path is for.  Could all the (re)setting up being done in
cifs_mount_get_tcon() be pushed back into cifs_get_tcon()?

> Besides, do we want to share a tcon with two different superblocks that
> have 'fsc' and 'nofsc', respectively?  If not, it would be better to fix
> match_tcon() as well to handle such case.

Maybe?  What does a tcon *actually* represent?  I note that in
cifs_match_super(), it's not the only criterion matched upon - so you can, at
least in apparent theory, get different superblocks for the same tcon anyway.

This suggests that the tcon might not be the best place for the fscache volume
cookie as you can have multiple inodes wishing to use the same file cookie if
there are multiple mounts mounting the same tcon but, say, with different
mount parameters.

I'm not sure what the right way around this is.  The root of the problem is
coherency management.  If we make a change to an inode on one mounted
superblock and this bounces a change notification over to the server that then
pokes an inode in another mounted superblock on the same machine and causes it
to be invalidated, you lose your local cache if both inodes refer to the same
fscache cookie.

Remember: fscache does not do this for you!  It's just a facility by which
which data can be stored and retrieved.  The netfs is responsible for telling
it when to invalidate and handling coherency.

That said, it might be possible to time-share a cookie on cifs with leases,
but the local superblocks would have to know about each other - in which case,
why are they separate superblocks?

David


