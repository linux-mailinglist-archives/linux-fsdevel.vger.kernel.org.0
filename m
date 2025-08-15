Return-Path: <linux-fsdevel+bounces-58032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3CB281CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7785E500D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF70D22A808;
	Fri, 15 Aug 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrtaHYEA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D8224247
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268203; cv=none; b=K2wL1tGrHnx1BOp4uw7ppUz2ByQWteUn9uTaOjJDyl5UxyUBSECKVlohpbiQFi5MmlDxq2q3JS7OpHm0zkiULKGjalIkfu1WBw9UC6CXgO8AuwthNy70nHki3pHpIBeYSM+ptkCHOAIJHShBUPlUUgGm+qV5rXkS3npRW9FoQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268203; c=relaxed/simple;
	bh=z/Rojt1rqB5YZDqPCQ/VaENIWhVOa+GpUgH+I6AqbaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBLO64t2f+L/we+uA2ki0AJuQrXYKoJKiOrOaq/kVjDNpSLWG9owYgj7nz/UjfUK/OCzwEaBIUhtq4yEAK90+JAWkbYUBLq1lNc6ENCC6yKlMdJpT4vIdE59fL5lh8uUK54DwPe3sEc3CJFvNYceHJU7irRvcVJop6RyPFqIsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrtaHYEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD9DC4CEEB;
	Fri, 15 Aug 2025 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755268202;
	bh=z/Rojt1rqB5YZDqPCQ/VaENIWhVOa+GpUgH+I6AqbaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrtaHYEA90Koem1kehK6ZsSB7goOBkU0rBrfUP1qFPD2R+9pezT0a2+vNBrjpZdUe
	 VM4qGUSTpdoJIiivtc0kBPQUxSDV53POWhK7z9sAmsTUDHuie9gsvXz6PFw87tGu7e
	 xaJvfKrCtIPu4q9x4rPNOoiNeqF/rJng+py43rU1lYeSbC6AfLJ1SAC9YHN91cn8JW
	 JJcfY0ZP3e8mc6p/2yRVw6CisXCoI+YbOv3BB/4awD/9KI+rMqiERQNaTcTk01Xj+V
	 74DX9YdWBEcKeGs3+0cQ6mKCi89sQ0ASdHnTVNm0me7N+v62NrBGdB2Jh3fNirDrEb
	 UlHr9RGpEOlDg==
From: Christian Brauner <brauner@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH RFC] fs/buffer: fix use-after-free when call bh_read() helper
Date: Fri, 15 Aug 2025 16:29:46 +0200
Message-ID: <20250815-nieselregen-anpacken-4d4cbfce2d2e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811141830.343774-1-yebin@huaweicloud.com>
References: <20250811141830.343774-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643; i=brauner@kernel.org; h=from:subject:message-id; bh=z/Rojt1rqB5YZDqPCQ/VaENIWhVOa+GpUgH+I6AqbaU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTMd0lj+p4782+63pkDqrvnb/335gX/gpVf73+bkDu1+ vkJ/oP7mTtKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmcq6NkaF36qMFynMO+gWd 5GX3k3VaKPaRvfbnvY0fE79zVNrN8pNg+Gf0tvjiiU0zriecf+vydXaM04PzdyS9/kRvZxdSN/q 9oZEPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 22:18:30 +0800, Ye Bin wrote:
> There's issue as follows:
> BUG: KASAN: stack-out-of-bounds in end_buffer_read_sync+0xe3/0x110
> Read of size 8 at addr ffffc9000168f7f8 by task swapper/3/0
> CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 6.16.0-862.14.0.6.x86_64
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0x55/0x70
>  print_address_description.constprop.0+0x2c/0x390
>  print_report+0xb4/0x270
>  kasan_report+0xb8/0xf0
>  end_buffer_read_sync+0xe3/0x110
>  end_bio_bh_io_sync+0x56/0x80
>  blk_update_request+0x30a/0x720
>  scsi_end_request+0x51/0x2b0
>  scsi_io_completion+0xe3/0x480
>  ? scsi_device_unbusy+0x11e/0x160
>  blk_complete_reqs+0x7b/0x90
>  handle_softirqs+0xef/0x370
>  irq_exit_rcu+0xa5/0xd0
>  sysvec_apic_timer_interrupt+0x6e/0x90
>  </IRQ>
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

[1/1] fs/buffer: fix use-after-free when call bh_read() helper
      https://git.kernel.org/vfs/vfs/c/fb6d0f63f46d

