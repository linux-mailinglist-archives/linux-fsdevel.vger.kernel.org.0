Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93D40F009
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 05:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243568AbhIQDBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 23:01:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56608 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243240AbhIQDB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:01:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9687D223BD;
        Fri, 17 Sep 2021 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631847604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1u7JfJ60ADhg0u9Pcl8n+h1Bz25Z10lXHgfdltE1Jc=;
        b=09WD61SfjEhN3tce5Wk8dsHcJSb/WzRs0PxztPkg/oLbQ8tSPZsUEzjy6uqwmhzuikCPuq
        U/HwnCMpj/gmCuZzk7ruhT8FrXhKowH88e6xhNyS5IhdEstIJ/afToqMOTj8wFJrEPQ6Xa
        cVP2L7nrJ3Ww7J3EnBJIz5piqvJIZY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631847604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1u7JfJ60ADhg0u9Pcl8n+h1Bz25Z10lXHgfdltE1Jc=;
        b=x0CJKsYi96KJP/4iSQP5YmW+cfO6FQgofzJz/NaLv+dviaJqtmgBNoT8ZnNF2BRpgwlvYN
        cVAEWbD8Oc5hvoAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3870F13D0B;
        Fri, 17 Sep 2021 02:59:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s9QlOq8ERGGiMwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Sep 2021 02:59:59 +0000
Subject: [PATCH 5/6] XFS: remove congestion_wait() loop from kmem_alloc()
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        ". Dave Chinner" <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Fri, 17 Sep 2021 12:56:57 +1000
Message-ID: <163184741781.29351.4475236694432020436.stgit@noble.brown>
In-Reply-To: <163184698512.29351.4735492251524335974.stgit@noble.brown>
References: <163184698512.29351.4735492251524335974.stgit@noble.brown>
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

As we no longer have the opportunity to report a warning after some
failures, clear __GFP_NOWARN so that the default warning (rate-limited
to 1 ever 10 seconds) will be reported instead.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/xfs/kmem.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/kmem.c b/fs/xfs/kmem.c
index 6f49bf39183c..575a58e61391 100644
--- a/fs/xfs/kmem.c
+++ b/fs/xfs/kmem.c
@@ -11,21 +11,14 @@
 void *
 kmem_alloc(size_t size, xfs_km_flags_t flags)
 {
-	int	retries = 0;
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
+	if (!(flags & KM_MAYFAIL)) {
+		lflags |= __GFP_NOFAIL;
+		lflags &= ~__GFP_NOWARN;
+	}
+
+	return kmalloc(size, lflags);
 }


