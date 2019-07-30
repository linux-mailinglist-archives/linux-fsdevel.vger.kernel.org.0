Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5196679E4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfG3BvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46298 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbfG3Bug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so28186764plz.13;
        Mon, 29 Jul 2019 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Znhv/kCRKUKHxOSXZDgniqB5ZIlr3K3JgxSCaFgdq+8=;
        b=mnDSVL3M6bAosUcHnoza2f8m7wEnumxSt3YvGoUwcyJEmuWgQSvjnGlgb6izTn97XH
         WlFFapP2gmybE/zhqdO56mykLwgimYu1v8UaIwPDFvTopkNnSPYzV9cwr9xzQwpBzJ+p
         Xg7xneetDXkvGpv8ehyjx/7htK1NAH+7+vyXX9E211v+GFQOZg4QBoJmL7Pzfptp5ZK0
         i8X5jSa/Y3pDBHXBrJcfSHV1vsty9muNkpfrva7etLeNSAQwVwVB/OF+4yE/1WEZx98j
         iarZwuS3V9vHIWqKPxNVa06nGj40Yu6RIznPCIObhC5bzPqBwZ7S5WW2D/fAxwiUL+0A
         0k5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Znhv/kCRKUKHxOSXZDgniqB5ZIlr3K3JgxSCaFgdq+8=;
        b=dpqVC4dbNPzCjm4hCPMwACxEj517CIh3RalvAMWQ0iHC2ymwqZUNXqVAwwWWw+5ntq
         GDe504U1aYhdU4pIra8S7pqw+YEMp8lAiLt6lmEid2Xo+N9IiM9gnTg/2Qo1+2fPJWod
         kFjRGqhHBlj/9HZfwvdxZOlo9l/cDJV9o6U1zPJnU4BBB7E9ldr09+jqyC+kiiZfq4N+
         w6eXxzBnXQONzP9wG/INN2/MV83Q+djtLMHlKb4x5kUmFxV8xCS3xqDH/RC1KBwzP7G4
         33hXRNqzHelozEDd8o38lrVPAmSH7GdKJ+EMry7lePxOViiGbrX3PEs1VzaXFkEZ9CEo
         EoYA==
X-Gm-Message-State: APjAAAXp0HgVcrYFCkWh4oS1dIauxQ2XvdxcB32b5cu14SatdlaXc6Qg
        QRe1LNAvrHYNVcTCLgmC4xSKms6YkWs=
X-Google-Smtp-Source: APXvYqw5bUkSyOBiAJcIYvdeq+xCu//0ZThr2vJrAZqPxC+L2tzGlmqjAahHtHiCjAClQuPYpNrDLw==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr117757847pla.213.1564451436018;
        Mon, 29 Jul 2019 18:50:36 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:35 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, zyan@redhat.com, sage@redhat.com,
        idryomov@gmail.com, ceph-devel@vger.kernel.org
Subject: [PATCH 15/20] fs: ceph: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:19 -0700
Message-Id: <20190730014924.2193-16-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

According to the disscussion in
https://patchwork.kernel.org/patch/8308691/ we agreed to use
unsigned 32 bit timestamps on ceph.
Update the limits accordingly.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: zyan@redhat.com
Cc: sage@redhat.com
Cc: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index d57fa60dcd43..6cf3a4fceac1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -981,6 +981,8 @@ static int ceph_set_super(struct super_block *s, void *data)
 	s->s_export_op = &ceph_export_ops;
 
 	s->s_time_gran = 1000;  /* 1000 ns == 1 us */
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	ret = set_anon_super(s, NULL);  /* what is that second arg for? */
 	if (ret != 0)
-- 
2.17.1

