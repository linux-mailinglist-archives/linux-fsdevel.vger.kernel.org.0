Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D0C5690B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiGFRdQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 13:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiGFRdP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:33:15 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46529CB5;
        Wed,  6 Jul 2022 10:33:14 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 139A21D06;
        Wed,  6 Jul 2022 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657128731;
        bh=LgQprGKfPWWuIWgll8EWNs0wlfhTJEIbWh1bL9GAuCI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=oDBtcpPS2VLw6xbG4fTzvuM3c72F+gQXF1y9LLiTqTh3O6P+geSF4SBaRIqhFRYVk
         qMe/e7i1yhc0Hbz6irA3TTDoC2efuJeaekfOdF/AvgBg2ly6T1nH+eh8wPsDKlGoqE
         ag3r+vwIiy1NVKSmFoqgK3n+oCU/bGmGiquvG/44=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BEAC92133;
        Wed,  6 Jul 2022 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1657128792;
        bh=LgQprGKfPWWuIWgll8EWNs0wlfhTJEIbWh1bL9GAuCI=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=t+uPJMkAnFdfLNFSKZnSIx+x3gvlKrH69UgQy6X+gRUooNaEd/DDOkuku1YDKoY2u
         qx6QvgmvwJUYInctEPGG/5EWtp5048G8PlyUqn8FxSO12r59vo4VanvHvATIL03kS8
         A1EsDEhCNaZEUlBXs7vDeXI5b2/7XpOsNExyQTMA=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Jul 2022 20:33:12 +0300
Message-ID: <1e532f1e-1ba5-11a8-8cb1-100b5c3a0f3b@paragon-software.com>
Date:   Wed, 6 Jul 2022 20:33:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 2/2] fs/ntfs3: Check possible errors in run_pack in advance
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
In-Reply-To: <d578fcbe-e1f7-ffc7-2535-52eecb271a01@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checking in advance speeds things up in some cases.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/run.c | 39 ++++++++++++++++++++++-----------------
  1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 95fb9d739706..e4bd46b02531 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -821,26 +821,36 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
  	CLST next_vcn, vcn, lcn;
  	CLST prev_lcn = 0;
  	CLST evcn1 = svcn + len;
+	const struct ntfs_run *r, *r_end;
  	int packed_size = 0;
  	size_t i;
-	bool ok;
  	s64 dlcn;
  	int offset_size, size_size, tmp;
  
-	next_vcn = vcn = svcn;
-
  	*packed_vcns = 0;
  
  	if (!len)
  		goto out;
  
-	ok = run_lookup_entry(run, vcn, &lcn, &len, &i);
+	/* Check all required entries [svcn, encv1) available. */
+	if (!run_lookup(run, svcn, &i))
+		return -ENOENT;
  
-	if (!ok)
-		goto error;
+	r_end = run->runs + run->count;
+	r = run->runs + i;
  
-	if (next_vcn != vcn)
-		goto error;
+	for (next_vcn = r->vcn + r->len; next_vcn < evcn1;
+	     next_vcn = r->vcn + r->len) {
+		if (++r >= r_end || r->vcn != next_vcn)
+			return -ENOENT;
+	}
+
+	/* Repeat cycle above and pack runs. Assume no errors. */
+	r = run->runs + i;
+	len = svcn - r->vcn;
+	vcn = svcn;
+	lcn = r->lcn == SPARSE_LCN ? SPARSE_LCN : (r->lcn + len);
+	len = r->len - len;
  
  	for (;;) {
  		next_vcn = vcn + len;
@@ -889,12 +899,10 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
  		if (packed_size + 1 >= run_buf_size || next_vcn >= evcn1)
  			goto out;
  
-		ok = run_get_entry(run, ++i, &vcn, &lcn, &len);
-		if (!ok)
-			goto error;
-
-		if (next_vcn != vcn)
-			goto error;
+		r += 1;
+		vcn = r->vcn;
+		lcn = r->lcn;
+		len = r->len;
  	}
  
  out:
@@ -903,9 +911,6 @@ int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
  		run_buf[0] = 0;
  
  	return packed_size + 1;
-
-error:
-	return -EOPNOTSUPP;
  }
  
  /*
-- 
2.37.0


