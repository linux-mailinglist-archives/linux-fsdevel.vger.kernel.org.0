Return-Path: <linux-fsdevel+bounces-61744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B223B59896
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8603D3B9BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27E34A30D;
	Tue, 16 Sep 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLBo2LB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0F341AA3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031187; cv=none; b=ULi1MWYoXyRDx5urH49B/MYh3dFwRA4MzgJHcA8tQhYLdz6DDRlyhL5bBXLqPrlqsFTmVuqEQYfoNraanqXVYMSM4Dfr9ErFppMCsw7u7y4fillwO3P/AWR5aPTrL4j6+wCQaQ7j/TtNoc13tQBHB+K0qXCvRAH+bzrLTADRPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031187; c=relaxed/simple;
	bh=zBN9BldLXuQYafbepgbsRKYJCNw2ZdSE8TIiThiLfW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSBo89sUcdnPVm6MG5NbVhnkbEOt5x0mxC968HJWAWAdWUFVJ97a2BKm27lSJfQhWf4yvrpCeboZlPHhdV4coqwM0PVdacXHSf90MrJ/eSNLrqSxGTGcZKHXAh1+YaoRpuTYkcTMuSHivkCcAZ7EZHpDbGTblDLS0k5JtG7qHWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLBo2LB5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ec44b601b8so777671f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 06:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031182; x=1758635982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=BLBo2LB5PHvFexWoLIYT5WrIPilki61efSEs5c0jKV5SbQmSndN00mauMoB88EsbHy
         EbW3RDHt6qEcAhbdRfU/nR0p3s4ponYl6Od3MsYa3toqlYwc4dPCmvXQinYcjsWKkpoY
         1OgiiIhCNypynnEVbf6HaKtZAZIkbWWGkbYJOw9CwmaKGdEyGmqorR3wDJtsmNIg8YRE
         BKy9Gtsw/o9jXEw+WYSZBaiWgv7q56SpVfUBc0goRKHiTm6Drm8X62FsntD6u0YWyDak
         Ksngv81i03MZ/WRkd+u6vWvTeo51lmVGNs53sBwSK6FgmtujqQgh7j1VFNMk147g/McU
         8Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031182; x=1758635982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbghKwI6RgQqtHuzp8YIKipmqQLga/vSj80h86fMMYM=;
        b=h/+v42bqryZHbXv8zHrUZIFFN9dvgHlMYjIDpPCWWi5iVvd9hABn37MI2PSpgweRhu
         S+iCNyI6CqEuh73dFgcHfNHLb63Hm6VQOlg7ZkiiroEq9glR194D9iLCrZ1356j0YvAR
         SkUdKeX7U3Fu1oiCrpdeekXH3tgiP9k8iflPYdtFXRqfyBDS788DUmLuV8Qlmd8GIdob
         83cgRJBnLospkevB42D0OtiP5uBublvNDQX6z9mT+w4G1UFg2JAe9PSFBNhShVvez4Dm
         wG+mavUGJ2AS41ps6kKuDR/oFHiDrvInfLDRo5hhVSAB9w46ePys99UQ5+eJEMFdOUB+
         yFEA==
X-Forwarded-Encrypted: i=1; AJvYcCVS0qpZ+M7UcRRxvYQ5d/Ouwmi/sikzqAi3+Mk9JuUXLprlmLHUivbmmS+QbJ7zq6mKgmw+3U0XMYb2noDX@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5JDXH0IJBeEOLhr2+gq8ucddcIp+ZeFOfyizqpa82Ya7skCW
	hfa8WsCyvLLk+LuxpJ7euJ73ubZ/7AILN3A/uu7clAE+upfcsiIrS9f8
X-Gm-Gg: ASbGncv22pq7ijOVJ/9d667v5Fr4CrgW72sbWEItmOleYsDOF70SCS9CkboHzVrSNsn
	UBxi2dqh6PoenGiza0AlfWOEF4g10rN9Yuimh3J+21LVpzorZY+IyAzAwSe66DL7Lk/MAtgl7qm
	toBqQ+q9PZ5FomcuR0bNBdGuK9dClyxSTpeef60U5PesEjgeU2xf/fWys+WAPrwoOHwnTMZMwre
	hWz1VpUORi4/95w6gOmLpMej5B0F5Xaap0y7UU93yWmlz7nL+fx/F4hva0sqbSdkiNUanqx8gTH
	kzx2iQA9JUf1kXT4HJoei9BlKktJiT+PN3jF4zD8/rcAc6X309rdZoeshM8RCHm2ItZ7e3FlDZv
	JgKsvHXz/pS9Jzd3vY34wZlXEezLiKa+Z/Bd3DKNt8zg7mrO5iC5+mcAdg1EomETsSZmQJ4L3
X-Google-Smtp-Source: AGHT+IE5shqQIUKbOw6hlw6cRTrcBtFVXG2OEPPmead9j/NTizmYAzcuhQc64qnxQ9XZRhrVFrM2rw==
X-Received: by 2002:a05:6000:310f:b0:3ec:d7c4:25a5 with SMTP id ffacd0b85a97d-3ecd7c4282emr1856689f8f.42.1758031181954;
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
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
Subject: [PATCH v4 05/12] netfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:53 +0200
Message-ID: <20250916135900.2170346-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
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
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/netfs/misc.c        | 8 ++++----
 fs/netfs/read_single.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 20748bcfbf59..f0f23887d350 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -147,10 +147,10 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (!fscache_cookie_valid(cookie))
 		return true;
 
-	if (!(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (!(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
@@ -192,7 +192,7 @@ void netfs_clear_inode_writeback(struct inode *inode, const void *aux)
 {
 	struct fscache_cookie *cookie = netfs_i_cookie(netfs_inode(inode));
 
-	if (inode->i_state & I_PINNING_NETFS_WB) {
+	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB) {
 		loff_t i_size = i_size_read(inode);
 		fscache_unuse_cookie(cookie, aux, &i_size);
 	}
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..f728aae9bde9 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -36,12 +36,12 @@ void netfs_single_mark_inode_dirty(struct inode *inode)
 
 	mark_inode_dirty(inode);
 
-	if (caching && !(inode->i_state & I_PINNING_NETFS_WB)) {
+	if (caching && !(inode_state_read_once(inode) & I_PINNING_NETFS_WB)) {
 		bool need_use = false;
 
 		spin_lock(&inode->i_lock);
-		if (!(inode->i_state & I_PINNING_NETFS_WB)) {
-			inode->i_state |= I_PINNING_NETFS_WB;
+		if (!(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
+			inode_state_add(inode, I_PINNING_NETFS_WB);
 			need_use = true;
 		}
 		spin_unlock(&inode->i_lock);
-- 
2.43.0


