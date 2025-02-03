Return-Path: <linux-fsdevel+bounces-40637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D83A260FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 18:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A513A478F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B020C48A;
	Mon,  3 Feb 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv/3bCky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14720B7F3;
	Mon,  3 Feb 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738602596; cv=none; b=I+EXGg/UJ3WVfMcmUOHkDHTxROwT5OnovRjKFCYrsWi0pRHOEWjkZuu1g9/1JzawS91Oqut2CTN0MvkFs9ehkwIK4sqsd4r2bx3NjlcxYqps4XABVxUp1EhR+Enh5igdhGyh9IaBdByzdDmSRtDPPJwykmHXsql3OC/2KHrIv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738602596; c=relaxed/simple;
	bh=MddWkbwDmY4Djr2ktBMCExUfhg8X2JcTrHjDlOIt4xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VOF9jxFIslTD418JTlP7Tr+nveYGKY0GIyr2DZ3fcUqM21BeAedn7Imkele+2uWbeLhHBuLmRWNCPwzN5VApA/PdOFCrGJ1mkhUBgRtYm5M5yNdEKgCKfLO+QpPPxa1CTGKgMqyJCyj9yioNVOqx1V0AwU1wocIsbfNwobclksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv/3bCky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14668C4CEE3;
	Mon,  3 Feb 2025 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738602595;
	bh=MddWkbwDmY4Djr2ktBMCExUfhg8X2JcTrHjDlOIt4xY=;
	h=From:Date:Subject:To:Cc:From;
	b=Lv/3bCkyE6abQpl2DOZACzozO4x093WZ8QzHbyaS6IDtTxnMjcIGA3F3Hmp9u2kK6
	 eP9XinhsMmqN09V4jNlXDnfPERNMcTckUJGYpLcwLne9JPoDdfDRX7AGeqYwYOm2ma
	 4HUPy32pM9LOv+4wWIttCSCftQ1bW5paQV2Qdbcq6aDMpX+xW7CLnlOzafqj6M192d
	 REyRfG6t8aTL++zh5ludMuYDvzHrb2YxeU/Sv57owXsT8vBXfYdilNNMeLm1oj1Boz
	 Qz5p6AT5/9McgJ9Vdk8Rsbdp6jEU6iL87BpvN7onoPstVOcjHTDSR7hOhP3H0OanMb
	 TQx2BuX8Hcj8g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Feb 2025 12:09:48 -0500
Subject: [PATCH] statmount: add a new supported_mask field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-statmount-v1-1-871fa7e61f69@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFv4oGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNj3eKSxJLc/NK8Et0085REy6TUZIM0I2MloPqCotS0zAqwWdGxtbU
 AaiVa5lsAAAA=
X-Change-ID: 20250203-statmount-f7da9bec0f23
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MddWkbwDmY4Djr2ktBMCExUfhg8X2JcTrHjDlOIt4xY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnoPhfaP3N3BuhZsrZkuJ5z+LXfaJ/NYIS/NLbS
 VKz6qOkDsaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6D4XwAKCRAADmhBGVaC
 FSR5D/4pGdT8m7uFzHlGipckUwlkaao3TpO6OQauenhhiHkDujTKMxkNtGqJPMvUY2rPh+E+qo9
 iBIndeKSq+x4JhVOT5L0wdaWei07fCWCh9R6uRPsba1UWXwX58zrt78yG5iIg4AMOCRA/dc0UIo
 WgvTF3SxACubl/3Sw1YxWSIwNo3wB9gESvc+NkLGsi4287dQ2SVz1nMELXNxtAEziUeG4qThrhI
 oNyYnbNAhRk8+xtHuKaFMO+qUgyPmYk4wX0KM3AbGMdwvtV5LFz62g1I8yNRVvSBBR33qN09T2t
 tEWHS5iq/ivIM+jMWsAjnkbh8joEu2qf9TFgekZWhhNNtBvolUVWxcPtXZY7wq2Wcdy0GRDfSgB
 wD70QiKALVLnvO2RWYmeSNLsLwKTNejiKjZIvbfe+suJDb2yvb6U/TiW8Oq2zN+6p1dJz23QAql
 p0Vr2rwEJt3nU+PtOixQxEBQNl/gyWecyNn6aRuhH9/FkChgFA5KNzEZWKw0Kb7qWe63++MuQeg
 SC0oSGII4d2dnQcQ7kk+hCcZazcj8nQspEO/GWJegZe+fh4G+FN43IPXuaUXKT8eXhXe70/uE6I
 Hvy8v7lMW+PC9dXXSLMANGlu4ESwIoI0glXpYwOeo31dyesI1H4+xhUc+/coRm1IufJPa9TeLGx
 i+PxjU1RPbRLOVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some of the fields in the statmount() reply can be optional. If the
kernel has nothing to emit in that field, then it doesn't set the flag
in the reply. This presents a problem: There is currently no way to
know what mask flags the kernel supports since you can't always count on
them being in the reply.

Add a new STATMOUNT_SUPPORTED_MASK flag and field that the kernel can
set in the reply. Userland can use this to determine if the fields it
requires from the kernel are supported. This also gives us a way to
deprecate fields in the future, if that should become necessary.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
I ran into this problem recently. We have a variety of kernels running
that have varying levels of support of statmount(), and I need to be
able to fall back to /proc scraping if support for everything isn't
present. This is difficult currently since statmount() doesn't set the
flag in the return mask if the field is empty.
---
 fs/namespace.c             | 18 ++++++++++++++++++
 include/uapi/linux/mount.h |  4 +++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cbae6238cda09874e2dac146080eb6..7ec5fc436c4ff300507c4ed71a757f5d75a4d520 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5317,6 +5317,21 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 	return 0;
 }
 
+/* This must be updated whenever a new flag is added */
+#define STATMOUNT_SUPPORTED (STATMOUNT_SB_BASIC | \
+			     STATMOUNT_MNT_BASIC | \
+			     STATMOUNT_PROPAGATE_FROM | \
+			     STATMOUNT_MNT_ROOT | \
+			     STATMOUNT_MNT_POINT | \
+			     STATMOUNT_FS_TYPE | \
+			     STATMOUNT_MNT_NS_ID | \
+			     STATMOUNT_MNT_OPTS | \
+			     STATMOUNT_FS_SUBTYPE | \
+			     STATMOUNT_SB_SOURCE | \
+			     STATMOUNT_OPT_ARRAY | \
+			     STATMOUNT_OPT_SEC_ARRAY | \
+			     STATMOUNT_SUPPORTED_MASK)
+
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
@@ -5386,6 +5401,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_NS_ID)
 		statmount_mnt_ns_id(s, ns);
 
+	if (!err && s->mask & STATMOUNT_SUPPORTED_MASK)
+		s->sm.supported_mask = STATMOUNT_SUPPORTED_MASK;
+
 	if (err)
 		return err;
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index c07008816acae89cbea3087caf50d537d4e78298..c553dc4ba68407ee38c27238e9bdec2ebf5e2457 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -179,7 +179,8 @@ struct statmount {
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
 	__u32 opt_sec_num;	/* Number of security options */
 	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
-	__u64 __spare2[46];
+	__u64 supported_mask;	/* Mask flags that this kernel supports */
+	__u64 __spare2[45];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -217,6 +218,7 @@ struct mnt_id_req {
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 #define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
+#define STATMOUNT_SUPPORTED_MASK	0x00001000U	/* Want/got supported mask flags */
 
 /*
  * Special @mnt_id values that can be passed to listmount

---
base-commit: 57c64cb6ddfb6c79a6c3fc2e434303c40f700964
change-id: 20250203-statmount-f7da9bec0f23

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


