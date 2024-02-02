Return-Path: <linux-fsdevel+bounces-9983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E7846DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683E228EF95
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FF17E76C;
	Fri,  2 Feb 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BIwKCFtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C27E768
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869845; cv=none; b=h4lYuYrdCZeEIWFt8/pm6npTbFyBNX7w71ZINYXINb0e2WG8YfEy07USLOB7Z/olDf0Uy9Rh9U6YGyi0iDmFxN3DKYwUeO8pLfMlfHEHOXDqNsCSCBjoyiX6zy/Picnzfd6LUO3so8Uuc1RH9jkdW/jp0dl23hrb7gFbsmeXULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869845; c=relaxed/simple;
	bh=5KHFfbYz0XTbcNHG7+bpBM/YwzGH5EBYCvju5fllu1U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=AC+PucILb8k6xGEr1bv5ybQrYkvjLhzMI5nxg4Olvtu3kd3E8mrwYWpXiUVNb25pp3o5QeRy9YFuSMBRABW7vtO/QFBln5x+YXX/HxmDwP5J81FaHpSqD1ajlLxVEFVnA4Hi+LRF+0X96LKSv0Azrc6UUy/iJZnapZcEYHRIAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BIwKCFtE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706869842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5htgxDobsa2ufZAg9x3xAeGYc24d2Ai20T7JxwVTcN0=;
	b=BIwKCFtEvxi71sdf+g1vcy4UIPne3pqc4K1Z1Ma4eg+Yh5n2+T0t+dkq3tA0ZpK9Sk2+H5
	gcXSALDOxPg1UhOB5vRwvR+3HJ5p5X78BKFiByevFTs63l1J4/XoQPBP3i7XJZW+ePtjp0
	ftZyod6cQ/iijJWtWPA9BdtBNT1tzA0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-cvMLszvfOgS4t4W1plW-4g-1; Fri,
 02 Feb 2024 05:30:39 -0500
X-MC-Unique: cvMLszvfOgS4t4W1plW-4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC2A11C04B65;
	Fri,  2 Feb 2024 10:30:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 383632026D66;
	Fri,  2 Feb 2024 10:30:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
References: <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com> <2701318.1706863882@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
    Matthew Wilcox <willy@infradead.org>,
    Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions of uninterruptibility
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2704766.1706869832.1@warthog.procyon.org.uk>
Date: Fri, 02 Feb 2024 10:30:32 +0000
Message-ID: <2704767.1706869832@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > We have various locks, mutexes, etc., that are taken on entry to
> > filesystem code, for example, and a bunch of them are taken interruptibly
> > or killably (or ought to be) - but filesystem code might be called into
> > from uninterruptible code, such as the memory allocator, fscache, etc..
> 
> Are you suggesting to make lots more filesystem/vfs/mm sleeps
> killable?  That would present problems with being called from certain
> contexts.

No, it wouldn't.  What I'm suggesting is something like:

	overlayfs_mkdir(inode)
	{
		inode_lock(inode);  <---  This could be interruptible
		...
		begin_task_uninterruptible();
		...
		do_stuff();
		...
		inode->lower->inode->mkdir(inode->lower->inode);
					^--- say ext4_mkdir
		...
		do_more_stuff();
		end_task_uninterruptible();
		inode_unlock(inode);
	}

	ext4_mkdir(inode)
	{
		inode_lock(inode);  <--- This would be interruptible, but
					 called from overlayfs above is now
					 uninterruptible
		...
	}

You bracket the context where interruptibility is bad and then everyone you
call is forced to be uninterruptible.  This would need to be nestable also:

	begin_task_uninterruptible();
	  begin_task_uninterruptible();
	    begin_task_uninterruptible();
	    ...
	    end_task_uninterruptible();  // must not become interruptible
	  end_task_uninterruptible();  // nor this
	end_task_uninterruptible();  // from here *could* be interruptible again

Obviously, we would need to gradate this to accommodate killability also.

David


