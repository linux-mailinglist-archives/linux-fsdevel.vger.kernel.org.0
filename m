Return-Path: <linux-fsdevel+bounces-57357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F72B20B4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BCE18C77C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A222CBEC;
	Mon, 11 Aug 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlay8WZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAF1A5BBA;
	Mon, 11 Aug 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921231; cv=none; b=advE2m7X7uU25Tu7JjlfRoqIiSZVGpimG31WMO9yY4BMZbYMoCD+BnuQFwmm/yOqzHf6ld8sOZtLBuK8LA9gt9obN85fsN1MXkyhDdVd/sIsLuUeDi26dnccyBp1Mv6e7rTn7ecji1bm1t9ihphZxdO3EfKpB+iZHd+ryGlz3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921231; c=relaxed/simple;
	bh=K8K9ZqtZvAXY/qtQK4SMOEyyAf2d3MR1QUMImvS+two=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDoXXf6y7tVyV3mLSl2zSOJsxo3sb+oTnaZIHqMgdNLBNe+dH49+d8hsLatUHN3kUlZ1m5hQEF4hsV2IS5DU4aFxSb8D/EfCt0y6URX7r/m5rq1cN7nWfMXIuFMWslcW4sqlGmvgkXmHq0+9uzCMeQe++jV8M9lsc55QpNdAuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlay8WZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB7C4CEED;
	Mon, 11 Aug 2025 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754921231;
	bh=K8K9ZqtZvAXY/qtQK4SMOEyyAf2d3MR1QUMImvS+two=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlay8WZSqkE3KKj0I1X7u02GQ4kNLlkdehe1UgUAg7QVB+LHjbzbN2IUKYjg5OKR1
	 mhzytmQ4+fwf+e6nPec5FzAz8IQfBsfISJ1XApNpPa9RZ9Ab+MlcZocwsp6E69kpvJ
	 HSFPn/t/Tm8p1bHpuIgaNtLMkeaIBazzX4qfIyIQ5Rwgwx7Ngv0Phcya202t7l5mVV
	 u2ISgmILpPaDiMJM6rsYbhS0be13S8nLv74DtIlP3hOHLOMGlBgMmHgn8yJ9UxBmTw
	 5ia7k4L1vK346JWUi0cXDeGrjhEmBHGJM1CDDVnuIJpuGnT+OmM38GT6nhxw6ZwHxv
	 IsJGDsHgF1t+g==
From: Christian Brauner <brauner@kernel.org>
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: fix incorrect lflags value in the move_mount syscall
Date: Mon, 11 Aug 2025 16:06:59 +0200
Message-ID: <20250811-zitat-diebe-3acc89b8c971@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811052426.129188-1-yuntao.wang@linux.dev>
References: <20250811052426.129188-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=brauner@kernel.org; h=from:subject:message-id; bh=K8K9ZqtZvAXY/qtQK4SMOEyyAf2d3MR1QUMImvS+two=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTM/MlVtSns+RvOPAnm3Z7ZC7qcvnsWvefUZW7J8BIQ2 lWztdGio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK8dgz/S7imXyl5KSWdZC01 Y83eCdtf8/nOnNv6KFrubXpEW+rn+wz/fT5O91n2Y3GvsJWGaaEq45s2tggd7puhZ7+H5ps+6dv CCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 13:24:26 +0800, Yuntao Wang wrote:
> The lflags value used to look up from_path was overwritten by the one used
> to look up to_path.
> 
> In other words, from_path was looked up with the wrong lflags value. Fix it.
> 
> 

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

[1/1] fs: fix incorrect lflags value in the move_mount syscall
      https://git.kernel.org/vfs/vfs/c/593d9e4c3d63

