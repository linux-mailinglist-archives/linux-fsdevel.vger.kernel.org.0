Return-Path: <linux-fsdevel+bounces-35269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA19D353A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685E5B2587A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88A189BAD;
	Wed, 20 Nov 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx8h7H1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5E166F3A;
	Wed, 20 Nov 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090655; cv=none; b=kWL850ojLT+uwW+W3sSFBvp/XYS/sVEW60Vhn+ieyqSQ5MV6M13KGdsBG01OW7BiFaGOoRBpCysDPiDPVO1fEw+1/TEENpZf2JeKT8epZDveAA4KC2VnAXT27NkkdMGptmHIWU5npYoRyr6kD5xNoo6uBNVNbmULcR/bfnIl9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090655; c=relaxed/simple;
	bh=VZ0bMgpHmeS1q3zJXNgfFqVDOKY02RdiVHnzp3t4PKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3nF7a9k0xCNMW0ZiIJWia0RHhanKUhE3YeXXLm3H961efVSPQW1DRcaCP/nhDHWh1SYugkHTi/7m3q43N/KuIHl0J+YpdtLmD6ouv2pyqomrjVHirJHC8Kpvi2vbHlipM0seTTdiQL0oHSJhc1tLjVgF8OIIsfoGrnU3LA0aHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx8h7H1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791B1C4CECD;
	Wed, 20 Nov 2024 08:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732090655;
	bh=VZ0bMgpHmeS1q3zJXNgfFqVDOKY02RdiVHnzp3t4PKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cx8h7H1FN/5vsyHemnKYAB0VKnI16GrilNQpp6mC4wYbA6viC2kfsPuA1cAowKTMt
	 p2+ZRVrb3FMo+4EBoWLoxoRuv3WrSigL8SBsGkNtexnOLEVXCF7iBjQj29t9dK+q4S
	 YQUNHA9Jbn7pb9Cgizuktomm6li/x21k5/CzcSgRni1u3FsC5Em8+TntJSsfPiSglz
	 NHDLsOSPSrtpnrpVRbF9/WO1RzJ3OORZn4qIYeJw48HAJUBYfoSMOusjjrtR0xze90
	 eFXw1pXPi7pRXKgJG1YJtOZFkKdO5mSYAH9DDQr+mGaDdclJ8mGzM4Ik7WLXW38iyb
	 jDo7Dy5JPckhQ==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	"Cc :" <stable@vger.kernel.org>
Subject: [PATCH] statmount: fix security option retrieval
Date: Wed, 20 Nov 2024 09:17:25 +0100
Message-ID: <20241120-verehren-rhabarber-83a11b297bcc@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c8eaa647-5d67-49b6-9401-705afcb7e4d7@stanley.mountain>
References: <c8eaa647-5d67-49b6-9401-705afcb7e4d7@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=brauner@kernel.org; h=from:subject:message-id; bh=VZ0bMgpHmeS1q3zJXNgfFqVDOKY02RdiVHnzp3t4PKc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzha7omcmfLT/ZfTVhqfu7zm4OvNbjBay+D2I681ew VnjP/toRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUrjP8UxEyeH6pT+llYFfz ovMCSR5h06eesMh/JvunNiL8l/K3OEaGJ2fFCu/FTjbc6DaVLSZeN5jbKdzY6G1iuDvvucqDTeI sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Fix the inverted check for security_sb_show_options().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/c8eaa647-5d67-49b6-9401-705afcb7e4d7@stanley.mountain
Fixes: aefff51e1c29 ("statmount: retrieve security mount options")
Cc: Cc: <stable@vger.kernel.org> # mainline only
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6b0a17487d0f..eb34a5160f64 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5116,7 +5116,7 @@ static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
 	buf_start = seq->buf + start;
 
 	err = security_sb_show_options(seq, sb);
-	if (!err)
+	if (err)
 		return err;
 
 	if (unlikely(seq_has_overflowed(seq)))
-- 
2.45.2


