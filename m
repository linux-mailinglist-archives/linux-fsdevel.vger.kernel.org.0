Return-Path: <linux-fsdevel+bounces-67555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBE0C4339E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7DE188D741
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 19:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24048279334;
	Sat,  8 Nov 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="fEfR45/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453E1E32D3
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Nov 2025 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762629011; cv=none; b=XjUplSNaDxuOJAj9F0RYW83V127M0rihFCEkP9OO1M8THHaMAuGhEE7+/iptCXzTjrqGWeoex3KBTHL2dCbB7U1YLLHxIff0qXI85Suzo02Zq3XCVuIHRb0QYn/MEJq78Z+jv33w5JupLKHnHmenAoxo9M062gSVa7qxAgTZZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762629011; c=relaxed/simple;
	bh=9e3E1g4hxN+rejc8kzum2wJk3KiPtUh8/abMAG27iG8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZPcVFY7JrXvizL3571tOveN08CSsp7FeRLTxQ4C4URi4I8oudS3ADd8rjsq6z2RlkIRf6x4EObppEiIbSQPwSZIqZBCUxPGC8dO8oo18KKoL8DR069FRn6/+2kJTHaNcsM48kra2OBNaENUh5Z6V+kz7YWq05QDgAH/TzRZEr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=fEfR45/B; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail; t=1762628992; x=1762888192;
	bh=WfmfezCASpoeRxzyP97/Bg6TuZeskJUKe+Q4rAekhjg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fEfR45/BGmwWjUPZt6R1yF9uOirxoDV5bmKbJHcdmYTVN6KC1lLXBcFooWKTSwOa9
	 EvBA3LO5ooz9thOjCxycCoPWu7v7B4iN0NMZ5RJR+xqfPiQT9A+bflUjd8jKs5vutw
	 o8WpXvXUEpgUiQzmG1tsgj+BWtJGrbSKTJN0Z8N3f62gfnVu0INV3RaSOA1XG4ZrVJ
	 ipi2kFQQZkEomm03BbX3b++TPECxdbtcQm2y7BNFPnOCPktyGZIlGIleeRnW+vqzZo
	 1V/UZT605WmGMutL6ZSZpGrRMS+G1bxZiN+wPuGJ+p/VQfm5U6jiU6lxb/ogidYUvn
	 dLse2aUSQu/5Q==
Date: Sat, 08 Nov 2025 19:09:47 +0000
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, stable@vger.kernel.org
Subject: [PATCH] shmem: fix tmpfs reconfiguration (remount) when noswap is set
Message-ID: <20251108190930.440685-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 149e0ed8edb97c432bef16be68b2175ea0fe5f86
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In systemd we're trying to switch the internal credentials setup logic
to new mount API [1], and I noticed fsconfig(FSCONFIG_CMD_RECONFIGURE)
consistently fails on tmpfs with noswap option. This can be trivially
reproduced with the following:

```
int fs_fd =3D fsopen("tmpfs", 0);
fsconfig(fs_fd, FSCONFIG_SET_FLAG, "noswap", NULL, 0);
fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
fsmount(fs_fd, 0, 0);
fsconfig(fs_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);  <------ EINVAL
```

After some digging the culprit is shmem_reconfigure() rejecting
!(ctx->seen & SHMEM_SEEN_NOSWAP) && sbinfo->noswap, which is bogus
as ctx->seen serves as a mask for whether certain options are touched
at all. On top of that, noswap option doesn't use fsparam_flag_no,
hence it's not really possible to "reenable" swap to begin with.
Drop the check and redundant SHMEM_SEEN_NOSWAP flag.

[1] https://github.com/systemd/systemd/pull/39637

Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/shmem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28..1b976414d6fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -131,8 +131,7 @@ struct shmem_options {
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
 #define SHMEM_SEEN_INUMS 8
-#define SHMEM_SEEN_NOSWAP 16
-#define SHMEM_SEEN_QUOTA 32
+#define SHMEM_SEEN_QUOTA 16
 };
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4677,7 +4676,6 @@ static int shmem_parse_one(struct fs_context *fc, str=
uct fs_parameter *param)
 =09=09=09=09       "Turning off swap in unprivileged tmpfs mounts unsuppor=
ted");
 =09=09}
 =09=09ctx->noswap =3D true;
-=09=09ctx->seen |=3D SHMEM_SEEN_NOSWAP;
 =09=09break;
 =09case Opt_quota:
 =09=09if (fc->user_ns !=3D &init_user_ns)
@@ -4827,14 +4825,15 @@ static int shmem_reconfigure(struct fs_context *fc)
 =09=09err =3D "Current inum too high to switch to 32-bit inums";
 =09=09goto out;
 =09}
-=09if ((ctx->seen & SHMEM_SEEN_NOSWAP) && ctx->noswap && !sbinfo->noswap) =
{
+
+=09/*
+=09 * "noswap" doesn't use fsparam_flag_no, i.e. there's no "swap"
+=09 * counterpart for (re-)enabling swap.
+=09 */
+=09if (ctx->noswap && !sbinfo->noswap) {
 =09=09err =3D "Cannot disable swap on remount";
 =09=09goto out;
 =09}
-=09if (!(ctx->seen & SHMEM_SEEN_NOSWAP) && !ctx->noswap && sbinfo->noswap)=
 {
-=09=09err =3D "Cannot enable swap on remount if it was disabled on first m=
ount";
-=09=09goto out;
-=09}
=20
 =09if (ctx->seen & SHMEM_SEEN_QUOTA &&
 =09    !sb_any_quota_loaded(fc->root->d_sb)) {

base-commit: 0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01
--=20
2.51.1



