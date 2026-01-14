Return-Path: <linux-fsdevel+bounces-73769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95CD1FEFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 686DB3053A09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5413A0B0A;
	Wed, 14 Jan 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEXlux24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1138E121
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405637; cv=none; b=bivdotuowJX+djiyBo1MDch5bCNcR5gTD4QLXg7FIqOuSS4+eg2nqj8ZIQYKjLxfzGjTJtwmanWr7m+tJah+DfcV35lfFEQsM25BjhYkj2DGQA5CgLp81sCLGjejqPaTFcnb0eRclOdmXqk86eGLW/tPnN67QWwohBtsNThB2Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405637; c=relaxed/simple;
	bh=OP0v/aKTMEYgxvJqbYGPzzrNmlH7VH8YxfpJvCqThh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCVoxDoLHzKGAD3lvNgPgSrr8Vj7rURUUJMJbdkbm/xHCguR0GYUdL8+NmyTXOxcmqDrFhKFKvFwB4HevQFbPJC3ussCslpunMCkGfycgtOtrd6Hu6/cIZqY+9rxOSzLp/ZGsYxczIzJPOpI0l43463JY1ClneQ5cPr+pZtYiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEXlux24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665AEC19424;
	Wed, 14 Jan 2026 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768405637;
	bh=OP0v/aKTMEYgxvJqbYGPzzrNmlH7VH8YxfpJvCqThh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEXlux24yMpyh46Kw4S7agVUVIH36tRxTe5GQAV5wdFLhe2hko62FG4NZSQhjJo0x
	 aKZEhAKx7H2nSoDh7vGUm+WnVcrNOml9EodKbnDz/3lSp06PiEgDMw1YOkP0M3JI7b
	 5K9Kki1cwiJIFcTzierid3QsuGcu/79a7iF/WsXPVE5tXHWd4uNcrkohsc1RJLRVIM
	 54T1WoRyvSvlq7ILot5K46WGfP1cthNKhy875EhmiZtPbT25hyUs+iiBG9TuUZoRDn
	 y+MTD47oxyqVtLF+Gxmdh6OPIyado5PqeZZU/ArP/EpJBc5ZQYaupqKUs3hI9gGq4u
	 Ws38rwRo/ieDQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] initramfs_test: kunit test for cpio.filesize > PATH_MAX
Date: Wed, 14 Jan 2026 16:46:49 +0100
Message-ID: <20260114-wohnumfeld-hetzjagd-827a3ed0b441@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114135051.4943-2-ddiss@suse.de>
References: <20260114135051.4943-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=brauner@kernel.org; h=from:subject:message-id; bh=OP0v/aKTMEYgxvJqbYGPzzrNmlH7VH8YxfpJvCqThh4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSm72ps/P71Cc+H+dJCXDInpfLqPk1+Hxy0fOHdG3cWd zEv290yvaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiNW8YGeZZ2svP9g1dF8C7 7unWL1PfhRv0TL+xRp8/5O8Ome/SmoKMDMs0irbNueWWe3+x6KITtZFe6ownDmpcFb7gO4lvtqX Fdy4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 00:50:52 +1100, David Disseldorp wrote:
> initramfs unpack skips over cpio entries where namesize > PATH_MAX,
> instead of returning an error. Add coverage for this behaviour.
> 
> 

Thanks, I like the test for cpio unpacking. I think that's very valuable.

---

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] initramfs_test: kunit test for cpio.filesize > PATH_MAX
      https://git.kernel.org/vfs/vfs/c/5b6e22a5d937

