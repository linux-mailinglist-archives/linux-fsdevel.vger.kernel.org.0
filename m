Return-Path: <linux-fsdevel+bounces-6998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4BF81F770
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 12:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EA9B24910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2BF7499;
	Thu, 28 Dec 2023 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb4SnXhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6916FDD;
	Thu, 28 Dec 2023 10:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DADC433C9;
	Thu, 28 Dec 2023 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703761056;
	bh=8qaikp+moDcLUiCs4iR4gAs9ViYc3UIWQ8URTTbi/0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xb4SnXhhub20zuAvJSj8WObTIPU/FmjMbsZjgx1mj89rX9LUCiyjw2Y151hW/7xho
	 Ghysn7t3BjjSKBFvPwE/+UDSUWe7mcT3C/WQY/KqR5OXygdNfcyH2/aGJUOSPtxlgn
	 2n+5H75pUaxVh4ZviGRR464HxlbTPxzoLBmUS4p+q7ov7YL0jnZi9fyq1s4adxLJ32
	 akd9B6L/nxU4SU7uC5qZP+MEt5FqzWLtAmqI35NF0yGxuoTegp8jjvVn3b7/Gdm5ta
	 luhuidTHcMuzobBl/7318hganQlzBw4NTHCDX0pF7bENxHVkfVojSzYeKA86oYd09k
	 msWTkN4oUvoUQ==
From: Christian Brauner <brauner@kernel.org>
To: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>
Cc: Christian Brauner <brauner@kernel.org>,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yi.zhang@huawei.com
Subject: Re: [PATCH] reiserfs: fix uninit-value in comp_keys
Date: Thu, 28 Dec 2023 11:57:23 +0100
Message-ID: <20231228-blitzen-unbelastet-0ce4748dbe28@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <tencent_9EA7E746DE92DBC66049A62EDF6ED64CA706@qq.com>
References: <000000000000434c71060d5b6808@google.com> <tencent_9EA7E746DE92DBC66049A62EDF6ED64CA706@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=brauner@kernel.org; h=from:subject:message-id; bh=8qaikp+moDcLUiCs4iR4gAs9ViYc3UIWQ8URTTbi/0c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT2hkyqSwwOihO9JtryRvem2lv3yxsD0xnZVv9uneuj1 fE39LJVRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERK/BkZpm8ref/2fgbbwysX n6W0zH2wNSnYzjH8F++kc398Tb/wPGVkWHlMttr5+qEexz/7ju5YkPHr16bo8hOMulX7cicvY1/ SxwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 26 Dec 2023 15:16:09 +0800, Edward Adam Davis wrote:
> The cpu_key was not initialized in reiserfs_delete_solid_item(), which triggered
> this issue.
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

[1/1] reiserfs: fix uninit-value in comp_keys
      https://git.kernel.org/vfs/vfs/c/dd8f87f21dc3

