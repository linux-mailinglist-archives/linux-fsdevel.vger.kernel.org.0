Return-Path: <linux-fsdevel+bounces-50380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7242ACBB3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 20:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BAB18905D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F920E026;
	Mon,  2 Jun 2025 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="tbx1wnDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481618CBFB
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890219; cv=none; b=K0vJCxk3UrTs5lzaQYzQJEBRMio/mu3BD8fkb0/+TQ/GKJFz7aTMShdKbWTSfFk2S4eWMVp/IWuCy2bmoXSyWaUmEGVtRKsKlJkw09YcX9GXXLOjt4SIElmQnNB1Ky5V0yE7eQg5NFR+IXZq5jBC9j6p9fLtkaOF+xZxtaATItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890219; c=relaxed/simple;
	bh=UQwiexIpYJ+e0l8dqBFnN++gv7yeE7yNcld/03J5y1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usC1+TObhPrdOkjbYbvi/+BLkOd2GVRQcGeC62k8CAvJ00yDzjKB+gAtLQjUspJXrGfYSIIADcM7K2BF+CaVsVqDwbeSEIeK1DsXUEC5O6bGrhmmo5z6/WzblHYoFsoWcreECZxU0B/w4ZYQ9byDrCN6bN9EPqnHqKxo5dXgZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=tbx1wnDl; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23035b3edf1so43086375ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1748890216; x=1749495016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2qrd25YMOUGX9t5762yedVG2YbqEY35F/EaZHh8+EU=;
        b=tbx1wnDl51cwTjmVKpESdMWonATPC3rzvSoG36TUsSEY4iITLvJB3UGmSmZZox9NE6
         FUtOyhjRo3Zct0c6LO9jRrqxvzcu+xX9nv5Q5MA4KDadJAl5TZMW2YpfMb3Yqfi3i1dG
         9yV+U1DTNmlOjObSbjYev5lDWB7yDic3OjldApnX3FE71DvR9blub+Eimqavus0MtVlE
         YeMiX+dfaCxrnujybHJj0dPPGG1UghePtuTGkRO464ohsTjPnJkyhNU+4R4TLYw8UGLK
         XVwrL7KM3872zBj7gSXSzuV5p3JFOE09/oyIVwW1F9qEYzozV7mvdlAd5m619J2sBxka
         rZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890216; x=1749495016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2qrd25YMOUGX9t5762yedVG2YbqEY35F/EaZHh8+EU=;
        b=sSQlVlxW9DcfbU8/p0UomuDIpte6fhHkU4jssMNuqeR7GXsJA9h/lcd8kekFDn3UqV
         bNvZzct8FGcwq5YCjF72ktOuPd+ez9DVOqJXYRblX9D4f4Vdqa/vnSnPNlxCpImcxA/i
         MaCmrafoD7QTaQBReFgTNuftxeTunyhwt1EE7FuPhvbA2510AbH9hxFLSjrm8BsTSuL4
         +y6bE9CspmIQyQUZhqjnvqBd2NL3bCo3hSWJId5bX/sTyNHFzQux5Q86KeY/1/1Z4OyM
         LG/Nu/TWe7KD4RCN42lQPGp/Ln00QmQnIlT3E+Yu0Je4YCZeHHLuR02QpkSk9K7+LYeR
         D73A==
X-Forwarded-Encrypted: i=1; AJvYcCV0HdLCabXKWjmgMvYu1a8VQBvOf2ck4Fd6kjX/TxW21yz6EO0xDy5qs3T7zECbcL/Lp0rABvYpgQFH7/y+@vger.kernel.org
X-Gm-Message-State: AOJu0YzC/UCahW/HjkPtYkDYDwPzT/xJr9NO9ziYaZ5KdImXoxlWKdPj
	0NVPcEBw+08yKjyAgcIYBD6EGz+VtCs48gOI23PAHqG+TRwIAFbr12bPoAQ+nM7eiiw=
X-Gm-Gg: ASbGncs8A1VbcgPFdtMCne0qguqBFr0Y/LEUv0jYLTkF7NFuUDYRAGVrVoAI8BwTAgP
	DJ+Mtsrkh9Znf18g5rCmYqHBh9R01cnRsg3sBDTcxoPXoHGBB0Z+q+DCZYkHEPsa/28L7ejFqVh
	FsnImniHFAXddkzorTxPV5EWNV3OYQj4+waCQGfvwdGPaF4RDNz4KZFTIOOxqFGQQ+eh8T9QHrC
	2XktyBzDRL/F5IqnSHlJ3teSQ8gS2o4anyIIk/3KavxSWs7YuKzEczJkHrzDZ6/KggYG/rCbAjR
	ahYlXrDUFJAYjeECsvmPPSx51fG63cIa5VG5Rzqk8NkPODL5LmuCA1eSI1jlHnYEwvjDjQFRgXU
	S9m4nXrCkcmwXJ7E=
X-Google-Smtp-Source: AGHT+IFucfSB1X8/qOYbggCX4mgyyu1RO3Ldi4BK7IliwrTF+iZCEbymyXwjArEhUh6PkwnclqmTHg==
X-Received: by 2002:a17:90a:d408:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-31241e97f86mr19083559a91.32.1748890215951;
        Mon, 02 Jun 2025 11:50:15 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:cdfd:d09c:1add:462b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm5914266a91.2.2025.06.02.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:50:15 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	idryomov@gmail.com,
	dan.carpenter@linaro.org
Cc: lkp@intel.com,
	dhowells@redhat.com,
	brauner@kernel.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v2] ceph: fix variable dereferenced before check in ceph_umount_begin()
Date: Mon,  2 Jun 2025 11:49:56 -0700
Message-ID: <20250602184956.58865-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

smatch warnings:
fs/ceph/super.c:1042 ceph_umount_begin() warn: variable dereferenced before check 'fsc' (see line 1041)

vim +/fsc +1042 fs/ceph/super.c

void ceph_umount_begin(struct super_block *sb)
{
	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);

	doutc(fsc->client, "starting forced umount\n");
              ^^^^^^^^^^^
Dereferenced

	if (!fsc)
            ^^^^
Checked too late.

		return;
	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
	__ceph_umount_begin(fsc);
}

The VFS guarantees that the superblock is still
alive when it calls into ceph via ->umount_begin().
Finally, we don't need to check the fsc and
it should be valid. This patch simply removes
the fsc check.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_202503280852.YDB3pxUY-2Dlkp-40intel.com_&d=DwIBAg&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=Ud7uNdqBY_Z7LJ_oI4fwdhvxOYt_5Q58tpkMQgDWhV3199_TCnINFU28Esc0BaAH&s=QOKWZ9HKLyd6XCxW-AUoKiFFg9roId6LOM01202zAk0&e=
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f3951253e393..68a6d434093f 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1033,8 +1033,7 @@ void ceph_umount_begin(struct super_block *sb)
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	doutc(fsc->client, "starting forced umount\n");
-	if (!fsc)
-		return;
+
 	fsc->mount_state = CEPH_MOUNT_SHUTDOWN;
 	__ceph_umount_begin(fsc);
 }
-- 
2.49.0


