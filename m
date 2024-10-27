Return-Path: <linux-fsdevel+bounces-33033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9F9B2121
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 23:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724CA281540
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2024 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BFF188587;
	Sun, 27 Oct 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="Z5amQny2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3SZoRA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA337286A1;
	Sun, 27 Oct 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069293; cv=none; b=uetT16QmdiLp4/k2/qzNgBZE8lGAQEsG0y/tj7FRY2arKJVQihJzbaqvi2z/9pgEuHzzCcE9Al/LRX+Ar2boc7qdt6FPop8znK0mgp0BNXyOAGN2pcVNxUdTID586Wz9eufKHU+Ajv+lErpA2iX+S+zuqBKb3eoCi/3B1K6b8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069293; c=relaxed/simple;
	bh=mNwCDYHaewSTiQZC6F8XtuBW3oExxbRrggmg6HesAN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MM0XtmCca6hWl6F/I4ISfhc/rW4BbsngGuryov+rBpe98nn7z++J6OtuLLNZ9+tYhBpjT43g1eUvB8dCc1l2wHzDoShcSA8vCbTkQnOr51hVnKalug3AfJoHXL6EJg2NGo3f0Yg2Mf9ytP9BwXtcqqE8qcGMaXS/QzRqb+vm9h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=Z5amQny2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3SZoRA9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id DDE821380174;
	Sun, 27 Oct 2024 18:48:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 27 Oct 2024 18:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1730069289; x=1730155689; bh=ovpSW08eRQWRSpckMlBzd
	TJs6o+8zDMYbK3U5gGCDho=; b=Z5amQny2a0z7rN/Q/E40o+6idE/O/tW743VsL
	rsusfhOs5wS8OiPTVrnLKBjNG315kSkq0ueWvMlaKF40+n/1bh20lgqJHOGqrJDz
	g/eeleneftMg5rjJ+WwqxK/6BaL+WcKOQigZ25eREPPxUrJ7+SpkBvFq0wxjJ1JY
	bmh4n9atQ+Q03W0ku3GycA5pZBs2ye8/W+8MEATfpqFIHIqxBJr9virp5B37ZVtt
	9WsFfWxunuK4NjVlcEJ6ZpkY6qK9Cjl9q9pJzSJY4oa0GBDdlfqLnzGVJD/EZMi0
	c2f02xuzsUqeBMLygDGnW8jIcNjkITMAJ/Y5625HuaPHwmyvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730069289; x=1730155689; bh=ovpSW08eRQWRSpckMlBzdTJs6o+8
	zDMYbK3U5gGCDho=; b=Y3SZoRA9f4uscKyiBfLaHEp8BcaHWSKu81zhsrwAeugw
	TP+6SkyWjidStAMCzFKo1iX+NRBLSQu7QYGJKgZtn8h5T7BZmNnLkW/1+k2Nxcc5
	d5tUV1cKPEfp0L6iOQFqEc0QV374c/7FV08OS9jdw6UoPi9haLO0KixPUwTnwxvU
	LV14uNLzjI/6em6xFSdPyGseD4I5Zda7MGw5qKjferqURPuKeqTYP26VqVFa73nk
	WLNqMbPLXXe4h18JNAltj5zFuttL2iwSXfbMocch/0SQqR7IJgLAep3LvQq0JfX7
	0jB6Ppna35OYRWfsHjYVqLVeC2qLV40TSQu40PaTjQ==
X-ME-Sender: <xms:KcMeZ3_tqvVxSx0K6Iz_SzEoVL2FErWUMmApL-uZBaLATMnhQSjIFg>
    <xme:KcMeZztVMYZlpK4nZdexcHVuvXvhfwlQsfrmymWC9TVcdZ3mrgUc_t-yFg_shRBad
    PwCBo4_-8cn>
X-ME-Received: <xmr:KcMeZ1CkWCnj1mENtV0u9d5iOk2VtZRBvNj9LBlGQyizXfAlIBsLP3IRm5XoRI9M7T9GU_j312nAAgia7RVBqmdC4Ae7D0MuESiC8RD1Fgx37xAjkvxXVOPG8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejjedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtf
    frrghtthgvrhhnpedutdfhveehuefhjefgffegieduhefhtdejkefhvdekteeihfehtddt
    gffgheduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhrtghpthhtohepvhhirhho
    seiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegruhhtohhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KcMeZzdCAV1YzSwxzgetXf9xvVNJcthcDsgMynmDDfDby5Pgh0ZmvA>
    <xmx:KcMeZ8Nf_rPKE9eYOW8JoQlOBNe86a1UXBPC2BGjeOnUqLOQA6DhnQ>
    <xmx:KcMeZ1mUAhD3jvpnXqTd0t_Pmow9sUlrIsdEg5oXPYB6lCe0cjQMqA>
    <xmx:KcMeZ2uxCoWqAxR4zHG-_12J_8eKLkyY2ajX98DjlvOZtI6tfTR30g>
    <xmx:KcMeZ4CwOp8wGzCnd_HapAsFzhgmXD2i4brtg2gpngdylC_FJ2mFkg1X>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 18:48:07 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	autofs mailing list <autofs@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] autofs: fix thinko in validate_dev_ioctl()
Date: Mon, 28 Oct 2024 06:47:17 +0800
Message-ID: <20241027224732.5507-1-raven@themaw.net>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was so sure the per-dentry expire timeout patch worked ok but my
testing was flawed.

In validate_dev_ioctl() the check for ioctl AUTOFS_DEV_IOCTL_TIMEOUT_CMD
should use the ioctl number not the passed in ioctl command.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/dev-ioctl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index f011e026358e..6d57efbb8110 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -110,6 +110,7 @@ static inline void free_dev_ioctl(struct autofs_dev_ioctl *param)
  */
 static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 {
+	unsigned int inr = _IOC_NR(cmd);
 	int err;
 
 	err = check_dev_ioctl_version(cmd, param);
@@ -133,7 +134,7 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 		 * check_name() return for AUTOFS_DEV_IOCTL_TIMEOUT_CMD.
 		 */
 		err = check_name(param->path);
-		if (cmd == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
+		if (inr == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
 			err = err ? 0 : -EINVAL;
 		if (err) {
 			pr_warn("invalid path supplied for cmd(0x%08x)\n",
@@ -141,8 +142,6 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 			goto out;
 		}
 	} else {
-		unsigned int inr = _IOC_NR(cmd);
-
 		if (inr == AUTOFS_DEV_IOCTL_OPENMOUNT_CMD ||
 		    inr == AUTOFS_DEV_IOCTL_REQUESTER_CMD ||
 		    inr == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD) {
-- 
2.46.2


