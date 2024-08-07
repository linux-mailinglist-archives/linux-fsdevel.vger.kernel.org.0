Return-Path: <linux-fsdevel+bounces-25352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5678594B0AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C42284085
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E1145321;
	Wed,  7 Aug 2024 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Zv5nWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FF13F42D;
	Wed,  7 Aug 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060289; cv=none; b=nTQBfAed+4s5UWxo4stIgfNWJ2jBoZxvgPlDQseU7erMv1jt2RQDl3FCZ17kWthzkGgaWDf9BUcoAeBGOfjiswEdHKuFslt8GSdfmRYucdM/Hb0goSEMlcHP+PDYF20c0oElRRYOFgQfiGFdGEY8fTRMncrufCsfdgojcOT9Sdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060289; c=relaxed/simple;
	bh=SvqeU/ZIJL4InXKZ4IE/gkXwgJ0pFR9Ce/8L1Ah0vsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t02S6S2eCf0k3ylHTi49UTyyRi1u0LdszVTufyIK/q7rje6bDEwXFRz29dtb3ZPTcb1yg6A7wAgHoCi5gRgyNi+L/HJWIxR98T5YUMJ39vgoXoIYX9CjucCdFzkQT+a2yPQKPBJvUdVVmzcreOYeLMYNaNgeAVdOvtP6e1+7xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2Zv5nWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1499C32781;
	Wed,  7 Aug 2024 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723060288;
	bh=SvqeU/ZIJL4InXKZ4IE/gkXwgJ0pFR9Ce/8L1Ah0vsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=f2Zv5nWyAL78JMALjEvnyPwQPdTRf9kMWSjuMAYiDlgp9dt+1Ig1gnZQNmwYKXe0F
	 0oqFWF+shI8uRVvf1w8LS9ilw0dlV56mHBNDsYu0+TurLhf8wuUcVCNtEvGX8BkTGG
	 9hBP2N+srYnnCZ6mh6kAb6mTMh8R+9H+qoCQipQf+ErAaQS2asDT+k9/7hbT3iNels
	 +y/wf5ZQ77Fs2Bzri4wX2PtRKGs6YFo/lz3ZRQgvTshKxxezDWDYFQX85GG72hT8Z1
	 CMZyVCmKIqeUfyQX3yK7CCw08VSqGpQN6VdVoVG1mIDsKl8PuRmg4jUCmCdtQ6XM9q
	 IhmzUe++1V8Vg==
From: Kees Cook <kees@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Kees Cook <kees@kernel.org>,
	Stefan O'Rear <sorear@fastmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] binfmt_flat: Fix corruption when not offsetting data start
Date: Wed,  7 Aug 2024 12:51:23 -0700
Message-Id: <20240807195119.it.782-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234; i=kees@kernel.org; h=from:subject:message-id; bh=SvqeU/ZIJL4InXKZ4IE/gkXwgJ0pFR9Ce/8L1Ah0vsQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDGmbL1hNX7o1ZHXuhwPhrQXex+8t+tBiLXdh59PcrYLOx zRumG+d0lHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjARbmtGhlk2q14+YHWddP+E zcXEValhnC5FBgoXfz9/bfQ4c0rM1ApGhpchtm0T1K35dYO2mXMF/d7+YFVbadhndv3tiS9eBO/ fwwAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
introduced a RISC-V specific variant of the FLAT format which does
not allocate any space for the (obsolete) array of shared library
pointers. However, it did not disable the code which initializes the
array, resulting in the corruption of sizeof(long) bytes before the DATA
segment, generally the end of the TEXT segment.

Introduce MAX_SHARED_LIBS_UPDATE which depends on the state of
CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET to guard the initialization of
the shared library pointer region so that it will only be initialized
if space is reserved for it.

Fixes: 04d82a6d0881 ("binfmt_flat: allow not offsetting data start")
Co-developed-by: Stefan O'Rear <sorear@fastmail.com>
Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: update based on v1 feedback
 v1: https://lore.kernel.org/linux-mm/20240326032037.2478816-1-sorear@fastmail.com/
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/binfmt_flat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index c26545d71d39..cd6d5bbb4b9d 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -72,8 +72,10 @@
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
+#define MAX_SHARED_LIBS_UPDATE		(0)
 #else
 #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
 #endif
 
 struct lib_info {
@@ -880,7 +882,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		return res;
 
 	/* Update data segment pointers for all libraries */
-	for (i = 0; i < MAX_SHARED_LIBS; i++) {
+	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
 		if (!libinfo.lib_list[i].loaded)
 			continue;
 		for (j = 0; j < MAX_SHARED_LIBS; j++) {
-- 
2.34.1


