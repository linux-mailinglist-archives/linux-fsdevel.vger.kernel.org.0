Return-Path: <linux-fsdevel+bounces-22584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E1919CBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 03:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E065CB22E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474354D8C3;
	Thu, 27 Jun 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr9ChiUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3A48CDD;
	Thu, 27 Jun 2024 01:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719450052; cv=none; b=Dkg6lLdm3zAcMl+WLdtnbsZc7fWA6K8Am5+93ur6rFy5QBDAGz+VfZnOy3NBSAWPHiJf11DX9An/0QQIOxwAskZyXvUsFilSHNh8vs4JhcMdhUKtF62ZnvrGhx9XMN2inym2m7QCsewS707IJYxkIU941oY6DqdCTUq/P/ZIISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719450052; c=relaxed/simple;
	bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgqJ+yX1MjnlSwWJTwm3MfTFQS+giFqTvd6Mi+qstGStsXJNFtfMcPsJ+d7Oz6RY3RBYVCE1cvD3xP8T4/6xeV5/S8Si+dSbCt0r3V2eM1S+YQkEHNOzEgui0ZXLRbCc99xnNP/KX+qdaHY8dbl8VXFFL2cuexlgCqXwYS0mswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr9ChiUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66928C4AF0D;
	Thu, 27 Jun 2024 01:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719450052;
	bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sr9ChiUu/HOsm1DsI0g6vQFuwDNK9Yj0f/PnCpCU6pRp+u4CF7nqtx+HCVqlhx6Hj
	 HMTeApGIieSv04dS6W3ujYsyGSeOP+p4Dgc1VMLOPUKjQ55g221rFhfVjU/hDgAgry
	 uZbBTcKyh+Gkh0gLcEU/sf3UGuZEFrHIRejP82Td27zeA7N0srKiiFyu08z33MisE0
	 OsyehPxrgZC658BcQmWV0tJhgFbFJ4EeNilJ9UaxG65NIxrqO367fFlOTlnIgnIxPS
	 OjlR+ht+u63kFmQB6jCkY0npDtqM9sB9F4X9IOKGN+m4jSon1PX/mJOJlA5CxISIcn
	 VlAzfenYaviWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 26 Jun 2024 21:00:28 -0400
Subject: [PATCH 08/10] ext4: switch to multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-mgtime-v1-8-a189352d0f8f@kernel.org>
References: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
In-Reply-To: <20240626-mgtime-v1-0-a189352d0f8f@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Rk22CdrDmdQOqV9B263elJ8j6v40sRU7F5SFeqVcw0c=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmfLmvqkH1GH6QlyLmqwfY2ESip2uk0QjCTjONT
 BWdPqsbpveJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZny5rwAKCRAADmhBGVaC
 Ffc+D/9f0X0vSHUxlsnazyA1xAWKX2SHeCtT2+4AWal62qmtzL0zDfdsa9FrQjjYp2Lb4y2cqIE
 BxzRUA+YHUkqyhEjKitJQs53rlXD1v80bjzOWwIkxaKqNPFbZ7aAudQIbTZy789FfEZuiC/w3BZ
 KkQoB88sOffNZMQj0TTwlMoeWj1fk24AWCvsXkjXtyF6vhA3n4JkWhik0UtV47RDe8RVAbBb1F9
 Q1sxt5fHsjxEf7XeQYezhIZzQ9gYFmUFxeKOz0+On39zx/WU9bXr2BfB9bkl9iCcY1K1ZHCtX2g
 i14XcGB/btpbkld+TOhURgTVbNyfffpEPxe4Zcke22To5jcLoZRsYn0MSPPClhhAZpsd6pXahia
 /JaVEkCoRXpHPbUbo7hnVUewiomTNU3AsJXcmWrQaL4S793aijKo2q86UPV5n5GBDMS/XWkYNVO
 g8Vm50/QN5pqeMtsNgO0qySwNglfhAQ8Yb15ImlD4cQtgHNmcIZ9YFwI+T3lTivNKrwkaaH1HKk
 E+0JmRxCW0dAmw4niwg2v9T3RCNtIQl41GkKrNFSe5n6bIZwA+ql6pZqqP+Nwh8CRjrpOFOt6Ga
 WAd2d9Kq/s1MV+pCktB4A6JbvYjEAUc/VPvlpU+BoUfMshyfeo0t557aEfD9pgeAVJnopa4O0Al
 IVvzX5z4937vJLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

For ext4, we only need to enable the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64..9ae48763f81f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7310,7 +7310,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
 

-- 
2.45.2


