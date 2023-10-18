Return-Path: <linux-fsdevel+bounces-615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2677CD9CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8D3281BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D31A28A;
	Wed, 18 Oct 2023 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CA199A4;
	Wed, 18 Oct 2023 10:57:02 +0000 (UTC)
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 03:56:59 PDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3E10A;
	Wed, 18 Oct 2023 03:56:59 -0700 (PDT)
Received: from weisslap.aisec.fraunhofer.de ([91.67.186.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Myevl-1rkb8513aX-00ywBN; Wed, 18 Oct 2023 12:51:00 +0200
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
Subject: [RFC PATCH v2 07/14] drm/amdkfd: Switch from devcgroup_check_permission to security hook
Date: Wed, 18 Oct 2023 12:50:26 +0200
Message-Id: <20231018105033.13669-8-michael.weiss@aisec.fraunhofer.de>
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
X-Provags-ID: V03:K1:5hEHFJ1ImyT/QBoZt+16PZOB0PG8GCYi6JjwGtaP6iS7hUpeti4
 SQkmld3M5LO4Um0eZThRUP8ulZFPP+a7w11JYT5kc+yKewkRv47KcwH+ZUHSnHecFJqezO1
 kmiKN3Jv2MKghSH9lFZYmT8Jk7fJvfL2Y+iJ4CREoeJGJJGWsyQtOo9/38siC3NrBZnmenN
 bR0USbbnxTsgNCcwoS86Q==
UI-OutboundReport: notjunk:1;M01:P0:GtiADAAjAwY=;LC6o+4QflxJbOhLM1dykXA+PqWA
 DXAh9zy91am0hr7PYpYyD4+FPQqw7awKB7Gcpw5icJ6sQUly0ayUAUWqy/aWUqkIM5Nn7Dkiy
 WiJk7AzjBK0puAEu89YWyyWS+F5mfZIGUCFRuEzGWpoIo3HuCnRT1BYULf2Wsjl0zQGWF3QSF
 u7AAH7MrCJwKgv5P1nz+5xGqDmytVwALHJys+Bke29D7IzdFNx8e1T9WBAJPFszCwaVfpIf4k
 ERBxSLBRNZfVd2kf2AGI4+tAyd3J18rhisnNysVUjl/4eeBPw48jRtMx+k5LC7rJ1ftwc4G/3
 EugVRAdbqmmEb/S4Cr73MaIPdCJK3e+md+9X5DfYYy+cPB0yayJeYTJT65mEzO29RN1YTeEDd
 UUhDHcZvhMtpkHIwLLL8kpkUuf1K7HUO8BrwEjATSlRrjXqaYJWoP5eua8yKaDNsNupmET7n2
 Eeerq5i/DZWD0t14Jy4xh/BuAdBwFwvbFpMjaqqdgFiP3MdgarW9ayr9idjmPlZb6n6G5Foj4
 NMCDT5uQPjbGM6gFMdjqJg8Sx6vZM3SbsIaGaY4JbBZyRtyAnDGfycaLGsBzGpRJOe0DQ/6NW
 Yv+dc66TYfV+IlVu+T0OYwgAJwrFTWPE7k25Pn0AkVjOfH2adPwAGsM4Ujms/4D8TfdMGuQkN
 QM3BJuC64orDPjgDXm/6aYne4+HExF3wazTVThD3kepQkPPpiqGHZKwhObk+8fmtLu8QZfgIF
 E8yfPKJKZCb9VPRQRIqYCFnabCE8FJ4KmWDXoqJp4kmUCs9uaqLbAClyfwwCxs1j1ZwOI0azk
 81t+E0E+AWYMxSTff25Cl+HLAmFD+hsn4EBgD0vujsbgWcGc4y/ETnw4mCMwJCwGNVoSCxVNs
 vVEcbR9TcxtzDHw==
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
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fa24e1852493..50979f332e38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -38,7 +38,7 @@
 #include <linux/seq_file.h>
 #include <linux/kref.h>
 #include <linux/sysfs.h>
-#include <linux/device_cgroup.h>
+#include <linux/security.h>
 #include <drm/drm_file.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_device.h>
@@ -1487,9 +1487,8 @@ static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
 	struct drm_device *ddev = adev_to_drm(kfd->adev);
 
-	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
-					  ddev->render->index,
-					  DEVCG_ACC_WRITE | DEVCG_ACC_READ);
+	return security_dev_permission(S_IFCHR, MKDEV(DRM_MAJOR, ddev->render->index),
+				       MAY_WRITE | MAY_READ);
 #else
 	return 0;
 #endif
-- 
2.30.2


