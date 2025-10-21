Return-Path: <linux-fsdevel+bounces-64911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D7BF6730
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138CD407260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A77431A050;
	Tue, 21 Oct 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvKI648d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CB2F28E9;
	Tue, 21 Oct 2025 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049403; cv=none; b=pV9sLjDcLNY9AH1Zk96+EN3FRo/6qfB/ocfjXVXTEMcJBv0RTlsiJZlzQ8w4SUqeDGskR8Ls22Age4+khR1DrZXuhZF0C2NK0HcCa1UL/iRtakl2tZGpjEkQRVJvtnoHTEwWO4fVdQTxPkKgVDr4U2DHBqlzpR10UtyC0jsc6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049403; c=relaxed/simple;
	bh=+sqiUHkSfP5A8rVdrQN/t30eii5gADxC9If4cWd7tlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arN+sfmvc6UtzKrOoH63qjraUT+FwD6iG+aZYBUor7F2piYzFL186XpixgeoMaq6aDzNUd1vXxaMPN2schrsY+EtKM86V+kg3qiTYkv3k6XTuu3/Cm8yLr+sr7UuBpwBPi/NvUhX3O+gyAieuK7iu4lBD/Ax49A1PwrHAZTN3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvKI648d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE38C4CEF1;
	Tue, 21 Oct 2025 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049403;
	bh=+sqiUHkSfP5A8rVdrQN/t30eii5gADxC9If4cWd7tlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BvKI648dgvJFDJR+yz7wj8UibEotw1CDx0ep4muQnjaEpn0XUG7WpUrNk9rtfmQRQ
	 HeSGB0jM6U0/K/N3duIDCJ+Dx3/EHA2RdjnYusZMHthhB/GE7wXcmFa83zW9Llz6VL
	 7xItfrlQm8+aH2FG7n5CjplJQdaeis1BAKK5s6x0DgDyZJKcG7MnMx+Dh8X9RTEWuk
	 lhZih2awoIgHgF/EIylZNu7bQW4+icxnHndrBL8lbfXesl1T+cCnQsTyQjNVm3x+gq
	 ycUnJBIph96pUmJm2CGGv6Oh+xcVo2nVipW9fICAUk/Ph/uGYbrcTm42Q1UM6Wzzb7
	 wK/U0SaRbd1NA==
From: Christian Brauner <brauner@kernel.org>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v2] fs: Fix uninitialized 'offp' in statmount_string()
Date: Tue, 21 Oct 2025 14:23:13 +0200
Message-ID: <20251021-zahnmedizin-statik-640ccc16a11e@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013114151.664341-1-zhen.ni@easystack.cn>
References: <20251013114151.664341-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=brauner@kernel.org; h=from:subject:message-id; bh=+sqiUHkSfP5A8rVdrQN/t30eii5gADxC9If4cWd7tlU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8rzZTP399z/IvryeL+6m92ZX4/11QynnOrSIsNtKJL Z5GUTbsHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5XM7IcMpWdvFFOZY9HZem 2B40E1/daJvV6bGg9I2Qab6hVc2FTkaGdffLBA2znc8tvqN68ETvqsz19VKxOak/HA6Wls69P0u PDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 13 Oct 2025 19:41:51 +0800, Zhen Ni wrote:
> In statmount_string(), most flags assign an output offset pointer (offp)
> which is later updated with the string offset. However, the
> STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP cases directly set the
> struct fields instead of using offp. This leaves offp uninitialized,
> leading to a possible uninitialized dereference when *offp is updated.
> 
> Fix it by assigning offp for UIDMAP and GIDMAP as well, keeping the code
> path consistent.
> 
> [...]

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

[1/1] fs: Fix uninitialized 'offp' in statmount_string()
      https://git.kernel.org/vfs/vfs/c/0778ac7df513

