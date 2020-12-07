Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCC2D0F1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgLGLeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgLGLeR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:34:17 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82586C0613D3;
        Mon,  7 Dec 2020 03:33:37 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q22so9587803pfk.12;
        Mon, 07 Dec 2020 03:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V7IqDWSKXukQODvyRYxxHyAp9kzYnONBivG3E1uSTi0=;
        b=YIMPqFee/AenZi8qBNwZ1evrJB2ILU5DVBLCXYmgkgMvkajLVi78Jv6Z/OiFi2nfW1
         u/YJnlOgZeEA70FaDcZFIcf31FvalQEUazAyBN7IUyWDay51dK1/1zqafd3IwqnePSII
         f4iij588EBRDCzP9KPiO0aTvaS4APpif6lMHhKyytak+ZjMZ3sxH2BKJEPMaTDsyFeLu
         9kb1y8rVVQPPxQW+2Eb5TjVDa9Jv4XiM6S+q6Lfic5FL6MuReKSh5B0cZHiDIXHxmLiB
         QsCC+kgZIWtG6Zl3CQdJd/Yz+V47c7WU3yfJrs9g+0W1tVoMSSFSOz4Y4OTMBNn32GVd
         N0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V7IqDWSKXukQODvyRYxxHyAp9kzYnONBivG3E1uSTi0=;
        b=R5PzOt071SIFuEPzEBrsUqZOtJaaQXBoFiZfK/VsM9XB2Okhvr/mOr0wMtSzgUKHmY
         8YRoqxInvGfOylOLw6Pk4fEdY1ZEU0Z8qk5iD/SR6vcQov9narVwc4xtqSMZ2MjOQDL5
         IBZmdjxAmQxRxXi8+3ojTsbpRY7D55MLI5I8ES/Mb43ISRESKnqfTW7mP/ajMqrKEHGB
         /TlowNgQaK57OU3OinNFxDD1Jvl13JygJjbO8/OzhiUVukCgjzh8weA47JyTFU1+d9Gq
         CwnYGnG+nJ48X9JTvDKB04aFwe7s+sZsoSjbMRsIaqUM5HlTsrb3j6e5HkrlXC9JV8b7
         eTpw==
X-Gm-Message-State: AOAM530mNBx94VD9YO8dRkXdQiB4YeyFE8/wJqnVXxAzeEU279dBbFIU
        Gf2YN0TBpGZG2RBFEKZg/58=
X-Google-Smtp-Source: ABdhPJyQefdtFNDvBzo/WKmc11oLIwPzRy//V+/lSFKCStAywDqYn6pKN5mcS5ZLbN4k0Rx9dBfgRA==
X-Received: by 2002:a17:902:9341:b029:da:13f5:302a with SMTP id g1-20020a1709029341b02900da13f5302amr15670304plp.9.1607340817145;
        Mon, 07 Dec 2020 03:33:37 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.33.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:33:36 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [RFC V2 04/37] dmem: let pat recognize dmem
Date:   Mon,  7 Dec 2020 19:30:57 +0800
Message-Id: <805999e57d629348f813017e02a086e33e507d9e.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

x86 pat uses 'struct page' by only checking if it's system ram,
however it is not true if dmem is used, let's teach pat to
recognize this case if it is ram but it is !pfn_valid()

We always use WB for dmem and any attempt to change this
behavior will be rejected and WARN_ON is triggered

Signed-off-by: Xiao Guangrong <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/mm/pat/memtype.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 8f665c3..fd8a298 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -511,6 +511,13 @@ static int reserve_ram_pages_type(u64 start, u64 end,
 	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
 		enum page_cache_mode type;
 
+		/*
+		 * it's dmem if it's ram but not 'struct page' backend,
+		 * we always use WB
+		 */
+		if (WARN_ON(!pfn_valid(pfn)))
+			return -EBUSY;
+
 		page = pfn_to_page(pfn);
 		type = get_page_memtype(page);
 		if (type != _PAGE_CACHE_MODE_WB) {
@@ -539,6 +546,13 @@ static int free_ram_pages_type(u64 start, u64 end)
 	u64 pfn;
 
 	for (pfn = (start >> PAGE_SHIFT); pfn < (end >> PAGE_SHIFT); ++pfn) {
+		/*
+		 * it's dmem, see the comments in
+		 * reserve_ram_pages_type()
+		 */
+		if (WARN_ON(!pfn_valid(pfn)))
+			continue;
+
 		page = pfn_to_page(pfn);
 		set_page_memtype(page, _PAGE_CACHE_MODE_WB);
 	}
@@ -714,6 +728,13 @@ static enum page_cache_mode lookup_memtype(u64 paddr)
 	if (pat_pagerange_is_ram(paddr, paddr + PAGE_SIZE)) {
 		struct page *page;
 
+		/*
+		 * dmem always uses WB, see the comments in
+		 * reserve_ram_pages_type()
+		 */
+		if (!pfn_valid(paddr >> PAGE_SHIFT))
+			return rettype;
+
 		page = pfn_to_page(paddr >> PAGE_SHIFT);
 		return get_page_memtype(page);
 	}
-- 
1.8.3.1

