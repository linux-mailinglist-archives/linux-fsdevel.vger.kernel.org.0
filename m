Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032E721B82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjFEBcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 21:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjFEBcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:32:18 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D34DA;
        Sun,  4 Jun 2023 18:32:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a3f26688bso3596689b6e.2;
        Sun, 04 Jun 2023 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685928734; x=1688520734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATOgTCD4yzJoITjwwVO7z1jeNiclQOzGdaaC13HT7dU=;
        b=iXV8TJjwPfdvLP5q/uHJcwt9ZqxB6wVvQ1qZho/hZHuQPu7c1cbZRvos/993vdKQCs
         SbffgKS6J016HqbmIBV/SbpiDPjjBSRQ3l8LjtBo3w4d/09q28YguMsRV7tfy10T4qPv
         virb/r4FrTzg5rlSlObfp1+SnX5oljTbE4JCoWjm5/t0hujITD43kyTNpndFNr9sjiuc
         6zZm9+zRowSUV8ZYrYo7xC8JOvOhUN531CeObiv5htYgVxXTU3jMA6YY9FrNS7ojs2TR
         ZwJP1j78WWAuun+7oFoDvtvF3DGlpHpi3XDGaSZYk+ew0LsA6P9n0IEVTRTtxRwWy8C3
         O8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685928734; x=1688520734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATOgTCD4yzJoITjwwVO7z1jeNiclQOzGdaaC13HT7dU=;
        b=VIEVHMl5Hwuwkvu+8CKLQvi9hAMKjdymcnY5vETJzlNx4XzIuS1GdqAwKRfgJyetSo
         72l6RfGUcKezBMrSDf4hYDFGvJjomqniHlncu0Ncx5SBgCyPTfWUopS1KdDnmuVQG8JN
         u9E9f/ecTG+nfZ6Gf1Z3x6CLPaqYDqPCAwOzQ1OUpZAMk7w+eMWdXMr5sb+1pl9e+YiS
         zjUud0oyk4dYDtdowF/UVJdBhlRKXon1tiVAL0JFwboSxgfu31tOJ6NtjSAV/fZoINtO
         hqRuJFtre0eCrlNtcREL+FfG0Xtdqe2wySaoJ18BlyapO5dVTWQJsAlvp2oqi59vUu2x
         IS6g==
X-Gm-Message-State: AC+VfDzcYvBeznAHmZLpRKDJpRT+XrAMtWgf/BlOS+C4w5j8+YS7nrQt
        Hl8O+pvWx8+k6FduiJZboE6b1wBzR7M=
X-Google-Smtp-Source: ACHHUZ717vkQBUTY8Nl9I3WEOE+oUuvaq5Nl0cCYBk34bNtx+NVhLBJmn3yVTvL8PNldmDU79u3NuA==
X-Received: by 2002:a54:4002:0:b0:398:4465:ed25 with SMTP id x2-20020a544002000000b003984465ed25mr6837200oie.37.1685928734182;
        Sun, 04 Jun 2023 18:32:14 -0700 (PDT)
Received: from dw-tp.ihost.com ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c14d00b001aaec7a2a62sm5209287plj.188.2023.06.04.18.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 18:32:13 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv6 2/5] iomap: Move folio_detach_private() in iomap_iop_free() to the end
Date:   Mon,  5 Jun 2023 07:01:49 +0530
Message-Id: <4b57e8bf317c1d08c9a44dca5fa4290d213bd004.1685900733.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685900733.git.ritesh.list@gmail.com>
References: <cover.1685900733.git.ritesh.list@gmail.com>
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

In later patches we will add other accessor APIs which will take inode
and folio to operate over struct iomap_page. Since we need folio's
private (iomap_page) in those functions, hence this function moves
detaching of folio's private at the end just before calling kfree(iop).

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4567bdd4fff9..6fffda355c45 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -71,7 +71,7 @@ static struct iomap_page *iomap_iop_alloc(struct inode *inode,
 
 static void iomap_iop_free(struct folio *folio)
 {
-	struct iomap_page *iop = folio_detach_private(folio);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct inode *inode = folio->mapping->host;
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
 
@@ -81,6 +81,7 @@ static void iomap_iop_free(struct folio *folio)
 	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
 	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
 			folio_test_uptodate(folio));
+	folio_detach_private(folio);
 	kfree(iop);
 }
 
-- 
2.40.1

