Return-Path: <linux-fsdevel+bounces-7310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EB823859
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98E6B24677
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DA01F607;
	Wed,  3 Jan 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYznkNce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3BB200AE;
	Wed,  3 Jan 2024 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d44200b976so40017325ad.2;
        Wed, 03 Jan 2024 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321761; x=1704926561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+2gqGxCQVVJrCooIPs7Fc2JoxPo3Bt1g3/hDzEpuj8=;
        b=lYznkNce6ro0tKZ/nS3v/LdaUx3GTp2uCQwf1C9nAnofEWdc1dmOfsqxhT0srQveMe
         /cAIizN8d9zgY5yUjDyH4p4vGpvwGQ4VphEoTtkeMv1WYazk8NhBndnEwW2KkVLE2Nr2
         VeoXQUCqRWIZ0XCfhrcf5D11KXCH7t2JxoTCzny7yw8tMtcEg5f3pI3MvFTg8PZSMlZi
         G8yYizm62wHIxYc6v3oPr8eX/kl0fsgOrl2o+IIkVIhe63qKe6c2WZMIQRYQIe/SjR2O
         NMg5DykfGv7ojTdcchT1sh1WJjf88rNIfPMuJi8gB5Y3LG0/KpLOAG0XZVzR6iH1pUme
         xR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321761; x=1704926561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+2gqGxCQVVJrCooIPs7Fc2JoxPo3Bt1g3/hDzEpuj8=;
        b=XrTLmHY78TZCtNfzKbk+51chuhT1MCSOsHvs6WtqveBLD9vv+34H03whIGL/u+mE49
         nLMoIG2D+G9Z6ckTpQ2gox6Ty/fOSrB+NlLMETjMfhNObl4Rrjy7XFAZDNa/+Hr5dhok
         T1GregYNkAl44m14UXLOJgp1zOxBgH8aDfLrL1FBzVNdjJtFauMIrIqVNh89Hrbi3/iF
         koawDKNLG0qJYjqhRyCbxM0ZWYC0ce4FpVw+MQCkE+ZGsEHDHoNQ0Djq6/26T57Y35Gl
         4ulKJlsqdSy1z6B0AdaC7lQghNhpMXFwofrRvEEd23YVE2PgivmJZtAL5ykzS4BNLuJ0
         GM8g==
X-Gm-Message-State: AOJu0YxvivVdiGsxYuKskOw+fgB1kol7T6lKQi42DxhWQZLoNzlvzhf1
	PLpyWeSlUtKt8Kfyrnq/5w==
X-Google-Smtp-Source: AGHT+IFnOwL88aJ7puwINYSQH+GK5aFsJocJT3yRJ9rZ9oLHhwfKfEgPNmLvb6n4zqZvaSRmEBRslg==
X-Received: by 2002:a17:902:ecce:b0:1d4:35ad:41cd with SMTP id a14-20020a170902ecce00b001d435ad41cdmr7934219plh.108.1704321760933;
        Wed, 03 Jan 2024 14:42:40 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:40 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v6 02/12] mm/mempolicy: refactor a read-once mechanism into a function for re-use
Date: Wed,  3 Jan 2024 17:41:59 -0500
Message-Id: <20240103224209.2541-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240103224209.2541-1-gregory.price@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the use of barrier() to force policy->nodemask onto the stack into
a function read_once_policy_nodemask so that it may be re-used.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 30da1a1be707..6cdb00acb86b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1900,6 +1900,20 @@ unsigned int mempolicy_slab_node(void)
 	}
 }
 
+static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
+					      nodemask_t *mask)
+{
+	/*
+	 * barrier stabilizes the nodemask locally so that it can be iterated
+	 * over safely without concern for changes. Allocators validate node
+	 * selection does not violate mems_allowed, so this is safe.
+	 */
+	barrier();
+	__builtin_memcpy(mask, &pol->nodes, sizeof(nodemask_t));
+	barrier();
+	return nodes_weight(*mask);
+}
+
 /*
  * Do static interleaving for interleave index @ilx.  Returns the ilx'th
  * node in pol->nodes (starting from ilx=0), wrapping around if ilx
@@ -1907,20 +1921,12 @@ unsigned int mempolicy_slab_node(void)
  */
 static unsigned int interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
-	nodemask_t nodemask = pol->nodes;
+	nodemask_t nodemask;
 	unsigned int target, nnodes;
 	int i;
 	int nid;
-	/*
-	 * The barrier will stabilize the nodemask in a register or on
-	 * the stack so that it will stop changing under the code.
-	 *
-	 * Between first_node() and next_node(), pol->nodes could be changed
-	 * by other threads. So we put pol->nodes in a local stack.
-	 */
-	barrier();
 
-	nnodes = nodes_weight(nodemask);
+	nnodes = read_once_policy_nodemask(pol, &nodemask);
 	if (!nnodes)
 		return numa_node_id();
 	target = ilx % nnodes;
-- 
2.39.1


