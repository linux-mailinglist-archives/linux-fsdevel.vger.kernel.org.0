Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF240A200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 02:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhINA3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 20:29:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbhINA3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 20:29:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB9EB200AC;
        Tue, 14 Sep 2021 00:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631579309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fJh0QfLu557SRIcbnLQw5jXDd2d5nR20JToY2iryFI=;
        b=HxscG/LDiGhsXGcbasBy/GQpdvuvcezFHx0oNgiHTzBfG6jLNj7at1rWx8uH73RB9dCBEK
        43zz46aMTEEwRh8Kab1HMrXpHEHa8osZ6ZQ61ivRCI80gCkcehQ/wgKC04GE2CRXQEzw46
        /6h+o/IWXCBi0R7pu+/Q8WQGi/3R1gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631579309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fJh0QfLu557SRIcbnLQw5jXDd2d5nR20JToY2iryFI=;
        b=zy9E9ltAIbtS5E4r1Cp18Z6g2l7UU2NIsT6UJfPtYAJjWhnxeEspX3gl509vflmF/5AQeU
        SGQVgd8837Ms+xDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91DDF13ADE;
        Tue, 14 Sep 2021 00:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EE9HFKrsP2FQawAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 14 Sep 2021 00:28:26 +0000
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.com>
Date:   Tue, 14 Sep 2021 10:13:04 +1000
Subject: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <163157838439.13293.5032214643474179966.stgit@noble.brown>
In-Reply-To: <163157808321.13293.486682642188075090.stgit@noble.brown>
References: <163157808321.13293.486682642188075090.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Documentation commment in gfp.h discourages indefinite retry loops on
ENOMEM and says of __GFP_NOFAIL that it

    is definitely preferable to use the flag rather than opencode
    endless loop around allocator.

So remove the loop, instead specifying __GFP_NOFAIL if KM_MAYFAIL was
not given.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/xfs/kmem.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index 6f49bf39183c..f545f3633f88 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -13,19 +13,11 @@ kmem_alloc(size_t size, xfs_km_flags_t flags)
 {
 	int	retries = 0;
 	gfp_t	lflags = kmem_flags_convert(flags);
-	void	*ptr;
 
 	trace_kmem_alloc(size, flags, _RET_IP_);
 
-	do {
-		ptr = kmalloc(size, lflags);
-		if (ptr || (flags & KM_MAYFAIL))
-			return ptr;
-		if (!(++retries % 100))
-			xfs_err(NULL,
-	"%s(%u) possible memory allocation deadlock size %u in %s (mode:0x%x)",
-				current->comm, current->pid,
-				(unsigned int)size, __func__, lflags);
-		congestion_wait(BLK_RW_ASYNC, HZ/50);
-	} while (1);
+	if (!(flags & KM_MAYFAIL))
+		lflags |= __GFP_NOFAIL;
+
+	return kmalloc(size, lflags);
 }


