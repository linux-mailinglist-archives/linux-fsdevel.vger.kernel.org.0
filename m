Return-Path: <linux-fsdevel+bounces-7481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8C8258F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 18:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812D71C23376
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 17:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70F321BD;
	Fri,  5 Jan 2024 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="tn6PqWq+";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="CvojuvDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9C32186;
	Fri,  5 Jan 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 47DCEC026; Fri,  5 Jan 2024 18:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704475255; bh=G5QLtqgPgUPlhX16D8cxgZSrhZwA8FdHTj67GHw0qi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tn6PqWq+0UHN3QxCRZid+V+fJBenvC3IrIIcqOsdUbUgqD8BvhWt2WB90oSw7XpPg
	 QlUFE2ue/FCeJ/DLCFsWomlZCxMLnpaB0lM3wvwMCs4jctG4fvUBqrc03/wmY/sc0S
	 8N2iRbE0aTsPVsWcNX4DCgvZISkj+1s2RpUktuXRQ7liHWaMGGelG/otThKmTb5+o9
	 rqsKWauiSE5eYZH82ZaqL1LP0H6bbwJzQQG77J3sBIpVhHOvH02KIeT/rFE6grRJ9i
	 cHB85E+b1u50A//1wjlYgDkzEh8xzHxoPl97Y55v0xmCQmwlSI3+S7yRacHEVsWfLm
	 H0mNlD3NjjkYw==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 448ADC009;
	Fri,  5 Jan 2024 18:20:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704475254; bh=G5QLtqgPgUPlhX16D8cxgZSrhZwA8FdHTj67GHw0qi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CvojuvDVolRZkDDlIyj4uY5hFwD/G9sunkTM46WaLCaS3QIrYNL/Um2wFEN1Efbub
	 AMgqrgm0WuuDyTu9RFhh8PxIVWprskRaMfCAUwhNw8adtnNMYHs5Bky4OntLrV86/Q
	 XmU2feeoZdQm8hdpDIY+BLbeIyzFOjK2HbobG5a9E+yEpXx9TfaYR70WhcumYdlH5T
	 HkCWSMxrchak5K5WPOkEkbPG2H9CmhaW1116sshIwrG/ZnK1AyARzAH5rYoKYuS2Jk
	 AqxoyHMYpNvvuolbdXa2aaLMFmQjd42lAcZqTp8w5LAgtmHV3I+9GZc8lkKE5jXWtd
	 swfGIM6q8sjVg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 39ce6c8b;
	Fri, 5 Jan 2024 17:20:44 +0000 (UTC)
Date: Sat, 6 Jan 2024 02:20:29 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix oops in NFS
Message-ID: <ZZg6XQOjlOA0CL17@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1197168.1704465212@warthog.procyon.org.uk>
 <ZZgBcJ7OAS7Ui6gi@casper.infradead.org>

Matthew Wilcox wrote on Fri, Jan 05, 2024 at 01:17:36PM +0000:
> host on /host type 9p (rw,relatime,access=client,trans=virtio)

David Howells wrote on Fri, Jan 05, 2024 at 02:33:32PM +0000:
> > This commit (100ccd18bb41 in linux-next 20240104) is bad for me.  After
> > it, running xfstests gives me first a bunch of errors along these lines:
> 
> This may be related to a patch that is in linux-next 20240105, but not
> 20240104 ("9p: Fix initialisation of netfs_inode for 9p").

Yes, you'd be reading zeroes without that patch because the netfs code
thinks the file has 0 size and doesn't bother reading, that'd explain
the exec format error loading other modules...

One thing that surprised me is that this also affects cache=none, I
thought we had different file ops going straight to p9_client_read in
this case?
But turning my brain on this would be the read-only mmap case that we
need to support for execs, which module loading also uses, so this came
biting there alright.

-- 
Dominique Martinet | Asmadeus

