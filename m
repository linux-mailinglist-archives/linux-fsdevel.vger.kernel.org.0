Return-Path: <linux-fsdevel+bounces-607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607517CD99F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C6D1C20A89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E321A5BB;
	Wed, 18 Oct 2023 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123318E30;
	Wed, 18 Oct 2023 10:51:31 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7FFF;
	Wed, 18 Oct 2023 03:51:28 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MpTpc-1rKN122hCu-00pxt2; Wed, 18 Oct 2023 12:50:56 +0200
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
Subject: [RFC PATCH v2 03/14] device_cgroup: Remove explicit devcgroup_inode hooks
Date: Wed, 18 Oct 2023 12:50:22 +0200
Message-Id: <20231018105033.13669-4-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:9txzexZlGvSwb4okFwepV4A/xdE7L+En6yWfSM7Ob2qFS8xwk0B
 RNfCtlU26HDOIiVtyVENVGHclRnYkLubq56knGJ51Qnw6ZKsh1SW9LuRyybOxSDZIUIKxNv
 AN3CLFTohgXBzt8w8DrZ9YVVEYjtxF8dwDLsEOmjAvd+roOOsqvaAaeWGEtp06qWBl9o7XP
 aqMAqctBfV8LCg07WwDaQ==
UI-OutboundReport: notjunk:1;M01:P0:Az/RNyG4D6U=;jVudnFj5FTPOi2y/60oGrCFlaQ2
 k32k0rlRq18W2bEI8ApBH75+5UQK+P1MesrQM5UTngTIRJjxFO37BoR10eN+MAgd6HNE5xNw9
 C8vCjLnds4fGSXhVNO/BnqQiCLl+jv109Q5M1nqrH4Xtx1KQp5G8J9sZANbw1/EjDi/afQksW
 0cTYl6bFkJI+y+bZyGhy4N2CcKBGtOU/LPz9Oem5+Wr7BRL38TPYCaszJMbFwOrwCduUfhmzb
 0suSv2C+bn6O41gp15tf+vvKBJiidOwMhdTTMrvpPtSaA4vHk/mwXZyLcKtH/u/O02PWoAA4e
 h+QJ9o6AOkW1Q0ZuU1MaXaKTVEBNvKmYSmTlmyiEK7ecA5HkjulkqCFk0NgptO4b43LPTEpCb
 KSbqyLdZAwyn2ToVQCyUk0W2WBDpaCpFP9Y437NgGHV2JP99bVjPD7tz3XZIrKm5vxs8KQPa1
 nOMv2gKf7povpJszKmzXKpuHyKD6okbnYExjnU0sJPV+ZDqeJWC9lfQ9/bD7AOlDKvjem81vV
 4TFats2vvFWCt8bSyjraoQXSwLiU615Yn/bVwbZ1tUTCMrcKng4/Hfl+ddnwEhdYbtwTlcpQP
 JI0YKmVGm+pMJWuD9qJnYO+VRNdnE5r2GjzbByp52N7pbw1fbVAE9xY2Ow8pA89L5VREdD+r3
 lcRJGhaTbwhXeAfipkHIc5MYwFabJ54Eoy4i8TDMNE5MbV9uKp42lKBeafgF7y4PwTbFxlQE/
 v08r8kfpkQ7vPbbdiXxMpq/36zwVydHLfPaixlg5s/nVgxGDZaHmOC46AlxUZUWbk0eC7jUjk
 YitFlaPxHyNEojlvFTlHcec808NTzpXX/EnM9SZvqKGb6htXFLHqKuftmKy9Oe3tP2Y3zVlQZ
 JTICdwF1R5bVQ60TLAlcNdx2wt3UfijH+md4=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

All users (actually just fs/namei) of devcgroup_inode_mknod and
devcgroup_inode_permission are removed. Now drop the API completely.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 include/linux/device_cgroup.h | 47 -----------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index d02f32b7514e..d9a62b0cff87 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -14,54 +14,7 @@
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
 int devcgroup_check_permission(short type, u32 major, u32 minor,
 			       short access);
-static inline int devcgroup_inode_permission(struct inode *inode, int mask)
-{
-	short type, access = 0;
-
-	if (likely(!inode->i_rdev))
-		return 0;
-
-	if (S_ISBLK(inode->i_mode))
-		type = DEVCG_DEV_BLOCK;
-	else if (S_ISCHR(inode->i_mode))
-		type = DEVCG_DEV_CHAR;
-	else
-		return 0;
-
-	if (mask & MAY_WRITE)
-		access |= DEVCG_ACC_WRITE;
-	if (mask & MAY_READ)
-		access |= DEVCG_ACC_READ;
-
-	return devcgroup_check_permission(type, imajor(inode), iminor(inode),
-					  access);
-}
-
-static inline int devcgroup_inode_mknod(int mode, dev_t dev)
-{
-	short type;
-
-	if (!S_ISBLK(mode) && !S_ISCHR(mode))
-		return 0;
-
-	if (S_ISCHR(mode) && dev == WHITEOUT_DEV)
-		return 0;
-
-	if (S_ISBLK(mode))
-		type = DEVCG_DEV_BLOCK;
-	else
-		type = DEVCG_DEV_CHAR;
-
-	return devcgroup_check_permission(type, MAJOR(dev), MINOR(dev),
-					  DEVCG_ACC_MKNOD);
-}
-
 #else
 static inline int devcgroup_check_permission(short type, u32 major, u32 minor,
 			       short access)
-{ return 0; }
-static inline int devcgroup_inode_permission(struct inode *inode, int mask)
-{ return 0; }
-static inline int devcgroup_inode_mknod(int mode, dev_t dev)
-{ return 0; }
 #endif
-- 
2.30.2


