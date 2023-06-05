Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7607223F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 12:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjFEKzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 06:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjFEKza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:55:30 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14E18E;
        Mon,  5 Jun 2023 03:55:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53202149ae2so2543185a12.3;
        Mon, 05 Jun 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685962522; x=1688554522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATOgTCD4yzJoITjwwVO7z1jeNiclQOzGdaaC13HT7dU=;
        b=U3XJZon/zyBw9Xr0o///D7ldH+DK7KtmJJ745H0oL3skfDSbj1nR2l36OpxK+evEAB
         0I5vxqJziM7OD4g32unebKfgBVSOG5EwBjnrRJhA68QSR4OFajWdnnbh8H9YRb8HbVj7
         xr6jw5K1hlsnSovZiz1Rspmd/ipqlUOTZUHAetqi53d2Gy4oXIQIke4CbrK/LivD16mC
         yAK6yk4ADioj+Y72Od4KPyd5vrSu9FIXwJvLuOep8D9FM89H1AqhKQ2P2tm0kbLcTfFt
         l1pa+F7C40nUbYXOegMsnaCxEZAB804cjB6fG1yZIwZT01hZI7pXSGErxDLbHuIRA/hB
         VM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685962522; x=1688554522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATOgTCD4yzJoITjwwVO7z1jeNiclQOzGdaaC13HT7dU=;
        b=PqT1Ptjn1naoRCki42Rs9P8K7x9qS+d/JIEU6XApL+MHicXCm/YQ3aZ7LWfhhG+TUN
         trRlWaUtCXGRSoFlYhsLT7s0RslcDDrPzO1IzQUlQ2IXPeq4Kk+CEJOiJIkLKGpJY9m9
         H6FOcnz3cReKI0WRDe6JL2kp3NYrUAH7OcYXkL5mE9pYEj62i4Hslg87G5Qz0Q0FRR/A
         EeUw9CfDr3i+a/iTepj+2KCCOy2KUF3QtyrCrwr4hsYPa6RCt5u1A3ExlRsX4nwEB2IJ
         fmBs43PjQNl/ubi+RP0MDqiZ+BWDxLGIvv0G9AtZbmJdhWKZclMR5ylc1Lb7bL6ElHVy
         rWWw==
X-Gm-Message-State: AC+VfDx33WvV15tIxSszmxu0eg7QGDn3o9iJc5G/FMf5Bf3eg0uHfbWd
        Wa4j2nEjpQJ1q7iRkik6SERHVLAnR4o=
X-Google-Smtp-Source: ACHHUZ5ICNcF4CADAq0qIJmjOJH1ij3Pd+z6r9TrBRYClaEF9aFwSEeRpRLPIvl4RTC1Ty1o4uLTPA==
X-Received: by 2002:a05:6a20:7d87:b0:10c:c5df:8bb7 with SMTP id v7-20020a056a207d8700b0010cc5df8bb7mr4001097pzj.30.1685962522459;
        Mon, 05 Jun 2023 03:55:22 -0700 (PDT)
Received: from dw-tp.c4p-in.ibmmobiledemo.com ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b001b0f727bc44sm6266883plh.16.2023.06.05.03.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:55:22 -0700 (PDT)
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
Subject: [PATCHv7 2/6] iomap: Move folio_detach_private() in iomap_iop_free() to the end
Date:   Mon,  5 Jun 2023 16:25:02 +0530
Message-Id: <c3a91a81cf449d357e8a0255d720c5760283ee43.1685962158.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685962158.git.ritesh.list@gmail.com>
References: <cover.1685962158.git.ritesh.list@gmail.com>
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

