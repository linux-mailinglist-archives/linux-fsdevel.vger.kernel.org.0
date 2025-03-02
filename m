Return-Path: <linux-fsdevel+bounces-42894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BA3A4B149
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0792A16CCCE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF91D89E3;
	Sun,  2 Mar 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOBHMKkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858681D88BE;
	Sun,  2 Mar 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740916386; cv=none; b=aQSuOeI9xafA9QtLf6ZMqH4V7Yz3Wid/6EynwQSpkpVI9DBozBefdzUMfzZfHTa5LmJ+UrB8QZo+X0XoD+ZbBfLsKgBsIbmP+zt0u5xD6++0/Q0W6vX81gSn7xx4k5fxH9D7LsJ3B+Wryjrmz8jRWxOQWGD8L7sPC7eKaw7jhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740916386; c=relaxed/simple;
	bh=UC9uH7d0Nj32FTC8LwH3y3Y6TcrIhnYbvJ0s8EBx8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjsCXybHVZQKAP4sj/gb4X568P8BXtbcCJLSHvR+sfO//GhTJUejUbx+b3TRQiiURUSxPrBHVs0KBrNi97y70uTdtf6pBqYyWtb3HiL/YpqNiyQV+eelxpYsNkRGgkFmOGjsMh9UstDMieZ0HPG1ykXrElism+1aIT/7iBcpGws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOBHMKkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB946C4CED6;
	Sun,  2 Mar 2025 11:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740916385;
	bh=UC9uH7d0Nj32FTC8LwH3y3Y6TcrIhnYbvJ0s8EBx8x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOBHMKkpzuKspgtMuDYG2WEbUAeTZq4ECF7+BBZtcvMGeDHbNJVyCrNTv8jFlYYxm
	 WWZJSg5pwDbbMkezgXUna5GH8PH5DEB8YZj4/sdGGF69zmRS+p/ewzgmUWriXMewn5
	 qXHEp0ggl+wUBJulGjbSjJh/3exqChJlhNdWTWnAgtIZ+zywaXcFn9oTsnt+Hp+1dg
	 N8AXoeLDddj/ThZya3QykT3DMi/ffNiiJDaDIkDytHma1OBHmmOJjcR5N6Tw+s9x2K
	 JPl7P0NwqNmBqRGYT2IiVX4h0XxnWlLf5We7Q+9w+r1FpICXi16nVP+5oVdXU0wuzU
	 oDcAlSxLduUUQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: predict no error in close()
Date: Sun,  2 Mar 2025 12:52:52 +0100
Message-ID: <20250302-computer-unbezahlbar-dfc476460fc3@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301104356.246031-1-mjguzik@gmail.com>
References: <20250301104356.246031-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=brauner@kernel.org; h=from:subject:message-id; bh=UC9uH7d0Nj32FTC8LwH3y3Y6TcrIhnYbvJ0s8EBx8x8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfcZs9Wzwv7AqHp+gSuRs53dZMnfv5jur4CmV6hM1uq 7s+P+xERykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUljMy9HVP+8sdcKvZ7sbn 239O9VWKnNh9Y6qQzpXQwidT3ig0TWb4pxD8fv+8D3rHl7zKN732d82C+UVrN4hODD5+4vL60y9 /VvIBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 01 Mar 2025 11:43:56 +0100, Mateusz Guzik wrote:
> Vast majority of the time the system call returns 0.
> 
> Letting the compiler know shortens the routine (119 -> 116) and the fast
> path.
> 
> Disasm starting at the call to __fput_sync():
> 
> [...]

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

[1/1] fs: predict no error in close()
      https://git.kernel.org/vfs/vfs/c/c7f3ef71a2db

