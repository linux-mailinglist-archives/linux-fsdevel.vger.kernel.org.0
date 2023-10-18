Return-Path: <linux-fsdevel+bounces-617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABBD7CD9D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88FE281D64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C286C1A737;
	Wed, 18 Oct 2023 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593A1A5A3;
	Wed, 18 Oct 2023 10:57:06 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C18112;
	Wed, 18 Oct 2023 03:57:00 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9Ib1-1qvWya16jX-006PWF; Wed, 18 Oct 2023 12:50:59 +0200
From: =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de,
	=?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>
Subject: [RFC PATCH v2 06/14] block: Switch from devcgroup_check_permission to security hook
Date: Wed, 18 Oct 2023 12:50:25 +0200
Message-Id: <20231018105033.13669-7-michael.weiss@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
References: <20231018105033.13669-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g2BQi8jhy6myxnCus8ZQPoNW58k4bHpqaw0EG5w9henscj1hzwh
 +LRuATaGTnBWBWkD6WqjEFcQ2oo8oocdg45yWtogdxsTACLQLaTrVi/wC0nt3/pzp/HwB7l
 WbXaEvirGLkTgf1rTZHblrr/Ij+/xiLQhErhPbKLn88BU0G2c8pYTNh6rS+z1bruMVDNP6g
 fHJxRmLTFHsoJ8N+Aq7ww==
UI-OutboundReport: notjunk:1;M01:P0:JXHVyhNThiA=;cyZuFiGGc0TW4/kMx14p4/R+huY
 yNY4t5YbgqKc/8n6xoDjinZccz47BgP5UVdZxa85ZQt9DYeKBataf98xF8MxWxynC/YhUweXI
 M48qBzu6COM3TvjVWMzzB7BxmpevoBQlmdSMX5vHwq3NYj2ZyuCheQT17No7DsfVHw9IFBAkA
 v/grs9MhuLPTciXhgYjTvWv0deyNIkjiakQRLjUayb7a9vA41LeoOsceIHVfo2Poym9T/SV0O
 P7zqahNznxNAOYRtBTEmEKqjHhJYy1JfaK+bBU2FC3tndeb5YBQo7ge8x9eRPmlre0+NQmKHX
 8RPAyzvuRgBukbLPlk2kTbU/I/nnsyk7Qq9v+fBBPVQmLj0jC9dwITHFzyulC1qeDpjx4MAit
 qFctqbf8B5L2HgSJ5OTnBYtVA5wnL6u4Swi5qCrEplqVYNScX6UoWsTf+tj+BOGEYGNhSO0xe
 1EabzTnaK5SLzISTInCVw3v+Av0SewD5io4bpLZIqveLkZLrMDK08U/SiDgj0t6wZfvtk4mik
 k9O/etP0/M10ZGqFi0Ty4ZRiR3c0r2GLiWreIgO/WWLzP6YoMBADEdRWzzHK4tP9rqlghlKzu
 0/6gxAWsJqykevu/GbFjp0BUyWuU5bR84YiO06z9H5HW1M8kGam1MUwBl5cKmqup9wQrO9Exx
 kWU8cT+oQHJf9GT9IErHeV9uYHZdK0ZfEH7PwgJsuVJ1gItz7Mxwa13JYKGqwoAlAD7kx049H
 5AywXgxU3wvNGP9lVGRvEDsPVCkGoiy12bJlR2fUy5p8+35ks7NZeBihThQ9hdtI695zc3vvH
 b48pbPFaKeeRxoPb+uXfkhT3zIdIKX3m7e6AJ8nxGwXnTz5nYsyRNhOtY3n6sfhl2N6/wG9r/
 f4q9SG0yLyvLSog==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The new lsm-based cgroup device access control provides an
equivalent hook to check device permission. Thus, switch to the
more generic security hook security_dev_permission() instead of
directly calling devcgroup_check_permission().

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 block/bdev.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..fc6de4e2a80b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -10,7 +10,6 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
-#include <linux/device_cgroup.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
 #include <linux/backing-dev.h>
@@ -27,6 +26,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
+#include <linux/security.h>
 #include "../fs/internal.h"
 #include "blk.h"
 
@@ -757,10 +757,9 @@ struct block_device *blkdev_get_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 	struct gendisk *disk;
 	int ret;
 
-	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
-			MAJOR(dev), MINOR(dev),
-			((mode & BLK_OPEN_READ) ? DEVCG_ACC_READ : 0) |
-			((mode & BLK_OPEN_WRITE) ? DEVCG_ACC_WRITE : 0));
+	ret = security_dev_permission(S_IFBLK, dev,
+			((mode & BLK_OPEN_READ) ? MAY_READ : 0) |
+			((mode & BLK_OPEN_WRITE) ? MAY_WRITE : 0));
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.30.2


