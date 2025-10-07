Return-Path: <linux-fsdevel+bounces-63556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C6BC2147
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 18:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7928C4F62B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CD22E7193;
	Tue,  7 Oct 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR+wuHLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D6214228
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853854; cv=none; b=E+clMJaJS+l0FWPYE6jDsa+wtd/hVD93lqJ5KykBemPi/W3YAIkwYrK5PQQefGoiV1wJAm3N2tDykGM6Ic0IfcRUVfq9FL6u7vBSNCxsfezw2+18uzcs4dAvdtEqH9HUeR053CqFaszwl5W47m/u9EAY/Jp93fkNA/MOS8bbabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853854; c=relaxed/simple;
	bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSeNNNFzkXi4Sx6hqWYnXf9XJlS/rl+S8RsINNtjd1pP9XK4R4DDft8orsHpORE949/z8SrgxbYT3QWjJoX56YBY6+Rt+FqaqtBMoR/S6k39l6l5XBu2DPm4cgteJ+G7Eg377sytAEho9UhPV4tgueWFTlseBhrX5FLVTeDBKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR+wuHLO; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8cf4f90b6f0so523392439f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759853851; x=1760458651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
        b=TR+wuHLO585PamBK2WXdvWMukywEPATm2ScA8Xy93Y6vh160rpd0C3R7UeVBy/ECfJ
         AGs1noKFh5iDXRRceDbIEMGvhxm7m6Pzmj4QgQtlAbG/kjCrp+mDmsZgo4IlWV0Wqm6+
         7ohVwKGrvDOQYPXdPfoJMaXrI1kRzn8aoBh1o4Rai4WOflmO7BiHDt3POJ0M8e17MDvM
         tBvyUUmoi5fYjgRf0KOtIbncmZRMEBfmxXcyxm1bDwgX3Xz43p6S5B4EmHS6bh+WjoAf
         XLmm/IDdOiHnkkALeZDOMaFA7eSQJsFukwUI3U2PUu/9NRcb1bzRMNwrZZlah+WwzosZ
         DsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759853851; x=1760458651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKULPQQuwiOMb26v+cKjhqRJho79LgmVc0rOc9shKDs=;
        b=Cl7vW0kPC5OkyxBcvM4wCJpeKp6CldcVwUiuVa7Wo0fWgCcni+1jKv1eNQ94S66LI1
         7smUEgcdMSzgeNSU6nBgpSZysYDuwsopHfMdB5GOQZTbxVPxmTDGhBOBIDhO8H6W6XRp
         BJ/jSuF5NnzVVFV9jRkacYG11GU4UReEMsl3D/tu7p6C9+o33yJ/a0b7iGVh8E5rxU3S
         5OrindKjte5IHqmE/eChByVDt/ujn35dh1gf+ZewpMIcnSdl18Ho8770EkyBwsy6Pl9L
         hKAfL32UJtPamaG8bP3yr2Xl/RAMYzuxNXm0RSZRK2sIszP+mcXySmrhh9Z+zwI4HKWb
         pIwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVsQvC/zfyEPoKHQJMggUldWcQTMd4D5X2O2gkr/ip4aLpdlxifyyTiV+wF9vikd9ifTyGBPQt4K2dD19J@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv11Vkv1uA/nQzHHTAWLp5Z/VDiGrriFXD6gMyohyVkbZM6vOz
	L2N1+4SaQpBtdjh9mJBc+1Vket8AjVXk+ylrHXR0tnxYN48NIT/3r3bp
X-Gm-Gg: ASbGncvM5D+atVTlKedcv5v4GNBnQH5CloyIUaN2k1B9wln4ywHTcz4367H3ZSofjFB
	pWD/yspMgY10QVWhMjUA8pFGw0J+QjlFXrqcdPjay1rP6F+06WlMCjrH55NTCQpwykjvvNPcNvM
	MdmzL1UVGB7wcyrVOTWPljE6IlSXRjVxkb5rLIECiT1Z/ga3Tk/P3UMJbNiFMBVPsPAvkmKjYyA
	IytAh00IYNcGJarqECTkZL/BGBZFgd/U0nW2Xx1ii+16Fl+cxK4veiXgdM3yVVbAQ9ayrzIri6v
	8tQJ0UEIfhzekKBwrO23Ukcu1FKhnWpFmWww9Z19AYKeEOYvPhW9sOwHEy/Iv3ojMa+2UY6ey2x
	mzRakax/WvL/pPU7GBsMxJ/C+ccPr/MGeW9x5AafYA8GJdGsnKowoMuI=
X-Google-Smtp-Source: AGHT+IFyXdSH5lmXmhQmU+6+2rFb2XcvaPsAqqFnlPFjaKItZfU6kDMDObVgHMoy+y6gZCvNhaIPTw==
X-Received: by 2002:a05:6602:2d91:b0:937:43fd:ee68 with SMTP id ca18e2360f4ac-93b96ac2dbemr2694731539f.18.1759853851293;
        Tue, 07 Oct 2025 09:17:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::7bc8])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9e8efcsm6273618173.2.2025.10.07.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:17:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: jimzhao.ai@gmail.com
Cc: akpm@linux-foundation.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	linux-nfs@vger.kernel.org,
	Joshua Watt <jpewhacker@gmail.com>
Subject: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic into __wb_calc_thresh
Date: Tue,  7 Oct 2025 10:17:11 -0600
Message-ID: <20251007161711.468149-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20241121100539.605818-1-jimzhao.ai@gmail.com>
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joshua Watt <jpewhacker@gmail.com>

This patch strangely breaks NFS 4 clients for me. The behavior is that a
client will start getting an I/O error which in turn is caused by the client
getting a NFS3ERR_BADSESSION when attempting to write data to the server. I
bisected the kernel from the latest master
(9029dc666353504ea7c1ebfdf09bc1aab40f6147) to this commit (log below). Also,
when I revert this commit on master the bug disappears.

The server is running kernel 5.4.161, and the client that exhibits the
behavior is running in qemux86, and has mounted the server with the options
rw,relatime,vers=4.1,rsize=1048576,wsize=1048576,namlen=255,soft,proto=tcp,port=52049,timeo=600,retrans=2,sec=null,clientaddr=172.16.6.90,local_lock=none,addr=172.16.6.0

The program that I wrote to reproduce this is pretty simple; it does a file
lock over NFS, then writes data to the file once per second. After about 32
seconds, it receives the I/O error, and this reproduced every time. I can
provide the sample program if necessary.

I also captured the NFS traffic both in the passing case and the failure case,
and can provide them if useful.

I did look at the two dumps and I'm not exactly sure what the difference is,
other than with this patch the client tries to write every 30 seconds (and
fails), where as without it attempts to write back every 5 seconds. I have no
idea why this patch would cause this problem.

Any help is appreciated. Thank you.

git bisect start
# status: waiting for both good and bad commits
# good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect good 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
# status: waiting for bad commit, 1 good commit known
# bad: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect bad e5f0a698b34ed76002dc5cff3804a61c80233a7a
# good: [5f20e6ab1f65aaaaae248e6946d5cb6d039e7de8] Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
git bisect good 5f20e6ab1f65aaaaae248e6946d5cb6d039e7de8
# good: [28eb75e178d389d325f1666e422bc13bbbb9804c] Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 28eb75e178d389d325f1666e422bc13bbbb9804c
# bad: [1afba39f9305fe4061a4e70baa6ebab9d41459da] Merge drm/drm-next into drm-misc-next
git bisect bad 1afba39f9305fe4061a4e70baa6ebab9d41459da
# bad: [350130afc22bd083ea18e17452dd3979c88b08ff] Merge tag 'ubifs-for-linus-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect bad 350130afc22bd083ea18e17452dd3979c88b08ff
# good: [cf33d96f50903214226b379b3f10d1f262dae018] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good cf33d96f50903214226b379b3f10d1f262dae018
# good: [c9c0543b52d8cfe3a3b15d1e39ab9dbc91be6df4] Merge tag 'platform-drivers-x86-v6.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86
git bisect good c9c0543b52d8cfe3a3b15d1e39ab9dbc91be6df4
# good: [40648d246fa4307ef11d185933cb0d79fc9ff46c] Merge tag 'trace-tools-v6.14' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
git bisect good 40648d246fa4307ef11d185933cb0d79fc9ff46c
# bad: [125ca745467d4f87ae58e671a4a5714e024d2908] Merge tag 'staging-6.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 125ca745467d4f87ae58e671a4a5714e024d2908
# bad: [d1366e74342e75555af2648a2964deb2d5c92200] mm/compaction: fix UBSAN shift-out-of-bounds warning
git bisect bad d1366e74342e75555af2648a2964deb2d5c92200
# good: [553e77529fb61e5520b839a0ce412a46cba996e0] mm: pgtable: introduce generic pagetable_dtor_free()
git bisect good 553e77529fb61e5520b839a0ce412a46cba996e0
# good: [65a1cf15802c7a571299df507b1b72ba89ef1da8] mm/zsmalloc: convert migrate_zspage() to use zpdesc
git bisect good 65a1cf15802c7a571299df507b1b72ba89ef1da8
# good: [136c5b40e0ad84f4b4a38584089cd565b97f799c] selftests/mm: use selftests framework to print test result
git bisect good 136c5b40e0ad84f4b4a38584089cd565b97f799c
# good: [fb7d3bc4149395c1ae99029c852eab6c28fc3c88] mm/filemap: drop streaming/uncached pages when writeback completes
git bisect good fb7d3bc4149395c1ae99029c852eab6c28fc3c88
# good: [7882d8fc8fe0c2b2a01f09e56edf82df6b3013fd] selftests/mm/mkdirty: fix memory leak in test_uffdio_copy()
git bisect good 7882d8fc8fe0c2b2a01f09e56edf82df6b3013fd
# bad: [6aeb991c54b281710591ce388158bc1739afc227] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh
git bisect bad 6aeb991c54b281710591ce388158bc1739afc227
# good: [f752e677f85993c812fe9de7b4427f3f18408a11] mm: separate move/undo parts from migrate_pages_batch()
git bisect good f752e677f85993c812fe9de7b4427f3f18408a11
# good: [686fa9537d78d2f1bea42bf3891828510202be14] mm/page_alloc: remove the incorrect and misleading comment
git bisect good 686fa9537d78d2f1bea42bf3891828510202be14
# first bad commit: [6aeb991c54b281710591ce388158bc1739afc227] mm/page-writeback: consolidate wb_thresh bumping logic into __wb_calc_thresh

