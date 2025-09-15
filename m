Return-Path: <linux-fsdevel+bounces-61360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7680B57A4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648921883D75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D11305047;
	Mon, 15 Sep 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO8e8b1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FD24A044;
	Mon, 15 Sep 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938785; cv=none; b=CushE/0C3eTb7O/lW3xS5dhk7O7hMUxdWYIQ619kSX5TKk3uIzq6p52HkCuQ8cjiQYrqKgnPbnMbS0Zk9A8yrptfb8gqbf2lY1vYnC0eIXJWvRXGi9oJsCaQ/jwWjU/KfQA3F8R70XZBRSQCf87YFr6MvKSf8WooChBjdMaHNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938785; c=relaxed/simple;
	bh=l5Zerqh1/Oc1Qyem5tmwlM1+UIeC27lubKzDCyI2+Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfT3IugIM16aTX0TRpHzkLzVIatDqjwp20Y5anE8lNNrJ9GRMGsnUBV/fTA0mhTbOyJMMN/rlEBVmbUeJ1SXBsn9AWzY9F1okTkX9eIcPJk4i0ueTNvqzE1Jd6VkXnNu6Qq1+eHrObsWgHtkxwYh8qP1HiVE8/gzOQO2ZbxH+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO8e8b1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC3BC4CEF5;
	Mon, 15 Sep 2025 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938785;
	bh=l5Zerqh1/Oc1Qyem5tmwlM1+UIeC27lubKzDCyI2+Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kO8e8b1ggjtxi+5ZRI5880vDl0JhLXW7kfQPxN93EekJQnxkklX7PXjQ3GpE535s4
	 Ajr3yv4PVn+eJ1N5iIDcGA0NbPALzZAq29xqm/6FLo0F7thYwhGS5PUAFlXD+Idi/C
	 +aXZeRBYH7gEwZR4WFRbZa8DuNZcKGrDEYvCyEPuYslj4owrYkWjChANNWn14DzbUd
	 wtIpK4bvQUHg/T1C1FyxXDfMf4uHXuCTpHebs3bPgXlL8nzbuj6e376PTB2djwUiI6
	 G0JnUChSiCbSSoW50YEoFFnJIAwoQKd3a7yl1zHjfL5Ljv588OzLsqGTbttOp2AfSq
	 BolXKZ2MCfbPA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use the switch statement in init_special_inode()
Date: Mon, 15 Sep 2025 14:19:38 +0200
Message-ID: <20250915-blutjung-vollbad-baec52a26b44@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909075459.1291686-1-mjguzik@gmail.com>
References: <20250909075459.1291686-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=brauner@kernel.org; h=from:subject:message-id; bh=l5Zerqh1/Oc1Qyem5tmwlM1+UIeC27lubKzDCyI2+Rg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScYIkWk2ByONT4dje/593f2zQKNnSeczl9W/tM1pqLE TYdp69d7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3QcM/4yiNef9XmgdYSXF d6j5/2rjE9YeWZ85k6Vvfcm59Nkr7RQjw3yH10fdorLeHMlb/9hv4qHfnZtO3JYMei2xyba37I2 8HAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 09 Sep 2025 09:54:58 +0200, Mateusz Guzik wrote:
> Similar to may_open().
> 
> No functional changes.
> 
> 

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

[1/1] fs: use the switch statement in init_special_inode()
      https://git.kernel.org/vfs/vfs/c/4635c2c8bd5c

