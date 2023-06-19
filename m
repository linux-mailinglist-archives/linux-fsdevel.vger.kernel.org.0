Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D4734A3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 04:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjFSC3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 22:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFSC3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:29:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FB8E47;
        Sun, 18 Jun 2023 19:29:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666e6541c98so2407298b3a.2;
        Sun, 18 Jun 2023 19:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687141755; x=1689733755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLImmVLn3mGGa5KeTYkDF4FcAsovaMmgH/N39hJNTNU=;
        b=fPUZBsWLSzAeUaAg5HZQQtmBkVtsXIf3TCVuAdK5D5TGRxn4/jgJb5mGDH0BQiHLjF
         GIwaMLaX7PWiDvIA7WQjDMjZvOo3N5VnIGl670G8ecMlV9XX7FSFD5ccSfnVwVvVn3oa
         PdNvM69lYVG9ycLwFrY9J4SKnwF7ykciuvNxLYT+pgpzTXl+rf9g7uDD02AYD6jo11Ah
         C/HaFtNdee43OvZp9ljS3dEBZ3SMS02ycEwwe2Q2922CQk9nxXzyMg1wSfwZJ+K7y+fQ
         /FcDQ6DWSG/8nd5xNo0021zwKZ8UFFN4C1OCauD042YFzeHbpGRj8Enn/oi3YyfQKFFr
         LQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687141755; x=1689733755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLImmVLn3mGGa5KeTYkDF4FcAsovaMmgH/N39hJNTNU=;
        b=NFgPdaqBDqf7kpnG2T4o2QXrMcMGNKm8NOJr1nAqH8nUKBZOUwPyuJMr/yWbXd1hMr
         r+NAZ6DbA5s7GctnMBBCEOUsDj6iEGKK4VZbFTHRiJGMxq3Xc8znlQDQOcCA69Q8ViE2
         X9VKV4Fz4mVPh8U230yEoFYKFfIBdjylBJqYl80KNd8VKwYzj+QH4uXEg4x0YVnM7Ffu
         DGBi62dQh6pAUnLZXY787EHyTpolKv5T43Im8wObsCzkVlpcifMTxOq64749kH1OJeoz
         47UFFD4i6UtKdzcv25uxY6HyIKbubdY69DkZGegU1y8dQ6hnU0vQWfOIIKIzC85ezsGu
         rllg==
X-Gm-Message-State: AC+VfDyl5EFFq56Z8yhEEJfRplFlYxYhTZsoAE+cJfV7j8EriAZ3bJ+W
        U1NPq/lvec7xThxzYbFj37SePXTTqjc=
X-Google-Smtp-Source: ACHHUZ5G4WBoh6SNbxorIV7l8ifJoH8b6V5xe3rpURHKtQ0kEwn83U75cBkPZfpare/hVZ1tGzB+wA==
X-Received: by 2002:a05:6a20:4401:b0:11d:ae2e:6954 with SMTP id ce1-20020a056a20440100b0011dae2e6954mr13122013pzb.15.1687141754873;
        Sun, 18 Jun 2023 19:29:14 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b0064ff1f1df65sm399531pfo.61.2023.06.18.19.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 19:29:14 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv10 4/8] iomap: Fix possible overflow condition in iomap_write_delalloc_scan
Date:   Mon, 19 Jun 2023 07:58:47 +0530
Message-Id: <0343bb9a59f8c3d647004df471445153bf1f8a3d.1687140389.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687140389.git.ritesh.list@gmail.com>
References: <cover.1687140389.git.ritesh.list@gmail.com>
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

folio_next_index() returns an unsigned long value which left shifted
by PAGE_SHIFT could possibly cause an overflow. Instead use
folio_pos(folio) + folio_size(folio), which does this correctly.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 790b8413b44c..8206f3628586 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -933,7 +933,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
 			 * the end of this data range, not the end of the folio.
 			 */
 			*punch_start_byte = min_t(loff_t, end_byte,
-					folio_next_index(folio) << PAGE_SHIFT);
+					folio_pos(folio) + folio_size(folio));
 		}
 
 		/* move offset to start of next folio in range */
-- 
2.40.1

