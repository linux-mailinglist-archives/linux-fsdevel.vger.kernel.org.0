Return-Path: <linux-fsdevel+bounces-62491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6AB9574A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FCB19C0252
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E4321440;
	Tue, 23 Sep 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwKNqmqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F453224F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623967; cv=none; b=i7dDtdN+i2L6cAWpv0AzjinwjsckpgcWBzQTz/kFQm9Kx2mUHaZcOwSkHYJb3gN45R4SI9jqWF6uK9Cm+luD6Z+GTjqHQ5k0rzXFCxgMFyDw7Oov/efqafhY7UsSrNyZiMP/QcKEJQwjaLAq92kApg3z0wm0JcyKYSM5a6F+NWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623967; c=relaxed/simple;
	bh=YAQOH3DX4sYE4MQfuZ+rDrH4LEghglpCA+SzwnM69ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ7uKqJBTnHNyvmZPw+PEv3OC/IjLWSeuYjpHJA7rbgnpwS9pEZdaC5YNo48vHCHbJa7XswyFQKtxGaQadvpXLwWKzIHISe3zB7Azh9ocRnNAxIQg4TNTn16pRepc1kg2HoeDesaZS/ygiarBvT0clANNBGhzKLyRlWLOB5wr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwKNqmqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9F1C113D0;
	Tue, 23 Sep 2025 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758623966;
	bh=YAQOH3DX4sYE4MQfuZ+rDrH4LEghglpCA+SzwnM69ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwKNqmqjjDDHDmyECQxlAkNG0pRMwo0BS+P8PpDLicOT55PQuSyanMps5zEyUvPfl
	 h99QK+Wy4M/3kPo+VETY86SJsrnJmZOxgW9k2MDLYPblqcCZt93kKkWw34EajB3Lk0
	 ZsbrZKVmmK5rWK91wH6WfoLOBYBemfw2AI+mTURpL4sDXjYLkuqXVsqm+zCdINAzjF
	 guCiaak9w1PNXF/TIK0W9+1rQM+Fe5VKOea7RhFzb9MDXYD3grSca56pFFw1jc4oHZ
	 AO1XLlDQoof1SiXTjXy7teR9BNJjspAQwAZOwltpnSv/YDTqqV1ccbNC8MO+/JEorL
	 ke5YvMBd1Yy9w==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4 1/6] VFS/ovl: add lookup_one_positive_killable()
Date: Tue, 23 Sep 2025 12:39:12 +0200
Message-ID: <20250923-liquidieren-soloalbum-06669081a8d3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922043121.193821-2-neilb@ownmail.net>
References: <20250922043121.193821-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=brauner@kernel.org; h=from:subject:message-id; bh=YAQOH3DX4sYE4MQfuZ+rDrH4LEghglpCA+SzwnM69ao=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcqrjZ9NA0WeOi0Nk3lhPLONe5KOmnaTGft/26vf56C UuWjCRDRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETqTzAybL3HYSOyOPX7uYda BhkR62Oz1s6+vOh87n+Z7bmZiwq4djMy3FJbeEFL6DXf1drZIhIbvy3aO3dDlOyFeYUbLJunXuV t4QQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 14:29:48 +1000, NeilBrown wrote:
> ovl wants a lookup which won't block on a fatal signal.  It currently
> uses down_write_killable() and then repeatedly calls to lookup_one()
> 
> The lock may not be needed if the name is already in the dcache and it
> aids proposed future changes if the locking is kept internal to namei.c
> 
> So this patch adds lookup_one_positive_killable() which is like
> lookup_one_positive() but will abort in the face of a fatal signal.
> overlayfs is changed to use this.
> 
> [...]

Applied to the vfs-6.18.async branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.async branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.async

[1/6] VFS/ovl: add lookup_one_positive_killable()
      https://git.kernel.org/vfs/vfs/c/17eb98d6b517
[2/6] VFS: discard err2 in filename_create()
      https://git.kernel.org/vfs/vfs/c/e66ccd30dcdc
[3/6] VFS: unify old_mnt_idmap and new_mnt_idmap in renamedata
      https://git.kernel.org/vfs/vfs/c/d7fb2c410240
[4/6] VFS/audit: introduce kern_path_parent() for audit
      https://git.kernel.org/vfs/vfs/c/76a53de6f7ff
[5/6] VFS: rename kern_path_locked() and related functions.
      https://git.kernel.org/vfs/vfs/c/3d18f80ce181
[6/6] debugfs: rename start_creating() to debugfs_start_creating()
      https://git.kernel.org/vfs/vfs/c/0a2c70594704

