Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06317482D72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 02:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiACBfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jan 2022 20:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBfx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jan 2022 20:35:53 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C94C061761
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jan 2022 17:35:53 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id r139so29066756qke.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jan 2022 17:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=JaSZZ+/ZBLkNzEcEn9eD+IlDGjCZFtM4r21Mxyksolg=;
        b=hT+6aP4/NC3vMVqIhmCXqGkMBlMD5MdP9vNNwMtApmbOflavOSVhqzfKbVOsBAZBq7
         9tTaDUAhg829po65kAvLTn9iMygiB2/kWOd1VwWe8ipImHI7uJEixSZM5Fr5/CrJoH0F
         bjUo7d8TaCIGijcO4F0SN7kj54IKT027e82lDAcjzwldGVVsaS14B3i5SpoDgq6gqFw+
         1xoCmt26e37Ywc9tWAMH46RJiqDda3iJE9tm3YBtr9/+WDO5Yy6DT1/wUZ7CIt93Q5ks
         4HJHfNKAotvDbnIoP7CKCyjZ9KOn/XgvebnatVwfHtf7oXaOuAxBHweJCIZ10UOVpVg/
         sIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=JaSZZ+/ZBLkNzEcEn9eD+IlDGjCZFtM4r21Mxyksolg=;
        b=tyzvBrYpBXN44TAZ/ZiAtuL6aHNUHMpIVRhP/4amtV69d7anwI6qSQmTlcQjw44v0d
         k8xgdUFxX8sD0QfswNcUdabJMCyE39HkcdYfgz3NeWN2S4f2Sw5o1JTstq2Mcyia17Iw
         N5dr1iz0ugSctqhVbGdAGNLVTnYzdpABxGFQcvSgi4mJmCbguyl7LDkbKQbm+8Ry26+L
         dJQNGStH0II11krz6XCqFDjoxxhYGIjxKt9wieIxG5CfHN2p+7xEzKf35qa52Ccv9qab
         Tr+VI/PEyntsK99WugkviN8mYxPjMgffC5K06x6nhWN4OGmnBiuLIKSXV7GUBqtS4oqW
         WZpg==
X-Gm-Message-State: AOAM53388h8cFzkNe1S3Es+Wo463hD67r65jiAVenNw4nly1TJDl2ONS
        +njd1a8ZRoV5762CroiiJ0qbYw==
X-Google-Smtp-Source: ABdhPJzoXsD5f7PvFJQ6Mu9VEZlpODAEzB2rbY5NHjHbnv/vRbwrq0S3GSu4FEPFxBMNh3OBJOHiAQ==
X-Received: by 2002:a05:620a:c4f:: with SMTP id u15mr31341532qki.565.1641173752550;
        Sun, 02 Jan 2022 17:35:52 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r20sm27971780qkp.21.2022.01.02.17.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 17:35:52 -0800 (PST)
Date:   Sun, 2 Jan 2022 17:35:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH next 3/3] shmem: Fix "Unused swap" messages
Message-ID: <49ae72d6-f5f-5cd-e480-e2212cb7af97@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

shmem_swapin_page()'s swap_free() has occasionally been generating
"_swap_info_get: Unused swap offset entry" messages.  Usually that's
no worse than noise; but perhaps it indicates a worse case, when we
might there be freeing swap already reused by others.

The multi-index xas_find_conflict() loop in shmem_add_to_page_cache()
did not allow for entry found NULL when expected to be non-NULL, so did
not catch that race when the swap has already been freed.

The loop would not actually catch a realistic conflict which the single
check does not catch, so revert it back to the single check.

Fixes: 3103f9a51dd0 ("mm: Use multi-index entries in the page cache")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/shmem.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- hughd2/mm/shmem.c
+++ hughd3/mm/shmem.c
@@ -727,9 +727,8 @@ static int shmem_add_to_page_cache(struc
 	do {
 		void *entry;
 		xas_lock_irq(&xas);
-		while ((entry = xas_find_conflict(&xas)) != NULL) {
-			if (entry == expected)
-				continue;
+		entry = xas_find_conflict(&xas);
+		if (entry != expected) {
 			xas_set_err(&xas, -EEXIST);
 			goto unlock;
 		}
