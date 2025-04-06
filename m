Return-Path: <linux-fsdevel+bounces-45823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80077A7D079
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 22:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5671316AA18
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F3B1ACEAB;
	Sun,  6 Apr 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="roZE7PJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MG94ThnM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59B15A85E;
	Sun,  6 Apr 2025 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743972360; cv=none; b=Dv4vrHeOtuiX/iiMmDZ6QH676OMUMc2idbICFzJMMbFQPOkex4ksASvEVoeOFzR/DFZVo59+b9X8NlOYMKLxWz7nQrP2fjVfGiIloL+cLW5qcCBQZLofRPCDACmwvf0holbQmP0pkRmp0wDtqpDZeKmluuAqZmMRjaSQ4Xc4I5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743972360; c=relaxed/simple;
	bh=7HGn0jib/kmR9d10MZQU3iiQIPjUSsHH+0CH7Imt00Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC7uF4MffAYNTUFSWUaEYvm9JUG0Aw8SJyQxOKHIy8vxx3NAHfmNYRmKS6T503gmTBT4IwJ8CDJ3h5i9rru2iIQoqX2nBMYaOt2E5I5mqnarmbt7hbIy9XmQtpBIC74ollk/bO8ysFXyUZLIH7kKVhgyrjhPf+gO1obtWo6PxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=roZE7PJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MG94ThnM; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 00937202430;
	Sun,  6 Apr 2025 16:45:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 06 Apr 2025 16:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1743972356; x=
	1743975956; bh=6go0t2my0vJ/oS1uBp4E6KCMY7Xbt6JkyoRL1HMo1Jw=; b=r
	oZE7PJJH6lR9H5rn+oSWMgKLkOC4CUE0pjhKTwdig/I02ZD4QJp9sUgZXhKDVFol
	qOQSF1Qja0befWOScKpSQJsKuw4TAzcuDEx42jWNIJyUvejqeKZHPItt1kAvcvXK
	G/ARVfPhXb0Kdae9nw7M4ZHt0AQSoMjH5qaMVj+jaxsbZmLz+55NE5l9+6AySni4
	5ZAfNy4n+DFYA137z4hG79e2VLwaAb1mIFaiWq63cilqofFueZIAoNVK32Wtli5w
	/Npk9bgWksMf6+jjTAzocbE19/4Ts/rCSjJPiXrhpKs117d5rMD9ZxJZr9f9+fAe
	fknLVGlNbWgIdgOn3RR/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743972356; x=1743975956; bh=6
	go0t2my0vJ/oS1uBp4E6KCMY7Xbt6JkyoRL1HMo1Jw=; b=MG94ThnMog4g/OtQ6
	NMlnKKAQ0tiTuWwYic1mxv+J2tLU3UIU+ggDPNmbytmH9YMjUEGHRkv5CN5dyso2
	SAT9MAK1BAqwcwim4/xvlwoZsWAaT354fJUgFP7y0TqcL7HBGk8z+ZEj2YfjhEq4
	i8ZOSzlBCaWvypUM/kMkzcoO0ssxMQQyFUwPOaLCK8KPSi0aOn9mvW8PZzncHCJM
	XrPMjMRF7UTthwlERNK2Xb1iKQtbo8+S/q7OzEaXn4Q6kz8c19Dwq/Hqn7J1Qqk/
	YDzL+NIp9bqHp2z/MwyLTb0Bq2f5aJ+aJi+tJbvbUrmak32cuNE7HspBZgD8UFvU
	9NjZg==
X-ME-Sender: <xms:BOjyZ1NEZkyG7fI4CvD0o5kFcCjVE1f7H47W7oeJ-EZSD1_QMoNtqA>
    <xme:BOjyZ3_FZ6cArmoRx2hQnbAW-cuCnGKh2JcoB9komYsTmgSvBSVuiEAYPEfCSnAbY
    TCRW9Sd5IK9IIgLlGU>
X-ME-Received: <xmr:BOjyZ0SJE62tlbDNwUDbyBYB_QAXqBvtOUGBg9S5cB5wRWRc0eryfsvw1Z0oYUr6e354Wc3zoln80ebsGODhG-_A1arugYRRGzJ5LtwAh-XGU51HmqpVh_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeuuddthefhhefhvdejteevvddvteefffegteetueegueel
    jeefueekjeetieeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepudefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghsmhgruggvuhhssegtohguvgifrhgvtghkrdhorhhgpdhrtghpthht
    oheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhssh
    estghruhguvggshihtvgdrtghomhdprhgtphhtthhopehmsehmrghofihtmhdrohhrghdp
    rhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhope
    hmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhnohgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BOjyZxv2NwZWjS5pkOJq8pCYZXwdPJ_B6H-EVpWZCN2MyPlDnyqwhw>
    <xmx:BOjyZ9fPF3RBEhMkQYUwbqajAmSlVK8zOsZKw0s9GMGx0Z19w6AUQA>
    <xmx:BOjyZ91E-V8oQfl3okh8sIJ0lO9On7kxIhL0sqrQvFRMk_bNoWR7UA>
    <xmx:BOjyZ59xWmXNeyOdgINAa6LhGvUUtT2fgSelLg1giAPT1kaguj6ESw>
    <xmx:BOjyZ2cE1wRo_bGu50qf6aKFBTxBMnpmYMPH9DZo7Ym5F-lCRuOpiBkR>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Apr 2025 16:45:54 -0400 (EDT)
From: Tingmao Wang <m@maowtm.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Tingmao Wang <m@maowtm.org>,
	v9fs@lists.linux.dev,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/6] fs/9p: Hide inodeident=path from show_options as it is the default
Date: Sun,  6 Apr 2025 21:43:04 +0100
Message-ID: <611ecb66e65699bce6696076e1c2e5933adb88c3.1743971855.git.m@maowtm.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743971855.git.m@maowtm.org>
References: <cover.1743971855.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I think it makes sense either way, not sure whether we should do this or
not, but including this patch anyway.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 487532295a98..0070d1179021 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -155,7 +155,7 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",inodeident=none");
 		break;
 	case V9FS_INODE_IDENT_PATH:
-		seq_puts(m, ",inodeident=path");
+		/* default */
 		break;
 	}
 
-- 
2.39.5


