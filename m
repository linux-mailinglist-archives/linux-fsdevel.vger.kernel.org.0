Return-Path: <linux-fsdevel+bounces-59587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3C7B3AE38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FBE1897B25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314222D24AE;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wruxMa3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B402F39AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=IkdwvOZ4t8BsVdTBmc1zz61mwEj1FtDuMPmEn0euyp5I6Y1GtxQV3bAIjicpXsyH3golZRDRe2CNxIc5dLLv0Fou/doLHWYj56mLq9PLNfHa85RKxrxuzGZ80Kr117qRDSGFK0QX1Rz6MqyW589SBy9ohMPZlmHdHeQNIjqT4RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=eabTmgWEWc0UlpjCmJAetXRBH4cndOAA23rjW+jF8jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jC4k8ydP5D7xxs+tcpXgR5xJhxujuH0z+vG0c91eGRPN5de7jO9Zul9fXmJiwHeqyXuWAnBt21wB1f7TKgciA3hreKAU9IEDmr2x2dwMUaa1TXgDWvGeC23QdP8bPh2G+8MYTfMXQbZbLqhm0zTpkw/LI4r/OHqEoRHZmQCB1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wruxMa3w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dC/0gqTMWKzUwF6i35WEfURk1vpefgbQoWGxb+/kh2Q=; b=wruxMa3wXjsKgS7qYEvIXD9w5k
	9aE4pImlfJkkQISSIkYKFvMPqkM4YBvq7e6H0UH5aaW6JYEzk9fuLeZBKHSFMBMWyu2bPidsg1hdU
	fn8XO7H21QuoKtYEXfk4MC8O8n2FaOyf4oxZJNvYgo8X/4Jty00sYyQvhjidkSf5ir4nTY4/VGroF
	33p2vb2cABHrr3QfzXJm2Fc981fPepYa8zrrkk+vx9lZNmf30zPJpV+zyimdd+OF0g/OwptUaamv4
	lrIu5utW7COWexpM/6lhqbPPkJK1GKLv55oHM3TXFhVKO/zTzcNJOHVtW4ogITcXBDCMGLe2e7hnD
	GwyyaPAg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj3-0000000F29E-453y;
	Thu, 28 Aug 2025 23:08:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 50/63] do_mount(): use __free(path_put)
Date: Fri, 29 Aug 2025 00:07:53 +0100
Message-ID: <20250828230806.3582485-50-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a57598ec422a..b290e2b3bcfb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4098,15 +4098,13 @@ int path_mount(const char *dev_name, const struct path *path,
 int do_mount(const char *dev_name, const char __user *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
-	struct path path;
+	struct path path __free(path_put) = {};
 	int ret;
 
 	ret = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ret;
-	ret = path_mount(dev_name, &path, type_page, flags, data_page);
-	path_put(&path);
-	return ret;
+	return path_mount(dev_name, &path, type_page, flags, data_page);
 }
 
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
-- 
2.47.2


