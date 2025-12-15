Return-Path: <linux-fsdevel+bounces-71321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36908CBDA4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13BD83055B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FC1336EE4;
	Mon, 15 Dec 2025 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OweAlaqf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68753358CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799325; cv=none; b=jZ1aQzow0SVjJqVE7DkADgCT2xwh8yBqQM4UbfPLOuC/7cgOI+RC5HdWm6nd6o3mL/scKAgawqrdLgjL2ausYrHwjJ6SQs+hQujC4xIvf766KJsGi836coJ/aOy1MIWbZSN4SXzuKk0Td5mpQuscrow7Q66aGvw1hrgkMp3qqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799325; c=relaxed/simple;
	bh=UEs/C9BYSnit6YUYNsXI/TPVZ8wlbVWtOoMfZCt2Czk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH6ZNFlinXZUB6N32FfEH+CuVRYVREKXhGoEwROZzA8vVhd7pj8fMOwI7FpZyS1hmPo4B167I5mFWbOsWvtYIWbxyTvx2hUaHU41uncuM6YLytR3uv/4GlpBY95uWu27KJmjTiN9pjihvhVTW3WL1wsPkHqqexutp5ks0uTiO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OweAlaqf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29844c68068so41128375ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799322; x=1766404122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
        b=OweAlaqfINL7xdPdmKk7yZe4PNrDwsXB/WguG+W6yGXU/N4FmmQsaiJTz9UcZNvddq
         oyD5s+xq1SoElPYVq1NfOAf8IoJjyaqPlhsHryoMSo8e0CPsDCuBCb/4lW8uDPMctSky
         LE8GBndKHvLKRarKfht22U+rMUvkYsBLNOdBg2YV06C4a+ZeoilpdlpmSPzLY5IGnZPC
         5ygciS5mbNeWYspdSVCiVqHLNsu6g0wWEVTGR9tF14j5GdVW4qK8VljQDH0TF3JD5ND/
         7mOGw3PJrznkPFe/ifku14nsvF/qjiOI2lGEJxErhHzfBb2VyPT280arSuUDg7ivq7Pl
         jAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799322; x=1766404122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HauKBmXABfepG7VVzo5pWgXSZcUBePm/ZvLfsSGC9U=;
        b=QBT5qHhnkQoXINVLSS+U2O+u32dZjxEQtqWS0lj9FPpi8LXKmogDDvs3K52YF/6xO3
         4bNMM00eHhEWCDIoQVpWX6IQxpBajNNsapafXyvvEu2Ookd3ZJabB2cKVQF1YwyWN+SY
         1U5xhAcKWl28au56ezh9KswUdHh309lh6M019u3++Bsh5XcKqH531N311N4PPmjp4Xlh
         FXxA54zGHIiuO2MtuQfeMXL6OdTc1iomL0dzcCUmoB2iUqY9PFnVfdwrS3/J0YByfUbf
         32c6Zs72A9UJdRyrAxZtkfrcC/CIUcFWYgo4+zgZ63wDFaqHzO4/KfeLHOfd9XWRZ8+3
         LtKA==
X-Forwarded-Encrypted: i=1; AJvYcCV/TPaZ0QdU8isQFn2hsO/7W70n6rhJV9fXv9g1AeZGc1a81dP2Ad7d0eu/Xm0ioc5YbB+BhKbLEInJI5qF@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSCIm4iR0k8atS3EORrOknjCuN0GDc6E2jTgEhVMoR5e1ZOmz
	PuKg2sf3s6CnWMspgMbnk8gcLkyYN2Vtm3k9mzyv/7xEFs33ox9Z6RrO
X-Gm-Gg: AY/fxX6tXk1J5rN9GUZQIX1PXFcn+oOay8FxC3lCSGbrO0LFKamxmKRbK2UOWH9I04u
	WNG+uabYdwQSjHmFeEtueY39XNjM6/5fuEBb/TI5dUU0LxCjbpypv/qI3g8OE/kvS66vt8BgOzC
	Bf55630oLDcgyCeaSJyrM23TrwzLpE1KLz0qOyRFof69ycOlIoXYpS0nKp8HF2YpWIWdcc3gf3Q
	BBioyQ+lPvd9EBIbvVufgaSuD7QuzOxUCVTWditRk1DH5BDdGEvunjkIQDkLpB6cVlj65VeXVfe
	M19NSR73oGJqraBErOkAcuaw6de2JLZ44uxQcqU2yJ53rwUTggZTOKHXTqUipPWSoRfOZkol0zY
	cjz101WqvbH3G6x6FMq5sE+hI5YLT7ebcvg18A+41g67a0sjI/zdCrab4KGEDugJp2VfuV8KDOq
	w5KpgiXrN22GU=
X-Google-Smtp-Source: AGHT+IHfPz2x7Vw5nYSquN5rdr59IqpuimzSW/oHADfYTkii49T/33BfFck+CRU3WD2YFqFgGY1MBw==
X-Received: by 2002:a17:902:ccc8:b0:2a0:823f:4da6 with SMTP id d9443c01a7336-2a0823f4e6bmr66287715ad.50.1765799322057;
        Mon, 15 Dec 2025 03:48:42 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f271bc8a0sm97458185ad.92.2025.12.15.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:41 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E64B44588D7; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 10/14] drm/amdgpu: Describe @AMD_IP_BLOCK_TYPE_RAS in amd_ip_block_type enum
Date: Mon, 15 Dec 2025 18:38:58 +0700
Message-ID: <20251215113903.46555-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=bagasdotme@gmail.com; h=from:subject; bh=UEs/C9BYSnit6YUYNsXI/TPVZ8wlbVWtOoMfZCt2Czk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4P/rZd71fJeeea2Y6ze7l+/BUWfvZxbPVvJ7FLhc b8Ca2nfjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkQCXDH065v1Nu7J+SJNXm fKBEpbzzpEZrbklCWe8WSUFLrulTkhn+J33s75ffwvJ3fu98iUql0+pnUqJKXmg5a8ursxTsZFv IBQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/amd/include/amd_shared.h:113 Enum value 'AMD_IP_BLOCK_TYPE_RAS' not described in enum 'amd_ip_block_type'

Describe the value to fix it.

Fixes: 7169e706c82d7b ("drm/amdgpu: Add ras module ip block to amdgpu discovery")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 17945094a13834..d8ed3799649172 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -89,6 +89,7 @@ enum amd_apu_flags {
 * @AMD_IP_BLOCK_TYPE_VPE: Video Processing Engine
 * @AMD_IP_BLOCK_TYPE_UMSCH_MM: User Mode Scheduler for Multimedia
 * @AMD_IP_BLOCK_TYPE_ISP: Image Signal Processor
+* @AMD_IP_BLOCK_TYPE_RAS: RAS
 * @AMD_IP_BLOCK_TYPE_NUM: Total number of IP block types
 */
 enum amd_ip_block_type {
-- 
An old man doll... just what I always wanted! - Clara


