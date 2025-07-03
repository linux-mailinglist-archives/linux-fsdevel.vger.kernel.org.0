Return-Path: <linux-fsdevel+bounces-53792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C02BAF7336
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9517656358B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD42E6D26;
	Thu,  3 Jul 2025 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T677CqwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B492E62C3;
	Thu,  3 Jul 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544233; cv=none; b=KOZRed3trAIZ/It3IdyDeMwM2NNp3Pvc/WV00fwKG0rtoeva3uMAkVA5hbbOu3gVleQ6zCWHhAcRNrtp1KM15rqlhPiPdyhpkCTW3IAGQp/ivBl3/mNsn0XsojWVYGSjI2O+9TTZRqRH4ipG6cgN07dsm2nqTWKpQgPPEHb1FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544233; c=relaxed/simple;
	bh=jsD9YH9kuJbOz2Nw8fyYrbyTDwny+3LMZ7c8TI4cvqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngNsFy5tXcY3ufdO/OwjdiFktkmVFkeJCVQmvQib0NfdXGRCjAhHnyWYuU9X10W4eqPcoQ1Pcw9oao2VQQkkwNbO52N5ULFYPLQCnXd5PzHOJmRpTYmgtmgCn0urj0wg5BYrkIeGdHWObLE0BFz1zD2ktm8MESZ6AToH84C7Uus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T677CqwI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so11012238a12.0;
        Thu, 03 Jul 2025 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751544229; x=1752149029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bWYCB6WfPUI/fvWa8m+GGn4eYVfhW03+nxeFICCU4E=;
        b=T677CqwIQBTTVG36ZVllrreSaZA5mGcG/wXNPZq6cFRZtlte5E2zrohaxGFTv64qoM
         wHfqC40KninqcTxIO98mBXmbZCEl3U/wjliBSkTxQFpfbSOm78hdU04t+wj+iAOfWuT5
         01LaLVMOzb80lS7OqXeKBavgmSUDoL3jUxMIycl0U9k/aL8xEGO8dvRdzHbDt5qkWGTP
         X0334EAZUfn+KKLbM7vvT28Up9CMchX7b9PRzfWEc6yBImZe3ujKR0X28GeAgyo0ML9B
         rEQ5kiQKMRw2aib66JZG3t0FjwlOuYu4BuRO9M3vGAPMrtdMkpGyRnuUE+ziIZcRgveC
         nwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751544229; x=1752149029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bWYCB6WfPUI/fvWa8m+GGn4eYVfhW03+nxeFICCU4E=;
        b=V8MSEnOAbUWTamH+88jPoVTZ0VQ2dlkv0bKmahakNHT90Gz2By3TN2CDPKtttdCq1o
         XH1uKAwsllW3QXGdII4DhmHp6cPj/zRrNYdwo6yFYIgfO+FYS/taozy89WQBomwWBgid
         B8aNUfo/KwyriQg84rR5Bp+Uq/0vnr/AUjIrV1lxbATSMnyzB2fnePkOjY/A0Vne9CAB
         DYNMLYeW21Pw7DXxpZ6DQzItX6xf5csvEZr9NEXq0Nhe2CZHF2DA6Vq5lbpcybmH2HcQ
         PRM0y1evmjYBbOAD/vUAgcOcXrtkAUgOKFB28G7aFfSb1EQgPOA85EByAmmD4AILuJ3B
         cHBA==
X-Forwarded-Encrypted: i=1; AJvYcCWF/Qb9ogV4aEa3ytQ64fi1getzUpkmE39VEM6CzIpb2kCWbB/UvnfHIdkFv7TzkJ42M5FWS4p74EvjKogW@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVdJjyDC7MKGNJu7rcKnS19Xx9HRCIXoqOv+ECNef0GQ4oned
	Q8HaHMKo4gQhrB37jT/n9yozt4Rid8N0FtN1iFpxrNR/4uzXNe4Nc3/0xpOfJZIU
X-Gm-Gg: ASbGncuMBKDIqeldCVJImIe9KlkiAHG1Jy3wjZyNoMJwF8xeyClCpSz2VgspST6+z9b
	3k4JWJvC8R43+C/r8ELYOsl9wEADtgIWVLWL9RSh6umicupik59AWdEHvRMnuT0W9p0atPkW1E7
	NLb5WQPc/Ns0p3yJHwnS72G+gXds4PAYHDqLSNkr8NABx5VEnHFzA72VYIft3Za41YF5PQ4hO+y
	Or93bBZRM6HAPY46Ork+Ooxe4QeY+v6jgLpYDvaNbNTba/TGOg3CMo6PO0qVs938zVQYR/LiYS9
	XQMqRJQS4m2a/xneoYLBDfWsL0IU8KVi9uHmp1Y21xZsAdWioCmUVF4EtFWjQRUVLMizSw8TGfn
	PNsRqkeBe2BThmt0d2K2AvR82OaH9YveGbWYwObY=
X-Google-Smtp-Source: AGHT+IEZYS9li2tfKun6TzOZdJNjRX1nV7xFW/O6jF6WWUakzeglVIQiROoz8XNYN3xnKYNHB5Y0vA==
X-Received: by 2002:a50:d6cb:0:b0:60c:3c19:1e07 with SMTP id 4fb4d7f45d1cf-60e52cd3706mr4571413a12.15.1751544229356;
        Thu, 03 Jul 2025 05:03:49 -0700 (PDT)
Received: from Mac.lan (p5088513f.dip0.t-ipconnect.de. [80.136.81.63])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c83205eb0sm10563837a12.72.2025.07.03.05.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 05:03:48 -0700 (PDT)
From: Laura Brehm <laurajfbrehm@gmail.com>
X-Google-Original-From: Laura Brehm <laurabrehm@hey.com>
To: linux-kernel@vger.kernel.org
Cc: Laura Brehm <laurabrehm@hey.com>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] coredump: fix PIDFD_INFO_COREDUMP ioctl check
Date: Thu,  3 Jul 2025 14:02:44 +0200
Message-Id: <20250703120244.96908-3-laurabrehm@hey.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703120244.96908-1-laurabrehm@hey.com>
References: <20250703120244.96908-1-laurabrehm@hey.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Commit 1d8db6fd698de1f73b1a7d72aea578fdd18d9a87 ("pidfs,
coredump: add PIDFD_INFO_COREDUMP"), the following code was added:

    if (mask & PIDFD_INFO_COREDUMP) {
        kinfo.mask |= PIDFD_INFO_COREDUMP;
        kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
    }
    [...]
    if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
        task_lock(task);
        if (task->mm)
            kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
        task_unlock(task);
    }

The second bit in particular looks off to me - the condition in essence
checks whether PIDFD_INFO_COREDUMP was **not** requested, and if so
fetches the coredump_mask in kinfo, since it's checking !(kinfo.mask &
PIDFD_INFO_COREDUMP), which is unconditionally set in the earlier hunk.

I'm tempted to assume the idea in the second hunk was to calculate the
coredump mask if one was requested but fetched in the first hunk, in
which case the check should be
    if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask))
which might be more legibly written as
    if ((mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask))

This could also instead be achieved by changing the first hunk to be:

    if (mask & PIDFD_INFO_COREDUMP) {
	kinfo.coredump_mask = READ_ONCE(pidfs_i(inode)->__pei.coredump_mask);
	if (kinfo.coredump_mask)
	    kinfo.mask |= PIDFD_INFO_COREDUMP;
    }

and the second hunk to:

    if ((mask & PIDFD_INFO_COREDUMP) && !(kinfo.mask & PIDFD_INFO_COREDUMP)) {
	task_lock(task);
        if (task->mm) {
	    kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
            kinfo.mask |= PIDFD_INFO_COREDUMP;
        }
        task_unlock(task);
    }

However, when looking at this, the supposition that the second hunk
means to cover cases where the coredump info was requested but the first
hunk failed to get it starts getting doubtful, so apologies if I'm
completely off-base.

This patch addresses the issue by fixing the check in the second hunk.

Signed-off-by: Laura Brehm <laurabrehm@hey.com>
Cc: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 69919be1c9d8..4625e097e3a0 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -319,7 +319,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (!c)
 		return -ESRCH;
 
-	if (!(kinfo.mask & PIDFD_INFO_COREDUMP)) {
+	if ((kinfo.mask & PIDFD_INFO_COREDUMP) && !(kinfo.coredump_mask)) {
 		task_lock(task);
 		if (task->mm)
 			kinfo.coredump_mask = pidfs_coredump_mask(task->mm->flags);
-- 
2.39.5 (Apple Git-154)


