Return-Path: <linux-fsdevel+bounces-9385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E78840908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A111C21532
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B51534E7;
	Mon, 29 Jan 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="PcJCFGk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D084664DE;
	Mon, 29 Jan 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539910; cv=none; b=fihlmBxuzFmANTA15DAcKW/WR0CO4oUSfk66OF7ITsZw48QtZ5l1hB8RHbo3DmZ454XyW3fDL7X7ZDFDidGL8mnJByRozok3yqjPWWpnxiWVEkfPhqIvcTyYZIlaxLGMshZAWdF00KCj56B/qrISDc8UE0HtOOyPKwsVSL022cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539910; c=relaxed/simple;
	bh=eQAgMHUu2TPgI3CFnF+f0gE8JUhEUD68C/EhB1GXcPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTr8SheqFeK+G9INY8nS6M1OBEYajDZp86LzlOP6B2kD1F7tRO4xD6ee1ej32NYmtvrVpdb3WPCrwnU4CkX3VuKmKigI/SSC0Fr4KfVnzE6v+Yp0DNLGtpdn/M+u7uX7MdMaZ4q1xZGIgHgPlaJS205xHctAZ6X9jtlCwEX2foA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=PcJCFGk4; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=GS1g13cvmu/J8tisETDybWHkXTlbk7TLNosWxc0MwC8=; b=PcJCFGk4ksa/E0mFLnU2TIQ69u
	DEwjeE6DLNvO/6lOUc9fbyBzZPNxiitP8wh4JhB8mE13z/w3qthxXsUDhYtmznoHAdQHeZZIefQ4d
	POpA9v3dBfgfuI7IrKUhRWMnfIqd4wx9wP2GYOeToJItX1j/iDc/fI29P8I241mTd1l9CAaGfRyD7
	dRZILfLCwR1b9QqdVZv26G4BryfvBgYyA0h/npKmj2dvjG2u8OUDm4Fd7WKA7pBq3B53hE9opDNZK
	pXb6g16BY9m0RDXZ7vg2wM9u96viDrJjBXxt7My/frzziBhDdGjN3qdMJtrtdnfi08JkClo9DA0yu
	DgPpHTqpCQz9uuTACPL0LtSpf7SQXGSCUX9/nov5OdcWWmvyQje1RaUOlUWEajUZbqHShEQXR5std
	bvL4oqHJehdCppCRKbnfFA7q3bhWfJVZvvsJZjepZ+W2K3Dpbc6Ikzsg2a7tA+SzOe3ETDOLJCbTH
	JbjZvyq7ZTIas3UsVRxXzBSkX+jUw3eAbrDybDYuv8BOB9U4/VgCZlNSKl+8LlvI4fRFY8xW3VqUz
	2M9w8JwTxDab+D9GHCH+bYwvAVYCTNkgiIVl4AMRDuzoB9VtYZfMgmc0q3RM6yCRLi3NHn+72sGpO
	JqxcKYsVP71/mVG3h/1ptI/UoFkfe0VBZYmkWO6V8=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Latchesar Ionkov <lucho@ionkov.net>, David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] 9p: Further netfslib-related changes
Date: Mon, 29 Jan 2024 15:14:28 +0100
Message-ID: <1726980.McBZPkGeyK@silver>
In-Reply-To: <20240129115512.1281624-1-dhowells@redhat.com>
References: <20240129115512.1281624-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, January 29, 2024 12:54:34 PM CET David Howells wrote:
> Hi Eric, Dominique,
> 
> Here are some netfslib-related changes we might want to consider applying
> to 9p:
> 
>  (1) Enable large folio support for 9p.  This is handled entirely by
>      netfslib and is already supported in afs.  I wonder if we should limit
>      the maximum folio size to 1MiB to match the maximum I/O size in the 9p
>      protocol.

The limit depends on user's 'msize' 9p client option and on the 9p transport
implementation. The hard limit with virtio transport for instance is currently
just 500k (patches for virtio 4MB limit fetching dust unfortunately).

Would you see an advantage to limit folio size? I mean p9_client_read() etc.
are automatically limiting the read/write chunk size accordingly.

>  (2) Make better use of netfslib's writethrough caching support by not
>      disabling caching for O_DSYNC.  netfs_perform_write() will set up
>      and dispatch write requests as it copies data into the pagecache.
> 
>  (3) Always update netfs_inode::remote_size to reflect what we think the
>      server's idea of the file size is.  This is separate from
>      inode::i_size which is our idea of what it should be if all of our
>      outstanding dirty data is committed.
> 
> The patches can also be found here:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-9p
> 
> Thanks,
> David
> 
> David Howells (2):
>   9p: Make better use of netfslib's writethrough caching
>   9p: Always update remote_i_size in stat2inode
> 
> Dominique Martinet (1):
>   9p: Enable large folio support
> 
>  fs/9p/fid.h            | 3 +--
>  fs/9p/vfs_inode.c      | 1 +
>  fs/9p/vfs_inode_dotl.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)





