Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25458777DDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjHJQOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbjHJQNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:13:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C83581;
        Thu, 10 Aug 2023 09:13:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bcad794ad4so8481285ad.3;
        Thu, 10 Aug 2023 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684007; x=1692288807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8Q9xp1hpHwj6pNr+X5XwC5Li0wmHIWn07CtqwvptdI=;
        b=IJ/HEYnsAODmGUD4SLrT2mk7Kbfjk1jGBf5ows/R6bb0x7AXJDbGwsptPTPHMbM0M5
         MMFSQsDlD9avKRFzTtOUE+YKB7oEOEIah017O3TX/qsEVd7o77QfNMzpw2qLC+XJba7t
         UuVOsAcETenzmYfx1XlUFTh9SfJlC/RjGFzPgYI+dretjrt3lYzpVf0UKxw7MeL2rq4P
         pbKUfxQrtifvATuD+EM/dnqAmb4m7Ko5L6/4ikHw3nDAqULRsfMa4Wudql0nenUeCraX
         Hu+pyUPMXFIlHM7uGuTQfCuljoeGJU6DnrhRzxS3N+tz7Lp7XeZzIZcuMXFbCS/e3WnJ
         JenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684007; x=1692288807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8Q9xp1hpHwj6pNr+X5XwC5Li0wmHIWn07CtqwvptdI=;
        b=VBbwT44mL6Shr5eoxs9uIvcMRa1pV3OJhJawMCZzSZu/qO26vApDlaC/oq03C4tNtQ
         GfqKZU8my+RaCKejnAzGGwEDXfJ+Ikr7s26C3t/z/x7jXOncENsNC8Hyn2ipwyoFsj71
         wPvK390BDXV0HHXI/L9DEa6pX8sZWqwkHHCYueInc+FnjD0zgT9Rh6sMMbM2XQm8brdJ
         BBxHCLV6o7l4RaPlYlPqMf+s+t2WZ7r9q+QyOvjZlx2vDL0HdeJq2OoSUuk9R+qaxV9p
         974J95Ms8DBwrG4c9ko9tHUBZ3BqpC6Vmw62S/YTRRHnHHkxbX/0Bgal/a4YQ1A83rZR
         jNcw==
X-Gm-Message-State: AOJu0YztvYo9/Kr9C+wf5vliRu1GSFom0tsJdUPrzR+kYZ6+JI5LyxWB
        urK9EQVigvc6QLS9kdP84IY=
X-Google-Smtp-Source: AGHT+IF2wwr+Qo2PrhtF+th5PmcbtS3OAFIljYU9PclgzSIHGvB8qfweZAb49T2u7uYeNr0ZCbtWLA==
X-Received: by 2002:a17:902:dacd:b0:1bb:a941:d940 with SMTP id q13-20020a170902dacd00b001bba941d940mr3108026plx.15.1691684007304;
        Thu, 10 Aug 2023 09:13:27 -0700 (PDT)
Received: from manas-VirtualBox.iitr.ac.in ([103.37.201.179])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902b20600b001b9e0918b0asm1960070plr.169.2023.08.10.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:13:26 -0700 (PDT)
From:   Manas Ghandat <ghandatmanas@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org, anton@tuxera.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Subject: [PATCH v3] ntfs : fix shift-out-of-bounds in ntfs_iget
Date:   Thu, 10 Aug 2023 21:43:08 +0530
Message-Id: <20230810161308.8577-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <2023080811-populace-raven-96d2@gregkh>
References: <2023080811-populace-raven-96d2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added a check to the compression_unit so that out of bound doesn't occur.

Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Reported-by: syzbot+4768a8f039aa677897d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4768a8f039aa677897d0
---
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
+						vol->cluster_size_bits > 32) {
+						ntfs_error(vi->i_sb,
+							"Found non-standard compression unit (%u).   Cannot handle this.",
+							a->data.non_resident.compression_unit
+						);
+						err = -EOPNOTSUPP;
+						goto unm_err_out;
+					}
 					ni->itype.compressed.block_size = 1U <<
 							(a->data.non_resident.
 							compression_unit +
-- 
2.37.2

