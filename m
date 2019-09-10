Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64EFAEE40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393159AbfIJPMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 11:12:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfIJPMM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:12:12 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2860783F4C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 15:12:12 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a4so7813115wrg.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 08:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrqaTrvxa7VaAlf71OLZqePQvcrU6r13R8Bqx0ichEU=;
        b=gq1dkCCNqZopaobIAgMupBCuaYPCx5WBpyZlalQMC4g49/1jN1C3cG+pg6nLXl41+N
         auKXvO8+yT+Ors5LeVl0FjEvg1LVSMckVbrZ10TIoFTxHC6iclZk3uhkQA6HhW5y6CpH
         WyxU9RLPfeWM5bhQrKS4wzJ02mAplrDtXcYxfI7TlHXPuHRy4Mi0BgBVjaRDmcWdnyN4
         0drvoAOD2o+rtxHWXK04tXPCZQIYlSze70cFTtoZVQT1QPhgV2xZ0a3iCTSd2RmPCOV8
         wCAzzyRN/KRsxk+Ei98LxBCoEpOdASShilio+tyQtgUccSllB1NqM2OUw6s1ZN+66T04
         kHpA==
X-Gm-Message-State: APjAAAWeDe7AR6hZ9fnfjOgV5+SN1fCwtDSM4U1n397Uv8hnLCbn5lkq
        kRTTZ4x3szanyqW6PhTdLQg9Lp2TWeJ4mJ/pfD6KTpSiECdHA9Egad4QlvZ67BvDZ11gBO9NiAC
        YG+7MytW2MpDdM0Pk6EHp8kkJsg==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr1675wmc.11.1568128330959;
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWeg/w8Vqy0703RcJM9HuLu+OSLqPixswfN1pv0bUZuNqcYM+945Q0W3J0uRRmaWdkr1fPhA==
X-Received: by 2002:a7b:c054:: with SMTP id u20mr1659wmc.11.1568128330796;
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g185sm12803wme.10.2019.09.10.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 08:12:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v5 1/4] fuse: reserve byteswapped init opcodes
Date:   Tue, 10 Sep 2019 17:12:03 +0200
Message-Id: <20190910151206.4671-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910151206.4671-1-mszeredi@redhat.com>
References: <20190910151206.4671-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio fs tunnels fuse over a virtio channel.  One issue is two sides might
be speaking different endian-ness. To detects this, host side looks at the
opcode value in the FUSE_INIT command.  Works fine at the moment but might
fail if a future version of fuse will use such an opcode for
initialization.  Let's reserve this opcode so we remember and don't do
this.

Same for CUSE_INIT.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 include/uapi/linux/fuse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..df2e12fb3381 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -425,6 +425,10 @@ enum fuse_opcode {
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
+
+	/* Reserved opcodes: helpful to detect structure endian-ness */
+	CUSE_INIT_BSWAP_RESERVED	= 1048576,	/* CUSE_INIT << 8 */
+	FUSE_INIT_BSWAP_RESERVED	= 436207616,	/* FUSE_INIT << 24 */
 };
 
 enum fuse_notify_code {
-- 
2.21.0

