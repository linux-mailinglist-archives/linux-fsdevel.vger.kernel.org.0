Return-Path: <linux-fsdevel+bounces-3622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1C7F6C13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31F1280EC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C458F57;
	Fri, 24 Nov 2023 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="N2Pdj2k2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B2719B9;
	Thu, 23 Nov 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q9X3xgtg/XP2tqHjPVSI8SGKsJDTk1SufhPE4ojFnAg=; b=N2Pdj2k2ZjGr/gAcl9j3TTB4Eh
	e+TxRob6A3skYTInmQxQfpvzQJ+CI860MBRvUXt6YeA4lh4PRt48rIujQ+vFur4iq5th2DAHXQGWB
	bMkilc8khBMAW4NvpFVQs2roMlulq1V6UZd06cDDcsBm/i3NwvHaymzPHTtDOWGmywRteoYWNN/jG
	Au98BB2XxjpvdP9WoJI4GxxJrLfoXX8O/iXEmOpfnR3Ri8+C0cKMpfdUXqvpllGRnS0Gx05wqRy1J
	C95+ozK6Ac4hRVKK2YjxW/hYWloDYyyUktNiost976oa6cQQ1Wl22c99pftAyzTNDxfjSTK7CjE7D
	HXFFGkUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKu-002Q0Q-31;
	Fri, 24 Nov 2023 06:06:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] struct dentry: get rid of randomize_layout idiocy
Date: Fri, 24 Nov 2023 06:06:27 +0000
Message-Id: <20231124060644.576611-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

This is beyond ridiculous.  There is a reason why that thing is
cacheline-aligned...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/linux/dcache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..1d9f7f132055 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -111,7 +111,7 @@ struct dentry {
 		struct hlist_bl_node d_in_lookup_hash;	/* only for in-lookup ones */
 	 	struct rcu_head d_rcu;
 	} d_u;
-} __randomize_layout;
+};
 
 /*
  * dentry->d_lock spinlock nesting subclasses:
-- 
2.39.2


