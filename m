Return-Path: <linux-fsdevel+bounces-34200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9531E9C3A9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14916B21C1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B7175D3A;
	Mon, 11 Nov 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgPSPhwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F011016A959;
	Mon, 11 Nov 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316379; cv=none; b=hb4dNgDtEt1pzeC+FsijQ8uLvQsRo7zkF1/dQcTIDGdj3MbXr6A+HfcEnxqnfp7osEgZqDaidC7wvpGo+WDXgMSl5pGJH1oJz/qiEB4ybcaRSs7anMyWS5qrklr4JPBWqT7jrY78nsbRrg/1H9EgCo9S33Mfs/mN0YdPsuPKTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316379; c=relaxed/simple;
	bh=eLegIPzm6kl+o1xbtiBt0w/Vn129KLVaIrdkjfKYWaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACjyU5n7k2nOg9QueFtI6LYwdN8HtxLJhGJjoYSxR6XO6idLkWoAYYnD1pP5q1+TDcMLhkkC4pr+HZqBxd36ceJWFY3zkxwvCB2X9lZ8RRmozU3leoSy2J//PSIEdWT7pkSzGYxv7uYsKW0/4gj9jpk5fkiY/xxhRG38nOa912E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgPSPhwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D85C4CED0;
	Mon, 11 Nov 2024 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731316378;
	bh=eLegIPzm6kl+o1xbtiBt0w/Vn129KLVaIrdkjfKYWaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fgPSPhwKVCoHhP5ZUhqFPaUA3BckikO442jgj8GZjtPjAiQvZy2Zt8UJaqx4sZ4cn
	 tLQLnuNp8PDWRuevwPEyIHOAmeXYlFpVSIX3s7ozITJY1rKstBsCZlFlksJ0gw6tmS
	 kdvvTwHsIdFewza2NlXVyqYUKM9MykIn/gCPy6V7rfKaE5bePR/WM3+hqBWYTt+baE
	 ElCEQ+0slDPOh3YKguR0LIEL0eNaL2YyYEX/vSMtnmZZUKcDhQynA4VIMn0yTrjVZ3
	 fE5fwQWPiTHePSimVwb1JplWrql7brpCmIVXRpE7c1XmVUtvAeONSspLa67X4zbXJl
	 sD6sd7jx8WGRQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 00/33] netfs: Read performance improvements and "single-blob" support
Date: Mon, 11 Nov 2024 10:12:33 +0100
Message-ID: <20241111-kochkunst-kroll-f8386db7f273@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108173236.1382366-1-dhowells@redhat.com>
References: <20241108173236.1382366-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4915; i=brauner@kernel.org; h=from:subject:message-id; bh=eLegIPzm6kl+o1xbtiBt0w/Vn129KLVaIrdkjfKYWaA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbnuoTcJer1I9iZPy/KXnXkR3yzUvPeSUdKhatyKkPP 1/h4qTTUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHXyowMJ73NZvvz71XzWu/R kX/O6mpbvrbzAbX0naeF5dI9IzTqGRmeOOw/3D7HYsVKm7tHJ/g+THnPZ3IgVWj+mYxQHlHHyPM MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 17:32:01 +0000, David Howells wrote:
> This set of patches is primarily about two things: improving read
> performance and supporting monolithic single-blob objects that have to be
> read/written as such (e.g. AFS directory contents).  The implementation of
> the two parts is interwoven as each makes the other possible.
> 
> READ PERFORMANCE
> ================
> 
> [...]

Applied to the vfs-6.14.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.netfs

[01/33] kheaders: Ignore silly-rename files
        https://git.kernel.org/vfs/vfs/c/3033d243b97c
[02/33] netfs: Remove call to folio_index()
        https://git.kernel.org/vfs/vfs/c/f709cec9dc52
[03/33] netfs: Fix a few minor bugs in netfs_page_mkwrite()
        https://git.kernel.org/vfs/vfs/c/07a80742a52b
[04/33] netfs: Remove unnecessary references to pages
        https://git.kernel.org/vfs/vfs/c/53f5f31a1549
[05/33] netfs: Use a folio_queue allocation and free functions
        https://git.kernel.org/vfs/vfs/c/1d044b4cb3e9
[06/33] netfs: Add a tracepoint to log the lifespan of folio_queue structs
        https://git.kernel.org/vfs/vfs/c/7583f643f714
[07/33] netfs: Abstract out a rolling folio buffer implementation
        https://git.kernel.org/vfs/vfs/c/2029a747a14d
[08/33] netfs: Make netfs_advance_write() return size_t
        https://git.kernel.org/vfs/vfs/c/34961bbe07a5
[09/33] netfs: Split retry code out of fs/netfs/write_collect.c
        https://git.kernel.org/vfs/vfs/c/8816207a3e26
[10/33] netfs: Drop the error arg from netfs_read_subreq_terminated()
        https://git.kernel.org/vfs/vfs/c/44c5114bb155
[11/33] netfs: Drop the was_async arg from netfs_read_subreq_terminated()
        https://git.kernel.org/vfs/vfs/c/3c8a83f74e0e
[12/33] netfs: Don't use bh spinlock
        https://git.kernel.org/vfs/vfs/c/5c962f9982cd
[13/33] afs: Don't use mutex for I/O operation lock
        https://git.kernel.org/vfs/vfs/c/244059f6472c
[14/33] afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
        https://git.kernel.org/vfs/vfs/c/10e890507ed5
[15/33] afs: Fix directory format encoding struct
        https://git.kernel.org/vfs/vfs/c/c8f34615191c
[16/33] netfs: Remove some extraneous directory invalidations
        https://git.kernel.org/vfs/vfs/c/ab143ef48b3b
[17/33] cachefiles: Add some subrequest tracepoints
        https://git.kernel.org/vfs/vfs/c/46599823a281
[18/33] cachefiles: Add auxiliary data trace
        https://git.kernel.org/vfs/vfs/c/499c9d489d7b
[19/33] afs: Add more tracepoints to do with tracking validity
        https://git.kernel.org/vfs/vfs/c/606d920396fd
[20/33] netfs: Add functions to build/clean a buffer in a folio_queue
        https://git.kernel.org/vfs/vfs/c/823f8d570db5
[21/33] netfs: Add support for caching single monolithic objects such as AFS dirs
        https://git.kernel.org/vfs/vfs/c/5ae8e69c119a
[22/33] afs: Make afs_init_request() get a key if not given a file
        https://git.kernel.org/vfs/vfs/c/bfeb953ddf0b
[23/33] afs: Use netfslib for directories
        https://git.kernel.org/vfs/vfs/c/2b6bae4ca558
[24/33] afs: Use netfslib for symlinks, allowing them to be cached
        https://git.kernel.org/vfs/vfs/c/a16c68c66f52
[25/33] afs: Eliminate afs_read
        https://git.kernel.org/vfs/vfs/c/b84e275b6da2
[26/33] afs: Fix cleanup of immediately failed async calls
        https://git.kernel.org/vfs/vfs/c/355d07737082
[27/33] afs: Make {Y,}FS.FetchData an asynchronous operation
        https://git.kernel.org/vfs/vfs/c/e31fb01515da
[28/33] netfs: Change the read result collector to only use one work item
        https://git.kernel.org/vfs/vfs/c/1bd9011ee163
[29/33] afs: Make afs_mkdir() locally initialise a new directory's content
        https://git.kernel.org/vfs/vfs/c/4e93a341aec1
[30/33] afs: Use the contained hashtable to search a directory
        https://git.kernel.org/vfs/vfs/c/08890740b1d7
[31/33] afs: Locally initialise the contents of a new symlink on creation
        https://git.kernel.org/vfs/vfs/c/d4f4a6bde676
[32/33] afs: Add a tracepoint for afs_read_receive()
        https://git.kernel.org/vfs/vfs/c/f06ba511d8d5
[33/33] netfs: Report on NULL folioq in netfs_writeback_unlock_folios()
        https://git.kernel.org/vfs/vfs/c/19375843912f

