Return-Path: <linux-fsdevel+bounces-31530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E99982C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAF71F224C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494681BDAA8;
	Thu, 10 Oct 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHKv48xA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7B1BD4F7;
	Thu, 10 Oct 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553733; cv=none; b=tYzGzHOU0v/1q9uojMQRCTYE5oMCqGGKXU8K2Bbz3eLkCErlzBpRyv1sDsPI6r7sS5lTxjcKUIOhM7f9WoaFGYi946iUZ6Pc5n3k33oCcN+R+6FyWI5NLeOZ4R91ziNghr5bLfZ++pj7prkeAIgAnOF8PxQ3USOcpRFVgdOreLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553733; c=relaxed/simple;
	bh=DZHX/dOTGTTWmHSD7EGIIvqgPoTlZrjsUh+D2k6vutc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbOUt2Qig6B8i3x/LKpSuhIZ/zsKYoLh3X/0kjOxXoebWr7+L1qCb3Ij7OzBMzT0FeLey+BxahDhgkoLZapHtlFvn/oOoBDrv5+v/wJJbWbig27g9LC2oGBN8yNIlObqsU0kdaxolwvlScs/w1gXoFMTo2Z+77bDAyHKO3G1oNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHKv48xA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16561C4CEC6;
	Thu, 10 Oct 2024 09:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553733;
	bh=DZHX/dOTGTTWmHSD7EGIIvqgPoTlZrjsUh+D2k6vutc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHKv48xAGWgbyleVsFTzt8YP+w0xQOUPTLbUmoIl5sP0HFJ9QnHG5B5tqaEv7ELKd
	 9UprnO4fTAK11YvzpndvancYqPFj8L8o5Rt5q0iaYcdsmL2hl72jV2dziDVWGDGOec
	 Fs8b3l7VJUHCVOqxDIbDnqtwaDGMDdxmdwkY8wDqKNiZflZXZLsDLAnVkr3vjJnU3g
	 p8zpxFw6Gmc+XpnxIM3j6FBFpPt55rhSx8JsVMYyAj5BguEp3BOhTvwCDq+TO9hA5M
	 hZHgCf6Mt/tPYpcGgYA2zvlQC2dFAm7HcE8aFn5oQQ/DyK/Lv5JE2yLvuQmoD8CDnh
	 48Ngqb/jUEdMQ==
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] fs/super.c: introduce get_tree_bdev_flags()
Date: Thu, 10 Oct 2024 11:48:36 +0200
Message-ID: <20241010-bauordnung-keramik-eb5d35f6eb28@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=brauner@kernel.org; h=from:subject:message-id; bh=DZHX/dOTGTTWmHSD7EGIIvqgPoTlZrjsUh+D2k6vutc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzL/qz2fGNauqe95Hf7NR+CBgGNB28P+H1lc1fzmxfx L7Gpi3dpKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAih+QZGZ41//LavdTmmXmy Qb2ZpsNBp6+OZV2V5lwHbbmPPkqUb2FkmPu9pMm47Wxut3tZxd07uVMDahem6Hv7S/A+YZv16aw EEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 11:31:50 +0800, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_flags() to specify extensible flags [2] and
> GET_TREE_BDEV_QUIET_LOOKUP to silence "Can't lookup blockdev" message
> since it's misleading to EROFS file-backed mounts now.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/2] fs/super.c: introduce get_tree_bdev_flags()
      https://git.kernel.org/vfs/vfs/c/f54acb32dff2
[2/2] erofs: use get_tree_bdev_flags() to avoid misleading messages
      https://git.kernel.org/vfs/vfs/c/83e6e973d9c9

