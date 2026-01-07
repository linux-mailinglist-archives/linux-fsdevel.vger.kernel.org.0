Return-Path: <linux-fsdevel+bounces-72618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 727FDCFE27F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DBB43003FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979A32E130;
	Wed,  7 Jan 2026 14:07:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292632AAB1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767794819; cv=none; b=K+uosporfdv+wooLMrozMBXceAmxu8a42arK8zUTpKWh0tLsh9QAGQtDXdFI52KmvI3CeJQKx0uHQXCsCl3twNHR4yv3ZJ5n4i75bicfCU41atyw0v1pnFHfHAlsabrfgg5z8xayqY5ZVmMMfZ1+GGAdOVAfPuoyalIXMvMCqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767794819; c=relaxed/simple;
	bh=Q03oAK7dYPK8RIOcWB5kLJfIjm+pK92q86ShqiLQj4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nf4maG6rUNX6T9q6sqbWF7bUIJWl3SHyQfmf8D14Q4+HGMtqcScTz1AqRVqxkhvXC16FbCxN/3UKO63bGoIOTXdwOCxvXCKth7SzQAFnbqhIcWj5YcUx82kCUlgNdSvjj/KzEe8s2wdCoOLgHeenrLWRC3VmSaCctXySv5wHRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3f9e592af58so1246936fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 06:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767794814; x=1768399614;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq0N2ZYr66guWKudTrbZSgeGohHNa2AeqLyUsW/1UrU=;
        b=O58GCrnV0vMwitbEpuAEgSddg53ehUiXYBC6x3XRrKKXEVjPW7rktx969KBpznp7Ul
         ja7q/ZMEILRDe1eozgA8GJ+kC4Y/2ocooGp1QabFnnREsAwB5WRk7wLgnZlOd+CxPUAv
         r7qSQeHPUiU2sThpUGHGqKTOld+bCbZCLzuh6XtxLQGUXMuZjrK6B8J7EvBJt+qLrOBX
         gMeKOnc6romFhP2zEZOlLH+O50x7fan/+dCoj74QIFkAtvd1EF8rH4WknlWp7SP6x1A/
         hnAeOlwy58VRYP1kgxfGd1nRqEUwBtwt1av3tN/D14uhxEa5wo3k+R6xS2k9nIANstRI
         INdA==
X-Forwarded-Encrypted: i=1; AJvYcCUhIKJtShPnHX5iBWlc4FetrB2NwcvVaMqdvdaZ2J4khlxl2Ldi/hUGeGWI7fuiGx8EgfQm3FgPo8rH36Gk@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsOnQYrJSyxNVvKjKhgw63Prt0Zn3cGMrug3O4Hl0n4m36C36
	/84W7ozS4kGtxOwsryHRhsDOSon+NoUFEVYGe0hdLHhXIm56nyI73mwLZuFTvQ==
X-Gm-Gg: AY/fxX7ur/6n+slUBaTQOH38QOiJ1s2M0yj/hRCGANTGpPFOMs7ud4K9r+RGQgVOcTs
	hYHBJBfmoDnn19i82lWbNQwjhg++LFQdvKdbr2a1bc1z3MsBOTG/aw61i9j+xDZYhaYVQAvHAdk
	fJLIhxpe7jkVRrsGh0RekSsQw4eX/grxl5ZIPUWh7Wj6fQXmKIWbfWVOEm89p2pOiQT/WqG31K1
	iUc3QytdVRsU8hizK9/3WFA+TQ1Y8seVoN1up+q+iyVWhCqzNk44YiAuz5MQkkt4kwGxiOZ2kTn
	ZDznunT6VqbJQu+wughZLfVLLUwXZxwKmjCLzt5CSgocEcr27zmpUopCBIAc4zhYn51MEhQ6CdJ
	ML5MMfmpVNiPYUkVFjIPhFBCrq9BFY/gYfm3ByRr3jBVE4GwG8tyPuNEY5geWCh9KRRcAEMPmXc
	3WD5p6gxCpb94B
X-Google-Smtp-Source: AGHT+IHWGit+F298nFpjyBlCkq0pRLQwpp0ohTaIDars4OMRdvHaA+CCb22mjSzxxuDVBjhmE2h0kA==
X-Received: by 2002:a05:6871:114:b0:3f5:aec3:88dd with SMTP id 586e51a60fabf-3ffc0b72aaemr1337331fac.44.1767794813851;
        Wed, 07 Jan 2026 06:06:53 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa516150fsm3199934fac.20.2026.01.07.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:06:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 07 Jan 2026 06:06:36 -0800
Subject: [PATCH] device_cgroup: remove branch hint after code refactor
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-likely_device-v1-1-0c55f83a7e47@debian.org>
X-B4-Tracking: v=1; b=H4sIAGtoXmkC/yXMywrCMBAF0F8Z7rqB6YAP8isiUpOrjpYqSS1K6
 b+LujybM6OyOCuizCicvPp9QJS2EaRLN5wZPCMKTG2trW5C7zf270Pm5InBNHfcWl6pZTSCR+H
 JX79vt/+7Po9XpvGbYFk+DJ5fsHEAAAA=
X-Change-ID: 20260107-likely_device-20dae82d502d
To: Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
 rostedt@goodmis.org, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q03oAK7dYPK8RIOcWB5kLJfIjm+pK92q86ShqiLQj4c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpXmh82Ir1CWimsBijOp4n6TRb8hZZRduh3mYui
 2Z6wlkI/2KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaV5ofAAKCRA1o5Of/Hh3
 bYCVD/94MQ/N702Z6ptR0kfQCM2Med8nwkztcIl3lX4VVDLsn+f5A+kJgIL/deEDtIeHpT8lPsF
 yztsQC0igyy966fS+V6rfqEMEaOPmpm1QmbdZ0m7rjeeHT2FON81v3LX2WrCKeYk7B+R89/p8t0
 EAhFSRjsgZvvnks37YuFI0K1oC0rutHcQSTPHiIJU7xxOGQCi0Dwg4ZDPN2Ly3YVN6rTVd/qgwz
 6CaOU/Riyh3Bms/KY/1rPPbDIctF3Rpu1zcnDWMxPbiUtMBRaYm7OPgUoDkUOAGuUSf+X0qyH3C
 XSd2B9ORXQfjF6EhR+tTFGqyrAYzmzqTLW/++hxd0oFUZtb0O68GB1v6UR01kIB8Ui2wBW/tYwO
 yOCu0TlIeQEKcyOb34C1nz9JuFfEtoTXCPLHFjSRL3OByu3Eh+xbsQrcf+WFXG5jox0yRpJpo+B
 O7Tt9DHS3NrlWTIk+pb6UfkipCbNc+JUI0rPEfZtVu9yT1llDHFAsRLRm1XGSPqP9mvD20ORN2s
 3JWQPNQZSkCVG4u16/1fgCrEFz3wOgZ3cBc3Cpb6eeXWwKr2JM/OcFQIPqBnQ37Ky+auu2hdiY/
 Ptsk2aaXP4MVSMMNU8C10BKe5N5/DAn0szweI3FgkPOZDvUK5IhjwmaW4Wvn6P6ENfcMjmEDxBm
 JgU/9+bhMpT/Xdg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the
common case in devcgroup_inode_permission()") reordered the checks in
devcgroup_inode_permission() to check the inode mode before checking
i_rdev, for better cache behavior.

However, the likely() annotation on the i_rdev check was not updated
to reflect the new code flow. Originally, when i_rdev was checked
first, likely(!inode->i_rdev) made sense because most inodes were(?)
regular files/directories, thus i_rdev == 0.

After the reorder, by the time we reach the i_rdev check, we have
already confirmed the inode IS a block or character device. Block and
character special files are precisely defined by having a device number
(i_rdev), so !inode->i_rdev is now the rare edge case, not the common
case.

Branch profiling confirmed this is 100% mispredicted:

  correct incorrect  %    Function                      File              Line
  ------- ---------  -    --------                      ----              ----
        0   2631904 100   devcgroup_inode_permission    device_cgroup.h   24

Remove likely() to avoid giving the wrong hint to the CPU.

Fixes: 4ef4ac360101 ("device_cgroup: avoid access to ->i_rdev in the common case in devcgroup_inode_permission()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/device_cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device_cgroup.h b/include/linux/device_cgroup.h
index 0864773a57e8..822085bc2d20 100644
--- a/include/linux/device_cgroup.h
+++ b/include/linux/device_cgroup.h
@@ -21,7 +21,7 @@ static inline int devcgroup_inode_permission(struct inode *inode, int mask)
 	if (likely(!S_ISBLK(inode->i_mode) && !S_ISCHR(inode->i_mode)))
 		return 0;
 
-	if (likely(!inode->i_rdev))
+	if (!inode->i_rdev)
 		return 0;
 
 	if (S_ISBLK(inode->i_mode))

---
base-commit: f0b9d8eb98dfee8d00419aa07543bdc2c1a44fb1
change-id: 20260107-likely_device-20dae82d502d

Best regards,
--  
Breno Leitao <leitao@debian.org>


