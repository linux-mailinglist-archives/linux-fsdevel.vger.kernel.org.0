Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EA77A50D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjHMGBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 02:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMGBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:01:05 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3B610FE;
        Sat, 12 Aug 2023 23:01:06 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a412653352so2661010b6e.0;
        Sat, 12 Aug 2023 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691906465; x=1692511265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLM5KpkpD4gWxC6Oek1rSBQnlEYGRzxn9MLl0BpU5F0=;
        b=h24Q6I/UsAD9vYa6jWbyFrJMuP2WS8zeeAADdQF+/t+9qok/gC3ZdOu7v3zjXS+HN9
         POMQIUzExaDsIOJ9zpRIb49ugrUGwr9bYAhhc9zxnJpVXmPx4O60ISxyr0jslPERJd3S
         2m7KMb61RCZVkJ87N6ZJMAWdSJjKdtBUJnc9Nn2Y1dZ1NVTsF134gVhZ2e8to/7mTTBV
         re9gE4SQXvBdORy87nq2vF82jddTqCCKlHP8pZexRk8o2AcZOiqZbSkaylcwtIdAxIyN
         MYzo04t5tdIZhKoABdMFlMnsVFqp57Fb/FLd72USMctkmU4QyVQ4xVPRTnu6NipaEYBy
         dVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691906465; x=1692511265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLM5KpkpD4gWxC6Oek1rSBQnlEYGRzxn9MLl0BpU5F0=;
        b=cieGcRkp5OCziXocNBr7vTuMEdx/u5/iNSlW9fnaiImGK5UxsnAB7ILe1UdYHytLAw
         lK8OmtjoZI5ZS4yTtftQFZszpjSLhssKpBvPNPlRXWuERh8WT5QuHHXmrPuSlCTx/Ts+
         9rpRQGWBAO6vJNJmKxvFQmNqytjcoTU15qk3amr+hBoLRjJk5tYOFm6gR0CLeLoN2wRd
         3nPNrnjzrOUe1STTgoTLPYnoW2h0Nu6/63QvbaoK6WZ4UC4Zf7aAhk05bs5O8uwSPrSo
         rvxmdsseWAr/icYz/p6I6F6o/X8tCZYa6AB+HuwEbTeC6NvW2/vLzTgA7UHQt1D6/pAX
         gRBg==
X-Gm-Message-State: AOJu0YwOoFKiVlV5vu8zgP7rlN1rweh/HZeLzyhPbBJdUAEfY8dyUiqq
        4E1mMnXIv+ae6s12LRLbKZo=
X-Google-Smtp-Source: AGHT+IHHF3g51CV/WubhxPwpRm7sZqAoSXFa+dkSSWPQxBTL5FkGpDuLblN2HAN/MDR9Kq3V61Kv8w==
X-Received: by 2002:a05:6808:1792:b0:3a7:3ce0:1ae5 with SMTP id bg18-20020a056808179200b003a73ce01ae5mr9451677oib.47.1691906465578;
        Sat, 12 Aug 2023 23:01:05 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id a23-20020a637057000000b00564aee22f33sm6022339pgn.14.2023.08.12.23.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 23:01:05 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: [PATCH v4] ntfs : fix shift-out-of-bounds in ntfs_iget
Date:   Sun, 13 Aug 2023 11:29:49 +0530
Message-Id: <20230813055948.12513-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there is not check for ni->itype.compressed.block_size when
a->data.non_resident.compression_unit is present and NInoSparse(ni) is
true. Added the required check to calculation of block size.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b
---
V3 -> V4: Fix description
V2 -> V3: Fix patching issue.
V1 -> V2: Cleaned up coding style.

 fs/ntfs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c3f38d66579..a657322874ed 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1077,6 +1077,15 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					goto unm_err_out;
 				}
 				if (a->data.non_resident.compression_unit) {
+					if (a->data.non_resident.compression_unit +
+					vol->cluster_size_bits > 32) {
+						ntfs_error(vi->i_sb,
+						"Found non-standard compression unit (%u).   Cannot handle this.",
+						a->data.non_resident.compression_unit
+						);
+						err = -EOPNOTSUPP;
+						goto unm_err_out;
+					}
 					ni->itype.compressed.block_size = 1U <<
 							(a->data.non_resident.
 							compression_unit +
-- 
2.37.2

