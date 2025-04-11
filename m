Return-Path: <linux-fsdevel+bounces-46276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23405A860BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA758C216C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4291F8EEF;
	Fri, 11 Apr 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGF2adS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BB1F5858;
	Fri, 11 Apr 2025 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382078; cv=none; b=bEIQdDLN6pGrSKl0T1KeFanwDcEJIrHJVe8KRirqCOVrIoyg+CaP7OfUsTEgHMCMHw04zqWV1Tapwf+9X0EAb52VueI4gruY9ZcsLMz0BsZsVkmUmDcfJL2Fr7uq6y9HLXF7/x7ENjuNN/GELZoYFklt+mAfIMatoHVPXehSb6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382078; c=relaxed/simple;
	bh=1hBjehO9FygwAVYBIL1GBukuO7fz6vrwY0V1D2OpCg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pv2Y581ONBDjqCvvUCTn82gFfmVLPhi/z3BoeNSJQSHhXQCFQGZFFdKQGD3hiGDTZIDorkAJF48p7CMfQZJi4M3ZPaBOHsMmKxggRsfEYNOXfqk0QxX1G3OvwI65991pEfs2nd7ztZg44GlPTsfAeZl9/QTaBR1NHd8kHpLFSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGF2adS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E89C4CEE7;
	Fri, 11 Apr 2025 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744382078;
	bh=1hBjehO9FygwAVYBIL1GBukuO7fz6vrwY0V1D2OpCg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGF2adS7xuZk/PzTvT453ZTR0fXKu8kM0fye2aipWE+KA4zEKWvxvDBVR1p3P7ivF
	 3fAxwbXvDQxHSMan8RbZi/lO8oxOGmd2mFSNYwP3UXkne6iqiAiF+tGOXQvCiOhGQk
	 WiWCuDaj97vVxgUNvxZ8AY7OnzcSDzl8QYFce+Ez2Zbk472YM3nVBmPIY35la95XjN
	 qaA1ddPB5V5E0kByu44aINOvYYksCSCLJo63aoMxzdDuqMdUrV/gtKJ9ttBjkYvUtB
	 SUVjZKdl5xzBIkJoBD2yNLbsce7WlFzXmxZTXU7aMU60onitzQczS0GdEzWXkEdYK/
	 sP/FIW8B2XRZw==
From: Christian Brauner <brauner@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>
Subject: Re: (subset) [PATCH 1/5] fs/filesystems: Fix potential unsigned integer underflow in fs_name()
Date: Fri, 11 Apr 2025 16:34:26 +0200
Message-ID: <20250411-wanken-lohnt-e19fc787eca0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com> <20250410-fix_fs-v1-1-7c14ccc8ebaa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=brauner@kernel.org; h=from:subject:message-id; bh=1hBjehO9FygwAVYBIL1GBukuO7fz6vrwY0V1D2OpCg8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT/1Kjk6Fn0wc/nREaGHqOZqwRjh61NT1rq3LSgdfKXl jOvtePuKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAjLLIb//ltOKxkePv86oDXp cuFPkUWOf44uYePbcH4Jp+nedWdkZzP8U1jy8ntLXmPX5i79oA7h9ZUvNZdm1gcEfX1yjuH5vKl vuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 10 Apr 2025 19:45:27 +0800, Zijun Hu wrote:
> fs_name() has @index as unsigned int, so there is underflow risk for
> operation '@index--'.
> 
> Fix by breaking the for loop when '@index == 0' which is also more proper
> than '@index <= 0' for unsigned integer comparison.
> 
> 
> [...]

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/5] fs/filesystems: Fix potential unsigned integer underflow in fs_name()
      https://git.kernel.org/vfs/vfs/c/d319af11e9a1

