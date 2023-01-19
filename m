Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03C673D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjASPcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjASPcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADD40BE4;
        Thu, 19 Jan 2023 07:32:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1540644wms.2;
        Thu, 19 Jan 2023 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4IpF0CMnhbBf7H7iLN0nfh/18GS/Ps3ATwtaps4Vp8=;
        b=Z3RzMKM2PeGPS/g6yCgIuivIMD1cD+w6CLOObE5w4jVExMsj5qYi5WIfgNlz+SjDCO
         LTW2cnLatJ5ybfa3z6GSBsbbFSgzlcTReqJlOmGJnVrPfZSUm5kWxMxZM6l+d+mZTnhr
         mgBX7ABHfnQ0H7GhOvyIQyw5yFHnYIbg5Db5XFgOL+DHv+bmZGNRNPpexIn/51GN7P9Z
         JjqLCVHFyfKLt3Y+WB1E6wV/Sh8+kgzVV/NOrVpgPFMeN9tJXKppYR+Ww4LGjs+rKTIZ
         qwcJ9ZeCaQ8UHpBeT4THst9TSlHUh3bP1BKfSy+tSRDQWnTSYZW4Ki8TuMVGc2+4qRnH
         Lj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4IpF0CMnhbBf7H7iLN0nfh/18GS/Ps3ATwtaps4Vp8=;
        b=eQsn3prTZmhxGmIm9/s4w5MrgXOfbT/MsSRic1no/fYn2IMt41DIiTGrOcaAYlPOBF
         5gNJ1x+t760yCvBSGi7UFX3+ACfHKbyk4a3xpOYrb/Ds7zTaScUbv4uZaXSESe+2vMV1
         X1fSTXF6Fpht7pQ4MqN4er5q0U6lKq8RKXQ5ou/OqmTb+haAq4qzRWqwkxPlh728XQX2
         KnoWa8OcrmQ1UZLrZLrWFDFu/Bvjgoiz/pe57gH/aywLHmAaxsyFb1CI1Eubk48WeeNq
         jeqKsHrd2VaAsfvGBsaHukMG2QQaQ32WE+EQrlK2JGTAaozW2iiftrnrQZnxoNWUVZOi
         V5eQ==
X-Gm-Message-State: AFqh2koylKZu85SCXq/1lphTAdfLjy5ZS50rN4iHZNLDR+WuxF7eFmrS
        DqHyFlB4W7JukZy5WHfjIyQC9m+f5YM=
X-Google-Smtp-Source: AMrXdXt5w4SqrmPdBg9L23wXgAppGoxM3Sle9AwyEJxjL3A3Wf5GbcqNdvUVGPp/sLqI0FzOx+BCfw==
X-Received: by 2002:a05:600c:4928:b0:3da:909f:1f6b with SMTP id f40-20020a05600c492800b003da909f1f6bmr11044750wmp.1.1674142358283;
        Thu, 19 Jan 2023 07:32:38 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm5827815wms.19.2023.01.19.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:32:37 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 1/4] fs/sysv: Use the offset_in_page() helper
Date:   Thu, 19 Jan 2023 16:32:29 +0100
Message-Id: <20230119153232.29750-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119153232.29750-1-fmdefrancesco@gmail.com>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the offset_in_page() helper because it is more suitable than doing
explicit subtractions between pointers to directory entries and kernel
virtual addresses of mapped pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 88e38cd8f5c9..685379bc9d64 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -206,8 +206,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	return -EINVAL;
 
 got_it:
-	pos = page_offset(page) +
-			(char*)de - (char*)page_address(page);
+	pos = page_offset(page) + offset_in_page(de);
 	lock_page(page);
 	err = sysv_prepare_chunk(page, pos, SYSV_DIRSIZE);
 	if (err)
@@ -230,8 +229,7 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 int sysv_delete_entry(struct sysv_dir_entry *de, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	char *kaddr = (char*)page_address(page);
-	loff_t pos = page_offset(page) + (char *)de - kaddr;
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
@@ -328,8 +326,7 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	struct inode *inode)
 {
 	struct inode *dir = page->mapping->host;
-	loff_t pos = page_offset(page) +
-			(char *)de-(char*)page_address(page);
+	loff_t pos = page_offset(page) + offset_in_page(de);
 	int err;
 
 	lock_page(page);
-- 
2.39.0

