Return-Path: <linux-fsdevel+bounces-21889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BE90D674
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85DEBB233FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A2613C821;
	Tue, 18 Jun 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8ZyEDqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68113792B;
	Tue, 18 Jun 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721181; cv=none; b=S/n21bMd2Ie6TGJXxEY/ccF4tahd5qkL8BVsLaQ5s4+LhBn+8lOf60svpVmyt9khF4hHNMuOtMPTbNht3qZI2vLk63Z4DeUD7W8eXBIvXz/D8VGsfT43vVDNhjqf9M3LqWGSFTYokX9sjJdiVew/1clwpF1eYrxmRQBo2uIrmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721181; c=relaxed/simple;
	bh=A+79vWupD/VxycvUwB64PrvqaBGUAPzK3N53rHfZBRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng7Mmkm0oW4CviM9qwjr7U5cBYxehTt+3kOTDEbBH/sH2KcjwzxZtx9iiq12k+2LHNRf23Xl7CvM7miMauAhgpeexU3TkgxsiiuKQhbhWRrwWEmYZFR5Wd11bI8mJEGtvrFryBb2j+0oKD0YoM9tePTasbvqSdPLqjy09pGGPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8ZyEDqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86BFC3277B;
	Tue, 18 Jun 2024 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718721180;
	bh=A+79vWupD/VxycvUwB64PrvqaBGUAPzK3N53rHfZBRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8ZyEDqgCkax/DcpF4nYawuGeBCkOGglsQey0GtiKZyzdjR9wfku2fmVVxAe4UbXg
	 i4MvVm45faIZbSa4F2gN42i2jo+l5ignHDQu8NtBMGOvd2dKHEIVDIjbwUobEWOZuV
	 3SCdqn8zdENPBjbwAKVsfmRx5J0YLx3P2HqtM8H8kD1yg7ADtxLHH/5vKs5xm0oyfB
	 LO5tHelB36Dmy/X06+rWzBgQ/xd4SXCxkZx4cicrKTnq0KQiQJUAFPH4L1eBWh7nZL
	 km52cuewrPce/lYK46EtMvBw1ZmcMB3gEy1hiQ7NetG8dwxeX8xGTWGe6Kd06wKAv9
	 HEyQ59J/wvVkA==
From: Christian Brauner <brauner@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] Documentation: the design of iomap and how to port
Date: Tue, 18 Jun 2024 16:32:30 +0200
Message-ID: <20240618-kundig-kredenzen-f8e4a2dfda72@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614214347.GK6125@frogsfrogsfrogs>
References: <20240614214347.GK6125@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=brauner@kernel.org; h=from:subject:message-id; bh=A+79vWupD/VxycvUwB64PrvqaBGUAPzK3N53rHfZBRg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVzpqqvaVPWFP4ws97my+3Lqy34zI7lcJydPP2ZZpbV srKKV+/21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR4xsY/rskbbibt0Fn3oy1 F5M/uqw5+HzDAtsCzcn7uPnj3HQuM7oz/JWsLvJeqGFiOmn6kv6lM5ZMvBJZuLyU1676i6Usi/G FbQwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 14 Jun 2024 14:43:47 -0700, Darrick J. Wong wrote:
> Capture the design of iomap and how to port filesystems to use it.
> Apologies for all the rst formatting, but it's necessary to distinguish
> code from regular text.
> 
> A lot of this has been collected from various email conversations, code
> comments, commit messages, my own understanding of iomap, and
> Ritesh/Luis' previous efforts to create a document.  Please note a large
> part of this has been taken from Dave's reply to last iomap doc
> patchset. Thanks to Ritesh, Luis, Dave, Darrick, Matthew, Christoph and
> other iomap developers who have taken time to explain the iomap design
> in various emails, commits, comments etc.
> 
> [...]

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/1] Documentation: the design of iomap and how to port
      https://git.kernel.org/vfs/vfs/c/549c1f8d490e

