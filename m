Return-Path: <linux-fsdevel+bounces-37241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E19EFFC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ADE1883E4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D9A1DE884;
	Thu, 12 Dec 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXq+k5PR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C011DE3DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044639; cv=none; b=MFJz79Q57LXfMadRp2I7KXsbbLtsCwgnqex23W/PsCAe5OrCQ7gMZfa2tHb3zDpnfD2LwjIJQNED9Au6wkSSyNGaW7bBEW/dRtOTArxmy6ZvnUseBZWASx4NAThOCEQe7R3jLCTOX1s/dJBJ8I+13+vLVHEM6oDxRwGdAL0KjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044639; c=relaxed/simple;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdx/LvNkVoG+7R3bXlVv9U4SG+24R1n52tsityJ96YFA7WkZ8h/b1gARamnmDENwxyJAJsXIxCX4asyugEV91XYQH2yy0WH8msYtlWmSLq0zfb3tWQCjb3FJg3YFRnJmoeDpAC90YicP8wxzM7gUHr+CG54xCdgoTQRtI3BvI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXq+k5PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB2AC4CED0;
	Thu, 12 Dec 2024 23:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044638;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NXq+k5PRTDf55jisKjLCSM6R+CtzOKUHkdXFm+S5vkwcJcUD3UJFIIrxFm1e/hSZ7
	 /bmsNX4c2xg3jeHwM9JWITQ9/E2QBjoLscHqu12Fex2ERk5uPPd7zepgvaOfUy5X4o
	 ZdUL7sVfcMVVz+Z8FEYAZ5doaRj79faXGM2d20Vnq2fixdAK5c1d9qv/eve5cJJv2/
	 okrsCqes/kjUpsAQIsrOHLOXYt9GoJGC6f9tV0LpW0tXqis2O3mIWcRVGxZU8D8xT8
	 z0oSde7nbmMSbQTp5RsOg634kVtE2UAZ1+JqI0Wg7afUXFArjHvO1jBSfbpZ+OBPPl
	 COqChwElUWAlg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:40 +0100
Subject: [PATCH v3 01/10] mount: remove inlude/nospec.h include
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-1-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=545; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ9+yM4+/skvLTNX28aJYw9qjGnvMOvJnr72verOKw
 8k9lEuho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ/9zH895/4qaKcZ1OafIQ3
 x8ft8R7f7ddI+3w+9HlnvKHpPwftmQz/oxvtfji+ZfkewDLF3FJd+1ayxNXn7LMiE5aVty5ib2N
 lAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not needed, so remove it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3fee7d97df2a84a69438a677933654..c3dbe6a7ab6b1c77c2693cc75941da89fa921048 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -32,7 +32,6 @@
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
 #include <linux/mnt_idmapping.h>
-#include <linux/nospec.h>
 
 #include "pnode.h"
 #include "internal.h"

-- 
2.45.2


