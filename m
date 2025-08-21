Return-Path: <linux-fsdevel+bounces-58665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B79B306B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CAF6259BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F8C38F1C6;
	Thu, 21 Aug 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="dCv/3NfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885D38E741
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807660; cv=none; b=hb+DaQdYTh+27mGfVbuX1OvARjmyK58JPQraEBC1MBzj5zd824Ks+5Ha6bNu3+WY/QR2Hma18CHdZbSg2xlJbRmhsKGd8mzAKxErt5WSx8O10jnhCEbR6GIgEDWPbj6Vi8nbTdS8SfqrnZsIX2/HOejQef0h8mQM4p+h6tgLRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807660; c=relaxed/simple;
	bh=HO3qn6E2mu4iKLp4ae70vUhOoqfZurpCVV09CRALkRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq61hKDoWdwv/4vPHIkzPNjMVdka5lBCVaVHkoDHVzSa0W4IctgY9BWew5xA/Twmg6scpQKSZdtJKgjMlNrpCwWepVXziZJG2U6vxGoZF2P8pibh9arAu5Uep2JXh3xNPJNgE4Fi8agwIFg6i6FvDxt4ViDEvqsgt9Lf3NLNeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=dCv/3NfJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603a269cso11775337b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807658; x=1756412458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=dCv/3NfJMgy1NTV8aXZrLV/VPd0uX758F5uGHu9mHnNHwSlwt/MIuKV2zIZR+3f44p
         CgRLBav/0nvbZL/DjqQYgNjgx9bR5rpCCwso3sA7wRUgN/MLnQvhynz9I2vfkwqBKH4E
         k8aRe0hfz3ZVFlgs6QTvihs2AHjV2m0Kvl+mgoHxUo2wOM/o40ailVZ8olI2KZaUe1l5
         jI0Eze4T00ZTynCE0WFtOnu+XPRzUVtIsH9HGF5/OghSBpQU/VVcd48gG4vRDoILinN6
         5SXFamskA3rOryXuW1EYRvAlritNNFHbX1mCVu5yoHgeaQmSXsJ4FQw6zQQDlnB+tN9q
         MZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807658; x=1756412458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY21hOB+0muSrNOgrHptmS8Lc85J39c8M537N7BFIe4=;
        b=hW0y6SrZtcMUmU/yaTeUhCKArTpEuntRX+QHX1hcnfCE/wTW2/9eW3+nos3iUz1IH2
         8MpkA9LNbL+JYj5K+FXveqdC7Dgi4MC+IF9N4fhj4NmAkYm6ptLjigjicrXnpa9w3IUd
         aAuN7HxF1bBxGNxsNm/53TqE98HtXfXw2c+linAhMg6r3hlwaAj8ZGEdt0pU3Vf6ouc+
         pAsuW2toF+j5m9dHI3mK1HnDe20olf6Y/xZ22yEA5SqT7B1wf+3mLstlilmhCLhHkOxN
         49sQBQNmjrp7us+KKQtWBWukPSityQexp+EStn9hvJZAupKkmH6yRPa9K/lrmwB0+g0V
         +vAw==
X-Gm-Message-State: AOJu0YxRj8IvAM+0sQTeUwd1KOcyefEjVI8PmDeuNJAaJAFBPVYsJazD
	yq9YnkMwbwNZikADHWT8RwhvFsNjZzqX8esJk5RZ2125vHkkjTl9wcFnmNYDN6uV3RELqmUxNGC
	IiszjhGbkwg==
X-Gm-Gg: ASbGnctCXrhweoCLhLP5YIRpno3V72w4VQHFaVQYM1rhWTl+UZHIaIvbqhinx35Tf7/
	1CSm5vTC7uwb9Mv1sGdjSd6i9ViHUklnSPAWLG5oouAfRpJDqEPWZq27w7UoclJ32JBTNc1/Wty
	uJfJTE9W6sFxt87Y4nJcOBVD5q0V7dsLatF5HlvpKUhZJ1x8IjGOmW5SETNpBCyVUq8PtGIHUa4
	Ne0hLD3Y6AMhh+qqBNUUrY6MS4ZqOSDoxu0ULBUt3nnrt8FU3BFvwQfzPF1w3F1uRtOAcYjLD/e
	hOwalcQ0w7fbJDLTTq9TCeMJ0HB4+Ui723a9Eu6wBOjGb2/vc2uBoDxO3pKxOwi4CjitwXL/lzu
	1jR0NOcFHntppzU/B5GoGZ4Uv8mshw3zRgVfe5o9+dHEv6HK0ikskXQ4O2YLWejV5eDI0+w==
X-Google-Smtp-Source: AGHT+IEIFJCVTu1EDZBPKF7Wn7HgQkKCR2Ee9oTaJqcUfdrFVpYc/qrWl5B/CxZoKQkUQjNMeDd4HA==
X-Received: by 2002:a05:690c:b1e:b0:71c:8de:8846 with SMTP id 00721157ae682-71fdc2a890dmr6082907b3.6.1755807657866;
        Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deeb6easm46112717b3.33.2025.08.21.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 28/50] fs: change evict_dentries_for_decrypted_inodes to use refcount
Date: Thu, 21 Aug 2025 16:18:39 -0400
Message-ID: <a1eaf8cd138a75f087654700e9295a399403ead8.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for I_WILL_FREE|I_FREEING simply use the refcount to
make sure we have a live inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/keyring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 7557f6a88b8f..969db498149a 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -956,13 +956,16 @@ static void evict_dentries_for_decrypted_inodes(struct fscrypt_master_key *mk)
 
 	list_for_each_entry(ci, &mk->mk_decrypted_inodes, ci_master_key_link) {
 		inode = ci->ci_inode;
+
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&mk->mk_decrypted_inodes_lock);
 
 		shrink_dcache_inode(inode);
-- 
2.49.0


