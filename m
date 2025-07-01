Return-Path: <linux-fsdevel+bounces-53482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D5AEF7AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5850A4A6328
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD08D275AEC;
	Tue,  1 Jul 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpsiqzoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CE2750F1;
	Tue,  1 Jul 2025 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371088; cv=none; b=WDzIBxsa7IG7p2nu1W7kDgM/0ckSMJ3M0fyjABTPeRfkA8xPuLud07QZrYb7jWjBV2uJ4RuuGykwgB/J9+S81PigPQ1PmWU76hWj2QjxKJyIZD5ZCjZAAErjFHiI4fx5ghfVdChK/mcBaw98f13BWhmIXfQTLYGu/ve1bCO4M98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371088; c=relaxed/simple;
	bh=UZeMSKZ11B+fK200ltJVcPvGBcnZKR1wvE4AHo4yKxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duJsueHVWrgwmSLJHHQKj6t/vLY9Wl2XDRMO5Qfe5bCI5rnf74bDuFjgIv9ns03PacGVCh6U2B5/+r9UqCJMoBxscjbdW98iqlUqVJPxJ9WwTDnEhgf6CrpgQEFSvvaVjT5q4djOLR6U3jT1xC6BqJ74plnJhpGMZYWQLK3zyHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpsiqzoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DCDC4CEEB;
	Tue,  1 Jul 2025 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751371088;
	bh=UZeMSKZ11B+fK200ltJVcPvGBcnZKR1wvE4AHo4yKxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpsiqzoBHZkZPlelVhI8tvxYvJeh2jgfP7iGnaKx740QtEAQwivlp0c62KmApHqmG
	 6aSViIN68j9VqRaVjH5+7Or2JTjc4TX84h3wDGMmEF3jP7r0qE2DFdslIysLjRE5T5
	 xpxAUwnzRdMeefwSlAgCJ0NhzR/jeFxHFZQNcR9yhv6XhbnmZzCbgAo+qUwArz8E2b
	 +0ihh2fx3bxjAsMOEbQAhjOn6MaDsyzqLRCsbvHLijqh6H/QY/qQo+Gmu51Td7gR1y
	 MtjBlMubJM7c7HDOaJxWJfaaV1+Gi8CAw2ITPOqrdopC9DdZiF30+Vb0Tn6p6TrvnL
	 SO7QiwTNMDBpw==
From: Christian Brauner <brauner@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Baokun Li <libaokun1@huawei.com>,
	linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	Zhang Yi <yi.zhang@huawei.com>,
	linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	mcgrof@kernel.org
Subject: Re: [PATCH v2] fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable
Date: Tue,  1 Jul 2025 13:57:56 +0200
Message-ID: <20250701-lastkraftwagen-fachsimpeln-6c6c0210569e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250630104018.213985-1-p.raghav@samsung.com>
References: <20250630104018.213985-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=brauner@kernel.org; h=from:subject:message-id; bh=UZeMSKZ11B+fK200ltJVcPvGBcnZKR1wvE4AHo4yKxI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQkn/UsZJdM8/Kq7p+c+fEFj8A7q94bSy3a1cIP1s5fY dJnbfejo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJPDRgZ+i/22VfdnBi8snCf /sYSHo/NzNIWKqePaIeJlClVpy68z8jQdFDQ8dmukKYa7uhbVrMPx7q42yb0T0+94B5wf8KDvfZ sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Jun 2025 12:40:18 +0200, Pankaj Raghav wrote:
> Since [1], it is possible for filesystems to have blocksize > PAGE_SIZE
> of the system.
> 
> Remove the assumption and make the check generic for all blocksizes in
> generic_check_addressable().
> 
> [1] https://lore.kernel.org/linux-xfs/20240822135018.1931258-1-kernel@pankajraghav.com/
> 
> [...]

Applied to the vfs-6.17.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.misc

[1/1] fs/libfs: don't assume blocksize <= PAGE_SIZE in generic_check_addressable
      https://git.kernel.org/vfs/vfs/c/c2d3651387f8

