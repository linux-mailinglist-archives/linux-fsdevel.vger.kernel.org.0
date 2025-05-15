Return-Path: <linux-fsdevel+bounces-49114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BFAB827E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B74C6854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E432297119;
	Thu, 15 May 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujS3Ov5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0C296736
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301184; cv=none; b=Q4pwt0sC/nMTU8zwWNdbE5tRxQVS0C777w4A99I4qxEkMZZotRCEdxiS+lFPHVHdklzcYQD6mm/YmGLvB+XW2k5FSM9cqyzmcbwWQ+2KFhLfTcBwy1oigBR3crGOUavtG0KXMbSvCdt4/CFDiCxxx/D98fYW+2ND979AcZSOqlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301184; c=relaxed/simple;
	bh=j2/EANdlOe1JMmn4iP8l0CVyYzhbiQV1pQQJ63Xii8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3dHCz9Re5S4bqVJNyyFo2oKChm10II1JtJaqA7mpmYPPYwtksHWz3sDLLZ/smCO2cYySI2nb6KkKWqrgJtQc3hEbkKp0Um1zoI6o8MR5r6mPRYqflH8Rp2wIwytsze5nDgB8/yr7/MRUf3f2TLiJWSeGUhJjgLe6hnVMS8iDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujS3Ov5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD63EC4CEE7;
	Thu, 15 May 2025 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747301184;
	bh=j2/EANdlOe1JMmn4iP8l0CVyYzhbiQV1pQQJ63Xii8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ujS3Ov5IzIDSlVO1H8HIe5CS9j8rMofuXzTWCS7FvzzjNXi8ehFO7/miulyTyV5h2
	 KxpuURdkDpuJ8tqzuGv+Ts02QWkw38jOBd+8Eh6pwzntlAsLpTTRD3QJK34dSWN4Rn
	 LH9sLuYxP1X31U4shrGCiz0ZHbHiZDOnBKJj1g1BuDfSAOsqMBkx4Trt7LxYR+5sc4
	 tEHOgdtN3a4S/BL4GoVGqMzr2T4aKXAGQefdjPp/6TYbGkXCZ0VwUo5FOK4pl2akHg
	 /K52wOeU1AlyQhQmh39nVUVol6aduDxZ5RbpGYeN/QXIlSUsob/50zDEUqiKN153fE
	 1sYn81x8xPmfA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jaco Kroon <jaco@uls.co.za>
Subject: Re: [PATCH] readdir: supply dir_context.count as readdir buffer size hint
Date: Thu, 15 May 2025 11:26:16 +0200
Message-ID: <20250515-genesen-gradmesser-accdbd3fe43d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513151012.1476536-1-mszeredi@redhat.com>
References: <20250513151012.1476536-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=brauner@kernel.org; h=from:subject:message-id; bh=j2/EANdlOe1JMmn4iP8l0CVyYzhbiQV1pQQJ63Xii8M=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSobraeo31oqdzx/2YvOk5YnGsXMe6Z9y9y/+lkzrZ1o RMWdX081lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRC48Z/iemWhXuNCsMS3ki OG+i1hz9uytZ5+fnXfoy49JBy28zIswZGe7JfjCQ2di97+aha0d2s95Z0LlLXPrvnigGOaFdjbM Z/3ADAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 May 2025 17:10:08 +0200, Miklos Szeredi wrote:
> This is a preparation for large readdir buffers in fuse.
> 
> Simply setting the fuse buffer size to the userspace buffer size should
> work, the record sizes are similar (fuse's is slightly larger than libc's,
> so no overflow should ever happen).
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

[1/1] readdir: supply dir_context.count as readdir buffer size hint
      https://git.kernel.org/vfs/vfs/c/e0410e956b97

