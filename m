Return-Path: <linux-fsdevel+bounces-59016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CCB33EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3195D486F2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932942EF659;
	Mon, 25 Aug 2025 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UourJz26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819126D4EE;
	Mon, 25 Aug 2025 12:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123756; cv=none; b=rs8vjaLtfg2FwVVACgtdNsRz9MkBzUdJYpCI/7uK2vqldlKWl4nv0eGYLpvtgaViC8TWi42VOX0s6O8QgfFwGg+dTAhbYGJyb8GsRZiDDTufihkhme9slSmh3jUUitpJrIuHG+drOUDx3RBNLuHx2xp2joJox7F95g5FVlJhABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123756; c=relaxed/simple;
	bh=ukf0T702yUd0YZiGL6Fl439f6DIXC++Ou3GI58MKZik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0xg9PbACCtOCplo5Y2SURC75Jv4pJYk1uIW4oQZ+xkaqths6pQ2+8D/MHE2iBi58MnLtkgjTKe80b4Wt5Sego18Jj9eGpx6bgDTCJedQ5sel6Wa/bwpF2zKJCdN1XMX/O5TxocgUhBRGdgs4DXlJLz+Fh2+EfjpxdZ8HVzAwYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UourJz26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107F2C4CEED;
	Mon, 25 Aug 2025 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123755;
	bh=ukf0T702yUd0YZiGL6Fl439f6DIXC++Ou3GI58MKZik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UourJz265cDHrFkqvb2caRIDnyZn8Sv3WCSLYEUpBItvDpU7xvhunZfLfxaplTols
	 ENDm11TDJ0D9arez/Ov4TWjGaznpNlh57IrhyXQIvYgI2BHsxmfwuLaUYx9OPrj25n
	 KzccqcwKxL9W46GTToqj+oHfoVXOrOeBsYdtQdaTPIwvJg8mfbUssN9zIq1qkI7w1Z
	 Dc6UKvzbU0MMwVmI+5YpIgTavNzRksxJ0QpcXhQd339a2ZOwJLjMeTdE47E4aqvxtk
	 onnV+wQGzCtm69yACFDcE0D6rtLKrZbCfaLlB3j1H0BpI+WlrkeW+cELcFg011jUJM
	 ZnliBr00NeUVw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Use try_cmpxchg() in start_dir_add()
Date: Mon, 25 Aug 2025 14:09:10 +0200
Message-ID: <20250825-lammfell-nagetiere-0a136b1acbe2@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811125308.616717-1-ubizjak@gmail.com>
References: <20250811125308.616717-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=brauner@kernel.org; h=from:subject:message-id; bh=ukf0T702yUd0YZiGL6Fl439f6DIXC++Ou3GI58MKZik=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSsCUo/7e/wjXXHcQah/3kFVRe1qmMcVrvpLrYsbjA9v s/X+9q+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsWMbIcGjvgfbJs9peSuwX ymsX9eY/ef3D240TfCQj2/0XsP5ZosPIMMltOUfE0yeVnNv25p3ZLDvxjtXlhcnTgg06Lm/52v2 pjxMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 14:52:38 +0200, Uros Bizjak wrote:
> Use try_cmpxchg() instead of cmpxchg(*ptr, old, new) == old.
> 
> The x86 CMPXCHG instruction returns success in the ZF flag,
> so this change saves a compare after CMPXCHG (and related
> move instruction in front of CMPXCHG).
> 
> Note that the value from *ptr should be read using READ_ONCE() to
> prevent the compiler from merging, refetching or reordering the read.
> 
> [...]

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] fs: Use try_cmpxchg() in start_dir_add()
      https://git.kernel.org/vfs/vfs/c/14498ca7e0f1

