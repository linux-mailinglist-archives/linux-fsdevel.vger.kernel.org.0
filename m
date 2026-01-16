Return-Path: <linux-fsdevel+bounces-74082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF495D2F0D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC4533036C47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2818271471;
	Fri, 16 Jan 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l93dHf+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E130BB8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557095; cv=none; b=P6U+cFADC3lly0eZDeBQNAp5FJiHPuwKnwwDWerJ5M9cXSrLBDr4QX2peH9cyF2skQfeWLAfCALoOVYJTXFKe60JInYw7J2ddPuJGveSDMbVuxBrcnZrjMPnW8tuTUmSUnEn70uDMUD04XPoHl/CuGXkcTBQlTUr2PZ3eYrUo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557095; c=relaxed/simple;
	bh=498nBfMTtT/azYO/QXnaUlp/ktfPo1P0t59htdEnoJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNLU7S5cN+SfN4awEsQVQbEHWi3DoA6I0e5cGHphcMm2ngnuAckSP/KXBXS6mWiwQnVvtjhjh1rsKDs3Cd6zG7K9/Q/nngDWluFK2QVdVIV0lcXMKMFs+3eRWyEgWohUMLHxYgzfWo7ffzfGzE2ZX63TmH8z86Bo4f4ECcH7clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l93dHf+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35614C116C6;
	Fri, 16 Jan 2026 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768557095;
	bh=498nBfMTtT/azYO/QXnaUlp/ktfPo1P0t59htdEnoJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l93dHf+6Ld1aX7BsvLaoWT0aEuZy/o2naH1QbgeXyHhCJBMIJ8I8Y9lL7KnznCMi1
	 bfLJuy5Sk4xLKDxUV+IfvSioqGDOI806XsJTC6OXNnhENagBWlobSMMJKexQCmVgne
	 H0Nrb4BqKlCTeRIjnC4C6KLMnMlWwbQjBVYBfOr5xgzB4/JO4uzW0MRi9ExyXQzglh
	 Ogej/OULIuuWeGFNhjSsz93TffoipImW/4S62Ry02AsbHKQH/gXzr80i2MhFzWEvYX
	 uiLnYOHMWyzFk3pwCj+qrhUDsM97+FwY47MxG2OUPsQKXRebHOyQhjpiksOEqfCWXd
	 QgvG2lU2TIG1Q==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Date: Fri, 16 Jan 2026 10:51:29 +0100
Message-ID: <20260116-wacklig-kauft-7f0da31ccf10@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115122341.556026-1-mszeredi@redhat.com>
References: <20260115122341.556026-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=brauner@kernel.org; h=from:subject:message-id; bh=498nBfMTtT/azYO/QXnaUlp/ktfPo1P0t59htdEnoJM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRmcSltfVIc+tosJbOnYsGboNrd3S1P7IO57x7bOjHaa cFLMbuVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJkWJkePghXFaJ/6Ozt3fb 8zzd2xG726dqZKv0mKkEzNnfb9DNwMjwK+HBzo/aByZezn2YmmzukBPekzvBzSdW5/3DV7rzEtu YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 13:23:40 +0100, Miklos Szeredi wrote:
> Without exception all caller do that.  So move the allocation into the
> helper.
> 
> This reduces boilerplate and removes unnecessary error checking.
> 
> 

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] posix_acl: make posix_acl_to_xattr() alloc the buffer
      https://git.kernel.org/vfs/vfs/c/6cbfdf89470e

