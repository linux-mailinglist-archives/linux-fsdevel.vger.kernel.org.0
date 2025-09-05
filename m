Return-Path: <linux-fsdevel+bounces-60359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D04B459E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1E1CC38DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45E735E4FA;
	Fri,  5 Sep 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDh3QCZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454B35E4E1;
	Fri,  5 Sep 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080612; cv=none; b=qz3kW9V4eu4QEWARPEpUC4AT4QL2hDsmYkHYpXSxu/57hvU6/mhKIWWjOK3Xf55qzyBPvnNxfeE6YE25HHRsircZKItToD0KdsilaRrAoyymRqPtVl5Re4jG9MVt19tIFtWNLNcThz/cQavVJ+uxJHZbNRgKc2sOzIatkMIic4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080612; c=relaxed/simple;
	bh=1hGzZmdSJuzP6spOIHTVvRRo8NvllbiyNgNqPn97QRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svtmM0v8ZaEuz6bWgbJ+2NoNz8fmipwtOE5UzYFzBegf628PxDmz2G2MfgSfqk1QF/Jt2KLWRfetymrt7Yx94LQkAVTG4kltObkwTbo85A2lkPfeo9nXfe1pwTyoXuJLA2PMKOTwrlewgbeC3VubUE041JQ+QEZVcsbS3b81Fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDh3QCZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CD5C4CEF1;
	Fri,  5 Sep 2025 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080612;
	bh=1hGzZmdSJuzP6spOIHTVvRRo8NvllbiyNgNqPn97QRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDh3QCZsHal0nfKVKiKhtfcfsqwRmVQVOYhj+FFcwmyIIXx8vo4av1o20+NpQ6S5D
	 0IJiWYqaGqwgT9w5qluI13urzk17W3xfoqse3h1Yxafcd6Kh9r4K/oYz6FiVG8zQ8p
	 gCxAyG5otPef4WWbi95PY3Enc6ZTE+D4D0COGQNF6jTOSECS5P/nUbVpKoydV1/RjM
	 irEjFYHWw0GI+yOejyTiHxwOgkQr1JNRKqGZfriwOMIvm0s9RMdYq3PXSBbQemKkSH
	 P8NnUtlyV6Z69age1VkFMIujuaDqEMGuYa79i6460y+dKoc6OeiVgVs8dzQTD7pzoV
	 SYCkBkdyUU/FQ==
From: Christian Brauner <brauner@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] fuse: virtio_fs: fix page fault for DAX page address
Date: Fri,  5 Sep 2025 15:56:40 +0200
Message-ID: <20250905-einsicht-berglandschaft-8d4c6a189aa1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904120339.972-1-haiyuewa@163.com>
References: <20250904120339.972-1-haiyuewa@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=brauner@kernel.org; h=from:subject:message-id; bh=1hGzZmdSJuzP6spOIHTVvRRo8NvllbiyNgNqPn97QRA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTseiOnflv19CROG+fp5+tSaqyOm4bWPmmcZqKT9frB9 ftGLpW/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbykIHhv9vPR7cv2HZzfUir 2+J//smsrxuFvwso53J1WJbxi+894svwVzbcZNZBgY2lNUX/dmj07njYWqIvocRwlWFjQ+TK3D2 Z3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Sep 2025 20:01:19 +0800, Haiyue Wang wrote:
> The commit ced17ee32a99 ("Revert "virtio: reject shm region if length is zero"")
> exposes the following DAX page fault bug (this fix the failure that getting shm
> region alway returns false because of zero length):
> 
> The commit 21aa65bf82a7 ("mm: remove callers of pfn_t functionality") handles
> the DAX physical page address incorrectly: the removed macro 'phys_to_pfn_t()'
> should be replaced with 'PHYS_PFN()'.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fuse: virtio_fs: fix page fault for DAX page address
      https://git.kernel.org/vfs/vfs/c/e1bf212d0604

