Return-Path: <linux-fsdevel+bounces-67582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49CC43D4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AAA3A8438
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F832EBDF2;
	Sun,  9 Nov 2025 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAvIbX3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E72EBBB0
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690781; cv=none; b=N5OR6eZMoBcb2nPo1B2Lxaxu5YD2ca4P7XoRDOX7gyQXXheYI7KM1i1CTILIKWJDdLF13dEgzhJKfKFSQUVW2wwVAWEbk3kZR6kel2qac6KPF8GR7dT+wj9cNAQndlAkE00FoycZzfGi7HcbYq9SyW9xkJXkl+D8sTNzdckyIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690781; c=relaxed/simple;
	bh=RI8OG7v0LCuN6zw8dyXHr6xSbJ0eZb2RqvOZGNNRbbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmFfL+qQgaEm9R2sHQC7V+CnE+0I/FvKoDSUB+s89n7aSa2gSjieMlHn20nFA1Xs6lVndQgjVEZP4587cbLOU7tBwze5fC9x1r75RtrqYEkTGNgHKsmKG36Q4vdVyRqACirgTOZk3RmU81Ol6KXf8eCnl5qxLegIuiTJ/4c1314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAvIbX3P; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2504781a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762690778; x=1763295578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+qAufXH6G8vBsUnnnyRTAQrC2PGUzHUrWi4FrePh40=;
        b=nAvIbX3Pg2g4JqWwlWF9b+l2JtGk2BJmfDZ7vvVnscbUnwk1p5/NmbDl8MKv9pGPZA
         bH7qtGO8eDrFqgTm58ydHh4JLhDlXDWQQOiIdXYGs60GqQ8aQSfh+8nR2nKQUnyl5nb4
         vY3gOLvwZKRLi9Nh1VAFiNKsC76JRCkKhJeBWZUnrP8SO5d+jxp3RqQ2rxfo0LTNKcGJ
         0GARNAMGHWF3lyLk7/nTNySw4N67j6I7UrYgrbxa2nUcRn3+S6TGDwOQ3nsMnPLGTFOx
         zO2g6kKEZtZZTQLIoPIkmMUVpW3FVnfKfa2BHr32hpMHKE/af2y43bpSreYAC5BeVzs2
         /VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762690778; x=1763295578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+qAufXH6G8vBsUnnnyRTAQrC2PGUzHUrWi4FrePh40=;
        b=G7qXeywypQDyQg8TQtOCUS7DGgRqhn34RCy/iLVoSXsytxqdQ/2XNnU3HEPEfT103F
         Ud49FJTTh8VTvzuUrBgnOOJ+KhopLG+g2QcJoIz8T0bvMfuzpyXkI8JVxvpFfnXoIx/C
         cjjI8WXpdBzHaP9EEbATKUkVP8ldSbg6ws2MqhK/Vl36Zjn4bHtSwMAaodueZ+5cioBu
         4p3Y1fMEtgeOgtejWUn19XzJvkBQluVIMHsEnNeNwAqMBPMF0ynsazRG2bfl/YH9Hp91
         iIe9nTKZvk5KcUjNUQT/IPIvL39X5qNYKX6fs67+SI0DTU+tkilPKlSCTYtrl2SWDTb9
         w18g==
X-Forwarded-Encrypted: i=1; AJvYcCVDT2WQgj3GFi59OHpUxvVETPRuCCU34ePtbKhtSOmAMuigVmQaKQgSJTlQfTuO9SVQ1hVEl2QwkAFVXF2x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwni0CguLuNA3mJsObkYBuSO7l7UibJ+d+tcrl17t25LOLFrVU
	DoXLwTXpBDJOvYbm9n3LxQneHu0BVuuDgZ30B+jGA7Q0dxIa5PMNpbrZ
X-Gm-Gg: ASbGncvV57jMGudCVg8+EwotXaJETtkllRf9Mt7ibZPN6+O+1RGiGY9FKIZB9BQWeJH
	FeVZwzxRIjLDs0+8uzMOWAT5LyFAMM0JSvKRSjNLrAqHxjZYynAunD/XYF8eU88j6ozu5r5+yuh
	7w8vyP+SAEYOckL75+x6fazXwL5JM7Hs6+9ZKSRl7IIcdVsaXKvB5H+aHy3MFnwNIwkfnRsFRUm
	zA+kfSLpkSIZc1DdQugrnBMj+UHkyqDqBD8+lJlg234g0A2M1YeG6HM4MXfqfF0YSpJ7ou4zSM1
	7r4VP6zTti6O4rJLk4O8rlKuZoQy3RXAdjshiZuVwMWyE03WPLdeXRDB7iaGnMN8t4RamGoO1BB
	SGejsTX/I1KaAzUMtMMUMnXumaR7u9/6XY/QH/hoZJ+aMj4KqcBV+xcE/qUqufv7xKD2eGehazq
	QveXGgyoEmeyoyq7GjAJ/XbkCiozaOS1VIAWs6Od5vuZSmW/wHSEpgfcaFka0=
X-Google-Smtp-Source: AGHT+IESsSrfC3NJ8IFNuotOFPOATY0CGb9MaPKj5bpd2i2c9yv5ol0qKlnUskE2eI2wayN6ZZs9LQ==
X-Received: by 2002:a17:907:3ea9:b0:b6d:7db1:49aa with SMTP id a640c23a62f3a-b72e05dac61mr464154066b.63.1762690777282;
        Sun, 09 Nov 2025 04:19:37 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d7996c4csm600245666b.5.2025.11.09.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:19:35 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: move inode fields used during fast path lookup closer together
Date: Sun,  9 Nov 2025 13:19:31 +0100
Message-ID: <20251109121931.1285366-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This should avoid *some* cache misses.

Successful path lookup is guaranteed to load at least ->i_mode,
->i_opflags and ->i_acl. At the same time the common case will avoid
looking at more fields.

struct inode is not guaranteed to have any particular alignment, notably
ext4 has it only aligned to 8 bytes meaning nearby fields might happen
to be on the same or only adjacent cache lines depending on luck (or no
luck).

According to pahole:
        umode_t                    i_mode;               /*     0     2 */
        short unsigned int         i_opflags;            /*     2     2 */
        kuid_t                     i_uid;                /*     4     4 */
        kgid_t                     i_gid;                /*     8     4 */
        unsigned int               i_flags;              /*    12     4 */
        struct posix_acl *         i_acl;                /*    16     8 */
        struct posix_acl *         i_default_acl;        /*    24     8 */

->i_acl is unnecessarily separated by 8 bytes from the other fields.
With struct inode being offset 48 bytes into the cacheline this means an
avoidable miss. Note it will still be there for the 56 byte case.

New layout:
        umode_t                    i_mode;               /*     0     2 */
        short unsigned int         i_opflags;            /*     2     2 */
        unsigned int               i_flags;              /*     4     4 */
        struct posix_acl *         i_acl;                /*     8     8 */
        struct posix_acl *         i_default_acl;        /*    16     8 */
        kuid_t                     i_uid;                /*    24     4 */
        kgid_t                     i_gid;                /*    28     4 */

I verified with pahole there are no size or hole changes.

This is stopgap until someone(tm) sanitizes the layout in the first
place, allocation methods aside.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

> Successful path lookup is guaranteed to load at least ->i_mode,
> ->i_opflags and ->i_acl. At the same time the common case will avoid
> looking at more fields.

While this is readily apparent with my patch to add dedicated MAY_EXEC
handling, this is already true for the stock kernel.

 include/linux/fs.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd0740e3bfcb..314a1349747b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -790,14 +790,13 @@ struct inode_state_flags {
 struct inode {
 	umode_t			i_mode;
 	unsigned short		i_opflags;
-	kuid_t			i_uid;
-	kgid_t			i_gid;
 	unsigned int		i_flags;
-
 #ifdef CONFIG_FS_POSIX_ACL
 	struct posix_acl	*i_acl;
 	struct posix_acl	*i_default_acl;
 #endif
+	kuid_t			i_uid;
+	kgid_t			i_gid;
 
 	const struct inode_operations	*i_op;
 	struct super_block	*i_sb;
-- 
2.48.1


