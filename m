Return-Path: <linux-fsdevel+bounces-55117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC08B0705B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C598C1C20FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B02EA725;
	Wed, 16 Jul 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6rTud16"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41C72E9EC4;
	Wed, 16 Jul 2025 08:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654145; cv=none; b=eYF3Mii9WyfoX7AXu06zdj7yfEEaJDU9nUXl7wRpqHx6J9Y3XIorypYIcv0iUc0fPcgyGGE/TZLbvFAQNXbNcuIcJslq4Urjzwbu0p4UheSK/87wLHLZb41L0xWcETJxTU2dmtfM3cn7GsosONVefnKn0b4mDv9VxawjlO0bzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654145; c=relaxed/simple;
	bh=Xz46mLhAokL1btXLkGGLKHAclMSjaOP7HOtiwCqK/Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7HE6sYgCSi7qL0gCOm05RC3oJarNxMfhfI6uWEWkoreqlQMH2mb9g8cHR+K4dIqIZ4Twx/UqvJ7ztbmeZe/PZHPQRgB2nomflreeRp4M2eiZmt/eOi+67/72y/EjT/ti4pKh/aSL4cBY3RrplELVGkvslCcLPgYLDK90v7FVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6rTud16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24478C4CEF0;
	Wed, 16 Jul 2025 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654144;
	bh=Xz46mLhAokL1btXLkGGLKHAclMSjaOP7HOtiwCqK/Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e6rTud16JkckzYWCCt0KclDXkbtntyGaCd9AAy3jw0Raa0FGEK0ASw6f6hpf7M/hQ
	 V38jVUgRQpdqgYcJH4qRF3e5s2AfXDySX5EJehZOSDkyE+ZyuKL1qKYL8ZqmDLN2Oq
	 jheb1BcSUNqRiYKWToyekml7paxC3GLSGAVzNePLCrEuPG3TtZCpl0yos1qoDmS/XR
	 FXaR/jCbGGRGVDYbYt/MsYBW6t0kHyXBS8yrN+btxpV1apLmAVz94FwXsCaIE+8F75
	 1DS+VjM+uhAmgknSmSRHvma+tACvW+IRSkbwCnqVpgK+UNQIPAQkQGmxucQlXzsaAD
	 O6JrrDmC8jcGA==
From: Christian Brauner <brauner@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] fs: tighten a sanity check in file_attr_to_fileattr()
Date: Wed, 16 Jul 2025 10:22:15 +0200
Message-ID: <20250716-abdecken-backpulver-576b9e593f38@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <baf7b808-bcf2-4ac1-9313-882c91cc87b2@sabinyo.mountain>
References: <baf7b808-bcf2-4ac1-9313-882c91cc87b2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=brauner@kernel.org; h=from:subject:message-id; bh=Xz46mLhAokL1btXLkGGLKHAclMSjaOP7HOtiwCqK/Ug=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSUJ1qlHfyVn/Wqpq+SbUHBXItjnkJXGi9w69mqFIrZB ndN2aTQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGtNowMp5o2f12Weq/1jc2x 7QUiP/0S571kK45oWiAbLX/yWeHXIEaGbdH5668ee2vz2jQqk9up/yXXVKZsgSmFXHFOATsfndR kBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 18:03:17 -0500, Dan Carpenter wrote:
> The fattr->fa_xflags is a u64 that comes from the user.  This is a sanity
> check to ensure that the users are only setting allowed flags.  The
> problem is that it doesn't check the upper 32 bits.  It doesn't really
> affect anything but for more flexibility in the future, we want to enforce
> users zero out those bits.
> 
> 
> [...]

Applied to the vfs-6.17.fileattr branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.fileattr branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.fileattr

[1/1] fs: tighten a sanity check in file_attr_to_fileattr()
      https://git.kernel.org/vfs/vfs/c/e85931d1cd69

