Return-Path: <linux-fsdevel+bounces-24139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09C93A21C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FE8283EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4A153BD9;
	Tue, 23 Jul 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmlNEtpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484515359A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743083; cv=none; b=hTAopYQIIqLeQ+F9saWbJY0V9jmFAY4G8WKrQLEnicM0w+/cgawa2YVqE4pBQflBwg2vKTtflJkYigznbmKsmynEVz1YDv/Iaf0matozYRtJeL7z7yf4hiDgXV48ROpDrGybwB5/X7wSWjRBdJBNm32u6eQn15jLo+6F3SFFNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743083; c=relaxed/simple;
	bh=IsvV5SGoXcqwNf5yP/OJMU1KbdYOYdNfrEYOx3PtXMI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=U7gWNhnTBLhocKlR+eBaXf9YDuFQoOD9KwikU4pGV77b6tgE4qSh32+RvALX8NyIXzDyJXKrux3SUzKVBm79FUQ/tB6gozFlLHlq8uAv53MFD05R99Lb4hH4izlsXcjdw721p9uasmDYK3zzuDHHSHAVgLHJJjZ9LLJnNoMP5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmlNEtpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721743080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mD1ewwJQ3UoqJtaGN7mRy1QcxELMUlyTG0lTtPiLg4=;
	b=KmlNEtpI7Gse7IujAR1n2590d1r+ScNs0JcJBi/5+8paUeouMivf3ZI4PxpC9fiJfXZjh5
	Qwa37UghznP19ImiPinYMmNrfO2/5NLU3QnVo4wfI8OFYSYNwVmft3Y11H2s+ToLGJ+D4A
	bDEXrsXpSbKVpwkfvZwxuhVnD7L39sk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-poFk0CaNMfWaJRfm_9ZalA-1; Tue,
 23 Jul 2024 09:57:54 -0400
X-MC-Unique: poFk0CaNMfWaJRfm_9ZalA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E72261955D5D;
	Tue, 23 Jul 2024 13:57:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8A77119560B2;
	Tue, 23 Jul 2024 13:57:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240723104533.mznf3svde36w6izp@quack3>
References: <20240723104533.mznf3svde36w6izp@quack3> <2136178.1721725194@warthog.procyon.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr() and removexattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2147167.1721743066.1@warthog.procyon.org.uk>
Date: Tue, 23 Jul 2024 14:57:46 +0100
Message-ID: <2147168.1721743066@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jan Kara <jack@suse.cz> wrote:

> Well, it seems like you are trying to get rid of the dependency
> sb_writers->mmap_sem. But there are other places where this dependency is
> created, in particular write(2) path is a place where it would be very
> difficult to get rid of it (you take sb_writers, then do all the work
> preparing the write and then you copy user data into page cache which
> may require mmap_sem).
>
> ...
> 
> This is the problematic step - from quite deep in the locking chain holding
> invalidate_lock and having PG_Writeback set you suddently jump to very outer
> locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> problem because the locks are actually on different filesystems, just
> lockdep isn't able to see this. So I don't think you will get rid of these
> lockdep splats unless you somehow manage to convey to lockdep that there's
> the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> cachefiles) and their locks are different.

I'm not sure you're correct about that.  If you look at the lockdep splat:

>  -> #2 (sb_writers#14){.+.+}-{0:0}:

The sb_writers lock is "personalised" to the filesystem type (the "#14"
annotation) which is set here:

	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
					sb_writers_name[i],
					&type->s_writers_key[i]))  <----
			goto fail;
	}

in fs/super.c.

I think the problem is (1) that on one side, you've got, say, sys_setxattr()
taking an sb_writers lock and then accessing a userspace buffer, which (a) may
take mm->mmap_lock and vma->vm_lock and (b) may cause reading or writeback
from the netfs-based filesystem via an mmapped xattr name buffer].

Then (2) on the other side, you have a read or a write to the network
filesystem through netfslib which may invoke the cache, which may require
cachefiles to check the xattr on the cache file and maybe set/remove it -
which requires the sb_writers lock on the cache filesystem.

So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
ultimately, it should[*] then take the sb_writers lock on the backing
filesystem to perform xattr manipulation.

[*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
    functions which *don't* take this lock (which is a bug).  Is this an error
    on the part of vfs_set/removexattr()?  Should they take this lock
    analogously with vfs_truncate() and vfs_iocb_iter_write()?

However, as it doesn't it manages to construct a locking chain via the
mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
that I don't exactly follow.


I wonder if this is might be deadlockable by a multithreaded process (ie. so
they share the mm locks) where one thread is writing to a cached file whilst
another thread is trying to set/remove the xattr on that file.

David


