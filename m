Return-Path: <linux-fsdevel+bounces-6175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C033E814795
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 13:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF141F21CDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC432C68B;
	Fri, 15 Dec 2023 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEdkeyJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086725572;
	Fri, 15 Dec 2023 12:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97454C433C8;
	Fri, 15 Dec 2023 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702641806;
	bh=HBrttvezNQe0QQVMwijBpOeV4YQmzTr0YV92KoJQ8ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEdkeyJ+YkOxXK7th6GRD7Su1DsGpLwnVcFzG3pqhXXV6sI6Tn6btiHFay3VqWF+h
	 T+lrgu/3HmiLtAI0QKKQ62wvS1K4bOc0BGKCu+rJ3MHBjANlPTc1cgwbhuu7Qs0qxa
	 LVYHmvsKnnzSWcXuVttKC63psYuNX0maV8G8MjvrciytdpGH7Yvdza/mcYRZ1Ni4Kf
	 sy+F5V7FcG6mbiknZbtPYM54eM9rsKahjq0oe2NL7D6gXgGlUJDU/D9a80iEYIRvaS
	 5x2NrNfBun9TS+2Hac++AYbPUvA/6Rtpn4/d+HKcTvbMkziwMRKyPObJkJCT4XoKGN
	 305s520nTspaQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>,
	David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/39] netfs, afs, 9p: Delegate high-level I/O to netfslib
Date: Fri, 15 Dec 2023 13:03:14 +0100
Message-ID: <20231215-einziehen-landen-94a63dd17637@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=6217; i=brauner@kernel.org; h=from:subject:message-id; bh=HBrttvezNQe0QQVMwijBpOeV4YQmzTr0YV92KoJQ8ZE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTWODS2Tfm66uSZXeJqJUsnCukueuim0bUrM61+qxbj4 TCO/EdGHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNxkGD4Z8bHlZptWDLtokYW 6+zLF4+csT+Y/8qobP1VpUfHVsZ6FzH8U2Pb/zzyZqDya7H3sT/98l8W3bEPlJEzjP+6P/tTSOk NFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Dec 2023 15:23:10 +0000, David Howells wrote:
> I have been working on my netfslib helpers to the point that I can run
> xfstests on AFS to completion (both with write-back buffering and, with a
> small patch, write-through buffering in the pagecache).  I have a patch for
> 9P, but am currently unable to test it.
> 
> The patches remove a little over 800 lines from AFS, 300 from 9P, albeit with
> around 3000 lines added to netfs.  Hopefully, I will be able to remove a bunch
> of lines from Ceph too.
> 
> [...]

Ok, that's on vfs.netfs for now. It's based on vfs.rw as that has splice
changes that would cause needless conflicts. It helps to not have such
series based on -next.

Fwiw, I'd rather have this based on a mainline tag in the future. Linus
has stated loads of times that he doesn't mind handling merge conflicts
and for me it's a lot easier if I have a stable mainline tag. linux-next
is too volatile. Thanks!

---

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[01/39] netfs, fscache: Move fs/fscache/* into fs/netfs/
        https://git.kernel.org/vfs/vfs/c/94029f4c6459
[02/39] netfs, fscache: Combine fscache with netfs
        https://git.kernel.org/vfs/vfs/c/77eb7aa4805e
[03/39] netfs, fscache: Remove ->begin_cache_operation
        https://git.kernel.org/vfs/vfs/c/a7f70e4b4ebf
[04/39] netfs, fscache: Move /proc/fs/fscache to /proc/fs/netfs and put in a symlink
        https://git.kernel.org/vfs/vfs/c/131e9eb7bd1f
[05/39] netfs: Move pinning-for-writeback from fscache to netfs
        https://git.kernel.org/vfs/vfs/c/1792e1940f54
[06/39] netfs: Add a procfile to list in-progress requests
        https://git.kernel.org/vfs/vfs/c/1491057f69dc
[07/39] netfs: Allow the netfs to make the io (sub)request alloc larger
        https://git.kernel.org/vfs/vfs/c/6c3efd20150f
[08/39] netfs: Add a ->free_subrequest() op
        https://git.kernel.org/vfs/vfs/c/e0b44a08ac20
[09/39] afs: Don't use folio->private to record partial modification
        https://git.kernel.org/vfs/vfs/c/9d2a996de9a2
[10/39] netfs: Provide invalidate_folio and release_folio calls
        https://git.kernel.org/vfs/vfs/c/6136f4723a2e
[11/39] netfs: Implement unbuffered/DIO vs buffered I/O locking
        https://git.kernel.org/vfs/vfs/c/1243d122feca
[12/39] netfs: Add iov_iters to (sub)requests to describe various buffers
        https://git.kernel.org/vfs/vfs/c/a164fd03f073
[13/39] netfs: Add support for DIO buffering
        https://git.kernel.org/vfs/vfs/c/669e8c33691d
[14/39] netfs: Provide tools to create a buffer in an xarray
        https://git.kernel.org/vfs/vfs/c/c554dc89292d
[15/39] netfs: Add bounce buffering support
        https://git.kernel.org/vfs/vfs/c/476c24c3e80b
[16/39] netfs: Add func to calculate pagecount/size-limited span of an iterator
        https://git.kernel.org/vfs/vfs/c/25d0f84de71d
[17/39] netfs: Limit subrequest by size or number of segments
        https://git.kernel.org/vfs/vfs/c/53ee4e38619a
[18/39] netfs: Export netfs_put_subrequest() and some tracepoints
        https://git.kernel.org/vfs/vfs/c/ac3fc1846a06
[19/39] netfs: Extend the netfs_io_*request structs to handle writes
        https://git.kernel.org/vfs/vfs/c/90999722fa0b
[20/39] netfs: Add a hook to allow tell the netfs to update its i_size
        https://git.kernel.org/vfs/vfs/c/27dfd078db66
[21/39] netfs: Make netfs_put_request() handle a NULL pointer
        https://git.kernel.org/vfs/vfs/c/0ffd2319fb64
[22/39] netfs: Make the refcounting of netfs_begin_read() easier to use
        https://git.kernel.org/vfs/vfs/c/f7125395caba
[23/39] netfs: Prep to use folio->private for write grouping and streaming write
        https://git.kernel.org/vfs/vfs/c/acadf22234e3
[24/39] netfs: Dispatch write requests to process a writeback slice
        https://git.kernel.org/vfs/vfs/c/17c2b775e3f4
[25/39] netfs: Provide func to copy data to pagecache for buffered write
        https://git.kernel.org/vfs/vfs/c/dd6ed9717a0b
[26/39] netfs: Make netfs_read_folio() handle streaming-write pages
        https://git.kernel.org/vfs/vfs/c/c958b464f07f
[27/39] netfs: Allocate multipage folios in the writepath
        https://git.kernel.org/vfs/vfs/c/6076cc863769
[28/39] netfs: Implement support for unbuffered/DIO read
        https://git.kernel.org/vfs/vfs/c/9409fe70ca46
[29/39] netfs: Implement unbuffered/DIO write support
        https://git.kernel.org/vfs/vfs/c/7acd7b902241
[30/39] netfs: Implement buffered write API
        https://git.kernel.org/vfs/vfs/c/7b1321366337
[31/39] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
        https://git.kernel.org/vfs/vfs/c/d156da6e235c
[32/39] netfs: Provide netfs_file_read_iter()
        https://git.kernel.org/vfs/vfs/c/899ae1e25a64
[33/39] netfs, cachefiles: Pass upper bound length to allow expansion
        https://git.kernel.org/vfs/vfs/c/52882c158a30
[34/39] netfs: Provide a writepages implementation
        https://git.kernel.org/vfs/vfs/c/02bf7b4afdba
[35/39] netfs: Provide a launder_folio implementation
        https://git.kernel.org/vfs/vfs/c/cf4e16d98659
[36/39] netfs: Implement a write-through caching option
        https://git.kernel.org/vfs/vfs/c/7bf6f13f4a63
[37/39] netfs: Optimise away reads above the point at which there can be no data
        https://git.kernel.org/vfs/vfs/c/fad15293bd0d
[38/39] afs: Use the netfs write helpers
        https://git.kernel.org/vfs/vfs/c/0095df30ad7b
[39/39] 9p: Use netfslib read/write_iter
        https://git.kernel.org/vfs/vfs/c/361e79613421

