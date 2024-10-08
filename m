Return-Path: <linux-fsdevel+bounces-31314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E38B9946FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A528876D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3F01D26F2;
	Tue,  8 Oct 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq1ERBFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6961183CD4;
	Tue,  8 Oct 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387060; cv=none; b=q0eysehv/T2UAvTBNyhC3wutJxo3koM9Z3wKvfLK9+6r2QqDkuOuK0oE+y7ubq9WeyFIz8SE23sVEsfcOUMPtFhjDjzPWNjcMFnudCD6AXpsnz+9VbRTrJI0D1V0FjuIHfLkk7MbdSYxImRMZNaAqUGWL0nNpOW2dwqCD/BEdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387060; c=relaxed/simple;
	bh=LpL9dtMQLqWD4sFWnQHhVp2X1e22LnbI6VuQJzY8JJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuLEQqkoKJigoQ1FLnX7unSJ4oQbIpLb9MgphC1bLHc4g285sQrVT49wLZSkw8Yr8gkzWsxLzP1m//XrgHxRc2PhwDTCGhmMCvkoSSlfHQED3II0SYLQSHVktsi24zxzKg5NNE45Uwdj35+WlUmggWwbW3Wcs51tyhg9ZarzABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq1ERBFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F47DC4CEC7;
	Tue,  8 Oct 2024 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728387060;
	bh=LpL9dtMQLqWD4sFWnQHhVp2X1e22LnbI6VuQJzY8JJ0=;
	h=From:To:Cc:Subject:Date:From;
	b=eq1ERBFbQyt61djlGPEE1niuZpvzQdy2Wo7DPio9ouC7cMlFAmNRYplIX17mMZz+S
	 Vj8GmKvO4sT3Z4CgwO0bKOEGeQJ14uoDG8WmDxEl0SmlLXtGVxf2CVWXaQDMGGd6V3
	 Y57wPUdsxW8t8etJdVAHiHaMlNz0h7PyyX8lnwB6PGemZUQZXayP5iRCN0DZo21CBn
	 0EJNqFRrHMUU87NChkv8P6tuwyxm+r2qy1s0JMuPxwz2F3eJnXt4adeAUD1TA/YgjW
	 Cnx+FgySMFdIQG3v5eaizcU1YrgoQC8zzAkaWnABQdhgQRkPfBetH4XoADqmMCszXV
	 PU0BnhbZ2Hl+g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fcntl: make F_DUPFD_QUERY associative
Date: Tue,  8 Oct 2024 13:30:49 +0200
Message-ID: <20241008-duften-formel-251f967602d5@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=brauner@kernel.org; h=from:subject:message-id; bh=LpL9dtMQLqWD4sFWnQHhVp2X1e22LnbI6VuQJzY8JJ0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSzir+xFdbadU9yBfsx8VaN94/tZWzLjP/wxc+r2RC7R H3Hut0/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiFsTwP3Hbgotzf876cOGV 62VHebN5Bh4Hb7kwNLwUs3LKWnbsxQlGhsXFTvuqz2k4xm4Ktz0rLrPk64PKPx+yvmy/JrPTfba 7OTcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Currently when passing a closed file descriptor to
fcntl(fd, F_DUPFD_QUERY, fd_dup) the order matters:

    fd = open("/dev/null");
    fd_dup = dup(fd);

When we now close one of the file descriptors we get:

    (1) fcntl(fd, fd_dup) // -EBADF
    (2) fcntl(fd_dup, fd) // 0 aka not equal

depending on which file descriptor is passed first. That's not a huge
deal but it gives the api I slightly weird feel. Make it so that the
order doesn't matter by requiring that both file descriptors are valid:

(1') fcntl(fd, fd_dup) // -EBADF
(2') fcntl(fd_dup, fd) // -EBADF

Fixes: c62b758bae6a ("fcntl: add F_DUPFD_QUERY fcntl()")
Cc: <stable@vger.kernel.org>
Reported-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fcntl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..3d89de31066a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -397,6 +397,9 @@ static long f_dupfd_query(int fd, struct file *filp)
 {
 	CLASS(fd_raw, f)(fd);
 
+	if (fd_empty(f))
+		return -EBADF;
+
 	/*
 	 * We can do the 'fdput()' immediately, as the only thing that
 	 * matters is the pointer value which isn't changed by the fdput.
-- 
2.45.2


