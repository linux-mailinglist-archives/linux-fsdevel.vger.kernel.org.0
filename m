Return-Path: <linux-fsdevel+bounces-2214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B4B7E38D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F7CEB20C9F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46E13FE9;
	Tue,  7 Nov 2023 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLtJCONe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3712E7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 10:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A49C433C7;
	Tue,  7 Nov 2023 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699352382;
	bh=A4VPcvJ4dA+Yy8VOtHRw4WXDaIsSxBzIv4UlMHj8gJs=;
	h=From:To:Cc:Subject:Date:From;
	b=sLtJCONeJ6nLpIRdKU8X4Q3JZFoYcS4azYOe+wFgV/Mbij8DHlBf0R4M5sOpI8q6u
	 whedvNbxP9ddmU3DyW/JTXmfw6G7ex1SSPB6oCMd0n24HBEvZS9pNFkCrlyke7GNT8
	 87sOd7qw5dwZ8So6989NYKi6wqgMMqFqK2oggc+cPHJPZ3DPpj+K7AnGUrDyWGizBK
	 Jb+caC0Xi1bTFTP+28Op6YGnSf2aT7iPItFHOQ+FQRqa4D5O6MjVcBta2o3r1DP5O/
	 WVjrD8et+PmI4Z5bp/vyuldDurbdhVj671HmzgdzdStDJbxkSFLybRr6JgqMb8IwgA
	 WKFBOmv9N2aTQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs iomap updates
Date: Tue,  7 Nov 2023 11:18:34 +0100
Message-Id: <20231107-vfs-iomap-60b485c2b4fb@brauner>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=brauner@kernel.org; h=from:subject:message-id; bh=A4VPcvJ4dA+Yy8VOtHRw4WXDaIsSxBzIv4UlMHj8gJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR68d2aajXBTNn/85MpagFbnbWUD++JfZ77aDuj84ZfnfWX pvsv7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIsikjw4aQny+tLgjP2sNg4VKw+I 9hh9X2HRseHziz9f/UIzwnYyQYGRY49UhOKUqbbm93fsb+nYJMtn3r1jdzzKp6aFQkv8dwHQsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
As discussed on list last week this makes fs/iomap part of vfs.git with
Darrick as main reviewer.

/* Testing */
clang: Debian clang version 16.0.6 (16)
gcc: gcc (Debian 13.2.0-5) 13.2.0

All patches are based on v6.6 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.7.iomap

for you to fetch changes up to 64bc7eee421fafc5d491d65bff74f46430fe61af:

  iomap: rename iomap entry (2023-11-07 10:52:08 +0100)

Please consider pulling these changes from the signed vfs-6.7.iomap tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.7.iomap

----------------------------------------------------------------
Christian Brauner (1):
      iomap: rename iomap entry

Darrick J. Wong (1):
      iomap: rotate maintainers

 MAINTAINERS | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

