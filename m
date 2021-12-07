Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14F46B8AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 11:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhLGKUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 05:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhLGKUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:20:32 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED7C061574;
        Tue,  7 Dec 2021 02:17:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 8so13017044pfo.4;
        Tue, 07 Dec 2021 02:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDgqsJG2vbqfr0thKfws+HV4YvoO6K/qlR0d7DKQRJU=;
        b=DQAHxpLVsN8JY2uQhlwMsicadwbLVq+dgM2vlVMHLxQ0ioOhFqJLbEhX0YH2PZX79r
         F3PeRPi9ffreqbEKSbtwNgjjek37GThjE1wjmF+3ktLEjAtZtaA8iwL3hSIyLjqZZOy3
         W4VTEoEB7YISlxQ9Ka00f95MUP6KO8VVyugifdcSTbGHnQNM9vcn8nq+Py31j25CWg/y
         DjsFMiWZIbUBNT6lTM4saOxh1kCWyOo4mNrutjxm9LdPwXNvFxe891V6WJHpnX1sneHg
         22Cvsk3MUsSnCNvuC+eQQ7aQeJ66dsxOcoZcrB1vh+kp2bKlLW0JQ6S3C/DHfMsKDNPN
         eZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YDgqsJG2vbqfr0thKfws+HV4YvoO6K/qlR0d7DKQRJU=;
        b=2DyMbBJfjYvJWQ1zlbhe+9irhCJVuIcThYsE9uUQSiL0PrGs0g4oxYsZnii2U35hbY
         39/3zzcLuPEjyPN2fuUMQOLc//PDEe7oS/w1Kd8AWI9sgC3ZkuNKY9Z+PO0E8GzGut8l
         Mee7EnqKhgN4H3BsEuTBJa29KuRS0yjy+4qPj5jWZUiw3k67fUA2lbB+YySOd2FaDaui
         WWAspIYhg01fnC8GAzpl07M8dTADonIGTl6YCbYbTiFYIdkqY8vcBkIJf+D60nWJqggQ
         ZByOUIFVJ2HZq0YZQ5dJH4sIWnYH2HcDjPqoPhzuQFQP6bj078yXvcmt3PRH/D5D6nSY
         I+Kg==
X-Gm-Message-State: AOAM532K7C+TnpJ7Jml5w/5DeIkOoic+Rat4D2BA7HLu9GmJNEEuL7/6
        T0gviGGvQv6KIorBhM0gGp8=
X-Google-Smtp-Source: ABdhPJy0Y3ia+AHMqLMEthWCoGziKet2u7wp1flqMBPXmrZf/Nqx3/80yWc0ONsbFanFkmUeTR9EYQ==
X-Received: by 2002:a05:6a00:2444:b0:4ab:15b9:20e5 with SMTP id d4-20020a056a00244400b004ab15b920e5mr26836309pfj.0.1638872222608;
        Tue, 07 Dec 2021 02:17:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k19sm15121311pff.20.2021.12.07.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:17:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs/dcache: prevent repeated locking
Date:   Tue,  7 Dec 2021 10:16:46 +0000
Message-Id: <20211207101646.401982-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Move the spin_lock above the restart to prevent to lock twice 
when the code goto restart.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c84269c6e8bf..8580d51b397a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1102,8 +1102,8 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 void d_prune_aliases(struct inode *inode)
 {
 	struct dentry *dentry;
-restart:
 	spin_lock(&inode->i_lock);
+restart:
 	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&dentry->d_lock);
 		if (!dentry->d_lockref.count) {
-- 
2.25.1

