Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015CF7BBF46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjJFSzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjJFSyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F5114
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq+G/SWzJbNXPr4q3ksgk2vbn5f43WMbMxlAhTulQsg=;
        b=WnZFgsYSJ39FY0kcZT1fEJq+oh+qVKONOgT+2v7NjISTDeBLbvMCcqfN+LmxHzNt5+7Ovd
        RrSR83qlvLHpcgGPgx2eq/d2aFh3ACVLZJVdtNTorWPWVK95YZNGHB41n2ErWBKer2RF6g
        I4j5r3ZyTaiMUKiPleQPK1xaWfv+BQE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-n4fpjl_TM-CzS7MOCNGi0w-1; Fri, 06 Oct 2023 14:52:43 -0400
X-MC-Unique: n4fpjl_TM-CzS7MOCNGi0w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9adc78b386cso209874266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618362; x=1697223162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq+G/SWzJbNXPr4q3ksgk2vbn5f43WMbMxlAhTulQsg=;
        b=CL9lD6OzgNpDAlbq94JPDm3WKtmLRLW6U/gW7y+5KtRW3cVseLMUAYui9m7V4BkZMk
         yVMBoemlGGFk1EMvQ4D4tI6u/R54290H6F6gHGW18MIkcQcinFZy8/kuIqCQNABGnARf
         vjsRBuEi/uculGSjvd58mMVxq545FY1z9jJ0mQOYoyr2RwfwsgA53Fbrzf7c3iBHC/Ae
         hTBPNvxiwxpogD+xPMTPD826kMvMbPKP0WqoeBs5M/e0LEobmxdJetbjCQZd+rWdKGhJ
         ruRgJDxRJKLM6IhMbPb2tBUhYbv327rdUNtyPWz4skomGa6375crvRMvvCI/pdqGHSXH
         /jgw==
X-Gm-Message-State: AOJu0Yw94sjXbh6oehVzJbZtPWnONEyf7mJLymy+h8yGr3FgmEeM31Mj
        dKVIlEVHmdfvZfeLIw1PmOgcN1GsS+fmtQltXfnkQvWFUXCYuZhUo0DcEaFxwlEib9RlUp3zBat
        E+7vzPDpKoxjFxZGiBmIBmK3r
X-Received: by 2002:a17:906:768e:b0:9ae:729c:f651 with SMTP id o14-20020a170906768e00b009ae729cf651mr7909063ejm.17.1696618362726;
        Fri, 06 Oct 2023 11:52:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJNFgKdzEHOeVvd+3tQl9Cob5IB9hO5jTuzm4AjNObs8WxdVcJlwftDSDxj9DkgztYQ4iC7A==
X-Received: by 2002:a17:906:768e:b0:9ae:729c:f651 with SMTP id o14-20020a170906768e00b009ae729cf651mr7909049ejm.17.1696618362520;
        Fri, 06 Oct 2023 11:52:42 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:42 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 26/28] xfs: make scrub aware of verity dinode flag
Date:   Fri,  6 Oct 2023 20:49:20 +0200
Message-Id: <20231006184922.252188-27-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs-verity adds new inode flag which causes scrub to fail as it is
not yet known.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/scrub/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index f35144704395..b4f0ba45a092 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
-- 
2.40.1

