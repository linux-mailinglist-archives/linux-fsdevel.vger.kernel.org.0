Return-Path: <linux-fsdevel+bounces-8052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789882ED86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4781F232C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9B1B7F6;
	Tue, 16 Jan 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9W+EX4i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1A1B7EE;
	Tue, 16 Jan 2024 11:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F180BC43390;
	Tue, 16 Jan 2024 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705403806;
	bh=12enHdEQYZDZ3C3XmaZ8fBP/gSRyAW+Pnt48jGr3N8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9W+EX4iPCkfSggIM6tLa4X83v9iG3ko2x80brb3RSZ3tFwDl/PWDQ7B/ybrZJSbG
	 Q0oIghDVEAbqIQRG06yYr+bMYbg3w/FyK+zUHP0Fqz2liEH0y9bUKEqco+6LFNNdFK
	 VjLgJEKwmoGawPxcBgDFZBtXSGxoG5wXfae3nbweJLAxn8V2Lxgm/PJxx1jOZ5IfME
	 ohvRqWe1YOLrTPFuVu1TFsVcYdbZhknRYgr5fUI4ZBtefv6PrPwWM3n/jZXDzeKZXM
	 Xu9cJ7NbShP6gooMahRvQpnA4p+qJbZq1AYyRh9yp0bVaUv6DQyXfmYvKbTYPzuPUt
	 jfCH0OeErIgng==
From: Christian Brauner <brauner@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	willy@infradead.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH] fs: improve dump_mapping() robustness
Date: Tue, 16 Jan 2024 12:16:35 +0100
Message-ID: <20240116-privat-zeitplan-21db23926f45@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
References:  <937ab1f87328516821d39be672b6bc18861d9d3e.1705391420.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=brauner@kernel.org; h=from:subject:message-id; bh=12enHdEQYZDZ3C3XmaZ8fBP/gSRyAW+Pnt48jGr3N8k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQuS53GOe9+OOsFtl72fJE94u7z6uW7Gc+KuBakhl9Iu lUxYdbKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInM8mNk2Mn+2tRK0n3Lte8r F+SXnLf++N5bYuE8JUnn1IUdTxLqJjH8M8/xFLd2faYb+WfisRkq55O5Li61N03cF5TaaBWq17i cEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Jan 2024 15:53:35 +0800, Baolin Wang wrote:
> We met a kernel crash issue when running stress-ng testing, and the
> system crashes when printing the dentry name in dump_mapping().
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> pc : dentry_name+0xd8/0x224
> lr : pointer+0x22c/0x370
> sp : ffff800025f134c0
> ......
> Call trace:
>   dentry_name+0xd8/0x224
>   pointer+0x22c/0x370
>   vsnprintf+0x1ec/0x730
>   vscnprintf+0x2c/0x60
>   vprintk_store+0x70/0x234
>   vprintk_emit+0xe0/0x24c
>   vprintk_default+0x3c/0x44
>   vprintk_func+0x84/0x2d0
>   printk+0x64/0x88
>   __dump_page+0x52c/0x530
>   dump_page+0x14/0x20
>   set_migratetype_isolate+0x110/0x224
>   start_isolate_page_range+0xc4/0x20c
>   offline_pages+0x124/0x474
>   memory_block_offline+0x44/0xf4
>   memory_subsys_offline+0x3c/0x70
>   device_offline+0xf0/0x120
>   ......
> 
> [...]

Seems fine for debugging purposes. Let me know if this needs to go through
somewhere else.

---

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

[1/1] fs: improve dump_mapping() robustness
      https://git.kernel.org/vfs/vfs/c/30a1b9d12728

