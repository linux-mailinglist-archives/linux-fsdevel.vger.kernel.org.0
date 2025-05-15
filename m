Return-Path: <linux-fsdevel+bounces-49120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC8AB83A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B31A1BC1C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54AC297A4B;
	Thu, 15 May 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYQyQZxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19572297B60;
	Thu, 15 May 2025 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747304103; cv=none; b=TWZ4QHrD9gRLOwwMSUu7zoPc7DPOmSGh+P76rKQzK7AIWJ1k/7982xFYA3lYqNBjNpI2OjmhOBgybnTrvCjimiLy3C6hXzdqpINJDLjlYP36ZLh4MBcAWI1cUgQZZOX2IvNEZlgaD3/Y9IhA7wJbmw6jpjZTw6pWki+2VX3je1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747304103; c=relaxed/simple;
	bh=R6mphUTOSX/2JhAwvUojWFzDj+Z0x2A5QDAVFnWi0us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgeuNCIJu9Pj6nm6rEsjFgr1AN3QUA5olGjnD123j6eibkXH9If/51mfg9EkYZdlonWd30kNUeWf9NxHxQJSI48bhteYs9gPFHiFTtVR2R36AJKT34gvkBMfXqcA0IyWiS6YVBl8clu9TK4Mbiw4uND/AIDI/z6z5tJ/jU3tl4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYQyQZxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4227EC4CEE7;
	Thu, 15 May 2025 10:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747304102;
	bh=R6mphUTOSX/2JhAwvUojWFzDj+Z0x2A5QDAVFnWi0us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYQyQZxZLkTYUi+q1fvYrpd7L03kG7AH/bgAP3zLNs798GtdZzqlz/PHDWYM0HbPi
	 9XEbMqmpRwLKpJ4w0NsprMvSgEbKGQi4foj9PoxfSu+cryiHd+JduNZ0a2262hzea6
	 3CiQ2/2g+Gb2XPia1skP8xI6xVnmpzrqGA89U2HuxafqG+GGXtWMdZ1vrOQjQkH5hN
	 FCnILuB2eMrXx3eW0hMqN8R70CDX+Bj5M/pjH7ZUI94g7iUQzLMJ8imqHjkSelf4Xn
	 qmSGmlX3+18TEcTauqQDY7iAl3+nWMyNe/sQk2Qymnwnu2ZDPHnJ3LPNge3X+sqD4G
	 fYQuUo2jfoLDA==
From: Christian Brauner <brauner@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/3] Use folios for symlinks in the page cache
Date: Thu, 15 May 2025 12:14:57 +0200
Message-ID: <20250515-abwarten-legehennen-7eb82a17183e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514171316.3002934-1-willy@infradead.org>
References: <20250514171316.3002934-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=brauner@kernel.org; h=from:subject:message-id; bh=R6mphUTOSX/2JhAwvUojWFzDj+Z0x2A5QDAVFnWi0us=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSo7lt01LjY58EGL6U/TNtqtv+RVt0tqXHkvkdGNY/69 9f3v9zI6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIjhbDf8+wk++P+k+Wmf1B mCVBK5HH0vzfPv4fipE6mgdfqsbz/2dkaFnCp5fhc9BDKDhcTteEa5XrjZW68uK9/ZMmNiteE8l iBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 14 May 2025 18:13:11 +0100, Matthew Wilcox (Oracle) wrote:
> FUSE already uses folios for its symlinks.  Mirror that conversion in
> the generic code and the NFS code.  That lets us get rid of a few
> folio->page->folio conversions in this path, and some of the few
> remaining users of read_cache_page() / read_mapping_page().
> 
> If anyone's concerned about all the extra lines in the diffstat, it's
> documentation that I've added.
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/3] fs: Convert __page_get_link() to use a folio
      https://git.kernel.org/vfs/vfs/c/5f152cc012f4
[2/3] nfs: Use a folio in nfs_get_link()
      https://git.kernel.org/vfs/vfs/c/cc8e87f312e0
[3/3] fs: Pass a folio to page_put_link()
      https://git.kernel.org/vfs/vfs/c/4ec373b74e96

