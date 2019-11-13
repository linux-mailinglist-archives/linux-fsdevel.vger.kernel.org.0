Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF4FBB07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 22:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKMVp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 16:45:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38003 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:45:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so3685074wmk.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCIGNym1KnSbrflz0aPgysV9g2CKRub3cea0GIpdFfg=;
        b=fMdFyNK+SymwdAECuwGh5bgHiLHM52dlM8jOA7UMmkyThGbzpgqWdiZvnbYfi7Q5X/
         j8rrzeyjUH4OHFGBfQVetXMSg4HnUM6L7SqEx7WB5Iq8rF/KmJ+WVTiCgnfWP0Sx2EOj
         omXRh2a572Q2dOE+jH/Z+H/Igd+HuEMtjmDQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCIGNym1KnSbrflz0aPgysV9g2CKRub3cea0GIpdFfg=;
        b=Zbcd+HRbWrL9tl5uzC6fHw4/DkkZfE+7y1zcZFnH6Blqwqs/dBvtQkZxXun4M72PFO
         gWQ2kpXhUgSocgFiMRCIZDwD80JHHhfuTo1LIlBlgPy76+5ws1Y1bRvXXeFqoRv4aIhi
         PrxumEQmTIEjkfi8xkukjiJQ7vg8clDpXNZ1BDRGuh2AzlVB0e7jtN/HZNXgr5KCu2BU
         qvg+RxK5MQVtfAdsR2PRlzjmzN5NYq/Oq9DpJMU8dQ6Kw1zEICJHEtETUh2xFthmFbHR
         QWikj8udzD6KTCtS7nc8ZWxvg66IPokCMjU4vgnAICxVrHe87k70sAv02bTyWSR7T1El
         Vdkg==
X-Gm-Message-State: APjAAAV7wlMB64q+K7OBKInRGtVPwrZoPNWA7ySbMOi+bttwOiKeLB5t
        mS02RPyzib20NX8WQ+Aw5t/ebzr24jN6ZR/W
X-Google-Smtp-Source: APXvYqxfYNjJ9YUKGN42stJr40vzZ7uxffjOy9HavGJeFiHz5gHpLiX9J8pnt+qzLJb3/NNwObpklA==
X-Received: by 2002:a1c:41c2:: with SMTP id o185mr4419000wma.34.1573681524367;
        Wed, 13 Nov 2019 13:45:24 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y78sm3997722wmd.32.2019.11.13.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:45:23 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namei.c: micro-optimize acl_permission_check
Date:   Wed, 13 Nov 2019 22:45:21 +0100
Message-Id: <20191113214521.20931-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

System-installed files are usually 0755 or 0644, so in most cases, we
can avoid the binary search and the cost of pulling the cred->groups
array and in_group_p() .text into the cpu cache.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Ballpark numbers: For example, building a random package like
util-linux with "make -j8" causes about 300000 calls/s of
generic_permission, with root-owned files (binaries, shared libraries,
system headers, and walking the directories from / to those)
outnumbering the user-owned files about 10:1, so in that case one
avoids, say, 250000 calls/s of in_group_p(). Assuming that the net
saving is about 20 instructions, that's 5M insn/s, which is of course
too small to measure (it's in the .1% range), but might still be
enough to justify this.

 fs/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..c78757435317 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -303,7 +303,12 @@ static int acl_permission_check(struct inode *inode, int mask)
 				return error;
 		}
 
-		if (in_group_p(inode->i_gid))
+		/*
+		 * If the "group" and "other" permissions are the same,
+		 * there's no point calling in_group_p() to decide which
+		 * set to use.
+		 */
+		if ((((mode >> 3) ^ mode) & 7) && in_group_p(inode->i_gid))
 			mode >>= 3;
 	}
 
-- 
2.23.0

