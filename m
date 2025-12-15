Return-Path: <linux-fsdevel+bounces-71313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C91CBD941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB0D3050CF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8A73321A0;
	Mon, 15 Dec 2025 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRfwwMLw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EEA2EB874
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798757; cv=none; b=O4Q7MWBi7k20J9D/LZp0U8jIooERTkLdTKtUnREOtALTdkYEtkflGaFf/7ThTKtQiAuGBV/GaVf/jGG8ihckMX+Fu+K5hoMylGwNbPbMAjBmU3jFCt8BNxBitEjdlGailrDU4RAvT2JBYIYI49BSOYy1KLnrtCy83CWtU2rBIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798757; c=relaxed/simple;
	bh=sT1prVB7LRNvf/W4XodTbc9bjm2B3700BxVWkrXUues=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAkqymz+uqsS1W70FyuyhSJ8LzmnoHNOEeuehjuvDiziT7LsZanRoPswCyHLYVKrmWCnEx5987mJm/vGOXoi87DVFmr1DZHxO3Ai/oSWD7r+R3Puh++ifpHHnWM02WEoPKOdUip3NwTULtCKZX/X0gvtegZM6nlJBh5OSnAE3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRfwwMLw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso3579504b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798754; x=1766403554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYIA++CxPIcYPKgHl3oGianXtJJpe/hDcX33067gP64=;
        b=RRfwwMLw3zaa5wZ5fx7VBbwTe8OfC5Cv2aJtWvQtM2OWYw6wL6PW+2/kfpHE0V6apy
         p4y6NyeCE6qzUR8yaVY/xeA0VMa6UoBl+GuetBBuFr3vpU8RD3eKqGB+52wd3NLvxVSF
         qAhQhiwKbXXVr+6lweELCgmt5Uclu/r6g5r/VCSj+5Xl4l/0OI64sEgIvGFqDSFn1Y4m
         42RErcDkREEz4QoSGQSGzdBGJxGiLv6MfIZto+GCgBNauQ0vHAGWngpHttKUbZKLHada
         QyZhPYzQXozSYcnEgFZiT6/AXRNrXSdUZ5dfBvcI69xPMo83ro6XXOs2N0QWbmlngP9c
         SZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798754; x=1766403554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYIA++CxPIcYPKgHl3oGianXtJJpe/hDcX33067gP64=;
        b=Nxk6DLfR2qDtCzBDgXmoKjzNlAk0y8oFrMKm2nW5X/nNptBop1aDg08W0PtfFQtE1V
         6dslNzZIlra4L7QZpjrZymf90R1aXxWYf9QSA8zGk9uChmLfeTb5VmIEVe61tGezT8bd
         CBEJ7nTvWxWCL+9ioYYNxOSWnN5IxMOn5nMCy/CRSFz2/N2Fe7+2gQ7UVc2kYjdgqpnv
         IQOAWb4VuIKoTVXiOzQXUzFoToFIbiMpLu/xavwFc32Yxtuv8GjHXqjSPWFbAgLpo64Z
         5QqstPxn+ZEoJOg1UGrF2HuYyAhCPJ8aTG5J0hU650bosD0iqJnUef//Y7eQ6L+7FMES
         u7dg==
X-Forwarded-Encrypted: i=1; AJvYcCVpsXJh5cQLVRW+445pojttIKDN1YqOreDhqCXU/wTEw75B5AqGgV54NnEq16fCVoi+e7M3HVKJK8ob/PBO@vger.kernel.org
X-Gm-Message-State: AOJu0YygcG1gPewbYoaSsEoBecj8bbqs5PUqlIA+upFexXp+E8hMxi9y
	r5+EP0Po/0ClJVWJm83Rn46Wt1sa/ezqf/eawP2yJITXEz3y3fMq985r
X-Gm-Gg: AY/fxX6RUm438G7S8UMfAUIUMba8J4eFsYtbzyfVSfZSLxVA4pNlba5saaSWhsopUy7
	Gi3b04wFGG7BlmY5oG35xqAeodvXKJigSO64mg7HEZ+CcjabMMw9DvIE6z9bhcQQD/uiuU7CmjH
	LGUaQANWyn/307kYtr96EfueJ5wqP6ARnwlIYZSnZ9Mpwfv5YvuBDecQtvihUj5mmoGzhagAw1M
	bANezKtJjwjxg9pbYY90i6PieLvv6V1SKtYpGAuloVCU7e3oW5pNOXua5AlDLCHl7lCllEfcswf
	ISOoEbQdX/yuIVsdW9YGgM5wyu2QVOZfrShsqQ/s5FtlSbFEH6xBgtB8INrvqS/df9Izz3TXKEl
	VHvJRw5PV9QfeAtudb6RrJzOH88YcMN3r1s3NdbByHho1P8Mh3Rvcd7Nlh+BRJPYztoLqWlhVr4
	cQ6pCU8X/budk=
X-Google-Smtp-Source: AGHT+IHZqxApH7RH4SvWeJJw7f7kzbBWfG87+pyKENlTOJ0etjJH+97jX9IVf9ZouLQDPcaXmCZT+w==
X-Received: by 2002:a05:6a20:3d8b:b0:35e:11ff:45b4 with SMTP id adf61e73a8af0-369adfb3407mr9418258637.21.1765798753761;
        Mon, 15 Dec 2025 03:39:13 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26eb0f6bsm12221315a12.14.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 70D25444B393; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
Subject: [PATCH 04/14] mm: vmalloc: Fix up vrealloc_node_align() kernel-doc macro name
Date: Mon, 15 Dec 2025 18:38:52 +0700
Message-ID: <20251215113903.46555-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=bagasdotme@gmail.com; h=from:subject; bh=sT1prVB7LRNvf/W4XodTbc9bjm2B3700BxVWkrXUues=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OyyibMaS/TcJdL00op76xZei7L2Pv7hFORU9uuV vT80n3YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgInIP2BkeHzeo3teoLm8pE9N cXOPl0J5QO7s9Yesjvev3nrjTaKBPiND/5K7Lkx+c2t1WS5sWq6V/2tGhSPf8dA5nnLdX2fcuhb OBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./mm/vmalloc.c:4284 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead

Fix the macro name in vrealloc_node_align_noprof() kernel-doc comment.

Fixes: 4c5d3365882dbb ("mm/vmalloc: allow to set node and align in vrealloc")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ecbac900c35f9c..2c3db9fefeb7ab 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4248,7 +4248,7 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
+ * vrealloc_node_align - reallocate virtually contiguous memory; contents
  * remain unchanged
  * @p: object to reallocate memory for
  * @size: the size to reallocate
-- 
An old man doll... just what I always wanted! - Clara


