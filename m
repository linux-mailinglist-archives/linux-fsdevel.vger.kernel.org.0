Return-Path: <linux-fsdevel+bounces-26908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D495CCCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A51F21196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B411185E7B;
	Fri, 23 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOeou85u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FB1849CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417291; cv=none; b=FH6T0nFl/wuSyAG+PhOcMg/1jG2Fyee7ZiXQSg7oVSsqTv6XfLOOQGn0z6dIun/RjgRFglDOseSHX1dcucdvDDtg49sHtPGmE8DSiR0CnXbAXdvWxWhstlaRjMUPElHrg1SOa8DRb/K9aO0Y2l+btEUM2SXL7aPw8s9KKaPfg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417291; c=relaxed/simple;
	bh=ZbnemhAZAnpW15/SNSfrTfr8p+y1+hp11Dudl3zOWlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH3HYLI5gt8Y1ljv7Tq7IBJJdXNtFW/VfBMoQMGIq03lX5vp1N2PSSkvu5hQqmPHLCts4aKleGdBQwOeIqETP7h0x/sXO1gAM75NPjKZ/FZJ9tc0qaWqPCjwxjCnXpnvB4Eb05iQYrNo2/RSenjB4jmjfWXmTT3yNm3hJynj/gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOeou85u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333BAC4AF0F;
	Fri, 23 Aug 2024 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724417291;
	bh=ZbnemhAZAnpW15/SNSfrTfr8p+y1+hp11Dudl3zOWlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOeou85uOjz/t3TGbPH3AoEjglXYluTo/xGkOQeyh8NCJvyRpbuuStOcChjt1uErl
	 3IEv6hy7dgglxp3RG+pZ2iWGUo5fj1Pghz8NrZMlCwVqqtPYOYa+kLGkcDSi7+tZEf
	 o6oe2s+Tu3DcRMOMg4ZvWTVk6SRM/fFIf90zxjZRKLMraoOhS70PlO5lGmN7XxVF2h
	 Z/sFf6x0mlbiyl4OOz7YJiYJWaXEvyrLywGGdTGz7j1lIVTmzNsxGhUv1GRi/adZFK
	 Rami1MSKWFBQXNxe8g8tjYzHZW2hEhpICz6/oBabJTif94IgIoBQIFShGYszk1qewe
	 JkzWelL2W5TQQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 6/6] inode: make i_state a u32
Date: Fri, 23 Aug 2024 14:47:40 +0200
Message-ID: <20240823-work-i_state-v3-6-5cd5fd207a57@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
References: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=brauner@kernel.org; h=from:subject:message-id; bh=ZbnemhAZAnpW15/SNSfrTfr8p+y1+hp11Dudl3zOWlE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdaHl3cn6Xf6kTE+tWQY4uux9bfV8rdPa+qlt3VYXTo LT7xjTvjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4szH89/5x6b4Rk0+PolRT l8i/h1GX2vie3lLblFz+g6n8eZ30J4b/gadXvdtrs7XxkmT12aM23YanfxyYp5sXG1hXNNn+9zk HdgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Now that we use the wait var event mechanism make i_state a u32 and free
up 4 bytes. This means we currently have two 4 byte holes in struct
inode which we can pack.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f257f8fad7d0..746ac60cef92 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -681,7 +681,8 @@ struct inode {
 #endif
 
 	/* Misc */
-	unsigned long		i_state;
+	u32			i_state;
+	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */

-- 
2.43.0


