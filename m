Return-Path: <linux-fsdevel+bounces-63639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7CBC7E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085734207F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF92E2286;
	Thu,  9 Oct 2025 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XagQkyNV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03B2D9491
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996800; cv=none; b=SrlccY5drexXpQZXq0uW6f0uMWMMiX8JDjh71suK7529UQPA134ZpuP7/KlAv9aPS3wT8Xkt7olMcqbM8ZZkXz/2mQ1DqlUy4CBJseHQLxhmR8oFMD+BKtvxymcF5Vixy4CdaAYA+DeU03A+yDY9knaoQOBg1PoPJpe49o+jp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996800; c=relaxed/simple;
	bh=CjghRbVJnrrRxsFC/uqUg1E0WT10jkJULO+lABGoVkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twkuLEsgOwsMvtjr9+tz5Z6pJTZSJcXYPTrRU1Wvyanqupw70IWwbBuOoFRiseqwWjoAmAomhdirdXUP6VOn2nzYUKJUK+mToAlkEomHWlE8zpTqKbz3FAqE5DK+mNyojO/0a81ZZZ5kpcKpS5DwkS9Oe8K79BjznEyLC/2vKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XagQkyNV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b48d8deaef9so111941766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 00:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996793; x=1760601593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qUy8w4oQhAgPl6fOZI4wnlmjsFcl6OG6QfU8CrT8Pk=;
        b=XagQkyNVxo10BmQPyZD+yu//5tUJ2oRbuqYr1gAYVHfL+oBGf2DHyKr5NUSSOpszo9
         XNVfIA7L2ILl3KlexyL25l2DusOVsoonl03HpxhblrhT/dSehwjKS4WCbhIuWCkU1sZz
         +yql5aQB76ryOHiSeI12l1yC8ghJFwdrGCCcfYtPTy91qDr3ksDgSx19jQIBI6I0Qrmb
         6jVvsF6aacudvR7O4N7kmfCLBUsV2jdX+n+evXIeoLGKN1p241aiIXIjDZp/h2cyiiuQ
         uWHjDw9pGWbQjxRdbbUchADmgaYabJOE075a81KPgOTaVMvpTKKn1pw+dy1b0nkFz57T
         rHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996793; x=1760601593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qUy8w4oQhAgPl6fOZI4wnlmjsFcl6OG6QfU8CrT8Pk=;
        b=uah0rEU8YFaF3armmlXzTtU8v9eTaOxYiNPZ4JFkQyZHCA5LUkWE6oWTJwT/ZoQRy1
         kxBQvGFMhI1JSS385UE6zzjfq81XLFCT2mmneSJqsQLzdpMTYhzVse7k3C0NQW9iEIqC
         GjazMHp9qjdnjK5gAj4FQ+k/hLGJvMN+gl1f1Ag41IJcvv1W5W9NQ2HwEhyxXeCQHetE
         xRoaTLMpQAcF/9jq19tD36lVWoGO61bBIOKZ+mVGW/JOxgPgkg6LM/l8jlIUtaVRcUEF
         oydB/TDugVMNY/WqU5nG+YsGKE/V5adyRs39uBknXUVyUmcR+0tb8xK/KOdik5As7wP2
         CINw==
X-Forwarded-Encrypted: i=1; AJvYcCXb3t7nC2OR7ysyV9lL54Y1+JdGeTHNMgWP6F404sJsXcG6xC5IKcTBy5pd4YK1CtsAleZ9FZLAP6WBQZpl@vger.kernel.org
X-Gm-Message-State: AOJu0YwWkrf16/szCeeaCXXLaJy/jLsPgYGMvMruxcNJZRgMOta3G2GF
	CJbB5yFfVyz3Iqm78WBF4zfGDX2+sA0Z1L1Rv3BaqwHqjhIUrjwRYlRA
X-Gm-Gg: ASbGnctO/de/8SblmsxybH1duOB5EIZvXPxGgPqMn+Ir5n8yQu2/QaL8zBaaaJVdqcO
	S9S347LCUEZBLTo8hw+PLtN9tmsOMbu2Xp7HRUtwLXNfiegdxXno2wMrmCioSRbOFt7QvmIbrhV
	mbx4jcGjofcaJUbvtwu6E41VmItqirCo1TirLw93BbfzsE+itAk8s8y3xGRAnPPfHElBFL/sgwn
	oXwUF7r0bWsXObgMWgXzQH4nU5y1ODZ2yb/3nKn7mLjYOIUIUpMoT4/Q9m8rXjjJqJFCT6UFo1M
	G6pC1U8kSlkWbtnQ0Ka4/7t2C/PCCxB2QHOPQyotImi/BsanTsxQDLeVuIfExLl0SeK7/E3lALa
	UdRZ0kSJ1Zi/M0RmnrZu/gXh0EFW5LenB+PHri69QeYZvGFMgOz64uMQamz/rFRYqGI/DImfsJC
	JYJ6pTzPAmP8Rzp1lj5Lcm9w==
X-Google-Smtp-Source: AGHT+IGbrd08TTcAFiqwbpW9BDTUl/1zMbIp8ia/BbOIaKggRHixcVaV3Fgadc1Z9T3iA/deAE80rw==
X-Received: by 2002:a17:907:9702:b0:b3c:6093:679b with SMTP id a640c23a62f3a-b50ac2d58b3mr707002766b.36.1759996793003;
        Thu, 09 Oct 2025 00:59:53 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:52 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v7 08/14] smb: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:22 +0200
Message-ID: <20251009075929.1203950-9-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/smb/client/cifsfs.c |  2 +-
 fs/smb/client/inode.c  | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 1775c2b7528f..103289451bd7 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -484,7 +484,7 @@ cifs_evict_inode(struct inode *inode)
 {
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
-	if (inode->i_state & I_PINNING_NETFS_WB)
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
 		cifs_fscache_unuse_inode_cookie(inode, true);
 	cifs_fscache_release_inode_cookie(inode);
 	clear_inode(inode);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 8bb544be401e..32d9054a77fc 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -101,7 +101,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	cifs_dbg(FYI, "%s: revalidating inode %llu\n",
 		 __func__, cifs_i->uniqueid);
 
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		cifs_dbg(FYI, "%s: inode %llu is new\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -146,7 +146,7 @@ cifs_nlink_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	 */
 	if (fattr->cf_flags & CIFS_FATTR_UNKNOWN_NLINK) {
 		/* only provide fake values on a new inode */
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			if (fattr->cf_cifsattrs & ATTR_DIRECTORY)
 				set_nlink(inode, 2);
 			else
@@ -167,12 +167,12 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 
-	if (!(inode->i_state & I_NEW) &&
+	if (!(inode_state_read_once(inode) & I_NEW) &&
 	    unlikely(inode_wrong_type(inode, fattr->cf_mode))) {
 		CIFS_I(inode)->time = 0; /* force reval */
 		return -ESTALE;
 	}
-	if (inode->i_state & I_NEW)
+	if (inode_state_read_once(inode) & I_NEW)
 		CIFS_I(inode)->netfs.zero_point = fattr->cf_eof;
 
 	cifs_revalidate_cache(inode, fattr);
@@ -194,7 +194,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 	inode->i_gid = fattr->cf_gid;
 
 	/* if dynperm is set, don't clobber existing mode */
-	if (inode->i_state & I_NEW ||
+	if (inode_state_read(inode) & I_NEW ||
 	    !(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DYNPERM))
 		inode->i_mode = fattr->cf_mode;
 
@@ -236,7 +236,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr,
 
 	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW) {
+	if (inode_state_read_once(inode) & I_NEW) {
 		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
 	}
@@ -1638,7 +1638,7 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 		cifs_fattr_to_inode(inode, fattr, false);
 		if (sb->s_flags & SB_NOATIME)
 			inode->i_flags |= S_NOATIME | S_NOCMTIME;
-		if (inode->i_state & I_NEW) {
+		if (inode_state_read_once(inode) & I_NEW) {
 			inode->i_ino = hash;
 			cifs_fscache_get_inode_cookie(inode);
 			unlock_new_inode(inode);
-- 
2.34.1


