Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD677C70A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 07:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjHOFYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjHOFXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:23:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E6D10D4;
        Mon, 14 Aug 2023 22:22:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc6535027aso43183805ad.2;
        Mon, 14 Aug 2023 22:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692076979; x=1692681779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHF9DwBt/KL1PFI7RDqx5fwl57eGwDq8ZK1tGPWeBhg=;
        b=CTrcNKyM9wenReoMPPTsvZw/gbr1FG4sXAejfeRM4bbW8H59tBTiIeMhNjXTVTioGk
         xVZ775pmy1FLUUtGTYeI/sx3EsGalNoU/VgzGPBQ6srC+XO6CUkQfHlildtlbx/ag+bU
         Xpvi9yEubrzVuqcgBwF8pLk4MFy6IZaMrJuUp1nmC0s2X+VymajjhWPm9z7mgU7591h3
         D5/G7LoGl28xD3KsMigKiLRmdx1jWA04486fOIQ6IqlYptEQzsw4QMX7qRlJr5MyWf6I
         VW8lKUVFjmDURwQk3Y0TNK6p2lIhw6ZLIjPUDechn6NzTXLfsFtB8ehEXfD3MvcPfTat
         OvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076979; x=1692681779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHF9DwBt/KL1PFI7RDqx5fwl57eGwDq8ZK1tGPWeBhg=;
        b=YDuNl53FC6tkdItcqemPrmWqKEJN9t/aIJd8jmQOMOvtzexKWz6bgXI5Bntg/jNH1d
         +r2kHsQP9CviVIs1LnJpgGIR0PsgzS+aKvuELHor9tjHAz/s1bh8bXreMYR0TSpyIzyI
         LWHYATdZj4Vbn6WZWKfey6nv3+vU5zr+wq56ZaAPUXmZJNzsc5oPn+7AtJcAuWXO+HZ/
         AJpyKNckJv74ZjLxvQONGHEXfT6q7GC4JCZzYDduN7dd8YmITB9FA+qIhEh7mu6L3qrQ
         naW9RSUQ9Jw8bADJulvj6GNnDCJn20Ga5ICDXqA8L82c1/To4o+g8MCl1aYYPztYzR76
         9eTg==
X-Gm-Message-State: AOJu0YwbmyWkHD+ia9alDciEEkUPtwRkYySyeTWAypVq5hHBgnMKIBnr
        bIhZB0R98XUz03Qy8zKfUwU=
X-Google-Smtp-Source: AGHT+IF16TCyVtCgJTpVSwrOqeIBxBUrJvxhSI8dEuR715qV8vVR1nTShXLVmQC5gffHOlV4IQyhCg==
X-Received: by 2002:a17:902:6acb:b0:1bb:59da:77f8 with SMTP id i11-20020a1709026acb00b001bb59da77f8mr13032408plt.48.1692076979138;
        Mon, 14 Aug 2023 22:22:59 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.174])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b66a71a4a0sm10311347plf.32.2023.08.14.22.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 22:22:58 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     anton@tuxera.com, linkinjeon@kernel.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: [PATCH v5] ntfs : fix shift-out-of-bounds in ntfs_iget
Date:   Tue, 15 Aug 2023 10:52:50 +0530
Message-Id: <20230815052251.107732-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <BF7AB30A-8AE7-4819-B99D-8147D455AB95@tuxera.com>
References: <BF7AB30A-8AE7-4819-B99D-8147D455AB95@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there is not check for ni->itype.compressed.block_size when
a->data.non_resident.compression_unit is present and NInoSparse(ni) is
true. Added the correct check to the compression unit.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
Fix-commit-ID: upstream f40ddce88593482919761f74910f42f4b84c004b
---
V4 -> V5: Add recommended check to compression_unit
V3 -> V4: Fix description
V2 -> V3: Fix patching issue.
V1 -> V2: Cleaned up coding style.

 fs/ntfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 6c3f38d66579..d8ac221f212b 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1076,6 +1076,16 @@ static int ntfs_read_locked_inode(struct inode *vi)
 					err = -EOPNOTSUPP;
 					goto unm_err_out;
 				}
+				if (NInoSparse(ni) && a->data.non_resident.compression_unit &&
+				a->data.non_resident.compression_unit !=
+				vol->sparse_compression_unit) {
+					ntfs_error(vi->i_sb,
+					"Found non-standard compression unit (%u instead of 0 or %d).  Cannot handle this.",
+					a->data.non_resident.compression_unit,
+					vol->sparse_compression_unit);
+					err = -EOPNOTSUPP;
+					goto unm_err_out;
+				}
 				if (a->data.non_resident.compression_unit) {
 					ni->itype.compressed.block_size = 1U <<
 							(a->data.non_resident.
-- 
2.37.2

