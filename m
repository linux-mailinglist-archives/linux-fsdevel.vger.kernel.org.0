Return-Path: <linux-fsdevel+bounces-3205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D27F154B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D91282554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E31C29B;
	Mon, 20 Nov 2023 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSzhxryf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CF1BDF0;
	Mon, 20 Nov 2023 14:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DF0C433C8;
	Mon, 20 Nov 2023 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700489266;
	bh=S8qMgQ1EMUfvTUZrcDS8da/H/870w/2xeU9rsXS2ds4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSzhxryfS07MGtiYgKdA/KgvpJFBhySuqf49RrifpV8CtbmOpbCqJtDW4keAuKtJx
	 LpDr9JK6X7KHjMgFRsVyEn8IlsR+g0I90s7hNYxWqpp62eBumzAksnIMk/hZQV7Bhh
	 QRK+W/EQZTn8vzEb+USqMO98d1bKoOR5eeTho2jxFKHUTniP9QIEKL3YtPn9F/TQuR
	 fe/9oDTbrvwxGOKtGSzoz4CUhTteSf4cEpqXQsTlBGSO/r1wqBDQ56iWFpWvyCJPPA
	 1QysZD+ofQfaDMKoO2uD3CmW2hQYBkIkYSvkbIDE6AyUCz50ZGz+tnsWnw6EWtABuT
	 L+1f87OfP8/JQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: add and use a per-mapping stable writes flag v2
Date: Mon, 20 Nov 2023 15:07:01 +0100
Message-ID: <20231120-unnachahmlich-dachwohnung-c5d469db965a@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025141020.192413-1-hch@lst.de>
References: <20231025141020.192413-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=brauner@kernel.org; h=from:subject:message-id; bh=tN1Ke32NvKBFArsZFJBbxJjPjUX5X5jdMMtUAgN7p5o=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRGZ7DM95vs8sLQd/3VZRPV5T0b3xQwPI6ZmF/bEWoWu JvV58mpjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImENzIyLJxlsur5rnRrCXXB T6INaxU2H9/qxxd+dPJ22Ted+mqsvYwM11+13XPNeLT4z6JtD3Tmy7p+P5XRz8WyuTrRraj7h4o pHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 25 Oct 2023 16:10:16 +0200, Christoph Hellwig wrote:
> A while ago Ilya pointer out that since commit 1cb039f3dc16 ("bdi:
> replace BDI_CAP_STABLE_WRITES with a queue and a sb flag"), the stable
> write flag on the queue wasn't used for writes to the block devices
> nodes any more, and willy suggested fixing this by adding a stable write
> flags on each address_space.  This series implements this fix, and also
> fixes the stable write flag when the XFS RT device requires it, but the
> main device doesn't (which is probably more a theoretical than a
> practical problem).
> 
> [...]

Ok, I've picked this up now. Let me know if this needs to go through
someone else.

---

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

[1/4] filemap: add a per-mapping stable writes flag
      https://git.kernel.org/vfs/vfs/c/cb293ec9f897
[2/4] block: update the stable_writes flag in bdev_add
      https://git.kernel.org/vfs/vfs/c/743958a2f50b
[3/4] xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
      https://git.kernel.org/vfs/vfs/c/f04f350d39eb
[4/4] xfs: respect the stable writes flag on the RT device
      https://git.kernel.org/vfs/vfs/c/60fc2887c158

