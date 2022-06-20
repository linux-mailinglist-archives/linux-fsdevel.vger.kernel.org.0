Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3825513AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiFTJFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiFTJFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:05:09 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5F558D;
        Mon, 20 Jun 2022 02:05:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d17so686248pfq.9;
        Mon, 20 Jun 2022 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XS460ssN5m8qIg3j92C0hAPAV/Z5ErmQruhxnIIvXYY=;
        b=CiCtG6+GH5kziOsKycnqctyJHyCpazKfIc4YHjwpme8uwPmn1ldfoRY5P0BNShFdmc
         IqOmxBdJwBCBHpsGGJtI/130YEWeNPuOSz9g69Ba0JMJqBP/5oLpndCqJErSm9YDKwZS
         WKMIeCHxqErAHt3Dx+TxWEDsp3+HVS06+JDFeNFqiIisCsfSHDhSRrxGdf+5Na8Xpt+Q
         0zGJgB7+hA36TkKW9NvubAQqiGcWAml0M7GRuixFegn4gS0oqTnYAusGHxukPQOFAbyy
         X7bYDstD+aCPNxGO1E+0eGYT2rf0amFvEmEbCiPLlhyWvZ9Idf/EpWj0Yc3zM4A4LEe1
         P/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XS460ssN5m8qIg3j92C0hAPAV/Z5ErmQruhxnIIvXYY=;
        b=32ENWMKPJVsXS0c+1tmYwaorMXyqewi4nCwfuOak7aQvysbvx0MpdPHYiYQvH2xwz3
         opJmf7sqX57vRPBxDGbqesrZJvaMDqZkXI/dKy3EDZXpGlsVzm8+jvQfVBF5s8qbN1EZ
         +TsIzMo4Lr3STRjrDsxkvZiDLKIZngGHqxNw2sRzzOcXv3QtFT6C1plzc7TVxP6MPnQn
         9Vd4FC6tc0UC+tDkzfKd2MFFcvJ5coJEpXZmEv1eGSPYWkmgrfQbN5HEWnWZUeMB0cVE
         fdUIUuTCeXkdJ2eR+Xb2zWMEnHtKwWTCU7jQyjSSs4Dw0101/4x4eyejV7wVOvWe49lF
         5m1w==
X-Gm-Message-State: AJIora+HMPvkzeaw/JrWFZzV/tS5mAvHTpAcVJOTtDFMZcn/E1Acue+H
        9oscwW9KypelLKfgi2MxHm+g3W+wL78=
X-Google-Smtp-Source: AGRyM1vS8kGELbdV19Vr9wEXmhMd8sWuZgDKEJEyqEtTXc0eThP/isu3vjt9Jgjx/pOpBYIaKLoEow==
X-Received: by 2002:a65:6a05:0:b0:3db:27cb:9123 with SMTP id m5-20020a656a05000000b003db27cb9123mr20834886pgu.497.1655715903020;
        Mon, 20 Jun 2022 02:05:03 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902d64a00b0015e8d4eb2c5sm8099729plh.271.2022.06.20.02.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:05:02 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCHv2 3/4] fs/buffer: Drop useless return value of submit_bh
Date:   Mon, 20 Jun 2022 14:34:36 +0530
Message-Id: <0930c57e0943c4ec7a184725a3d036f917081da6.1655715329.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655715329.git.ritesh.list@gmail.com>
References: <cover.1655715329.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

submit_bh always returns 0. This patch drops the useless return value of
submit_bh from __sync_dirty_buffer(). Once all of submit_bh callers are
cleaned up, we can make it's return type as void.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
---
 fs/buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 898c7f301b1b..313283af15b6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3121,8 +3121,6 @@ EXPORT_SYMBOL(write_dirty_buffer);
  */
 int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
 {
-	int ret = 0;
-
 	WARN_ON(atomic_read(&bh->b_count) < 1);
 	lock_buffer(bh);
 	if (test_clear_buffer_dirty(bh)) {
@@ -3137,14 +3135,14 @@ int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)

 		get_bh(bh);
 		bh->b_end_io = end_buffer_write_sync;
-		ret = submit_bh(REQ_OP_WRITE, op_flags, bh);
+		submit_bh(REQ_OP_WRITE, op_flags, bh);
 		wait_on_buffer(bh);
-		if (!ret && !buffer_uptodate(bh))
-			ret = -EIO;
+		if (!buffer_uptodate(bh))
+			return -EIO;
 	} else {
 		unlock_buffer(bh);
 	}
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(__sync_dirty_buffer);

--
2.35.3

