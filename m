Return-Path: <linux-fsdevel+bounces-42841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1CFA49722
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 11:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D31188C3E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61E25E473;
	Fri, 28 Feb 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZy1Ll95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BD25BADA;
	Fri, 28 Feb 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738173; cv=none; b=R6vKQ22axQ+uFkUhVwH+VMVJ+s8zrFVnlCRh9Rz9NK8yMnJNPuAVX86+b76pp36hzZYTPof7ksiJ0qRCAce8dfQTpDS+/bhu8R4Jk0CdLYy6/MKryVpTk9wWaUvZmmcFpVkTj48G2Vqwl/1fgx3KEw1x713usozLvSzQrt5yj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738173; c=relaxed/simple;
	bh=TDGi4nu6CBnjZ08J2SjCtYhqNzs7LnfkQBYG9bn62X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS4ELLcJALQ940wASgql0Iry+azD2NZ1cmFxeI7CHJpD6w6/OKNLQtWWd+0i7T5cVtLouu7EhAkrBXgboSVF1EpJAirlS5LzmUDTbyZ6M3E9LJNuj5SUboCxiEZKE+Giqv4/iJnIBLCjCRQ7F+qeDm8h5pIHgXkLPX36ApskiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZy1Ll95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E2C4CED6;
	Fri, 28 Feb 2025 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740738172;
	bh=TDGi4nu6CBnjZ08J2SjCtYhqNzs7LnfkQBYG9bn62X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZy1Ll95a0QCSjG0lUGu0FevLb+DA3eYbfs6ZK0uv0ZKbqivkDfECLiIE61JGmU3j
	 HF52yuH4hG42PVOaJ3kqkzzqWn1YRH4XZjINkJ3JfWq1ai22RBH6ohq/YU+EXbL3Dt
	 2SUiymUqk3VdulEDcm1fQ6iKTrQa6v1BEjph9Hy0KcE5JLzwUGpyDWYYVyPSaj8jF7
	 WITTy2mGWOK3tZ1nNWonJf9iE5vPrC7qWUszy5KAGaSzsO/jf5oW6ZMcfOYw+wHRBP
	 OrbyuTgFjCOOLUPofj7vTEFT2qLaLUrpm1+6y5Zlv0OM3rP+TSbWBuJjoGt9Tki0L8
	 B5rHl3Jg/aTLA==
From: Christian Brauner <brauner@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 0/9] Remove accesses to page->index from ceph
Date: Fri, 28 Feb 2025 11:22:38 +0100
Message-ID: <20250228-witzfigur-geerntet-589bdf7ae13f@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185119.430193-1-willy@infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=brauner@kernel.org; h=from:subject:message-id; bh=TDGi4nu6CBnjZ08J2SjCtYhqNzs7LnfkQBYG9bn62X0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQf7Cu6ba2x5eu1GWcdZadcdXftPjhJfdvXPy6Tzmi4H uM5Jqe8raOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiF+YxMlxa+klF6uZjuecV nZ2al1bPuXQm8ajFsppvRt6FW+bwTbvH8N/RbM+85TX37b88DStO2fKcgXuF6pWqzO9yBSuNy/o WSrICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 18:51:08 +0000, Matthew Wilcox (Oracle) wrote:
> This is a rebase of Friday's patchset onto
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
> as requested by Dave.
> 
> The original patch 1/7 is gone as it is no longer necessary.
> Patches 2-6 are retained intact as patches 1-5 in this patchset.
> Patch 7 is hopefully patches 6-9 in this patchset.
> 
> [...]

Applied to the vfs-6.15.ceph branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.ceph branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.ceph

[1/9] ceph: Remove ceph_writepage()
      https://git.kernel.org/vfs/vfs/c/19a288110435
[2/9] ceph: Use a folio in ceph_page_mkwrite()
      https://git.kernel.org/vfs/vfs/c/88a59bda3f37
[3/9] ceph: Convert ceph_find_incompatible() to take a folio
      https://git.kernel.org/vfs/vfs/c/f9707a8b5b9d
[4/9] ceph: Convert ceph_readdir_cache_control to store a folio
      https://git.kernel.org/vfs/vfs/c/baff9740bc8f
[5/9] ceph: Convert writepage_nounlock() to write_folio_nounlock()
      https://git.kernel.org/vfs/vfs/c/62171c16da60
[6/9] ceph: Convert ceph_check_page_before_write() to use a folio
      https://git.kernel.org/vfs/vfs/c/15fdaf2fd60d
[7/9] ceph: Remove uses of page from ceph_process_folio_batch()
      https://git.kernel.org/vfs/vfs/c/a55cf4fd8fae
[8/9] ceph: Convert ceph_move_dirty_page_in_page_array() to move_dirty_folio_in_page_array()
      https://git.kernel.org/vfs/vfs/c/ad49fe2b3d54
[9/9] ceph: Pass a folio to ceph_allocate_page_array()
      https://git.kernel.org/vfs/vfs/c/d1b452673af4
[10/10] fs: Remove page_mkwrite_check_truncate()
        https://git.kernel.org/vfs/vfs/c/9dcef93363e7

