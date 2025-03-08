Return-Path: <linux-fsdevel+bounces-43514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF5A579F7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 12:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE12416DD87
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E034C1B0F26;
	Sat,  8 Mar 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB3+pvja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B11A8F82
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Mar 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741432888; cv=none; b=Wxr78SkjdWZryqjht+ejSHvNG/hAqVU9C/HcVOijmP7TZml0LIBY1s68R6tAxzOGI9ZfPo+9j0+f5+UjDBj18R7qQ37YM0Roq2BN9lrD9k1Tr0vd/WpcNbabWZ679x+9c026k2kD+5ZERviHDghahMgT/UG8sCfnePYQTJHZvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741432888; c=relaxed/simple;
	bh=uqP9Op5huw/IhAzHmD/Drs07QEpWYcM9Om/AK7lcyaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZZpDPnIQITI1RnQoTytiwcDqTe4BXMb2+jpu9tdIfxgvZz0Ji+5FLhmG5xpGlIv5SHjYDJqYPRffGCVE/Noxj9Tz3Z0XPbtIOZRvYXvCCLNpGh9HVQKM+lju+BLyZ/+nehE/Ux1/Hrg4g57H+hBdO37+sDKPVaLgOUJkcpWc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB3+pvja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F60FC4CEE0;
	Sat,  8 Mar 2025 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741432887;
	bh=uqP9Op5huw/IhAzHmD/Drs07QEpWYcM9Om/AK7lcyaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oB3+pvjaQa6gJhzTYgTwsq96xEV3RkQOJBmufZIcxHLZZmQdFoMvGokmHZqVrIG2F
	 2bR5RDZJrA/L6Qi+qUHZlm8ZU2CgwTvC0xE3xJwr/jEzIyt1kXSFrkSkxZjirejcv/
	 S9IlZwKsMa0QgxWIv6NOataM7z2MQXGZWFe79xfnL6PuDDYo7nY0x3oqd4B10Z5J6B
	 0ETvTYN4xXcoFAEwMREGbfx7sVTRX8C0XKWFuZ84W57tdKZ50AyI6jHizyLdvx+KtK
	 Utz3Us7htsiPCB5oIW5XU7vk3BCYXxBFw6y0N5wadQ5oIA9VnAeYuQh0SzxY7dRhfZ
	 BhDkppNJnq+wA==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] vfs: Remove invalidate_inodes()
Date: Sat,  8 Mar 2025 12:21:18 +0100
Message-ID: <20250308-vormittag-mundwinkel-f49254bf6312@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307144318.28120-2-jack@suse.cz>
References: <20250307144318.28120-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=brauner@kernel.org; h=from:subject:message-id; bh=uqP9Op5huw/IhAzHmD/Drs07QEpWYcM9Om/AK7lcyaY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSf0TBM/SPuUVTHaHZfZv/ETldBq+CYCV19UxJkIxduK Y3Z53Czo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKzQhj+F03/9lz+AX922rbV ln3cS7JVdee/9Jtu8P4v83pJzScdBxn+yhXs+sqzTu6PZH6U4uZ5/Uv6vqrmLfmxKWVn3y7+oJm fGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 07 Mar 2025 15:43:19 +0100, Jan Kara wrote:
> The function is exactly the same as evict_inodes() and has only one
> user.
> 
> 

I've changed commit message and added a new entry to
Documentation/filesystems/porting.rst.

---

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] vfs: Remove invalidate_inodes()
      https://git.kernel.org/vfs/vfs/c/93fd0d46cbf7

