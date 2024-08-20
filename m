Return-Path: <linux-fsdevel+bounces-26378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D281958BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE141C21C80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C3A1BB6A1;
	Tue, 20 Aug 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL4ZQlS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4602192B83
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170056; cv=none; b=WT9hHQ8J2Ns6ib9XKcGfNAiB/I2VuJfQIXT5xM7AyL+sJnVdYhSV189lE6JrfpMwKwdQPOMjrsfn8y2x2rIdy+OHYb70C5VdB70GDQo+Hwx9DoIEOszDmdNf4oxWgOjDPBqRO3ygK1upqRkrItNVq5c2k+uh6FeFrV+gSSdslUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170056; c=relaxed/simple;
	bh=vQaqAitSD8zjQ4WrCi/snDMGSRzMp5NkTpK7rN760cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha/NvA5G8FbasTcMHGqlfjUy0awGd85yvXjKYto0BpeK5DA//riFd5IxLIsgatpfF0wy6mPUzZxrAj8djvkErYdVkW9MZsutXBCtrYcJyIXwQydTHjj4oh/JJj9Ack0J46QImbBBvCXB5/A6v5gVcEoHr/81l+GtYfGrANaElbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL4ZQlS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCA2C4AF10;
	Tue, 20 Aug 2024 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724170056;
	bh=vQaqAitSD8zjQ4WrCi/snDMGSRzMp5NkTpK7rN760cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SL4ZQlS9+VHyJktxi4MIQKwUBrPTWCCtWRa3FkrYKggLoe9YJevrcH5S3Tka3Rbz3
	 t5erCNq/KFqbzLEoiq5XR2RqS5v7KLz00Z1VxkRYeYyj9ko3SPBoXk13ccGqhe7XS2
	 mcNhzJR+emLSazKQjECSEqdwMvUtnBreG7pf5NkUIP+GkzDpsGMnQf38Tlv5ms4Qim
	 lh1gndWKU18fEt0B0JFduSua24JyksGngllIbw9n3RaqRom7goNPPWp04ZNXsza87k
	 ivs3rHw9Kfu/ExxNrrVjVkhgGEFV69SdYVaiI5oskYaGRiGE0coIDiLhuDR5Luv8W+
	 ThQZdGsNhIQhg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 5/5] inode: make i_state a u32
Date: Tue, 20 Aug 2024 18:06:58 +0200
Message-ID: <20240820-work-i_state-v1-5-794360714829@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820-work-i_state-v1-0-794360714829@kernel.org>
References: <20240820-work-i_state-v1-0-794360714829@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=677; i=brauner@kernel.org; h=from:subject:message-id; bh=vQaqAitSD8zjQ4WrCi/snDMGSRzMp5NkTpK7rN760cM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd2a/Uc+vR5TtFtY9Kr2+1+npucsZjLmU9//NSpryPl lasvLMyv6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiIeaMDLPYLvxewmWafsD0 /ta/6383bvi2yTXzA7fOns990lHcN1IYGS7qe1W8SXlUa64WzXjpksU8s9rsS3M2h6710OKdOOW BGDcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we use the wait var event mechanism make i_state a u32 and free
up 4 bytes. This means we currently have two 4 byte holes in struct
inode which we can pack.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f854f83e91af..54cfb75b6a28 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -681,7 +681,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	unsigned long		i_state;
+	u32			i_state;
 	struct rw_semaphore	i_rwsem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */

-- 
2.43.0


