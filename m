Return-Path: <linux-fsdevel+bounces-66295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ECFC1ABBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77B025818FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD152D8391;
	Wed, 29 Oct 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbOM1L9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD82D6E71
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743680; cv=none; b=fhSogcKCFCCBgXG8buzXrAYmCKicm1BKnVsbqzKsdr+X0ZeO7w8R+EDNgPwxUGB4kY0rTwoLT6LagfZug6TSvcxVqzuYM/AKapxIQpvuc4V3em4Du8k9ueBOeM7qKYOV6CwcSv2SjBwiMJx0VBNOS8xbLa+92ZIAeh6kHFhNqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743680; c=relaxed/simple;
	bh=Bs2aNP4TbRyZDZpueTzP2CRA8p/I1ZXMSqkyS31vJuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEnKAziqQuAj0XRocxb9PckVj2yWoX3cNL01oJY7sITUJjpgwSyAUW0HPpKxmCzv8y+sKwGEAPbCmZpD99ItKD1027X7UnNGJsFH04GmozaC5TJKZCyNMIVtTYvJfaUMX+lw9d8YdHNu9yXuAdKCTK1oAp5ku0sr6dA5a3sJN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbOM1L9h; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3b27b50090so1282292366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761743677; x=1762348477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNptwftA6qXI1uXJ5WhqR8qfOzZwZcqLImk6T9du9b8=;
        b=HbOM1L9hU0WCun2aAiSzKe5Cd44pazjf4GRtMmgMyr1d4O7wzHuBkPdC2rVY32tAf9
         zcoFxzmYzoo88t1hg0/rK3avpOphV/kbtGbmZmUAdJ2qCF66cUWTUdeQriUvdYIF2dGe
         2JoA8yVySMGZGvwt6+lcd5O9CpJcc5ftE/5j/tGENRIL9UDD3/X4GRCXejaf0YCorMFR
         y5HF8zzbgYMfzoqVNKkZoqxP6j0GJ81NIwXFVN/EyIKLCbaBsb2cvBlXYdHJlYBwVIS9
         +QSghfvtzP4oCaM8TNXMxiNfIVjhyny0W4n7Dg+UU6o7VoWejOqGxzuS/JkSui8tCmQr
         dcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743677; x=1762348477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNptwftA6qXI1uXJ5WhqR8qfOzZwZcqLImk6T9du9b8=;
        b=m7nq9xk998uf+LKVOgs/jaTBJzCxXjBWKDJLH8kE/d/JOI1+T4RXZE5rjq5kX+Q6ZP
         fVkEj8Wig473jS6EnyyAVcl0zuPC4JHQap+I6ZLYCrAPlFD5fuQqxpJgX8FT3kMEM16G
         +ZZtqOb5ccx/ju4UuCgzuz/oaaZ4gluvTsTqzd1K29l2kj6lvtbOZ/AmgeTebTclO81c
         nr+6vmGW3HOZTopQYS+i3GqPf2LY3pl2CMHjVUwOIrkD21S5QttdUChclx9K8vL9sibe
         KcSfhhMGxny6AKjSknxQ8xc1Zlub10VDQaGAKwvES8KfPgGeQ9/DcDQrC4uiL+YrrTWA
         G+qw==
X-Forwarded-Encrypted: i=1; AJvYcCWSnjcXOpmLFBDktVYDTlU56sMmluVlRM2xEjT6tveeHPa8C+5F1veXnAp1eHg2jon5zNB9woDAJtvo7WJE@vger.kernel.org
X-Gm-Message-State: AOJu0YxMepUXj/+Un0KwZv68VTADfetz7tmRtiFElyY4td0yHGmf7j8M
	7tLg+K4ajFAfqnlinhvNT8i09sivIzyLelvSBN8Z/nYSSFYtWk7KsIus
X-Gm-Gg: ASbGncsi43zmtBOHy/oaNB7/gjCRTXOiisn7a8DGZ76zDujNmhpjsyoDRRqubMZMo4w
	6I8xECgTNbPEtaKPWCWVIV6Zwef8NK7CbJbl/F0o0z2P9OwJKRIJgkx9GhQqO/REHEU+5BLjRWS
	VZixKEoUaTwC1XRSO2OJKieywJrGQNKS/8n4hsGqczKozbWXs9H/L04L3CvwDivVNEmpBvc9iyL
	oE9SjzVdqcIkQhfejd0JNRhRLGSsDSWfVrSSdU4yASjZhHw/pgCaSz6GxEvJG41T43s69mvbTap
	XBBTs9ioM5bcy35YM2TAxNUKEiXpO7NrrTDmi4Jt8uFxvN7vwLjOx88hW5seBjbBYlTFs8ZmVK+
	qTJnnJjZAokU4Uyn4Hh4b0aLuRSWEVEite987CLrhjYgDbZ3DBWTzn4MCD6ubDWKbtcbEuRlhMu
	lbivDjQHMBpc65EroCpIXee2uAbOdZAmWQq0dkjS+jyIc/oBvWASN3aTkyRxE=
X-Google-Smtp-Source: AGHT+IHVtHIdZ2ky/5bjC1MvT8sxsNCpYJpQ/+gGoxQ/iDVsMSO6E2C7S/XUZYFkx8AFTD2zqZBBUQ==
X-Received: by 2002:a17:906:604b:b0:b6d:7f84:633 with SMTP id a640c23a62f3a-b703d311be6mr227117866b.20.1761743676960;
        Wed, 29 Oct 2025 06:14:36 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308c82sm1451840566b.5.2025.10.29.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:14:35 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] fs: push list presence check into inode_io_list_del()
Date: Wed, 29 Oct 2025 14:14:27 +0100
Message-ID: <20251029131428.654761-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with sb routines.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

rebased

 fs/fs-writeback.c | 3 +++
 fs/inode.c        | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f784d8b09b04..5dccbe5fb09d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
 
+	if (list_empty(&inode->i_io_list))
+		return;
+
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
diff --git a/fs/inode.c b/fs/inode.c
index 1396f79b2551..b5c2efebaa18 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -815,9 +815,7 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
-		inode_io_list_del(inode);
-
+	inode_io_list_del(inode);
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-- 
2.34.1


