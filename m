Return-Path: <linux-fsdevel+bounces-33063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AB9B3089
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A051F210C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477E1DA31F;
	Mon, 28 Oct 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql0dlzhw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881534C83;
	Mon, 28 Oct 2024 12:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119274; cv=none; b=ewUS8rqmXal0jiAs7Cv0VgmRNqTo3NHbMcJFnVhoke33UGK50U1m6KO5j7dDLK9XA6/JIHb0oC3sU2DnHCTHhe3eA3/ej4TbJA0YGIkxXl3x3ikb7Iiddx8xfKjxJ5/9mJpxhx/9TCxdJeMxv503DVum9iidPVwOjeQZqGieot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119274; c=relaxed/simple;
	bh=bZuEglKDOjZNBOrJVtiQqz7AMNZWK2RhVSZWBNWNwys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9DDDwfSnfiXT1FPnfyXQH9te19GGC8CBI1KwwVIGU+TSb4MQq2EJ8PfvasqhBh2w8enRjlN2CRgiM/99JieV3D3EzUBS3lXxHuZHqz4Mq1fYMANpC41MllC6jK1vQWygkuX3jaukio512ho/J9kOPWOnDqBu/+DdUVFSGCanvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql0dlzhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB43CC4CEC3;
	Mon, 28 Oct 2024 12:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730119273;
	bh=bZuEglKDOjZNBOrJVtiQqz7AMNZWK2RhVSZWBNWNwys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ql0dlzhwYEguQ9IWl+y5rgXE/woq2d6vj+VTApVdyVxJhLxGlzpCImQ66ND0ppXkw
	 1tg2361KwcQOhbnAiX7ZS579bQFejbtSDPiiEn7VZfLPxyOHx0dEenD1pkcFbMd3Eh
	 POlLHzc5NZ+EsjV1EoRMtdAEdJxxqtnW3kpnOrcVsX9UwQF8juO1B1GMOSRKJopaFU
	 7fDXJZTREMgmLasNOorp7X5g9sPJ9VhznhliNskLkZE0hJcfKfDLf0hxltlqWr/8HD
	 /rmp42CvUdlTY1Dcpyaa61ne4uJzSVHy0b26HMR6oYoxxXmm5ou0deI9S1B3Qnnl1T
	 3AZaEm7CSIBvg==
From: Christian Brauner <brauner@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP
Date: Mon, 28 Oct 2024 13:41:06 +0100
Message-ID: <20241028-gulasch-gestiegen-3b9502e5fbcc@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
References: <dd5f0c89-186e-18e1-4f43-19a60f5a9774@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=brauner@kernel.org; h=from:subject:message-id; bh=bZuEglKDOjZNBOrJVtiQqz7AMNZWK2RhVSZWBNWNwys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTLtyVN3n33ZIhNyomEKRXvu63e3r107pHjZF33cAau5 I+lkU+KO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay/y/Df9dST+UbM58nlZ3o /bXT+mhsLIvPiTMf/FQk/ZhtJNlmbmT4wyF24/KzX6k6/2/bSsxdcU5JfL1K8Y31F8sPBPTf9Uu 4yAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 27 Oct 2024 15:23:23 -0700, Hugh Dickins wrote:
> generic/077 on x86_32 CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y with highmem,
> on huge=always tmpfs, issues a warning and then hangs (interruptibly):
> 
> WARNING: CPU: 5 PID: 3517 at mm/highmem.c:622 kunmap_local_indexed+0x62/0xc9
> CPU: 5 UID: 0 PID: 3517 Comm: cp Not tainted 6.12.0-rc4 #2
> ...
> copy_page_from_iter_atomic+0xa6/0x5ec
> generic_perform_write+0xf6/0x1b4
> shmem_file_write_iter+0x54/0x67
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

[1/1] iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP
      https://git.kernel.org/vfs/vfs/c/c749d9b7ebbc

