Return-Path: <linux-fsdevel+bounces-62861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C4BA2E44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 10:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360AC7A9119
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E7F290DBB;
	Fri, 26 Sep 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe3WAmH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D72877EE;
	Fri, 26 Sep 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758874504; cv=none; b=L3z94pGHwDo4Y7iRL4mpCA2fz9JZfgf40Gqzg7xWDTZiVBxBH9BTfx+gKjkvrN7UBTR63NVghu9Qni32vHWt2Yc6M3e5ROvNjsyNqfQAyrFQYxdV/w2eJGg/J/xtDHsLlJ5+7EXzf6w0r54hHKyVbUAWRgOse/CfTRN7itaLM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758874504; c=relaxed/simple;
	bh=r8bB9D9hbaoidmN9A4Dy4fetHxoLmO6jJeY+jY/hGaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWhkOw9xkVf5A/mvmmVyhPn21Rz1WEl1NRNe+ZhqyybulNdEqW7DqJBQQ0DT5RtrFhRpEDFLch6kvUwNbNsIQhAzFKTUw4KJXPnVk0Ry5cMui4JQpwvVc2lXjQDcsaL7NnzSwpU7gfTPassdlHVwYmSZuIw5Txp+vAsYkkGJHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe3WAmH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D131FC4CEF5;
	Fri, 26 Sep 2025 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758874504;
	bh=r8bB9D9hbaoidmN9A4Dy4fetHxoLmO6jJeY+jY/hGaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pe3WAmH0cQjCfBXCvM5x9K3aMvtrA6l3saJ/U0y172VAdBp0Uv8VMQSIOebQiSR9L
	 nTS72YWivRmltPpRzmnaL2VNdQt3G+xAD4NSvBvtUCOTyRKTiBoNVSPYLCM3TTC+fv
	 bfL6XYBalaSSVHPltbmgUNxz0iKMyS4Ln6FoYD4JVYaiErVsAlBJDpzTYMVmSeZJpZ
	 2ZDe5w15x6MV0OQVL5Pm6l3Bhv0DjNiiV1oaL9b0PmKXy07hlYfjkuFJcoM4mFF58/
	 f8w71QkpjNv8Xn7d4oCFybN/cAHzURKE04C7DNrpjmSSImCSMGDFBuBRCWSmVbA0Pr
	 BPB+w4YKrso8A==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 REPOST] netfs: fix reference leak
Date: Fri, 26 Sep 2025 10:14:56 +0200
Message-ID: <20250926-buche-fragment-4839b9d8930c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <936424.1758805700@warthog.procyon.org.uk>
References: <936424.1758805700@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=brauner@kernel.org; h=from:subject:message-id; bh=r8bB9D9hbaoidmN9A4Dy4fetHxoLmO6jJeY+jY/hGaw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRc825avXffzNMfNbN46hw1zp+xlEz99zh6tfLatNDav gtZAutLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi48bI8MyS6c2KdzdOz/y3 sHU91+dXq59qmlZ4HXiZF/UicR1H20OG/3XCz+suMilqfJeWSzxy9fec8qqivx6yJ7W3Jxa3xk/ 4zw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 25 Sep 2025 14:08:20 +0100, David Howells wrote:
> Commit 20d72b00ca81 ("netfs: Fix the request's work item to not
> require a ref") modified netfs_alloc_request() to initialize the
> reference counter to 2 instead of 1.  The rationale was that the
> requet's "work" would release the second reference after completion
> (via netfs_{read,write}_collection_worker()).  That works most of the
> time if all goes well.
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

[1/1] netfs: fix reference leak
      https://git.kernel.org/vfs/vfs/c/4d428dca252c

