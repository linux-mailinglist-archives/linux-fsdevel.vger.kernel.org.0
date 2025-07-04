Return-Path: <linux-fsdevel+bounces-53913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A1AF8DBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754993A6C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4512FC008;
	Fri,  4 Jul 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWth88w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC012ECEA7;
	Fri,  4 Jul 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619684; cv=none; b=QBcEo9hqquXp8zA5CBqrT8g9rVFraS8eUmcM9XyfSCmLoLfCiZ6ZRWn0wuLaYzIpmNm6cdoXbkp2VUv/riKE7jcOVikqf21bHArQmuSKkS6CULkOUsjjy5WaCG5EZIzuW2y6iijifMHmrEzETun7cAHSfkh0SQQg34xeHfu0X58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619684; c=relaxed/simple;
	bh=pcXFhsJsF5hHVop2Uie9TJ3r5ke5/MrZcsdmdG6PI90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Efu9oY7af0CUoBpOOswTXZD0QCIFL5KgN6gOdfS6pxK5lFKgOwFR5IuSj6QJE5bRdoMtXoxTJdzGEXXIUX4WCMtTtyP5cEmMXGgQqzT4XzRXoTrSlEU62kgO6EnDteMA61qZF0E6UfJze150fCtE27/HXO9Q2QbDwMbxbRM+jIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWth88w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F17C4CEF2;
	Fri,  4 Jul 2025 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751619683;
	bh=pcXFhsJsF5hHVop2Uie9TJ3r5ke5/MrZcsdmdG6PI90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWth88w9VKiIbf+GBcuBPQcOc6Hwh9zyQr71qDjparPp1ptSZEjb0iNmv3p9fr84F
	 YqhL8670JOZgkF1AyL7Mz26ZHup6c0+Jg14eoduZmk8lsTpIuiODaoXJr5+6wUHAfz
	 9r+HuGiNwLAJP1PjQpHgYCMabqGvXfTL88m/gCDC2V8vEQk9N30pZ+exhWBSz3KC9Q
	 S4AUxgAvfTbDZgGk00E2Et3Ght8hDjzFjNH0gbZaM6CP5xgIMnY6pHJ+YSyoQWEQfk
	 W943Nkg84GGNj75k0JuVRn2L1kn2CQhg2cnx3+hQE+GWWg8sBNa5m5CKkUWD3InsAo
	 aehILMedRcJqQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/6] fs: enhance and rename shutdown() callback to remove_bdev()
Date: Fri,  4 Jul 2025 11:00:15 +0200
Message-ID: <20250704-erproben-umgefahren-a485732e97de@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
References: <de25bbdb572c75df38b1002d3779bf19e3ad0ff6.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=brauner@kernel.org; h=from:subject:message-id; bh=pcXFhsJsF5hHVop2Uie9TJ3r5ke5/MrZcsdmdG6PI90=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSkz4id2rdw0f/jH/S4TgTGCK0OP6vgkbBCwX1SZb/CT Jf0sDd7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiwMjI8KTol5138C/TV3su Hq5XK607tObknMkLlJPL4td7HdCJXcHIcMb/WwtfQV2QD3ezGEui+49+4e9amvcnfDl3YBlnX6Y gOwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 04 Jul 2025 10:12:29 +0930, Qu Wenruo wrote:
> Currently all the filesystems implementing the
> super_opearations::shutdown() callback can not afford losing a device.
> 
> Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
> involved filesystem.
> 
> But it will no longer be the case, with multi-device filesystems like
> btrfs and bcachefs the filesystem can handle certain device loss without
> shutting down the whole filesystem.
> 
> [...]

Moving this into a stable branch that won't change anymore and that you
can pull into btrfs/use as base for your patches.

---

Applied to the vfs-6.17.super branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.super branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.super

[1/6] fs: enhance and rename shutdown() callback to remove_bdev()
      https://git.kernel.org/vfs/vfs/c/165fa94de612

