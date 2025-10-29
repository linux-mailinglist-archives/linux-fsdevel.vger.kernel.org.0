Return-Path: <linux-fsdevel+bounces-66313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9AEC1B983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3377F6217DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFB22FABF5;
	Wed, 29 Oct 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6i+Tpv8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3F2C0F7B;
	Wed, 29 Oct 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749618; cv=none; b=NSoVANkLGskMXfU0iHrLzZ3fzRvHOggDgaAfM26GRVD5K1Zr1zyolyh7e/9Aqsc4Y09Oy9+lhLd4uf5z7k1PaOs+VR0scIDqTdj5wQBkFvKDzIyRhUAat+dhNkkfqSPJhDoFqi/tDTuJAG27Xf/MWfC7j0HoOBjgzp5QJvfE+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749618; c=relaxed/simple;
	bh=4N52YreIUF0OvAY3AgVuCEeEXHoxvfXQKpRpGqGXt0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qTF/08hMBurk2hPwiIPkUZwmEy9OIzZyGfzUNdQj5E0gGxLFwX+tqQp907bMfRzXXyl/gekmuswJXYIETm6t0bFAc454qrV8pVgSrG445q/6IeGFWhm6YGVB85fuoq/lBa1dRg1sAjIp826mzPY8Dbp9LxT4iVr7mngzjE0GAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6i+Tpv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75851C4CEF7;
	Wed, 29 Oct 2025 14:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749617;
	bh=4N52YreIUF0OvAY3AgVuCEeEXHoxvfXQKpRpGqGXt0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6i+Tpv81I+RjXv1z/ZhRypcIVRTtXraq5U9iBWHQnvW+KkPDvGl1y2pSEVEa6fIB
	 Ln4x6wF3AkfAIwedEj981+iIN+wR6+btNH1aNeYDoUlV+PjuWWLC2qWuazlwsZDUyc
	 w6JEXBhDvgpuQ5ndnBinokI18XbR2srsXkcfTy4nMLpLT5LYAeO4NgeFX7Rl3DUghg
	 Y+Yu9YxHcIql1AYDpRrZVpwWLKrTXwOqAs1s25OG2ooUXYEvx3zM1w82Fg077igDaB
	 eTslPtXRVVOcLbKtU1sdxtLF6P6BiY2N2GMT83pc272G20lW+5PvUy3M8NbUj0mjMG
	 oZaRyJXLYf5Iw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: filemap_* writeback interface cleanups v2
Date: Wed, 29 Oct 2025 15:53:19 +0100
Message-ID: <20251029-fahrdienst-klaglos-834e266b8e42@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024080431.324236-1-hch@lst.de>
References: <20251024080431.324236-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522; i=brauner@kernel.org; h=from:subject:message-id; bh=4N52YreIUF0OvAY3AgVuCEeEXHoxvfXQKpRpGqGXt0Y=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyaaVPuJ+i9m4br2nk2mOv3Hiqzuq8kEi/LX5pZ5Jpp 1hLQ0l0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESObmZkePvsGoekGs9rdpbt ZmmmOZrb/hx/6K49NePTtSDdi8HVvIwMl5ZenxV508LqDt+pO5cidkrwHHy3v/970ayNXZffekh 4MAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 10:04:11 +0200, Christoph Hellwig wrote:
> while looking at the filemap writeback code, I think adding
> filemap_fdatawrite_wbc ended up being a mistake, as all but the original
> btrfs caller should be using better high level interfaces instead.  This
> series removes all these, switches btrfs to a more specific interfaces
> and also cleans up another too low-level interface.  With this the
> writeback_control that is passed to the writeback code is only
> initialized in three places, although there are a lot more places in
> file system code that never reach the common writeback code.
> 
> [...]

Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.writeback

[01/10] mm: don't opencode filemap_fdatawrite_range in filemap_invalidate_inode
        https://git.kernel.org/vfs/vfs/c/a21134b5d6cb
[02/10] 9p: don't opencode filemap_fdatawrite_range in v9fs_mmap_vm_close
        https://git.kernel.org/vfs/vfs/c/3c2e5cee5eb3
[03/10] ocfs2: don't opencode filemap_fdatawrite_range in ocfs2_journal_submit_inode_data_buffers
        https://git.kernel.org/vfs/vfs/c/890f141da068
[04/10] btrfs: use the local tmp_inode variable in start_delalloc_inodes
        https://git.kernel.org/vfs/vfs/c/41e52c644753
[05/10] btrfs: push struct writeback_control into start_delalloc_inodes
        https://git.kernel.org/vfs/vfs/c/c9501112e3cb
[06/10] mm,btrfs: add a filemap_flush_nr helper
        https://git.kernel.org/vfs/vfs/c/7fabcb7fbabb
[07/10] mm: remove __filemap_fdatawrite
        https://git.kernel.org/vfs/vfs/c/735965144806
[08/10] mm: remove filemap_fdatawrite_wbc
        https://git.kernel.org/vfs/vfs/c/1bcb413d0cd8
[09/10] mm: remove __filemap_fdatawrite_range
        https://git.kernel.org/vfs/vfs/c/45cbce5b8877
[10/10] mm: rename filemap_fdatawrite_range_kick to filemap_flush_range
        https://git.kernel.org/vfs/vfs/c/c28d67b33cbf

