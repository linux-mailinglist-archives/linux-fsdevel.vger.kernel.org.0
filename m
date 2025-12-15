Return-Path: <linux-fsdevel+bounces-71310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A329DCBD88B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D518300F311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA165330B14;
	Mon, 15 Dec 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X097iqc6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7C2EB874
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798752; cv=none; b=LeguOeL8YwxRvhF60zMmn4g/TdAdQy8HuRKKfuLWtwkz4bazbtu5EC9LlTFwpdhcSIDGiQhSQHoa/kPb+ggN8c4r6rncRgEc1aPZSO6YuoxYixXYnBlZkpi0WliVxI3b8VA9Cnqk2u1Xqb5CuWs0IbGsTFqnQn1ewy2FqTrsAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798752; c=relaxed/simple;
	bh=yvRLY8BHqBHKchvPjcPm3zDNVddYxArgXi7Qv6PDXBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jH96W5JPmKloi4RSjlJkujlRc6jLssRdA1Kj5yQhVMhlmWmvEqqE1SIKCcq4e/8cVz2FGi5AcjJfvmCAmlfx6bfMfI7mHm6rJWVHBbkOtyCpsZKSh1qGHXMb1fgHuHYx2ca6iAMvWZWQMoBVJVrKTZZ4JZd03ATJLuu5DcgTH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X097iqc6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso522476a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798750; x=1766403550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
        b=X097iqc6ySK3hl3ctMLq5B21Jy6lZmPamt8uRNw1Qf6IGHSuK9YEvzyywh/RKlb82P
         /S1iL6uJKZxZ3IVAK5w1eh3uP+KfjK0HfN28C6as/ARSZjVSR0f2zTTm+uOJRN5Xo/i3
         8+Rnn9wQLwebCHdpy9jS8HhhBBjEmWOJpFduIBUarw7MZnfXhzVMQwWCivnLCm2xd9DN
         G/KzK9iMnlZ3MO5+MlMUHQbM2LbownJl8uVmVm60zRQi3sbhajY6BYSvqPvC18Lzylrw
         88wuHGJXxQTakkzD+anZ0VBSaEaMzNwUbKR7woCKuAP6IgBuud8UR/2LeLCcGW0/2gC0
         Y8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798750; x=1766403550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOExJIUd6SMMpu9ecZcijfoRnX+3TKAUcxRzAMDO5OU=;
        b=jO+4XUScEp6n+USXAWebY93iA1qU7i22jcbF8bWhNv1L2Ev70f4BA3yaoNfG0IcRWD
         wt68fsu7tWZM9RWYHKujk/cIIR+h7qsYpY4sW+HljJIAFdIet9JroNI6STyVKcDkGsIl
         zV4Zn8L9EA0sb4C5WnfiHhm8mCbk07IZxvbixWux3lMwX/H7w0/trtVRbjFplHwxQeDy
         ORt57j1eSwbCK0O1aAZCyR+3hS56DxB2bnjczdJN7lUv2H9sVuOyEIPiYb05heg2/iYL
         AG90ZXFvt1nitZeBpsj97zH96AbjDyFXXW63SqyxbjhyRQb9C9kmuBIL1fSZB+ra+YVa
         996g==
X-Forwarded-Encrypted: i=1; AJvYcCUqUXjX32ndeLn4DJNkuLtdfRM3qivoh12iu6FrcNTY7aRlywxiGzuTbIChn677Ze81gJfZXR/77tItxmp9@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUT+MyKdYoJE44p9lr/wp4IdmnN4WKEMGIY0UKzz9cVyoTCCa
	WKavROcMltE2f1H0l7XURJ5Ws+OSTR4sWOdMXIoNw17wIV34JuAMeeD5
X-Gm-Gg: AY/fxX7Ey6IT37cQh60uNjZ/ZasrjjEuirsjmPAbO2JpL8hePRLkFVfLoHjqw+DTK4y
	/ucqv5b0g7M5IVySmhGVPzSbRfzXG4MHkBxo0dqbNin+dbDbf+vRXgSYmFTpm/IAAM7S203luSB
	nkDHIMw66K3VK0NyMLnAKmzFh+O/QN4EafQKfHqefZuTn+se6olmh4QoJ5h9tjd0iblKqYeGKPa
	RHP0r1xyF5CiIM4X66/YeI3/i3oQHegNw3dz3pWivy8Dw3hFdXlr5a1Vj4XkWBWmHPVbT4ThsZg
	R840+SYJZ1zW9VBYFaXATODzp+h0+qA5ycpGFOLuj+c9qBJRvKB2Lr9MyJPEkw/aGpyQisDlzHk
	vJv+mo1xeEXZwyyVXPnjaL2gRc2Sgu8JlKKsiq9mKVXF9/vHvy6Ra67lTEngQuPMAW6RL8JqcxJ
	T37aRjw78M7GFPtC4aMeEZ1w==
X-Google-Smtp-Source: AGHT+IEi7Much+ynnSaGi+9pLWL2hRrocApHWp5vBqFK1ft2pjcvnQtgIu8VXEyupMREgh2/mG55NA==
X-Received: by 2002:a17:90b:2e03:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-34a926d9c70mr13163422a91.16.1765798749780;
        Mon, 15 Dec 2025 03:39:09 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294a00sm9273005a91.12.2025.12.15.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:08 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EAE05444B390; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: [PATCH 01/14] genalloc: Describe @start_addr parameter in genpool_algo_t
Date: Mon, 15 Dec 2025 18:38:49 +0700
Message-ID: <20251215113903.46555-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=bagasdotme@gmail.com; h=from:subject; bh=yvRLY8BHqBHKchvPjcPm3zDNVddYxArgXi7Qv6PDXBI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4MeLjlRVOvo/zL51uM7fT8nbubcy37qLGeos8/kb VKe75YIdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiGosZ/mm4fru/UqLr5XIZ H96Qry1BDLd3LedR2Gkharj+Q1jej2pGhm7zlf21hfvmpVcxGBvN2yCmrfs71+wCw2eFqbVucQl NvAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/genalloc.h:52 function parameter 'start_addr' not described in 'genpool_algo_t'

Describe @start_addr to fix it.

Fixes: 52fbf1134d4792 ("lib/genalloc.c: fix allocation of aligned buffer from non-aligned chunk")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/genalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 0bd581003cd5df..0ee23ddd0acd3a 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -44,6 +44,7 @@ struct gen_pool;
  * @nr: The number of zeroed bits we're looking for
  * @data: optional additional data used by the callback
  * @pool: the pool being allocated from
+ * @start_addr: chunk start address
  */
 typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
-- 
An old man doll... just what I always wanted! - Clara


