Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C86B2E9DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfE3AxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 20:53:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33631 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfE3AxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 20:53:20 -0400
Received: by mail-pf1-f201.google.com with SMTP id f1so3285013pfb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 17:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1zLLzunRacIsvbkfTaWpC4CoBmiOmCh3qurXkU7Ik8U=;
        b=h8FHABKxdlBN53cFTYJ5d0UiBL7PihQINuldUv4FTl0bNIxkuNBt/0Vhf2uJoL5oHc
         ntnxQeBd3+C8qEPYr5NVptJ+q35h8Vb6fgT/+ZS105INBTY18oRGfX0xwxo1L6VPNRA5
         c22OcQrAt10dKzRjCahiaTgdDbZ/vBceEd0fjRMjFH/6+q0u9FQKKJf/x+fsZdfIY04A
         Vc4TLPxz0LbwxUj10798jCsJzwt35n5zYTHpIofjFuIp+AqXXRE63vKbMXk1C/H9oUB6
         yHBPeUJEjTFKYiZzaX0gOwoHu4F0VQMZ+O+jfseDir1gYMx+VP4rwUkz9NYSSctfnSkb
         q/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1zLLzunRacIsvbkfTaWpC4CoBmiOmCh3qurXkU7Ik8U=;
        b=tTY+XmignH0WTkiKjokVJNZrlZ7UsVfWyX9yYKty186yolfr3d4Gd58OuAj/Sj8mjM
         hRIpU04FlATnZRG0R2nUJ5yyNRpEtfWHJtYNmfN6DBD5HJ0xDxYismEWzONjrFp+U2et
         SUQQT736/RemSgFjy8RvulaOxxd4ycu0TBiA1P04Vj4c3oo2fuYFqR8U+p8cX5aZ4jCF
         WdREWKkqduX1pM+Nt0HazZueMglBXfTgHbdKo59w26KYk8Vxdm+h/XYn8sI5SzEKizLK
         SNbIcY+0EQDdAwAvSh9MIptJPEqzfusK9bDSclY1X/BNLuz8yNH2kV9egbcDL+LBzFTT
         kd4A==
X-Gm-Message-State: APjAAAX+gCk6CIruIfK7k7ZOrqFq6BkmQI2cA2End4OEDnIkkNvGErOs
        7R2LFP3+I0TmCwCakMqzXYOV1Owa4uY=
X-Google-Smtp-Source: APXvYqyldr1oA4bszRUF74gO+ABbvOdB1x8BeqSdaTU/ourXVmDB1Vf2L9oUISnK4Rb3ipD8ZuMVYmiiBMg=
X-Received: by 2002:a63:1622:: with SMTP id w34mr958542pgl.45.1559177599505;
 Wed, 29 May 2019 17:53:19 -0700 (PDT)
Date:   Wed, 29 May 2019 17:49:03 -0700
In-Reply-To: <20190530004906.261170-1-drosen@google.com>
Message-Id: <20190530004906.261170-2-drosen@google.com>
Mime-Version: 1.0
References: <20190530004906.261170-1-drosen@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 1/4] f2fs: Lower threshold for disable_cp_again
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The existing threshold for allowable holes at checkpoint=disable time is
too high. The OVP space contains reserved segments, which are always in
the form of free segments. These must be subtracted from the OVP value.

The current threshold is meant to be the maximum value of holes of a
single type we can have and still guarantee that we can fill the disk
without failing to find space for a block of a given type.

If the disk is full, ignoring current reserved, which only helps us,
the amount of unused blocks is equal to the OVP area. Of that, there
are reserved segments, which must be free segments, and the rest of the
ovp area, which can come from either free segments or holes. The maximum
possible amount of holes is OVP-reserved.

Now, consider the disk when mounting with checkpoint=disable.
We must be able to fill all available free space with either data or
node blocks. When we start with checkpoint=disable, holes are locked to
their current type. Say we have H of one type of hole, and H+X of the
other. We can fill H of that space with arbitrary typed blocks via SSR.
For the remaining H+X blocks, we may not have any of a given block type
left at all. For instance, if we were to fill the disk entirely with
blocks of the type with fewer holes, the H+X blocks of the opposite type
would not be used. If H+X > OVP-reserved, there would be more holes than
could possibly exist, and we would have failed to find a suitable block
earlier on, leading to a crash in update_sit_entry.

If H+X <= OVP-reserved, then the holes end up effectively masked by the OVP
region in this case.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1a83115284b93..ec59cbd0e661d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -876,7 +876,9 @@ void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi)
 int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
-	block_t ovp = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
+	int ovp_hole_segs =
+		(overprovision_segments(sbi) - reserved_segments(sbi));
+	block_t ovp_holes = ovp_hole_segs << sbi->log_blocks_per_seg;
 	block_t holes[2] = {0, 0};	/* DATA and NODE */
 	struct seg_entry *se;
 	unsigned int segno;
@@ -891,10 +893,10 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
-	if (holes[DATA] > ovp || holes[NODE] > ovp)
+	if (holes[DATA] > ovp_holes || holes[NODE] > ovp_holes)
 		return -EAGAIN;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
-		dirty_segments(sbi) > overprovision_segments(sbi))
+		dirty_segments(sbi) > ovp_hole_segs)
 		return -EAGAIN;
 	return 0;
 }
-- 
2.22.0.rc1.257.g3120a18244-goog

