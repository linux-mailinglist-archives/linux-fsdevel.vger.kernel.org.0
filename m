Return-Path: <linux-fsdevel+bounces-71311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2545CBD8E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67B830275CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC907331201;
	Mon, 15 Dec 2025 11:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISA5KO6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA4330331
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798754; cv=none; b=jGbzbLE2tg5A8NGE4+Gw5RtDHqw7pAXPHHu5LhBfRxjVR/62yLEUV4aY9pwGcTtEtlmvYT5CQqG5gNK4FjnAQJ8KK3tBdm/EM7DEh+uVzKdc/nG8WPsmlCODYZ9LOkvn+Y+/q/i8EMOvl+OtGBVSo7vannH4C2j/fNLSBK0p+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798754; c=relaxed/simple;
	bh=zaXx2zRxHwtjfsFTgY05kdIMv0UeQBx9b1FFiByYYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aW8WGdES+k3mxSb1ONxIsezb/9UdF61vQQ2eqthVTZVrsS9J1GGuqNk0/Ksx9GqwNEBxxHgrtqMvb7A5qIXAZ990W3wfxwKNCEiDj+Qnggb2JyxIvJSziwofBpgNabBajFz5QkC0e/CrFie1pvBWmZURF+dRnojhNpSWe1NX4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISA5KO6K; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so404924b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798751; x=1766403551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6vVzDCLpyU2LgSSSdcXlxGJ4GVOIz+XeeVoTvfPkdk=;
        b=ISA5KO6Ky18dJIhYxEWZTy4YEyBxlG7RMCSjj/yV6K9mwAi+9QtMnhD8G1YfK9J9U1
         EigGsgvsUr5iS2uJOasrZvfdN2xHxtMxxyEos7Vs4fpCHVmggyQsc4q0I6IE6C6p5iUi
         KH0JKj+l7/Gf/dQ9Cgp56RVKo7zqLqMgEo7P82XwgRWDd2QWfA3bzXBeiedVb5+IHZ2R
         pMLfm7x7Ie/VWmkld0y7DtMrPhM+6uwoGIHtu5sEpkhuwCOuOSYfxdL39ugHk2dAqLf0
         tZWsMAyiaQlGEKh+MrUARyM2qlRh13y5MXrz8Opwzt/FXpuQAHvDSIaZ7tIRjmPpqaQQ
         IFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798751; x=1766403551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H6vVzDCLpyU2LgSSSdcXlxGJ4GVOIz+XeeVoTvfPkdk=;
        b=KdHwqHGOQKrbue92owdL7BQ5UiwQpuyU6601zfxTE/maO0Xz22PopfOtY4JExUtBsZ
         IPf1zRXkCEgA7JVKrS3XSAmRayvI3rGZscPxD7B7Vn7Efuson7ZJLCtp4FjJdaIWpFSM
         Z1oaiVy3w/NgoOQRmfGvgwf1o2ip1BubIOZA1HeS9PG7bm2H8Y7RMV8UUCZaRrgQcXOy
         FhwrDddarAyb17t2ncx/KVJezqe6MB8dj217zSB60Hw39ZdCDU44NjALVQ1hdOe/cgPt
         QlnDVFyXUpLkFAOe9lSf6+SBPcLKwpc7ERM4sQEnYfmpTHAZImncTuae0x0OpEAh/TCc
         Bnng==
X-Forwarded-Encrypted: i=1; AJvYcCVcsWcXompQ+yXFsrAK5GmImFwXou/iFesEIyxCpEznvA1ZEq++IeFtBXDugNs4DKQ62nLJlBkeSDz687RF@vger.kernel.org
X-Gm-Message-State: AOJu0YwlE4/HhETqiGMQ4SL6pLf9pMosU6GWZB0TqTqDju3b7jMNaK+K
	B902FrBsuwsqffx5ML7U7N3WCVtcbz8fYxARrxgsjoDnRZGsfyOz20c2
X-Gm-Gg: AY/fxX5wDQRjJ/QQv7PVTFAqy401B1bVR1+wDmVpfHy1V5pOPROMlrUHvtUQ8NVFnOa
	0Hmk2rW8KdoXRTPoi7j+Y4g8C1qdlrKG+lEsdhSKk7Z7lOnMFgWuttpqmH6YCc7XRV6Xtb6+Qv4
	dMQe/RBEm1t00iqgOCC5y5UmSyy45+YjDe12NyDjuArbkFG89uHh+tcNi5Vf1ccu6WTqtxhPLrh
	B7lnUV5T33cvxNFy879b6AYggS/dhu2w/Np3ppbLg5z619zOHUrsULJvIiDkkH1inxQx9U1HDYq
	M2yEvkTE5cDTC32s+nTHQwNkYz7GAggGZV3og7iD5pFZoXPa8gbUDrtKMd/Eyw2F/KzID84iHQV
	8EOrXzsHaqQhnFICkve3Yub221DDI8mYqtIoDTUlNLltTOBdyjpL51GYQ0KKXybcgnTS0dF+wQW
	kuPNcJPnPlbFc=
X-Google-Smtp-Source: AGHT+IFlU3I+cKXX8C9kVGFzGiJyAz7/LTk2+tkj0Oiyk+q1A92AqVW93jQniiO/3heM3uCR/CKzzA==
X-Received: by 2002:a05:6a20:728e:b0:366:14b0:4b16 with SMTP id adf61e73a8af0-369aa740ecamr11005465637.33.1765798751132;
        Mon, 15 Dec 2025 03:39:11 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b3850csm133388085ad.17.2025.12.15.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:10 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1D26D444B391; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
Subject: [PATCH 02/14] mm: Describe @flags parameter in memalloc_flags_save()
Date: Mon, 15 Dec 2025 18:38:50 +0700
Message-ID: <20251215113903.46555-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=bagasdotme@gmail.com; h=from:subject; bh=zaXx2zRxHwtjfsFTgY05kdIMv0UeQBx9b1FFiByYYYk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4N0b+unPg8UXJx6+/+iP9I7pV1rdBYrPMm9NqGYl enCm2OnOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR246MDN8qzkf5GvF8u6h8 fK78A+u9Z2vjTS5MNJ2mcnT+/S07J0sxMvTNsLugLdEgeebaKl/Lt7ZFnv2pX8UvGPzINA+RNZw /gQsA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/sched/mm.h:332 function parameter 'flags' not described in 'memalloc_flags_save'

Describe @flags to fix it.

Fixes: 3f6d5e6a468d02 ("mm: introduce memalloc_flags_{save,restore}")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/sched/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0e1d73955fa511..95d0040df58413 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -325,6 +325,7 @@ static inline void might_alloc(gfp_t gfp_mask)
 
 /**
  * memalloc_flags_save - Add a PF_* flag to current->flags, save old value
+ * @flags: Flags to add.
  *
  * This allows PF_* flags to be conveniently added, irrespective of current
  * value, and then the old version restored with memalloc_flags_restore().
-- 
An old man doll... just what I always wanted! - Clara


