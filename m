Return-Path: <linux-fsdevel+bounces-25648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50A94E742
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD3EB20B22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A94153BE3;
	Mon, 12 Aug 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vWYB85PA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEC13E40F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445949; cv=none; b=Fgf6SCre+K4QuI/0WdWiBsg9RW+BgzG246NfXijnwXEaXLsp3tEDSScm+fbwbaQSjPZCplTgtm6PfijvAmATi7X62oNvP3tDFJNnl4DuxnfM5FvdiB3vSt53uoKMIExmoyGA7oEhS4yYZJiCCKle9sh3uUaHtXSA+jZJY7Xgunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445949; c=relaxed/simple;
	bh=th3SClOuHu8pApZW/xsnZrfVKeFVrJajsSQkQxeI3BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdQcaz2vr0a7tif+IGPU11W+qOazr/kHV8wpaxd7baJjQ0rt8HvOiUndIZpqdQ32wbVDQO1ml4lWII2FnTOBlsybHykza0L0AZgokTUjk+uOHxOeJu1mmtZdaGiYqkkhu6bdNe6bHo7GE8FmAFTT6fOgv4JiVYUlrFT2WN2AgI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vWYB85PA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xN+7MW43+yLSyqT/5S/uP9zeJ9OWaDrY7qaUembhvsg=; b=vWYB85PAmQA5/JPT8NJSm7vUQ/
	IcwsJ67D94RRrp908x1s9q3MbaOd1AcM+1DzY/bhcAabmYlUWF7UwziSSTerYpn5MNlL7B1dofvhv
	tqQYC0Cd1wDBHqMofs+ob4iYW2rxpgrzebdVA3GTGkO3F/venEkDKHgv0OuH4nCYN9ldkKHsEUI1F
	z1Oh4fudh1lQF3h+nz5mFmt2gczIatn3AvhgkoLnWf1JoxvzVJtBQP0VhVvcHqNw2ZM/ARJQX2Fgn
	P/t7Rb/cx7qJyG/6kBmnS8kMkxSGVpKqOBHPl530h5/Y3PYhi/urwtbddc4Hode9rVcZLF3fe/Rc2
	jWJgwrQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdP1G-000000010nf-1VHr;
	Mon, 12 Aug 2024 06:59:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] amdgpu: fix a race in kfd_mem_export_dmabuf()
Date: Mon, 12 Aug 2024 07:59:04 +0100
Message-ID: <20240812065906.241398-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812065906.241398-1-viro@zeniv.linux.org.uk>
References: <20240812065656.GI13701@ZenIV>
 <20240812065906.241398-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it into
descriptor table, only to have it looked up by file descriptor and
remove it from descriptor table is not just too convoluted - it's
racy; another thread might have modified the descriptor table while
we'd been going through that song and dance.

Switch kfd_mem_export_dmabuf() to using drm_gem_prime_handle_to_dmabuf()
and leave the descriptor table alone...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 11672bfe4fad..bc5401de2948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -25,7 +25,6 @@
 #include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
-#include <linux/fdtable.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include <drm/drm_exec.h>
@@ -818,18 +817,13 @@ static int kfd_mem_export_dmabuf(struct kgd_mem *mem)
 	if (!mem->dmabuf) {
 		struct amdgpu_device *bo_adev;
 		struct dma_buf *dmabuf;
-		int r, fd;
 
 		bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
-		r = drm_gem_prime_handle_to_fd(&bo_adev->ddev, bo_adev->kfd.client.file,
+		dmabuf = drm_gem_prime_handle_to_dmabuf(&bo_adev->ddev, bo_adev->kfd.client.file,
 					       mem->gem_handle,
 			mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
-					       DRM_RDWR : 0, &fd);
-		if (r)
-			return r;
-		dmabuf = dma_buf_get(fd);
-		close_fd(fd);
-		if (WARN_ON_ONCE(IS_ERR(dmabuf)))
+					       DRM_RDWR : 0);
+		if (IS_ERR(dmabuf))
 			return PTR_ERR(dmabuf);
 		mem->dmabuf = dmabuf;
 	}
-- 
2.39.2


