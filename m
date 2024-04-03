Return-Path: <linux-fsdevel+bounces-15990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537828966A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB612894AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF1B84FCD;
	Wed,  3 Apr 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="IbWMGL//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424E83A15;
	Wed,  3 Apr 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129623; cv=none; b=oxKqOEMy4fakUfiFp0mX+jwRDuGaQtvTMGkg7m+Cq/Gw6MM7PW4ZwogGi7Rq5Ggn1/vLlGI4dwC21zMvhQxB5aCtaX6jjWkOy+zTzss35BMtAJLQjPJW9NZtDuGnpv4G4PihCnkBvp61L+9GAK3smfEOZvN4WwlwOb7DxzslxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129623; c=relaxed/simple;
	bh=94RmlMFWXGTXstz1CwkJFfXxsHVZs+VkfOwiVdyhsCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJj8LNEnlNxPiQ/TLGwwZGzBIK2SLg5lbWBH/eN273U4VvZ+iEJThedJPXW8su145k7uU6R8XFIXZ9zl3ZAn4IG2BGrSDFVwVR5bAy2aBsUfv3xUa/FPrgMEZpk9sKWEBIgdKzQls4wu8/1f3+5Pp87nSs7E6j4gan9xlyqpn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=IbWMGL//; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 8F82180924;
	Wed,  3 Apr 2024 03:33:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129621; bh=94RmlMFWXGTXstz1CwkJFfXxsHVZs+VkfOwiVdyhsCI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IbWMGL//ndu+2eM5w3j/YnRT3w418ByjraEMNZYb0TTbSS7WXFhnXQENWrVb6R3RT
	 XMvJ7x98BSJoTIoS8dr5PsO4Q3LElCZuY78m99E9Yp1NGJB1wOQKKHDALrrTFFszkb
	 cnahyGw/o5jSZ7OQvg9EkTVmKsJwqBtS8i21HzuewEZSc5qzEGZewbLAdc/pLE499q
	 uoIvMReqQmd3Yp0ZzO3c82sWs2/d2DI/x1RrTza5ZzPWVj7wD7oZSxgtDD8T+bpuEE
	 UlUzkevR3IuBxO03l5JyQ3zoKQv2YmlR7hVVtpSwtDxSbaPwVFFvKaiRejBSpexlW1
	 eK1THOkEXxD0w==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 12/13] f2fs: fiemap: emit new COMPRESSED state
Date: Wed,  3 Apr 2024 03:22:53 -0400
Message-ID: <aed306393b3e90379ec2b2f66e5ab759cfd3363e.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2a3625c10125..e999cb1bb02f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2014,6 +2014,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		if (compr_cluster) {
 			flags = FIEMAP_EXTENT_ENCODED |
+			flags = FIEMAP_EXTENT_DATA_COMPRESSED |
 				FIEMAP_EXTENT_HAS_PHYS_LEN;
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
-- 
2.43.0


