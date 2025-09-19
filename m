Return-Path: <linux-fsdevel+bounces-62226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACBB896CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 14:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08C97BFF38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F53101D9;
	Fri, 19 Sep 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS3uOwTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC430FF2B;
	Fri, 19 Sep 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284489; cv=none; b=HVixhXrHknT5jV34kKPhYeSXWjsvN+4k+Gn/jUo9hBJw9pRDTPCyjJ6m0Ut1ZegkeQWOtDcAWgiq7++/hac9NSN7iURpr+r/guhz/tLJOEjQV1SSO5UOBDK1w2Sodm8jb+MN1YPbtzdracwrCwoBCUNvHOM6fNG++7iLqf0W1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284489; c=relaxed/simple;
	bh=rXIgbfE716xBftqBoD9rprDY7oYuAFMefpcVDwRQo5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWhRt4643nqkW3fEpjPwNjWkbZWe4RG1joK0B2Qpo07CbsmaCkuOI0ZbYDSTniJ89ZLAP3tCs5F4fX++5kIzKvvgLDzSa65xXYiH8uNYgxQ2qc4zb2KtMl3DHJBhLY/b9jtX5QbFh7B+Ul1xjl750WAEzdvCZSFIsS3md66tqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS3uOwTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E9FC4CEF0;
	Fri, 19 Sep 2025 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284488;
	bh=rXIgbfE716xBftqBoD9rprDY7oYuAFMefpcVDwRQo5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jS3uOwTZccJhGlQ88oY6vvJuMdVS+b4JUvSJbriaEq3zMM1lCDyQ9xLYm8QnjUGxV
	 Q3e/b0rIOaeuj7qBX/hMTRb+HN3EzUR4GBVnnN6e6+a3hCVk8/rbSaAHapg+7rfn5f
	 Kez/vxrcEtawHzR1oYKr2pHkAfmQB4A++FXiGpv8bIB131Ho67XBEUG7L1qet/QzFJ
	 hx02lhcMicvrnnI20mb6NCohsqsSLadMZ6QVNXLCo6YbI7/MXTDduM2siRvwKsLglW
	 5bPAIurwxJiCxhsthP6Y2/CkJKlYKNkJvG1vB4Mc3tBDEPMWeGMBelSunQX/suE+XH
	 xAHh6gzh/bbrw==
From: Christian Brauner <brauner@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Marco Crivellari <marco.crivellari@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/3] fs: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri, 19 Sep 2025 14:21:20 +0200
Message-ID: <20250919-denkfabrik-addition-6e42bfe1d22c@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916082906.77439-1-marco.crivellari@suse.com>
References: <20250916082906.77439-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=brauner@kernel.org; h=from:subject:message-id; bh=rXIgbfE716xBftqBoD9rprDY7oYuAFMefpcVDwRQo5A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc9Tr81HJRw+naG1dmHH9/oC41h50vo5g3JkVy4VrTq 7x8ixW7OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSVsfwT0d1/QQx1vq9+l0l ar4tcaHVzy+um7d4l0fQp56yZ4v37GRkWGcvrS0xyed19/2W7vQL14u8uGZdNK5cv5NX+bLOEvn /bAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 16 Sep 2025 10:29:03 +0200, Marco Crivellari wrote:
> Below is a summary of a discussion about the Workqueue API and cpu isolation
> considerations. Details and more information are available here:
> 
>         "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
>         https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> 
> === Current situation: problems ===
> 
> [...]

Applied to the vfs-6.18.workqueue branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.workqueue branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.workqueue

[1/3] fs: replace use of system_unbound_wq with system_dfl_wq
      https://git.kernel.org/vfs/vfs/c/08621f25a268
[2/3] fs: replace use of system_wq with system_percpu_wq
      https://git.kernel.org/vfs/vfs/c/d33fa88429c5
[3/3] fs: WQ_PERCPU added to alloc_workqueue users
      https://git.kernel.org/vfs/vfs/c/13549bd48bbf

