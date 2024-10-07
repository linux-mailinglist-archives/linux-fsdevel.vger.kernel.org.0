Return-Path: <linux-fsdevel+bounces-31166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29183992A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63731F22F31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6A1D1F71;
	Mon,  7 Oct 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVeR7nlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F11D1E91;
	Mon,  7 Oct 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301179; cv=none; b=PboFYrri6gWtAEGhi295eDfneE2buA+xf3ft1WcaAIOHu8bLVrkBW+ulH7hzmQAGLasrtQd/b6NpzNmDcIthbv7zZg2lh0pktvrs+qC9UxzYIvXiHG+KB8H+X+I5QPQLlvF84T1nzJM5u/e2HX6SrefH1qU7dl1xYtwL95ri0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301179; c=relaxed/simple;
	bh=6TfGHJbx+uV5cVoNt6UJIaSS5C535EHg32pLeJeZk90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No29L7rAbkFrn6ik/BcHZJ/7dd0sB1dmvdKEJokuC/tkKVp+y7kCMqROFa9Kscovh5NIkdaQ7ivq4IKpi7jBZSHQyOafy1dCYUULGolPVykrkFbhYMZFOajfMleb8rAaXrZlNGEFEqUSyLiO1Z27pEOg2SHa9JGGcBkNeF2zSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVeR7nlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BA0C4CEC6;
	Mon,  7 Oct 2024 11:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301178;
	bh=6TfGHJbx+uV5cVoNt6UJIaSS5C535EHg32pLeJeZk90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVeR7nlZc4MqHUS87ocq/yqkglvc73XZbna0UARWXW9Xh2CmdtXuERWMIG1RO310M
	 dJoQnZTl3vXJgPkiRmvWtcWS+O1cKadTLz7FrmYlHiS8e/Rh8Uj6e/ASTGzUPxBl6q
	 0D2KqGJEkKMwxeR9SoVLpGTJKdxH8mMAtKrL3+BFDwLxYoWZup3x/6wN1QzXDC+yJ7
	 rZWkklJ3Bs29s/zpec749p46D6PFnsRQ+8HjP/c1ysnyt2N0mfZ4+GVl7nRflH7Oll
	 gVHsg0pTH6vvUnyKoT1xVlGP1vsy6vkRi0BloLqpyCMV+K/XG+bRpaB1cRgKTEJfgX
	 +P3nth+o6Gizg==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Uros Bizjak <ubizjak@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
Date: Mon,  7 Oct 2024 13:39:28 +0200
Message-ID: <20241007-anfingen-vorhaben-b6125e17972b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007085303.48312-1-ubizjak@gmail.com>
References: <20241007085303.48312-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=brauner@kernel.org; h=from:subject:message-id; bh=6TfGHJbx+uV5cVoNt6UJIaSS5C535EHg32pLeJeZk90=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQznygJe6zsNe/bX09ZK55Htlquj7ObF7+9Ip2ZHrdZ4 giL5W/NjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInwyTH8rw4o/3OEYePrzadv vWPtFJthtW+3ahnD45tqAnfd2qbILWNkWGC4/andQRuRepujxyY/uGCe8jxjs8g+ofpi/st8Qi5 3GQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 07 Oct 2024 10:52:37 +0200, Uros Bizjak wrote:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
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

[1/1] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
      https://git.kernel.org/vfs/vfs/c/26bb6d8535e7

