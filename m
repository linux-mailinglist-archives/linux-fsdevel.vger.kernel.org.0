Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD972D01AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgLFI04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgLFI0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:26:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09113C061A55
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:25:43 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 11so695160pfu.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CowKSBe21ybUCNZpbXy3BdqlRA0xnHhkE4QdTXQDr3k=;
        b=obgOqCMK9+gBEKH0ZvJObENCVSKcLtZyP4KoLqIoxqPr/HdB61VmQjSHVWVSI7Qy5H
         AUu5OHHRJzf0XtpZxFOi1Bi9pBoHz+y93p+W661gxc/7RyCbUU1hSTrnLiQdLzFWJSno
         YpNeLWL/tcbr57Vy1kaEHryGoS0DqPhRjiQizNC4yn2RNn7W1cTbgBLykdfOl0fGQnQX
         W6+EeIPIRYrz4GG9YL6ZdMRNVehGKGns5ox0eKwKWcsr9JjbNGMLy6uIfVNsxJ2Tt01W
         XY1cZtdYbAt+McNrsKL56VxC/b3pPKmdAe+2EPhEoxoYsXFHL31rlk/DVp5Ecnz4/ZAz
         xI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CowKSBe21ybUCNZpbXy3BdqlRA0xnHhkE4QdTXQDr3k=;
        b=MO69KqeNifQLwRhZs/2uEtZsTIdT8Fc9cshYlqyiTbxvF6fXJVL6ObqOECJVA7K90z
         7oW/41hq+KLJCUOplAz0t5Kqsbp558XoXYFoBFIXo9D3j9XprTNKfGeV+Ef9+93oiNF3
         CUo01QufyRGl2wKDsLEH+NZiNzyFFa4QKUNFBw1EhuWQ1TTyHBlVhB+ltY/Di6oM+fQc
         AHruA/zOLRakSSIn1+IDcbBC8+GmgScL/k0HLRy+JIHmNP3Jt0mF6n+AlOcFHndRJAhT
         7swLRGXqwstf2zbhgbaoLpiNikVyEnh8iMSM4VVMBl1AcFsCPcaHOLSoev0xuFH8n1eR
         l1JA==
X-Gm-Message-State: AOAM533la5vHO6VSgN1DFYAJNfDSve3kJkuSClob5/3udmp14MpFvAr9
        ILK9PcuhAS7O0tWBYqZxrOcD2Q==
X-Google-Smtp-Source: ABdhPJy5bNQjYo4wzFAYIfVUvgD7B9LeaNvbczwRJ5p8T6UGuwtFg55eMVVSm4zf5f5JLMhAkYE7eg==
X-Received: by 2002:a62:2b4e:0:b029:197:96c2:bfef with SMTP id r75-20020a622b4e0000b029019796c2bfefmr11289386pfr.46.1607243142574;
        Sun, 06 Dec 2020 00:25:42 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.25.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:25:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/9] mm: vmstat: fix stat_threshold for NR_KERNEL_STACK_KB
Date:   Sun,  6 Dec 2020 16:22:59 +0800
Message-Id: <20201206082318.11532-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel stack is being accounted in KiB not page, so the
stat_threshold should also adjust to byte.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8d77ee426e22..f7857a7052e4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -353,6 +353,8 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
+	if (unlikely(item == NR_KERNEL_STACK_KB))
+		t <<= PAGE_SHIFT;
 
 	if (unlikely(abs(x) > t)) {
 		node_page_state_add(x, pgdat, item);
@@ -573,6 +575,8 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		 * for all cpus in a node.
 		 */
 		t = this_cpu_read(pcp->stat_threshold);
+		if (unlikely(item == NR_KERNEL_STACK_KB))
+			t <<= PAGE_SHIFT;
 
 		o = this_cpu_read(*p);
 		n = delta + o;
-- 
2.11.0

