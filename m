Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF41F2F53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 02:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgFIAtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 20:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgFIAta (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:49:30 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BBC03E969
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2020 17:49:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so9289091pfa.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2020 17:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XHz5OmG4OD+PVVW0DSdtHbVwt77qJvNhIFvffVZyGJ4=;
        b=jDmkFOXWEPE7d9gXRagQtTgH19+Tvq6WBJKQS13ABqpKSLA6XozlHHV6IXtAg8Y3m5
         vU0Ix6XMYwa46tLw2PeX+sOfYrvqvJALSqHESgXr3i80h3KnVYrM0W0F4nkI9r71qE1e
         UURUKse0HL5e+ujMjrLk39OSeztmClSF+WXXiiIy8GNDUUCRFUEFo6TGstqk2hCKa5hb
         0YUFQRKk7zvlHArm44vMge6pWARdTssQ38FWCE+ZWoMKuCgrPe+4oWOYKx9gHn7OAyjc
         ErW9OBuOg1IRYWoQbUA/NyEtRPtcpOvju0fxJhQ7Nlc4fXMGiu0ystiutm9v9PIcZlba
         aM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XHz5OmG4OD+PVVW0DSdtHbVwt77qJvNhIFvffVZyGJ4=;
        b=s2GdgUdsDC8lZO2zAGxy8mMK3f0pxQ3VZCsywL54KJI1xlHF+Ds6iZjV+apzC8yH6O
         ou5Gg+vhq1/2tQafskqFufZoxlla8nIvWb/joep7LGHacg4TWJzw0KQmL1njqQRyVPzE
         0UdB+kMcz4EP76CTxlIg5YtNCLB3aXuXM2ggi3nGMGoTZvGLYgyoNVTqOzQEakDZHf9U
         rQKAUnHdyBazTnMhM/XIvJJrwOFRnfeHPA2jYC1mYmaoBFi+rEDhqSLDNUNG+evso/3e
         qrpfjHFLNDKGuNEk22lW9lxwyG8pA8PUPfTGR35s63RJDdYHNV2ehaeoal8Flku3ofZn
         Z32Q==
X-Gm-Message-State: AOAM533CgnZfUn1A6maFrS0H2YnFVBeyyk7CYhSLVXVRwcFgVk+l7aZa
        mT3DZXMSIi0zHj72J24qai/d2tsfVaM=
X-Google-Smtp-Source: ABdhPJwaa1jZ+Zn1c5+SjtDbWqu8+qc4K/i/9gTuUP+vA4uMQDh/dEao8Hy/2WvyPAkqUFUqf0TQ2g==
X-Received: by 2002:a63:7f5d:: with SMTP id p29mr21856966pgn.337.1591663768631;
        Mon, 08 Jun 2020 17:49:28 -0700 (PDT)
Received: from localhost.localdomain ([125.186.151.199])
        by smtp.gmail.com with ESMTPSA id s1sm600066pjp.14.2020.06.08.17.49.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 17:49:28 -0700 (PDT)
From:   "Hyeongseok.Kim" <hyeongseok@gmail.com>
X-Google-Original-From: "Hyeongseok.Kim" <Hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org,
        "Hyeongseok.Kim" <Hyeongseok@gmail.com>
Subject: [PATCH] exfat: clear filename field before setting initial name
Date:   Tue,  9 Jun 2020 09:49:20 +0900
Message-Id: <1591663760-6418-1-git-send-email-Hyeongseok@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some fsck tool complain that padding part of the FileName Field
is not set to the value 0000h. So let's follow the filesystem spec.

Signed-off-by: Hyeongseok.Kim <Hyeongseok@gmail.com>
---
 fs/exfat/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index de43534..6c9810b 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -424,6 +424,9 @@ static void exfat_init_name_entry(struct exfat_dentry *ep,
 	exfat_set_entry_type(ep, TYPE_EXTEND);
 	ep->dentry.name.flags = 0x0;
 
+	memset(ep->dentry.name.unicode_0_14, 0,
+		sizeof(ep->dentry.name.unicode_0_14));
+
 	for (i = 0; i < EXFAT_FILE_NAME_LEN; i++) {
 		ep->dentry.name.unicode_0_14[i] = cpu_to_le16(*uniname);
 		if (*uniname == 0x0)
-- 
2.7.4

