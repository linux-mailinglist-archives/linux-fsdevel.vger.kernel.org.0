Return-Path: <linux-fsdevel+bounces-21887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7039B90D5B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341DC28099F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390618EFE8;
	Tue, 18 Jun 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKgSBSao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781416F82B;
	Tue, 18 Jun 2024 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720890; cv=none; b=cxxO9BSH2CM0KbqWnpBC6/hHs2hq1AHgw810NaCMwOPc0HltBWepFLYPWMB5sRlS7sxXuMXo20htMwREjx3UYTv/7dX68Lmz7qEfWEOOfnxJW0o8sHxD0BJuikc8Vvj4CGzBMbKjIl4u9fyn5LI+UJZmslAJSyoAqZxE1OEx5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720890; c=relaxed/simple;
	bh=Tvh4hB5cyhfUoWV+w/CwDW/s35vlDm+9FWKgwonoTug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpYErKgGczXZsV//DWnpe4PU0iqVsEm8Mcr5RuYCJgGHRnFyWUorD3UdltoRe+rNFEvSEiSt190MHODRTcUpnPYa4qiiU0nuhMIGXKsVUfOQlUdh7CiAN+1DjChhcWN8g0DJ4+r9JYoFvnXtzvceWls84FYebGk3ZFDv+pHSmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKgSBSao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E02C4AF48;
	Tue, 18 Jun 2024 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718720889;
	bh=Tvh4hB5cyhfUoWV+w/CwDW/s35vlDm+9FWKgwonoTug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKgSBSaoQFby1RLs8vJoGD3tvLVQFetZ88877MWwWI2J5G4Np0wHCoAd2xh94Djrr
	 IZbaLRIZ9/JvcSGgwxrmnoCkMGmmeG7REBAQWQKUzTNCTNJ0EqdUqI6m3ij63Cr/D8
	 TG+58ieBAHONiwJJG2qH1VobC+bDyR3Pk1j5yYbXU5zZC+NtfQg6WY0V2Ii1jahx0G
	 7T6pxhFG39+CNNT60Jst7rD4okCHtrMjaUcyhcIr4DWJumC/Sa0VqpnID3N/7Uucol
	 Pa+4UVSHInZo+vGQGJxWcNCFkNtcMBEP0+6sbS4tpMVBg9XNIfGWPoLa+j8o7Up4jY
	 dHcIDL7w4pX6Q==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>,
	linux-nfs@vger.kernel.org,
	NeilBrown <neilb@suse.de>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	ltp@lists.linux.it
Subject: Re: [PATCH 1/2] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue, 18 Jun 2024 16:28:01 +0200
Message-ID: <20240618-modular-galaabend-c0dba5521bc4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617162303.1596-1-jack@suse.cz>
References: <20240617161828.6718-1-jack@suse.cz> <20240617162303.1596-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=brauner@kernel.org; h=from:subject:message-id; bh=Tvh4hB5cyhfUoWV+w/CwDW/s35vlDm+9FWKgwonoTug=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVziw0EtThc9yhHjBVc8nF/wIBweu/TvnxQdrpEWP+m VfqqX3rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayq4aR4eS+tjbZzeycTZGz ZR+frL35eMNW07C58YqTY7pvf2cN+M/w33+7q+KDE3+svMtPqL3+XuyWLXXSgulhYrpj6qtivrk V/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 18:23:00 +0200, Jan Kara wrote:
> Currently we will not generate FS_OPEN events for O_PATH file
> descriptors but we will generate FS_CLOSE events for them. This is
> asymmetry is confusing. Arguably no fsnotify events should be generated
> for O_PATH file descriptors as they cannot be used to access or modify
> file content, they are just convenient handles to file objects like
> paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
> file descriptors.
> 
> [...]

I added a Cc stable to the first patch because this seems like a bugfix
per the mail discussion.

---

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

[1/2] fsnotify: Do not generate events for O_PATH file descriptors
      https://git.kernel.org/vfs/vfs/c/702eb71fd650
[2/2] vfs: generate FS_CREATE before FS_OPEN when ->atomic_open used.
      https://git.kernel.org/vfs/vfs/c/7d1cf5e624ef

