Return-Path: <linux-fsdevel+bounces-611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA517CD9AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A08281D9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8181DDE1;
	Wed, 18 Oct 2023 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A619459;
	Wed, 18 Oct 2023 10:51:32 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8AC103;
	Wed, 18 Oct 2023 03:51:29 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1aQN-1qq2Gs12CZ-0036fn; Wed, 18 Oct 2023 12:51:01 +0200
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
Subject: [RFC PATCH v2 08/14] device_cgroup: Hide devcgroup functionality completely in lsm
Date: Wed, 18 Oct 2023 12:50:27 +0200
Message-Id: <20231018105033.13669-9-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:QIZpME4s742DfC8hMrFvAacnvaXAx9F7or1EdcOHr+AXfut/SnS
 K6PvdolrKyhFOfbwgo6zO9HIJZWfATHtgheagP3jvEL3r7NfZs+FK5OtlSXaKPY4GarpFI3
 5uk0w5KCb+cm+yqlenyUSwPZ99B00YYM20wsm6r17+X3pLOmtvGlKDmqajqp6RSo1otdAQv
 alXFP2b4DJGalNjTPXoqQ==
UI-OutboundReport: notjunk:1;M01:P0:jpKdQdwRLw4=;wsgzDyAf38qIa7+WwRQQUz3gqmB
 2vY2tGjqoo5K3tm391K5lFPaziCAI0ErJbr/vb3HMKM9sdrbx+tK3uXjXpuVslj67xW0Q8Sdc
 irrrx6nngTbxBss7n4At4NQoLCbXW/6a2ghH2K6TJui5lNW2H3e2ilKs1rhiWCA7vUiPvFiqc
 +h+9YUoteIb05YHA1ztCpOEvQiB6dlYAai2n02WDORs4a089mRw0UgwFjpAvCccXOMzLjM7DK
 6k5pIDLrk9ErjnaPAhRsXroh0conCREbU1gE7PnieG9R7eHg/csPBLcBrJ+Jti9pvdz4CoIIh
 uUX7ajXbM2B9ny+fNiY1IGJJT3Y7wOcApc2Bf36BydixTwKb/0zADjR2RjMN4RNi8KhQ2XAIf
 FJ40MacIoATrA0QsYux5RVvrfL31w2peGIA+WLTIFEV/MhjKQdDp++CZ0O/2nk2EtAQGjUX6D
 am9tEcTpcp7Jb80LVLsNCPUF7PdIjeEZ3UvW1u42br4XoMV8mrtsg+aGW3+Q6eT/dST7FUjJF
 6KnhFxOk9k0cSrflsUumg4R9sBl8iVdjlZK27IJq2Qi08AOSKYZBkSNmvikxLv9D2K7eHLeiD
 ME8Mkm/5varpzCkvKRH6mwEYH8F3Ps6xmKnM/YKettwu6wdyeo28BsbO4DsyrQPkRpAv0buSq
 ZnnBd7p7AHaryp+IJ+LzvT/lMLi81ojLxdWNC1nXq4MB2zCqHgvh7D6dn6ZiZUFrfs9EKe81U
 uLt0eEfqAxkC4tqmgbCImy8kZOJsVH1kcMoO/k5kYsPlu1K/tQgMWzcysV7VqoJMrT0QDtHr8
 lDHNMndtXdwV//y9ZSbPq/w/nDFNCKLVBlHu2jNbobLS30j34GQ9ZHOwPbGF7FCAdPKZuaNfC
 DJcDxI27E/HwTng==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now since all users of devcgroup_check_permission() have been
removed, all device cgroup related functionality is covered by
security hooks. Thus, move the public device_cgroup.h header
into the subfolder of the lsm module.

Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
---
 security/device_cgroup/device_cgroup.c                    | 3 ++-
 {include/linux => security/device_cgroup}/device_cgroup.h | 0
 security/device_cgroup/lsm.c                              | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)
 rename {include/linux => security/device_cgroup}/device_cgroup.h (100%)

diff --git a/security/device_cgroup/device_cgroup.c b/security/device_cgroup/device_cgroup.c
index dc4df7475081..1a8190929ec3 100644
--- a/security/device_cgroup/device_cgroup.c
+++ b/security/device_cgroup/device_cgroup.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/bpf-cgroup.h>
-#include <linux/device_cgroup.h>
 #include <linux/cgroup.h>
 #include <linux/ctype.h>
 #include <linux/list.h>
@@ -16,6 +15,8 @@
 #include <linux/rcupdate.h>
 #include <linux/mutex.h>
 
+#include "device_cgroup.h"
+
 #ifdef CONFIG_CGROUP_DEVICE
 
 static DEFINE_MUTEX(devcgroup_mutex);
diff --git a/include/linux/device_cgroup.h b/security/device_cgroup/device_cgroup.h
similarity index 100%
rename from include/linux/device_cgroup.h
rename to security/device_cgroup/device_cgroup.h
diff --git a/security/device_cgroup/lsm.c b/security/device_cgroup/lsm.c
index 987d2c20a577..a963536d0a15 100644
--- a/security/device_cgroup/lsm.c
+++ b/security/device_cgroup/lsm.c
@@ -11,9 +11,10 @@
  */
 
 #include <linux/bpf-cgroup.h>
-#include <linux/device_cgroup.h>
 #include <linux/lsm_hooks.h>
 
+#include "device_cgroup.h"
+
 static int devcg_dev_permission(umode_t mode, dev_t dev, int mask)
 {
 	short type, access = 0;
-- 
2.30.2


