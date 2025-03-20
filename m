Return-Path: <linux-fsdevel+bounces-44578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D24A6A726
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3DF175B35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB72139C9;
	Thu, 20 Mar 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci7JhTHJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800724690
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477321; cv=none; b=OkxLP/JJa5DqHd3TsaiOfLIjLRCldHOBRQCOTIE+oXxmCm+Zs8aVKiaGD9/5IXeOib/7hx2xJnnQRdLMRtbK55lKSfaD6mHhL49r26khx8MJb/l43GCKBxmrTxFqYKJfhyQIxXhDWocwk1E++SVznN+P+FnonIK3UUsaPhonKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477321; c=relaxed/simple;
	bh=+U5+jBoaDsuA76ehQ/nthk3UpSgaUPd+eMW8+QozEzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT9Be/2N6O0Ykwv0+4ifxKB+jojho95gdV/ChvJO7SS1XVyUXrSZc2nEcviiSofrjuAjFzJFcZUFRrQIzp2W3RBRTNZvdC/UiJ1D55gFRrsCqrbdvGEJiA8A+0280emA7LY5Icjr1JO0dUjMNkMcs8sc+z3RDZ4tsf3VpzHQr3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci7JhTHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AE9C4CEDD;
	Thu, 20 Mar 2025 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742477321;
	bh=+U5+jBoaDsuA76ehQ/nthk3UpSgaUPd+eMW8+QozEzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci7JhTHJYX1Wzcqht4HR+QbCueV3URAdxkK3fZPjQvs4ACulezwvSWRWA4KTsiajM
	 nNqJr4vV+H9DeUeGAyTZfILngtYL93494/vAB8By00WLpFGpv2iQQvdUwSwKp4/krp
	 QId3L2GPeLvW6Rqz4F2qfRm6d8cOXyH4ycPLDX/6+gTYaWHHw9Lfv/xSGfjOyeZxBO
	 JQUWLoVlGE2E2MP3GtkuctxhLW2jGX7uyOFwziDl+8mvNDHP8ZLQORd2mDIDrYf9b7
	 SDeXN75FOIwBIfevYM0/DSEN4C4SkV0tQiC0kzRn6ZmdMzy141YcXhK44E0p7Lq3Hf
	 eR3O+aT1t9/Sw==
From: Christian Brauner <brauner@kernel.org>
To: Yongjian Sun <sunyongjian@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	yangerkun@huawei.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Subject: Re: [PATCH] libfs: Fix duplicate directory entry in offset_dir_lookup
Date: Thu, 20 Mar 2025 14:28:30 +0100
Message-ID: <20250320-bersten-nippen-753e57fbae45@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250320034417.555810-1-sunyongjian@huaweicloud.com>
References: <20250320034417.555810-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=brauner@kernel.org; h=from:subject:message-id; bh=+U5+jBoaDsuA76ehQ/nthk3UpSgaUPd+eMW8+QozEzc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfkWCxavoybcO0/LatWnF3XzNl92rzvRPpnJFry1y4I kJKfx5HRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESeuzP8FeI5preLzUz5X1DV L1bdc1MVW/MPpPivPv/7Wuopm/USyxkZ/nuE3vS5djr/PtOR5+a3FUN+ZmzermlSUKJXfHqlVnU ZKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Mar 2025 11:44:17 +0800, Yongjian Sun wrote:
> There is an issue in the kernel:
> 
> In tmpfs, when using the "ls" command to list the contents
> of a directory with a large number of files, glibc performs
> the getdents call in multiple rounds. If a concurrent unlink
> occurs between these getdents calls, it may lead to duplicate
> directory entries in the ls output. One possible reproduction
> scenario is as follows:
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

[1/1] libfs: Fix duplicate directory entry in offset_dir_lookup
      https://git.kernel.org/vfs/vfs/c/f70681e9e606

