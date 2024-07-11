Return-Path: <linux-fsdevel+bounces-23569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D166B92E5E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100A61C20F88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 11:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA1516F0E0;
	Thu, 11 Jul 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZWlnKSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51116EC13;
	Thu, 11 Jul 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696132; cv=none; b=WiDNZQPMKCPB4neqpz6fWrlCsjNS2aqsmREd5Wy8GSiiEU6j+9sXOdfCgdDSzl75LL5BOfoGpTAjrSyGQVBHrlN33RTGWMpdcHpUBjM02s9U4FDzLcmlYeRdwyKOdzdKm0J2jUtiusnRXPZkgsfkvElq0J+5MH8umi85UMHiY+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696132; c=relaxed/simple;
	bh=OTapqLUtOhOklsMt0JtGipDN7/MAEwqOBUQ+KnQBUIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGTIkZbdQXaTOpzkA+/lkrP89EoQlmxGB4SgocJhEIrIaFf9Rn2N3I1mDxyneWnS5zsofDjMwkXCEnXgEIDexDeI0SfpLnhsRV2wkKax73b7owcBbM4S9Ego08pcTpELRo9t3bvz8ahFBBaaZJbnzs+PNCFMoHfdvupxxXDJEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZWlnKSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C94C4AF0D;
	Thu, 11 Jul 2024 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720696132;
	bh=OTapqLUtOhOklsMt0JtGipDN7/MAEwqOBUQ+KnQBUIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kZWlnKStTWj/I08Tl3NCNpksnVXMXWM9yXlhktX3p2YwFtK1kZcembFkaADm1ByML
	 2hqUuLfknzwwRWW8jz0tWvJZnTLio+NcpivJ7DKtiZzjradOKuHmkN/rEMucFiJoVD
	 qrqSIY5CLhJuV+gEMUuHR4ZYrg39tcU+yG36QOb53fR2jfy+FtZv4VnGEX/i9um87T
	 Hct1UhKTZePkdLV9+ldCeBWNs80da+df5Om6mWiOakKtFDt83ux9e+hcKRLH/jc+dO
	 wb08v3rnt5ZOUgzIkWiy7lcUXUxtmHZ5Xyy9dCUoLkfwj8sgDCq5Us7mAzhTwXAyWR
	 bhpic4mjWPRMQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jul 2024 07:08:13 -0400
Subject: [PATCH v5 9/9] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-mgtime-v5-9-37bb5b465feb@kernel.org>
References: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
In-Reply-To: <20240711-mgtime-v5-0-37bb5b465feb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Dave Chinner <david@fromorbit.com>, Andi Kleen <ak@linux.intel.com>, 
 Christoph Hellwig <hch@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Randy Dunlap <rdunlap@infradead.org>, kernel-team@fb.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
 linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OTapqLUtOhOklsMt0JtGipDN7/MAEwqOBUQ+KnQBUIw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmj70l7ZnQeMlGHhjvFghMhoPkLSm0RtSQvRi/6
 iYpytjkGrGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZo+9JQAKCRAADmhBGVaC
 FZNfEADRHxrrM5sremg5UaJseVwuJj4hBX4wOg9PWhSGsvDhBSLnesYgeOMU7tABwVt/Z/8KcII
 E7FyeB7UeKZrk8KHbfDLrkFr4s2S/TsKPL0w538UEz8RtlzRM4BSv05QfJBJoRKpw3uBgJQA2St
 owelXYZBb5lXQeYVY3Xjg6yE03rw7iXm7Wu6v+u5+KVwkX9L5Cybg1j5UmqyA7WAs0lIqln/R+p
 wRjdQjL+3DK8MeqWiReYlmE9bBRLXa6DAseu3M4zC6xlaNGriEHoTWjFGbtyVwrPBailuJjRHrY
 wlIbkJBkkU72wY8rV4URo52g0iKX5b26BzHIzseEAqFJP6QHZGBVS6xFGsT/V4kw6EtPicdbsYN
 7FlnO1dz1NWgv+TY02YEv5Gwd1Qxi3FeOHpJxt9o+5H5ASHjBGqlsdfjbp/hykirLGwFeBwQjAr
 vrz+47ffKte5ROyhV/V2djA/crlVqZq8xMxybO3ewVl5FymC+c4VbtWkTS60XsbXyFieFVR6Akb
 lnJcrsgvNEjeJoI01ocrq89wTYm9uYLYl6Z4W/Ffcp9WVS+BDgNe2Qk0r7JXbZ/aKZ8Jjm96txk
 +IdIydQLrUXuYBlPjpWI3oZp1xjrFddm/vOkQfR9dOD4JKH/hotMg3sRlNQzAo7lHreH0cGxP+Y
 TpESK6T5rsq7iwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 7f2b609945a5..75a9a73a769f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4660,7 +4660,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.45.2


