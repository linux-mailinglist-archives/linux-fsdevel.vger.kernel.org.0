Return-Path: <linux-fsdevel+bounces-7438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E5824DC8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 05:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123EE1C21F72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5E4566A;
	Fri,  5 Jan 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTLZVg7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DD5242;
	Fri,  5 Jan 2024 04:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mJPEL62eVi84Xk7Scl6XWRFXGzmJNpF/Y9oGJQjtN1Y=; b=VTLZVg7nKMZm2KMb7lg5o9PvD5
	EuqpAOQdauiVq2ESgt9amfX38XAf1Eqi30RKATfAQwiC/S26DRQe7Xg551K/uydbVKqSrYBHhgzkQ
	HZGLojzYHxm4D70Yt265+wjirR1nF8dkpWKbkjDzu7U75qpfE0vlUkN07fYxHbtZEcVQ/SNlbqES4
	/MN3Pbux3ZFtP4r+fR6Y2T67jx1rtDwl0HLQy38FmRaUjcNxCm0kup5Lqq9a7ASB4vAHdaJN08D6G
	7RUGVMngFqMssgEZomd1Shj2d37M6lrh7x3H+GYVkuVoLkd8u/f15GD5BFjMiqwewHWlMm3/pAaZ/
	DtD0tYiw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLcBs-00GuHr-UY; Fri, 05 Jan 2024 04:52:17 +0000
Date: Fri, 5 Jan 2024 04:52:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix oops in NFS
Message-ID: <ZZeLAAf6qiieA5fy@casper.infradead.org>
References: <2202548.1703245791@warthog.procyon.org.uk>
 <20231221230153.GA1607352@dev-arch.thelio-3990X>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-38-dhowells@redhat.com>
 <2229136.1703246451@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2229136.1703246451@warthog.procyon.org.uk>

On Fri, Dec 22, 2023 at 12:00:51PM +0000, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > A better way, though, is to move the call to nfs_netfs_inode_init()
> > and give it a flag to say whether or not we want the facility.
> 
> Okay, I think I'll fold in the attached change.

This commit (100ccd18bb41 in linux-next 20240104) is bad for me.  After
it, running xfstests gives me first a bunch of errors along these lines:

00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/fs/gfs2/gfs2.ko: Exec format error
00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/fs/zonefs/zonefs.ko: Exec format error
00004 depmod: ERROR: failed to load symbols from /lib/modules/6.7.0-rc7-00037-g100ccd18bb41/kernel/security/keys/encrypted-keys/encrypted-keys.ko: Exec format error

and then later:

00016 generic/001       run fstests generic/001 at 2024-01-05 04:50:46
00017 [not run] this test requires a valid $TEST_DEV
00017 generic/002       run fstests generic/002 at 2024-01-05 04:50:46
00017 [not run] this test requires a valid $TEST_DEV
00017 generic/003       run fstests generic/003 at 2024-01-05 04:50:47
00018 [not run] this test requires a valid $SCRATCH_DEV
...

so I think that's page cache corruption of some kind.

