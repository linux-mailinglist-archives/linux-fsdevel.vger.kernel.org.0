Return-Path: <linux-fsdevel+bounces-58583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CACB2F240
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5705C6069DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522722EAB83;
	Thu, 21 Aug 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB/twgsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BA2EA49E;
	Thu, 21 Aug 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764774; cv=none; b=BKSPd2hBuVjsXZMr4uddGSRrQ0Of3Ntzj8GMENmaHdfm01KrQA6AQRnTDBeSDByISR/MzpNeg4CgPjyOj64wYTzc5V7aYX5WdA+uQfrSKjg7gLsDP5z2ukC5Atg8ALnAE8VtCYwwA33P1kH6L+4t/IcdUYhZIZPPoxZMTQkP4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764774; c=relaxed/simple;
	bh=cLUbOqUr6cTb/vKgSfC31FXfcobLn5rCi7Usx5zRpc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJQ2g9VMLuSvJYwZILZ7Y/6/Hml00r+uii6JP38shCEttNUYpCMdJDCfHKNJxTUjArrTPel75lwHXUM05/Snhj2vIhNt9a6Iiw7kOygfbt4mDbclU9lg/Qf9Y9sl+qS0A6+Lax+dOjzG20Z+q7CUD1USilCI1NdXvoRTt39vYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB/twgsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD01C4CEEB;
	Thu, 21 Aug 2025 08:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764774;
	bh=cLUbOqUr6cTb/vKgSfC31FXfcobLn5rCi7Usx5zRpc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KB/twgsA/CTVnp586RP3GyuIdvA0EyWAAu+91jwzNtpbYbFOXHSU+jhu4roGlyYaB
	 BxV+AOwx9I0X+6uSH1kDHGrWRCz5VW4AjFllgPvHKsWA5GjEhBoTsBtmc2sQ09hzK5
	 jQuxubCyXuxk/Fe2zDo0iQi/7yW6zxEmdnetP1tMY7f7jUGykW5edx68Zmf5wRLqM1
	 AaGdKlxJfMGHLS7Dw6iFgcgxUCI0acFJ+cmRXj/ME/nXBKoswdmAChcBH49jSUT7AT
	 nNClgUYNQbD/ibAssVpOs7cjGiJbe9NxlKJR5WwEypQ96O8gqU8pcz1UxbhkZGpIi3
	 Vsg9b0HqcCtvA==
From: Christian Brauner <brauner@kernel.org>
To: Lichen Liu <lichliu@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	safinaskar@zohomail.com,
	kexec@lists.infradead.org,
	rob@landley.net,
	weilongchen@huawei.com,
	cyphar@cyphar.com,
	linux-api@vger.kernel.org,
	zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	initramfs@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
Date: Thu, 21 Aug 2025 10:24:11 +0200
Message-ID: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815121459.3391223-1-lichliu@redhat.com>
References: <20250815121459.3391223-1-lichliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=brauner@kernel.org; h=from:subject:message-id; bh=cLUbOqUr6cTb/vKgSfC31FXfcobLn5rCi7Usx5zRpc0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsuyF9J8I8+ZPI912RyxZ9nXK0nUlMZilruGDJHpOm7 9cirH4HdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE5BbDX+kbB6buCWFhtarJ sWE8wewxpUXp9twbsTPVd/5ZsXix9k9GhvNr7pbsmytTaOiSs/k6/9MrFlk+jBf5/2xw5Z0eo9v QwAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 20:14:59 +0800, Lichen Liu wrote:
> When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
> By default, a tmpfs mount is limited to using 50% of the available RAM
> for its content. This can be problematic in memory-constrained
> environments, particularly during a kdump capture.
> 
> In a kdump scenario, the capture kernel boots with a limited amount of
> memory specified by the 'crashkernel' parameter. If the initramfs is
> large, it may fail to unpack into the tmpfs rootfs due to insufficient
> space. This is because to get X MB of usable space in tmpfs, 2*X MB of
> memory must be available for the mount. This leads to an OOM failure
> during the early boot process, preventing a successful crash dump.
> 
> [...]

This seems rather useful but I've renamed "rootfsflags" to
"initramfs_options" because "rootfsflags" is ambiguous and it's not
really just about flags.

Other than that I think it would make sense to just raise the limit to
90% for the root_fs_type mount. I'm not sure why this super privileged
code would only be allowed 50% by default.

---

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

[1/1] fs: Add 'rootfsflags' to set rootfs mount options
      https://git.kernel.org/vfs/vfs/c/278033a225e1

