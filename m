Return-Path: <linux-fsdevel+bounces-10747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A739584DC95
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DE91F25A52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E506BB46;
	Thu,  8 Feb 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msIZuXzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257B6BB3B;
	Thu,  8 Feb 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383711; cv=none; b=q1/NBsutSXJBm8bNF5xCTuTPkFhSXbmyPhSsMI6O+Mh8ivu5j0nkbKqJu7Soh7mNBLk9WyNMn5HhVfRzQ6xSJ9efdCX6JdQuB+hGxq6h+70KLyqyRlIqgkb7KG7OieVaJZAXtygZNSw/OyJYA/vbovtBNEbVwbHYXmlkFwukAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383711; c=relaxed/simple;
	bh=waw1SbJdDbiBjHm/aT/t/Wf0N1njTMQj7zIlzg9utqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkLWl3kLhnkxllFbZw7zG/GB8ftr2NDqlmim/zmWvfIuTau4/L+ZfJ8J7k000MrFMIrRALcj6+aWOYtf1oXm/Zr5X08X01xaZ8aMIc4BooBwBhTVBvHM0nLNL4Xn4s5tm57SsIj2GSRHaS4RCrJfXlNBBNTeQNZGOQNrDNMU5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msIZuXzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B53C433F1;
	Thu,  8 Feb 2024 09:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707383710;
	bh=waw1SbJdDbiBjHm/aT/t/Wf0N1njTMQj7zIlzg9utqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msIZuXzGftHuaITYOsOoFfZ37ykrtsaxq/mTvuOtKsD9UHgETeS1paD+D2C65o5KN
	 nLEV9lzy9EWLLek2zKYpNXn8LMNliTbJC0BkP+opHd/Qf+s96D/ZrQqMCslj4yJZcI
	 +tgLB1jV6ika/Q7zcba0s0RANjQCtixj10+dAQ7QUrH+zv818fTj8aBj3meWZUYPxu
	 gJ8XrSg+Fdm7l0r5vsUsvFjB1vct7jRXjavYv5C4qqH6fc3jCGiAO4jT8qzI1zffwn
	 nZF+P+Y2838ZBtQbpW6HCqCoOOQFrtI31F7K+2L4NwoWy2NmBaeHsYEcSIJlGs+ajl
	 Fsxmuh7YC6L/A==
From: Christian Brauner <brauner@kernel.org>
To: Taylor Jackson <taylor.a.jackson@me.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v2] fs/mnt_idmapping.c: Return -EINVAL when no map is written
Date: Thu,  8 Feb 2024 10:13:06 +0100
Message-ID: <20240208-homogen-faszination-3740f9dc34b3@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208-mnt-idmap-inval-v2-1-58ef26d194e0@me.com>
References: <20240208-mnt-idmap-inval-v2-1-58ef26d194e0@me.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=brauner@kernel.org; h=from:subject:message-id; bh=waw1SbJdDbiBjHm/aT/t/Wf0N1njTMQj7zIlzg9utqI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQemT39Lt/xWY88dpuYLxQxdnq+o0tiWr7riT9+Eq8sk jcJ5m007ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIgQ+MDD0fi26u11t2Uu3J 0hcSjW/WmorXb1Q9Vbno/b7DpVP9drQx/LPVfrCBOXkFOzMzT3nAy/5yLZX2ZT4bZTVO3V21dao QLw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 08 Feb 2024 03:02:54 +0000, Taylor Jackson wrote:
> Currently, it is possible to create an idmapped mount using a user
> namespace without any mappings. However, this yields an idmapped
> mount that doesn't actually map the ids. With the following change,
> it will no longer be possible to create an idmapped mount when using
> a user namespace with no mappings, and will instead return EINVAL,
> an “invalid argument” error code.
> 
> [...]

Thanks for the fix!
In case you're interested, it would be worth expanding
tool/testing/selftests/mount_setattr to verify that it's now impossible to use
an empty idmapping.

But note, that currently tool/testing/selftests/mount_setattr/ is broken
because the tests assume that tmpfs cannot be idmapped which hasn't been true
for a long time.

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

[1/1] fs/mnt_idmapping.c: Return -EINVAL when no map is written
      https://git.kernel.org/vfs/vfs/c/b4291c7fd9e5

