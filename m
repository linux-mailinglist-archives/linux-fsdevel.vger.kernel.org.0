Return-Path: <linux-fsdevel+bounces-9510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C119841FD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 10:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC952929FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0E664B9;
	Tue, 30 Jan 2024 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/1AD10a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD6664A0;
	Tue, 30 Jan 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607588; cv=none; b=OxaaJt/62j98NdZb0sxdHKk71P9PMhDi22pzEMmvpJ7n57hYbTzeUAFF6zu//wAmMs5/mat727PKw4MXr8BGPs8po88ymU95Pq07C+ZmeIlECoe0pFJNs22oMiAOyzopRyAX1oXjdvN3PtSfJPyo3EU7L5T0etCFfdy8Aw/FTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607588; c=relaxed/simple;
	bh=mM2ess45AwnKbrhva6jwqwOxaR8DZ3trNEEwfS3BavI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ma1ItYTaqIwF+3QFWLII+vWCejTA6If0dVvviHew1RC3J0QdyKP7brBNLNETdBFOC4xvGxvO40G1RCT4y1+WL7TwV9TEfEuB3F8fHiz5O2ropr3tg3Be32mTLILtscUaalF0Isc1KeLFLxfZfwNoRvVwhChMt2CzD5cBunkZxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/1AD10a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3855C433F1;
	Tue, 30 Jan 2024 09:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706607587;
	bh=mM2ess45AwnKbrhva6jwqwOxaR8DZ3trNEEwfS3BavI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/1AD10ainb7xZ5Xh7+PkxKhKUE9EsKLKZ7Bp+7g1cEz3OhwehROSbXZnub3W1B/1
	 NFs0Nmk4eCsy+5LR97e9uqIqHAkH7qnHv+QoF5ou27Foh9gpPr1cldovq4KCNoUzXD
	 aytEQQVmfwCm7FswpGuP2DnawKPKxqIK0eR6O9xGlSCvZjMME69H2AvW6y0i3Fi6Vo
	 LGWBiRLqKjtKtfJTzcvbna7VSS5AA0G3tAvhvQEs/tBkhgwH5MfarX5YH7HYuSLKS/
	 axWcO1qbO5Pe8qkT87aYPv3cegHTz+qiVBv1DjsQFCiU/2+a2J4pUFREIYHVIUIolR
	 PloqIRzKSMh3Q==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] ntfs3: use file_mnt_idmap helper
Date: Tue, 30 Jan 2024 10:39:36 +0100
Message-ID: <20240130-heimvorteil-glasfaser-0e371f946d21@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=908; i=brauner@kernel.org; h=from:subject:message-id; bh=mM2ess45AwnKbrhva6jwqwOxaR8DZ3trNEEwfS3BavI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTuOHzbxHape+Lmq1ur/0XFTAnOVJ1x57zL9m3ycwvW3 lLSzUuu7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAYTJDH9Fn78uKBAV6y/XCMyX PKCyc3H7vaWO+cY8px2vKP1JM3ZlZHgmYHd035cz60+YW87iWMOQnzvFIaJ5VUdYys0VZouaYzg B
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 19:00:23 +0100, Alexander Mikhalitsyn wrote:
> Let's use file_mnt_idmap() as we do that across the tree.
> 
> No functional impact.
> 
> 

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

[1/2] ntfs3: use file_mnt_idmap helper
      https://git.kernel.org/vfs/vfs/c/16a37cba65f1

