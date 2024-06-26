Return-Path: <linux-fsdevel+bounces-22488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EE9180D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9400B27130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0117181BB8;
	Wed, 26 Jun 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pri+ihHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE017F51C;
	Wed, 26 Jun 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404375; cv=none; b=JjdSoyPUzIl7oOhARfRrOQbunN3qwOcw+5HmeNcVqfJZAqEqv/6BJUF/1Ov9aL0q2RXbB49tKZNGAb4xz3OGpsJbH31STZnEB/ClQd4n/tllzXNp831bTyKK29wgl9vU5a9dfWcGWoy+VtC0CyBynvZKsuLF770jtQNbwBW39bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404375; c=relaxed/simple;
	bh=+a6cKOTvjBqwaDCkw+KkodDw+TAU6VuT99/mNKvMi/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyUkwDNyOUMuuHTxK5qFzb1Fu84ovanaqJ3CI8g06kK8Dn1sbETPpPlDCK23sNv1ADj/MCiYksShRsYPcWps1XXryWLZ9LyAN9iUEI7ydj997UuYJ6qI/MPQEFLsUw1r44jV6cJvkSW2I4OBpnS5AkS6MSi21mS4pLW1AuMx2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pri+ihHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA674C2BD10;
	Wed, 26 Jun 2024 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404374;
	bh=+a6cKOTvjBqwaDCkw+KkodDw+TAU6VuT99/mNKvMi/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pri+ihHX6LCjoCWfssh1KMC23/kENbI3RJR/QRgf5v1PH+ivyNER4s3d4Y4Ei9wdZ
	 R9wpkRQL5fDkRmkGBcetNtjmbny16WrQt51T62EmpyxJ22VicfdS8GNzFwvOFzfO4H
	 xgn9oLBAzKDwK8EiYEhNUwii6WUaJup+13qLAPWjh8+621zQVTVVK3ga5ofgCNtnvy
	 AiX14y4WmlQfj2MxHsIKbHQE2Mje7Nhhuu5wG7SJpNGR8njRbHxiJ9hD/BITvLibiR
	 auK1zl6EfHYXdpsWHYdprFvHnFmoPMqm3iwygWG8LbwMZFWOvkOeVCteF8T6y6GU/0
	 ypdq2Pr9emrVg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
Date: Wed, 26 Jun 2024 14:19:24 +0200
Message-ID: <20240626-kennen-westseite-0c15ed37b7a5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <780211.1719318546@warthog.procyon.org.uk>
References: <614257.1719228181@warthog.procyon.org.uk> <780211.1719318546@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=brauner@kernel.org; h=from:subject:message-id; bh=+a6cKOTvjBqwaDCkw+KkodDw+TAU6VuT99/mNKvMi/o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVsPsxi/x9Fmk/c4KNgkXyZiG7vkmT1jWVhYnnml4Ki ZBerBPdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHDV4wMh77GvnLqe1bMGLjb +s+3rABXy/7zq4QPtkbkXnk5/bbTZob/5SnPvHyijp+5nbLx9wdRzQPnpbkvfVljY/2vgi8x7mc fGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 13:29:06 +0100, David Howells wrote:
> 
> Fix netfs_page_mkwrite() to check that folio->mapping is valid once it has
> taken the folio lock (as filemap_page_mkwrite() does).  Without this,
> generic/247 occasionally oopses with something like the following:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
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

[1/1] netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
      https://git.kernel.org/vfs/vfs/c/a81c98bfa40c

