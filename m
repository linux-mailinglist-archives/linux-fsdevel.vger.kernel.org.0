Return-Path: <linux-fsdevel+bounces-44441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35CFA68D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A363AE2D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7B254AFC;
	Wed, 19 Mar 2025 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ge8be7+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D72372;
	Wed, 19 Mar 2025 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389242; cv=none; b=bEizGxPYyD5kT9cf4r1IMjoru8l+9o1GbBpYxj+a3AUevC0D2xBWpNEXNOqjVMRRRTN6KEIl0Q9mihFzrwg9uIaXTYvDlgISFGessO+rytikeUZTQwUQBRxTm4bcWWp5or1TMZWe/ZD1bwq6+tGWkvwW8r2jFg2FvagOTOLJhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389242; c=relaxed/simple;
	bh=mKdT4eF604z8dN4+OFiuI30MPb/nu8Lyac+BZqCT/eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiFPzt6DDI9RV+Hs2zgG0pUlSG5doNUFccZnI5rgUgQ8+nh5JFIA8kmVAN9bxQ3oUtjP+NqYXPoKTKOIEEzJiD4IdQ4978KmnYatSVRorEwdE309qnoGYi7i/wNIov3CEQ0gDCXjs5jBBVLOJOEDHFAr9J1FAQtK2s82tSogjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ge8be7+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454EEC4CEE9;
	Wed, 19 Mar 2025 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742389242;
	bh=mKdT4eF604z8dN4+OFiuI30MPb/nu8Lyac+BZqCT/eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ge8be7+O8THrG4C0dT+3Q3+NNm1YL2dBh+JUVOBOYxcOyh02nxqkNVwdP5CjiQ+IR
	 gZ01I/p+9R6uZas2T+VCqry7Hlns4jFQEkU6JD6Rym69Rk65Z+jx3gOaOq3Ve1mtlS
	 25gYwKgqZNl1u+qIS9cM0EdrAOuPktkvM0obCnINn/iKHermp/UlN+9YrhfsIKH27S
	 fy/iK3GrDwh8ZXn+NtkLzcEaPO8a+maJfiXUzQ0SYmAF/9IMXd0yzYOEkVO6shGFeK
	 HS0oVAauFWNrj1UYpw6wKloQEtyjmfZhs1yzEbmhBoCfeJKwKkuu/MAke8siXmVNh9
	 UaBgt2mvqA/rw==
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH] fuse: fix possible deadlock if rings are never initialized
Date: Wed, 19 Mar 2025 14:00:25 +0100
Message-ID: <20250319-geregelt-hohen-c59e1649473a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306111218.13734-1-luis@igalia.com>
References: <20250306111218.13734-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=brauner@kernel.org; h=from:subject:message-id; bh=mKdT4eF604z8dN4+OFiuI30MPb/nu8Lyac+BZqCT/eY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTf2v/xkPKE79+SFyz6Y8BsuLqh+2zC1/g9859N3Ztxc p7Pw9mPN3WUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMJOQ3wz9L++lf5+yXMnz8 Zed0/QbpT3vi5dlXznRL5IjaFP16T/5+RoamwPVfX/zsMzOUED5XZJGvoLbihh1fBXu5yg1n/iP uzPwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 06 Mar 2025 11:12:18 +0000, Luis Henriques wrote:
> When mounting a user-space filesystem using io_uring, the initialization
> of the rings is done separately in the server side.  If for some reason
> (e.g. a server bug) this step is not performed it will be impossible to
> unmount the filesystem if there are already requests waiting.
> 
> This issue is easily reproduced with the libfuse passthrough_ll example,
> if the queue depth is set to '0' and a request is queued before trying to
> unmount the filesystem.  When trying to force the unmount, fuse_abort_conn()
> will try to wake up all tasks waiting in fc->blocked_waitq, but because the
> rings were never initialized, fuse_uring_ready() will never return 'true'.
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

[1/1] fuse: fix possible deadlock if rings are never initialized
      https://git.kernel.org/vfs/vfs/c/d55011469b41

