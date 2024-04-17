Return-Path: <linux-fsdevel+bounces-17121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDC8A820F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1B2844B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFDE13C9D1;
	Wed, 17 Apr 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdGvaeIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CC13C8EE;
	Wed, 17 Apr 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353231; cv=none; b=AGrbDgn4oH1pW4ekQfj3uBPDDzBhcL/GMr6XPrN+7Q2KMVfG5LehYtohN0WXK0FqifwR0uIMNvnIqdZU4A0+GZcLqmBTqMuE21bLTwskQ0pn5GjM2itlg/BLuhfz8spjIJnQCY3Yn+QgNbzSar8qU4k+f7CgcXcVpdOntgSeYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353231; c=relaxed/simple;
	bh=z8FhVtgetX6LUdFuYuwud6VwQ1GU1TH7FJteCQo1HBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrkJvss+Wa6t06zvBnRgGycFogVuSgbomWni8FDPvNHs/tKZ77ZV+PiAzn/Jd48tvxKAmvO3nNalCgZsI+eHjv/xftkBggDrP96JbbHErXcvjzk3MITUN5dku2DhI4PDbQi0aNvyx74Lifc2eFgbT3VR62yj4JnBA9fL8KJy4Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdGvaeIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF582C072AA;
	Wed, 17 Apr 2024 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713353231;
	bh=z8FhVtgetX6LUdFuYuwud6VwQ1GU1TH7FJteCQo1HBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdGvaeIPo+rdvJuwCI/5ibLrCzCKrqHk/PUjNtwX3H7VRIKV72/AGcHywfiKAXbrq
	 PCs3rlias7N0Qv+ltsfCgCvyqnvLHQifekEx3gvysBlc1Loi540AkvHCsABnJhRtax
	 VdnRPK5Ww3/8Alj/EQn1bF3fDaKLIHkf4xSNB2smo8cluF+jeCskZkZqDnlPQ71F3s
	 Z4I9DfICZiNSspeCbO1rXIta5/2E6z0k/KkGXpV5IjeoSGdH+AfKE2h8O0pYpf5+KZ
	 yPHBwtLMoQmNoqDfZD8pqDF6c0Gg3oo63FmPqxqawxvttRk5tA27p9pWubtmXItbRZ
	 fCcFASMUtTdWw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix writethrough-mode error handling
Date: Wed, 17 Apr 2024 13:26:51 +0200
Message-ID: <20240417-filmabend-matten-50d0cba545f5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6736.1713343639@warthog.procyon.org.uk>
References: <6736.1713343639@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=brauner@kernel.org; h=from:subject:message-id; bh=z8FhVtgetX6LUdFuYuwud6VwQ1GU1TH7FJteCQo1HBY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTJb/y38f3Nj+ytmktdNJX35xzYeHLFLj62taGfHqWFc cWdK2X26ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIZD1GhrO7umZK1fRuTcre Gnf7sN++9HVBSTU28vlsM33lDx1NK2f4w2tsOXNLqn/d5k8n766TifzjeCtQQSS8xcbPrY+r7/Z WTgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 09:47:19 +0100, David Howells wrote:
> Fix the error return in netfs_perform_write() acting in writethrough-mode
> to return any cached error in the case that netfs_end_writethrough()
> returns 0.
> 
> This can affect the use of O_SYNC/O_DSYNC/RWF_SYNC/RWF_DSYNC in 9p and afs.
> 
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

[1/1] netfs: Fix writethrough-mode error handling
      https://git.kernel.org/vfs/vfs/c/c70fd201bd29

