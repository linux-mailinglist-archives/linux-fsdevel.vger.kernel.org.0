Return-Path: <linux-fsdevel+bounces-49444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC00ABC709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E017A1D83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5A289346;
	Mon, 19 May 2025 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXQNxBgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2182874FA;
	Mon, 19 May 2025 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678812; cv=none; b=d1ovzS8RTqcIuXQef23fsvDub68qNZnoORbxExyzT/UrjP7gN8qeGLmix9R4nJU+MVh5EnJhU76J+CIzgcYfelAWJRpDj+Q6E9REdY8bnGI/m2doADS5W+p/ViY0OOV8jNq38YN43cA7+EcE5WcCPcPgurxcOFv6zTfEzq3X+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678812; c=relaxed/simple;
	bh=vly7GVdUqTmp2SjVQy+e1ShAYJ7IIpojqROtE3v5uuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMfx0I4gkaX1xDXXQVa1v2Puaur3dyBZdJl3foBF2D64ng2PviNIA1BEPu/rrxxsxFQnO7oaSj/Qh3QTf474KP0Iq3FKkYdGmV3LAA37gTBYoZ/nscGWjWqP8ASGPF8GNwXA2LjCLB7VuD5dCufC9MUcfIA2k97MRuiRzdkxp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXQNxBgV; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af59c920d32so3087411a12.0;
        Mon, 19 May 2025 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678809; x=1748283609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzaU+6mNYj90fVn2vNWALzuioh0as9cSNd/BN0dZb2w=;
        b=ZXQNxBgVCfkJbIGHXShDOl/zRpbtMFxoBLillBpCcSFExoWwCBmEXLdJBtd2OltItt
         RWEjkOQ5fUzik5lN92tbHHqAnDPG3bR2jamb99K3Pc21PDVfcNzTmigIh6FmaZ0a1cwY
         +OtDxwZ5/LfEE8IpZH3cYoIZX0vH2k6+b48nGInt9mBi1+6gOVtaB/w/W8z4H/JBrLIJ
         yvjK4s3GIdP9OS6lmLRYC9esrTOrrmwhnru2WvaztNv1S7DewpH/Vz8XBX02ZBqmFe8f
         +XdQ2ItyyPji+kBlb8gbiwh7YgUNbNFO+fcIi1ELaV1xupecfgkOaBlZnuG4ZC+U0xFS
         EI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678809; x=1748283609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzaU+6mNYj90fVn2vNWALzuioh0as9cSNd/BN0dZb2w=;
        b=LArGlAlmE68lzNU6fcBaKNWuq42x2jbBlGi/Tmnlex86zsvif5mzLneedmxXhsqvLB
         UQNTkudIm/QGiFcSyWDy79kLmP6niW+UldsxQTDO5+0h90xly/8Dn4XWNbxwPoCqbpnb
         /H5LJIAAYqgMYYk+qaqnjlNyvp9YZHeRrz8KrvX1FRZyW23N1xZuwIJlnpW/DIENrovi
         22Y7qX1WdQfCJq5YtLtbTLBwDM8qyR04AjaLTtcjn376vLrC6eAvJ9dEKDtDXghQU4Ox
         pTLi1d1chQGWvwzEfC9t8T/wu/b8wy7OH4HHhdbm4T2AljIxI2sUVp22IBsBfC7Dsc6p
         3pHg==
X-Forwarded-Encrypted: i=1; AJvYcCVaCKF+DTIZRxgkgckq90ddJrqM7AiHFOFNNSSZkyHFnW4fXFqlefg/r4RiYPCnU3dH6xJr0czpStI/1A34@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh97Cajn3vxNMWZDluhkyTWq9zEbnmnGT36p2WBNDO+SOkz5UU
	NzytokrQRCP2SOzdMobhbOOWU2nceNBLWcRLem/YxA4pG1FKDc0mTiomKBlImw==
X-Gm-Gg: ASbGncsmjvIefJQOC/Vo+IQwQD26Drn3IPbjQooctOY9KYgwazIeLJZbSFhU3qUVtyx
	L+YDfDbx16Bp+VKoQZ0TVdKMAFcExIb01l2Vh/TYUKRRsAo9QBtVeNs49CE6LeHW/E7kUv3IuCN
	a/vqr59lYQHVCx1a0mNClmAjMWIeVpyId2wkbeKn7BHBbMv6p7xkLvbb2BEZ4sbJJkoEkOt4wpi
	IRl6cAnCQO863dCW6HGs84ejB4AU0cUMZrpAJnE+vX1GkDqk+oS3JVRglHOQDUbE1R2OIF0wYYn
	C1PGA8nP8ZNOwS6VLRyPVaptQz/zq5qLADVEQkJVsutfFs0LJE4wESiX
X-Google-Smtp-Source: AGHT+IHkgG75yvWpQk7Lg/2FbGx0e8gDBnrmrBUEFNlgMr4/ZN44FQATfzW1WTGS5rbANmeDe/55ow==
X-Received: by 2002:a17:902:e5d1:b0:223:54aa:6d15 with SMTP id d9443c01a7336-231d44e4599mr210703215ad.12.1747678809477;
        Mon, 19 May 2025 11:20:09 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:08 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 2/5] ext4: Simplify last in leaf check in ext4_map_query_blocks
Date: Mon, 19 May 2025 23:49:27 +0530
Message-ID: <5fd5c806218c83f603c578c95997cf7f6da29d74.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simplifies the check for last in leaf in ext4_map_query_blocks()
and fixes this cocci warning.

cocci warnings: (new ones prefixed by >>)
>> fs/ext4/inode.c:573:49-51: WARNING !A || A && B is equivalent to !A || B

Fixes: 2e7bad830aa9 ("ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505191524.auftmOwK-lkp@intel.com/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce0632094c50..459ffc6af1d3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -570,8 +570,7 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	 * - if the last in leaf is the full requested range
 	 */
 	if (!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) ||
-			((map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) &&
-			 (map->m_len == orig_mlen))) {
+			map->m_len == orig_mlen) {
 		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-- 
2.49.0


