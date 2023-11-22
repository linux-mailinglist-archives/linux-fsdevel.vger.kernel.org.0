Return-Path: <linux-fsdevel+bounces-3478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D27F5223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561272816F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70661C2AD;
	Wed, 22 Nov 2023 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU3eyIJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F9D47;
	Wed, 22 Nov 2023 13:12:08 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6b709048f32so265316b3a.0;
        Wed, 22 Nov 2023 13:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687528; x=1701292328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UftY+9nJn82Vz5RJpbG87UiQLd2iCLBgMyI8O4iubXI=;
        b=EU3eyIJ/OBG42+qF2vpTOldu0KNB6DVzZQCeaQEQGVPoYN//InAIWxAtun2WfIbfzH
         TWL/XIqYPkNYEO0ZcxkFbx5D0BWnzTmRCjmaeR3eE7HpgzthwbT3vkWN4waN4E4fv4lj
         ejhd+zXWGt2stqG8f3YZabC7dhahyRFITCiMxPGVDI1sUv9dGbQLI/kYdqeetVG/pnpo
         bHBy6XrK0QUFX9YoK5H199sT2humxLXx/3L2chjv8RHA4KcGrqsSvZRjfv30JMHC7dcG
         wEYsucJjsdGiZORhNIk4n+tgfJC53U1lsbcr1pC7bZUgw9Bz3ZnVgt0o6khP8OP6TOGp
         TE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687528; x=1701292328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UftY+9nJn82Vz5RJpbG87UiQLd2iCLBgMyI8O4iubXI=;
        b=fFKtZMn/rKIod9M/FtNiwFu98MJDfLm9Hfzh40zNv3kgktPIN0voao6anea9YcbUqA
         sHVrNVPAHqDuu4ubAAlBnF+qeAgMbT3fOtskJeuxVdhiErpiW+4Mdh3PhiqqBYjM6rq2
         lkXJZ6DYHkMBuu32pN8IKbgDCaS/t41bT1EMDfhFxeo8/L9nyveFOfP+KRMwzrSq016/
         GLKCh+31GpLjooUWWgNoGGk04Viv+iof+SbWuRUdE17ukE2aSQHonKawRrQWUF2ZTfND
         6VX2otg6qz0WRQ3iN+sUKg6ITAlBXEv5IBLPJnrQtjrA7Lg5ZB9TnchWDmZ/86QuUUiO
         7aFw==
X-Gm-Message-State: AOJu0Yz3APQDHBHmgxDc2CIDoDPbHRiMOs2xRbk4rEA5WtKVEd03ku5C
	B04r0jQ/9wT4014SUL3y7w==
X-Google-Smtp-Source: AGHT+IFApmrVmTMi/koEr4L/CLh547UBRzR9U2yTau9qj52IoeLKDXr1/nWf98+BfkPjiCFsngGxIQ==
X-Received: by 2002:a05:6a00:4ac7:b0:6c2:cf23:3e21 with SMTP id ds7-20020a056a004ac700b006c2cf233e21mr4101209pfb.17.1700687527998;
        Wed, 22 Nov 2023 13:12:07 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:07 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 01/11] mm/mempolicy: refactor do_set_mempolicy for code re-use
Date: Wed, 22 Nov 2023 16:11:50 -0500
Message-Id: <20231122211200.31620-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactors do_set_mempolicy into replace_mempolicy and do_set_mempolicy
so that replace_mempolicy can be re-used with new code, not just
the system call.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..410754d56e46 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -809,28 +809,20 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return vma_replace_policy(vma, new_pol);
 }
 
-/* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+/* Attempt to replace mempolicy, release the old one if successful */
+static long replace_mempolicy(struct mempolicy *new, nodemask_t *nodes)
 {
-	struct mempolicy *new, *old;
+	struct mempolicy *old = NULL;
 	NODEMASK_SCRATCH(scratch);
 	int ret;
 
 	if (!scratch)
 		return -ENOMEM;
 
-	new = mpol_new(mode, flags, nodes);
-	if (IS_ERR(new)) {
-		ret = PTR_ERR(new);
-		goto out;
-	}
-
 	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
 		task_unlock(current);
-		mpol_put(new);
 		goto out;
 	}
 
@@ -838,14 +830,32 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
 		current->il_prev = MAX_NUMNODES-1;
+out:
 	task_unlock(current);
 	mpol_put(old);
-	ret = 0;
-out:
+
 	NODEMASK_SCRATCH_FREE(scratch);
 	return ret;
 }
 
+/* Set the process memory policy */
+static long do_set_mempolicy(unsigned short mode, unsigned short flags,
+			     nodemask_t *nodes)
+{
+	struct mempolicy *new;
+	int ret;
+
+	new = mpol_new(mode, flags, nodes);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	ret = replace_mempolicy(new, nodes);
+	if (ret)
+		mpol_put(new);
+
+	return ret;
+}
+
 /*
  * Return nodemask for policy for get_mempolicy() query
  *
-- 
2.39.1


