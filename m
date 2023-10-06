Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF517BBF45
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjJFSzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjJFSyw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA38110
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xavYdX/wZ0RnKLfU/MnqAKGW0flPB1iaCT9iprzm3zc=;
        b=TBmOsmv1DbGvkEmqOcd5flZI8xsiR0/TMRIsqvjnE75vI8EAVmGlvNpEIcCLB/DhfdODrv
        HSTjQd/UDzEQjcoHTAgZ2okyoG6CbiH4IyaAMeHXqeJrQbt+WU79zbgi3J7um5+WhkBzuP
        RJjyQLzMffpS5jTjHs2VjYTclyjY890=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-l8HSMQpRO3KAbF2He72sRw-1; Fri, 06 Oct 2023 14:52:41 -0400
X-MC-Unique: l8HSMQpRO3KAbF2He72sRw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-531373ea109so2202828a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618360; x=1697223160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xavYdX/wZ0RnKLfU/MnqAKGW0flPB1iaCT9iprzm3zc=;
        b=wQhQl3b/RLxeYBEQZ0G/f+4UVd9gGi4uPY9AaOX1hp5RaRpWAX6cHrQ96e4blNCIWG
         upb5Y/xGvdyfc3M2Fe/dYel6SUCx7/9xqbzszJTO18e3Ln895lk+eIdXCsLGqfFt+1XO
         T3W31medRpqvJbf46ytq2bTpatwSDxqK4J5v7rHjPoEtNmSi2Yju8BaUEvUig9JcYoLQ
         icatxZqs3cWu/sKiAGmsmfKakp/rck76VRYUYgkeOhZQh/NMKNPgDMYXGb2xGA14pfk3
         gERYq1r7ie3EBsJj7hNrO5ZJ0l+V6DWxw+0i5YjUsdWwXNarQ3V3htWwinaV/v9nmS9v
         ThCw==
X-Gm-Message-State: AOJu0YzcwMixl5bmMmr9/LWwc7268T2TFFhugrhZNxdrqDv97pScqrog
        ZtRFh8yrRQbcnBrtaRZjctgd1kQ98Ls70PdGSUwJgrZ0yb32AIx5T/X9RE9OTnWWGpPTCWu+QX+
        x2t3gFRrANIZicaSGuCEtT5jUz8XAm1dv
X-Received: by 2002:a17:907:75f7:b0:9ae:658f:a80a with SMTP id jz23-20020a17090775f700b009ae658fa80amr7985139ejc.48.1696618360158;
        Fri, 06 Oct 2023 11:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7SK73SUKTlwsNFT0YwN9JhYvDJYdu/UT4rHQhvxh32fN6Ie3lbiMgVmY+qoDZrohiyXJoFw==
X-Received: by 2002:a17:907:75f7:b0:9ae:658f:a80a with SMTP id jz23-20020a17090775f700b009ae658fa80amr7985129ejc.48.1696618359925;
        Fri, 06 Oct 2023 11:52:39 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:39 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 23/28] xfs: don't allow to enable DAX on fs-verity sealsed inode
Date:   Fri,  6 Oct 2023 20:49:17 +0200
Message-Id: <20231006184922.252188-24-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 9f2d5c2505ae..3153767f0d6f 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1209,6 +1209,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.40.1

