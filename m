Return-Path: <linux-fsdevel+bounces-71320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F1CBDA3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2092304EB47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1612335BAF;
	Mon, 15 Dec 2025 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAd6h6l4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E932C333
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799323; cv=none; b=NCkW51hFp+BdDyWG0o4cUJnpsay4j+mXA5XWXTLhXipFbDpmn1Kauo+pScDR9zSyz6bHYfDmqERlDiKIFlkputWM0cSn582w5RtEXdgElsZLBJ2A2vUEa6w9DA2Kh5dhJ91MmUtl1FywMHPZItU6SjKg5IF4y1pySG4yOMm0okM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799323; c=relaxed/simple;
	bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0YG8/XaLonhj+snt4wqZaP2V/7snRi0hOtoeEY4OZoCcmILgoaHHb2xm+R8wyEPUyXCfVluj+dWASVNBBOx3kWGVAJxDhkZTTA1whJCMHS7R+jm7SsqYshIA9RGsLZdKMMlUBYKI80ziRLQs+eFoxwg6JQwnWRp8jmjXoyp3fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAd6h6l4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0d0788adaso9722685ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 03:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799320; x=1766404120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=MAd6h6l4/YKSc10LnEFfm3OhEEbVLEKRuYqfPLONcXog2pLTf6OojvodUTKSpLiJCk
         hJm9lRC4I6IyLOPZy4uZz7WzMI9zvRoeGHTOvJdgXYWcY4SZPosskSgjiLKoHz7zUFh6
         bQhz1MNPYg1GHlpA+j8THPjt1R5oGeKktMBTQHBFR1q+a+mpKcSg902hA92IYeEqpenf
         KYyg3sXuv6N4qdzs2XOq7uXib2ucnunNa8MyP9z7TODJagWiisdYEhT3inIPSTtsAF6l
         n3MkoL0gMOOGDYLeqch/50JvIBVgu3YXwwjQUWzGsq6kdI+nrFMWHijpbp8gMrB082St
         p92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799320; x=1766404120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=SBSVkDrAssDmgTyFvNMh9KchX1DYZpb1OymIkX10IOd+8vuidqpOdVUBHAwOoToHWe
         ekcp9ubiferXIEauFDrpy/TyMBudrjl5xVGxNvtu3cTId2Hzs+ieK2hTNSUGy5NxwMVA
         Vj6G2kMq/EGH1mSgXVmlG5HBA/hn9BvnKF/l4P3/IQK639/fsgU5myxBp+gTfq2lAXfG
         DWObo5A7rKiqNz4O6L5rA12N7Fm/KjhMd6cL365c8QkOYlPDeZ949K/SmToFv+OKtJ+A
         u3mZDJxLOzp8LpjsW5wQII7a0QHUT+zrLEq94MzCfD3cG61lDWLJIExs8rMXRuAtObXk
         qgfw==
X-Forwarded-Encrypted: i=1; AJvYcCXneysWGmFFQqav5Gxwthg3uH7qNanceraS48vOm6hVs0GdahERNHxDS6iR6hHuRMViv4rYGC4JqgqTDF3W@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4mISreeWc0dQToVFgSoVd8OO1qS68vU4WRf+oXxQ+quWFAHpx
	4xBHCpsP/+3ryFO9uo+Bj+Ic3ajmBkhvdLC1EMhEELyVF+ZCIF358Mvr
X-Gm-Gg: AY/fxX4MWS5FOVIgS1fSowryLkWwmMiUwzHM8DsYoyL9+Dx1DLtm9lRXZQlRw2nkIEr
	O3a7E946bMLDpuEBocWgNkFCp80dxzcn8jq9BULma2g4KqNLanfwjPVqnhU96K3uKDS0ti3CbMf
	ufbE1EO2h8JW5suVENGT/j+eVAZRMUtA2fqRd9CLJxZoHAehvEWdkJFwOsgr8aRGxxs1dIfMDCb
	1cif1cfW5ASNLevsbHbSpFiPnUAC2UI+6rQ+onRVGdHBnuRngXv2AreRC4Vu0ggkz5/EwIamw42
	4YsG/0H5LZ6kFVgPNfvOwVi3dtDSMp5NbhQvMHOFFITtIOLtoWD5/cve6xDlqZz8pTNS+pK0zDA
	SPL/sxZi8nDwAGs58mfc3sQUiPneAFoe0EEpJGx36T+dzO2OEfPLMVAJ7fVxPmHtoLdTjk8N75o
	n6U1CG1ZaDx90=
X-Google-Smtp-Source: AGHT+IEA4ldqjntSU1IZe10aX19mQKLjoCVDqCMnCNeqo44SOanRLtLHyqhQX8MxC8RVHbAWKM2xrg==
X-Received: by 2002:a17:903:1a2e:b0:2a0:b02b:2105 with SMTP id d9443c01a7336-2a0b02b228amr63659225ad.56.1765799319837;
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0867ebe9dsm77190525ad.40.2025.12.15.03.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 46E2D447330A; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 12/14] drm/scheduler: Describe @result in drm_sched_job_done()
Date: Mon, 15 Dec 2025 18:39:00 +0700
Message-ID: <20251215113903.46555-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=bagasdotme@gmail.com; h=from:subject; bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4Pfzvv2aMJ6/2fiW3RmVPTpTFSM/fBW4Nu0ikdP3 J/+EMyq6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBENP8y/FN2WnBW9dYhDc+y QzUe+4R7v/wRO/L/c0NDkJC4klf71CqG3yyrLnq/ur5px+nadXME75rW9sxVOp7eMOmL58xwZZ6 TlnwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'

Describe @result parameter to fix it.

Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1d4f1b822e7b76..4f844087fd48eb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: job result
  *
  * Finish the job's fence and resubmit the work items.
  */
-- 
An old man doll... just what I always wanted! - Clara


