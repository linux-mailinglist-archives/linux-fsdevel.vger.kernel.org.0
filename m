Return-Path: <linux-fsdevel+bounces-50046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72640AC7BB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 12:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECE3A25C4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690BC227EA0;
	Thu, 29 May 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSi2q9Nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E32A55;
	Thu, 29 May 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514487; cv=none; b=s6OHAoRnym84UHVyUDcHpXndN2oPa+iIzDgIx36vznGeXXPQ3C2bgjBCBKJsMXQw48cSyq4TXYKUpLI+DJ6CX6jKyn2hpheDUUTJYrs9jlj+ZMBfKpjpfdljlhgF1x7sGcsPWvACLOemZMyUXxDmSucU/FPfc8T6FSTnxo6pl2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514487; c=relaxed/simple;
	bh=a13uHYLcSVY+Hd898nP8GF1NRi16EX51gglkpLkL028=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8km3q3msYIdIxlQV2rcQ+Xxefdg33S9c29u/PefMWv+QjySjZYXZAUqGGnpzCMfmF7F97yo+kMM6bizOl9jnloCgdXFF7B1CrmnMq3J6mEhBc02WupP6g8tCUJamZ5PJbF1q6fClSPOlvO7vXV4te2pO8U347n+FYSt4gIXXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSi2q9Nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF60C4CEE7;
	Thu, 29 May 2025 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748514487;
	bh=a13uHYLcSVY+Hd898nP8GF1NRi16EX51gglkpLkL028=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSi2q9NuE40SHt3Ifu4u3buqAQhVgbguuU3c+Olj6ROrIoyuBZDNiePK9MkheH0DG
	 PB9sUsrs2ib+Cxu3jl4uzwBirVnytneWD0egW/L7pEjoj5dlH+miQ0Uqfhj/ilCPyz
	 1N1WZpEHR+1+kX+yBIZnGVyxV+43Z3G6ZeOSwABTNQOmbB/p0PCbpr5vtc6WtCR4TH
	 nfALRasKEtJ5XFz36YkbporMMkbSs3oBst0zpVx8g6dq7yhF0J/jSeXQ4/AED5Rzbu
	 P/8sTLOhrEPR/4NqDbpYDfdPPa4mshyTXB+DFlFNlSdH6kb37bBOACn4FbOtSUNNb6
	 +OYJm+6FnKhDg==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] iomap: don't lose folio dropbehind state for overwrites
Date: Thu, 29 May 2025 12:28:00 +0200
Message-ID: <20250529-ausholen-zersetzen-e4bd9675fc54@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <5153f6e8-274d-4546-bf55-30a5018e0d03@kernel.dk>
References: <5153f6e8-274d-4546-bf55-30a5018e0d03@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=brauner@kernel.org; h=from:subject:message-id; bh=a13uHYLcSVY+Hd898nP8GF1NRi16EX51gglkpLkL028=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYmG1KWLdkiWltvcT+hMn7ZJ7LbTuTs10m9oem8v5pf 46H7fx1qqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiBnWMDDcmSN9YLrJ/aYfA Mr6WCEUHU0fm0t6egLniS6XunPXdsp2RYU2k/4P1684sODIv7fjf06Jz6jNXVd9/qCpUc/T3f/V +DiYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 May 2025 17:01:31 -0600, Jens Axboe wrote:
> DONTCACHE I/O must have the completion punted to a workqueue, just like
> what is done for unwritten extents, as the completion needs task context
> to perform the invalidation of the folio(s). However, if writeback is
> started off filemap_fdatawrite_range() off generic_sync() and it's an
> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
> don't look at the folio being added and no further state is passed down
> to help it know that this is a dropbehind/DONTCACHE write.
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

[1/1] iomap: don't lose folio dropbehind state for overwrites
      https://git.kernel.org/vfs/vfs/c/34ecde3c5606

