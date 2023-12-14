Return-Path: <linux-fsdevel+bounces-6050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4E812DD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 11:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7481C21506
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C683D98E;
	Thu, 14 Dec 2023 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMFfqC4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4373D3BC;
	Thu, 14 Dec 2023 10:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB0FC433C8;
	Thu, 14 Dec 2023 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702551328;
	bh=dOHfKJ1H5Yv4IAoRy4gpJnm+3MqfFLCm0K0QAMRIqk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XMFfqC4fH1moFbk3rbUruEybthFx4pghbNQ3GrwVQ101Jz8GdgjwxNQbifFnkvmy8
	 2keVRO8t2F8SxAiafKclJilYeTpyLvpt+yzkWg0R69zw1IjcWQJMsRISxGlsbRXmzZ
	 qA+a25hALeHaDgNztnvx6+W6CsCKMgsrdh1phd+Ws0N/AVQNBNLcYcbePobluRIFd5
	 2P4810geWzWzy/baIcXAFzlzfcQy7DE95e5eP4FG9fbeHrg79nzSNyNme52tkB7Tqd
	 4VF9F6XJ4WaWod7fxaILA0a5agkzAijmmTjUhldOStFtS+KKIGKVvvHLLXHOURZ/gA
	 CQ8UUqsYztKGA==
From: Christian Brauner <brauner@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	overlayfs <linux-unionfs@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 1/2 v2] fs/proc: show correct device and inode numbers in /proc/pid/maps
Date: Thu, 14 Dec 2023 11:55:04 +0100
Message-ID: <20231214-datieren-maler-10004f2ff2c3@brauner>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214064439.1023011-1-avagin@google.com>
References: <20231214064439.1023011-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=brauner@kernel.org; h=from:subject:message-id; bh=dOHfKJ1H5Yv4IAoRy4gpJnm+3MqfFLCm0K0QAMRIqk8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRW3Wff3frux6qykENz9S+anNN6efD5zrY9LgvvKpidi ZX2z9Ap7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIGxcjwyfliWs2v7m/V77w zJPtfA9k9lgnrrzj13NSL0D8qEjEzo0M/8tuF77hXLvkmErfgW3l2ftvHXK9/HcO/7LPTYkxiTL 9SVwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Dec 2023 22:44:38 -0800, Andrei Vagin wrote:
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.
> 
> [...]

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

[1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
      https://git.kernel.org/vfs/vfs/c/26b50595e169
[2/2] selftests/overlayfs: verify device and inode numbers in /proc/pid/maps
      https://git.kernel.org/vfs/vfs/c/22d9cfff4639

