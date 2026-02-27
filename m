Return-Path: <linux-fsdevel+bounces-78805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOd7KbgmommL0QQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:20:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DA91BEF96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 00:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A877930898E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B4F3D3307;
	Fri, 27 Feb 2026 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le0ckI7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9536C0CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772234416; cv=none; b=WakZiO2ru64Um+KmqVXpX51pE6/0Hz40sc3JfSkP7VE+1BAP7kNMP1ApD9ySav3Y4FjhnCpqdyHjXPmePu0sTbqdSGHg8B0R2TmbTHZp9zh+miIhZEaQI+WSIwilUj3N21d28G0yuOHGSTPOpg1A+moaTsUC4LgVus3qdk+Q70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772234416; c=relaxed/simple;
	bh=/aRfcc0FWmyP471vD2pIeYTV+OU8HPn9prrbelgUnd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dn684cfKq6vh0yffC01HwYFsDZy0pfSYN6h29G9Qgg7y3nwVazOjgq5+6MR/USJexLMo2E3ivcrDEJ1UOvfGsou5jKSex1dYQ8ORdFlVZ/T+mPlKi6fOjXDoZ3a5AKugD73W+U0Qg+TBtAU2apz4cYKmHqLvttVc3aGxl96+n0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le0ckI7E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436e87589e8so2511215f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772234414; x=1772839214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwCrpGcqRgHVPpOjWtlEizCs0pzjg1uHQ80GjIVgbPc=;
        b=Le0ckI7EKIEU9Pwu2sUwVJ6eXmxLZQibCWAfcEK4C6x8iLocx/q70A9023IEwXvjjF
         /XIqKOxGaSfYd/WDx8l+1ivq1EC5xXhD/P1m5vJNPB7Eeb8W9Hv3qQK+JdeJBci/ItTb
         qt539o82C8gfTelMwcdoGpw9FaY8KwU3uUUFEd8SNC1VDjQ1ngVDvFWk+oTzXZp/j2nE
         c4lYpUzo9tWS7uGJvwzKV94kSlEbjJEUahXlBLB9PzDzLHnrxaSboyaUgxw7HVAKl3CF
         IQLDxWyeJ+rM0K1FyaCgdTpGpOlDBOPSA6nIB+BCCWhNE9MoxkZo62/PlnN9pETbp2F8
         D9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772234414; x=1772839214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwCrpGcqRgHVPpOjWtlEizCs0pzjg1uHQ80GjIVgbPc=;
        b=d98XKyk3DBBzN06qLsWC392oLGrGxivY2OuOBcoVu1dEQy/po432Mueaco0WRaUF+b
         aN0B5BrLPz4T29XZzix/IbkVo+gT3v9mlgXVQSZQS+t5B6+set7nVXgHwF2QUmml4yhV
         LyFM/Lkl7Q1WqYyuKpkAS8RZokhob+9lwdaznrT/S/XpAZc12alIYJ1m4x/AJgKvbmaG
         sHzrl9Eh33zxarZsrq4Vz7oLfyML80jZlhVB8W0trpyO+d58dtT6OxTj74AIrojhrXf5
         FV1tV83j7H1i0Mfiy64/AZTr3lL6ysnswA/PKA2TWGy7J+0qyPQwleHYivOYt7q+HPAL
         4osA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYjD/8VhaI+XKZSVvEPJMuH1zqZKaOaUvlozAn0L7D1I4I4Q1yjPJit1yBWEmRWQntNMwaL3gJvf3Y234@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0X1F5Z36EOnr+nj4Q63SUfO9XRaRxUmZAlBRc11r9xym3+ft
	dp9oCyC77ZMJCbaHNhuVGvloubOLctwmHyV/DN+qsWm7EjzLqvOjv0bZ
X-Gm-Gg: ATEYQzxJofl5+Jk8Ng6IqaohVrvpvWRCMxkCmq02Y3I0FEKyrDs3Vo/hExqDZyptIKR
	nH6BTWel7X453frawGHX1ca98WqJRpBMCQkt0Qcfsp+2FIueyI40+AIMeZVLG0guwtJOsobB/UD
	IzeqmtLnWyZhnFKwBn6uP95g2UyQqqyH4mltcuoRUG42uLWbdorWqw4eGud0vi8GhRX4tFN/R2w
	3uPkuB1yevQZFmN99PxkAvFloJJ7QAqKmxxkRjOxn2Bd2T5EkJ46vzID3erbFCWTKyxv0UXVHpd
	QbPnHjHiLFEprVwUA1QSNZUhL+5gPc3e1lU6lblpluW8/3kISv8hiSk8s3273d8wba7PqSL2nrj
	JDXLw+azK6r+go2D2g5p3M4CcP1my00vhVJRCQajRrXz39T4FnUdjTwgEwUelbtRFW6k1gC9bhX
	t394bRW2d9Vx288LdEb4gFlw==
X-Received: by 2002:a5d:5d05:0:b0:436:3563:49a3 with SMTP id ffacd0b85a97d-4399de368a3mr7525057f8f.52.1772234413639;
        Fri, 27 Feb 2026 15:20:13 -0800 (PST)
Received: from localhost ([87.254.0.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a523sm9690140f8f.19.2026.02.27.15.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:20:13 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ntfs: Fix spelling mistake "initiailized" -> "initialized"
Date: Fri, 27 Feb 2026 23:18:54 +0000
Message-ID: <20260227231854.421561-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78805-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coliniking@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23DA91BEF96
X-Rspamd-Action: no action

There is a spelling mistake in an ntfs_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/mft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 56012477d3f0..6d88922ddba9 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -1442,7 +1442,7 @@ static int ntfs_mft_bitmap_extend_initialized_nolock(struct ntfs_volume *vol)
 	struct attr_record *a;
 	int ret;
 
-	ntfs_debug("Extending mft bitmap initiailized (and data) size.");
+	ntfs_debug("Extending mft bitmap initialized (and data) size.");
 	mft_ni = NTFS_I(vol->mft_ino);
 	mftbmp_vi = vol->mftbmp_ino;
 	mftbmp_ni = NTFS_I(mftbmp_vi);
-- 
2.51.0


