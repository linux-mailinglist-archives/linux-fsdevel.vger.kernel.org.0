Return-Path: <linux-fsdevel+bounces-62778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E395BA07B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFB54E12B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AA302173;
	Thu, 25 Sep 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLJsLSRf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FD23ABA1
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815679; cv=none; b=HTxoCwZQijSh/mJUU3+I46auYMyXvteCrqLnFBcMga1+6DMdPZY+817oklK+IULVItvbrumet/EhjocqoibXmXoHOq6N00tcRtcgeMOL75AOGs9oRjix22BeSMThywfkMSvIUq2EuaNWnldqsuTB2v9Ql/qajakgN60o15ANzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815679; c=relaxed/simple;
	bh=ojCNNYW52cZuOXTTZ1C9ikWFiXRXEas5maODIAHgHzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHlHXoUf6xtB+08ZbaoYAuXjfjX58ujfd4c7kKJyz5kCuDIiXc43SHKw5VxWT52L3k5tGnLH75Y7SeJvGcX+vfiGPfdR09eYGiLDXHWCozvRiJE/SxG/hWnTLlTHFbBxbTEihn/d7CA2dd8RkuiDopFjtc15Nnmqq1TAwpSi7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLJsLSRf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so1048274a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758815678; x=1759420478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6unFOdw+25OSo9KKla+RTEP3PML4rL1MzRrdobrk3g=;
        b=QLJsLSRfGr3Xn6JteVlV6Hv3KJRmQLgdaEHBILafIiCbTAsrbnXqjYpJXVqbDHtGCb
         KxK2VgW0+Y0UuEEOCR8gUyS5woBzagnubLCc/lzzYpIQOJDkou7lINHCcEXq9efQMSVM
         k/FQ2EMFew/OCPLEBtb+hIs0MpLpEXAhmn1Q6fsNeFcf/sysGVT77jCgN8j7uGCsd36s
         A8L2BWG9TKAV/Mfa9r0zuVkLh93SpmqYZ1FzohSGyc96paZdBmhnQ1mD17gBW31SwqpE
         H/rg+JgZbGRZ4wYsQA8jm+NMjyKHSHyly0ICamOU0DqZvwNpr6HZJnNsqmjZ+y06h/Jw
         agQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815678; x=1759420478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6unFOdw+25OSo9KKla+RTEP3PML4rL1MzRrdobrk3g=;
        b=iHRaHYkHtRBMSCfmNLb7h85+WqQ+PY0+rBn7ByuEyxc/+EFDsdOkwI+Zy/urC2ZxHr
         QdpjrEEBoh0rHVCPJQkiZV+Fa/kRw41Ljl6AjIWuMHebSEjbjGxG7V4yLwOUVEYGExex
         SAv/XyK7kLvlEHacy7m6/qW52BPyTeoK6CFC4BBW8oOeOw0JezkljbikL3/HKiosyY8k
         PYJUU0hHPCuwWUhSGFkWlqcw2WUHWJh/o0XesUpEwmGd5oZY+5OD84ryiTDtQRaIyTtG
         +8iHC8LKLt5X/+LLhR5MEM2OzuQbvOw0Dn4uZIN+CfbbtnRr1r1Va/FqgWdGIOIUKkeR
         FP5g==
X-Gm-Message-State: AOJu0YzC6vzXNvRDDdKWUYsziiIevb0ANWAC4zSJkU1tyMO+EaeMoNLJ
	/t2bNa0s06uNQf+8eORRg1YQxIXKsqXEZLmX+i/MHHttQPONHrEzmP/4
X-Gm-Gg: ASbGncvnuM29vPCqG3RUt6yqJr4GUZAj3eAZcTJYgsqWaJPGYuxmsuqvOUBA0GpzNsU
	nVN5+h8K3FVb18+C/U2BiVWhJbJQfwIXoZzIDTQrMRsre/Ky8C4RGxMMpKUW7fRTc9KvXBC+Iqw
	oPg2/+3SijbcmTlYxlHu1c+OqCj5l9LOsWtF/9lx4p6hAlpiVOBGH94SvKDdL1wknHVm61kz/S8
	Cn7D7iAUeEAeXvmU5C4mcsjjcJ4srTu1mbJ434FDiOdr+rl1D9l+LVs84UcZgjhTFtFxbnthUI1
	dhF6yeJ3epRFBqX4OaCKQ7X6K8Ra9L0F/Y/sWs7loqr06jskIfXZiWP4duDlolHyjfzl136Htnw
	5pwILSalh175GZuDMM4Ca5VfzpXFPDIRfwWqrmsTHRhD16MGWaxwBWPgXGLI=
X-Google-Smtp-Source: AGHT+IHKoV/EsaWFkrx9mF3ourWO41vWtjCVPz6Q9L0J1SKmQKG2p4xEQAcHF4vrEpICY0p71LH0zw==
X-Received: by 2002:a17:903:3843:b0:264:7bf5:c520 with SMTP id d9443c01a7336-27ed4a56b3bmr39363515ad.44.1758815677577;
        Thu, 25 Sep 2025 08:54:37 -0700 (PDT)
Received: from weg-ThinkPad-P16v-Gen-2.. ([2804:30c:166c:ce00:217:3714:c805:7cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad15e6sm28447355ad.143.2025.09.25.08.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:54:37 -0700 (PDT)
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Subject: [PATCH] exfat: check for utf8 option change in exfat_reconfigure
Date: Thu, 25 Sep 2025 12:53:06 -0300
Message-ID: <20250925155306.394763-1-pedrodemargomes@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check for utf8 option change since it depends on iocharset

Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
---
 fs/exfat/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e1cffa46eb73..500eb9c20657 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -762,6 +762,7 @@ static int exfat_reconfigure(struct fs_context *fc)
 	 * inodes or dentries, they cannot be modified dynamically.
 	 */
 	if (strcmp(new_opts->iocharset, cur_opts->iocharset) ||
+	    new_opts->utf8 != cur_opts->utf8 ||
 	    new_opts->keep_last_dots != cur_opts->keep_last_dots ||
 	    new_opts->sys_tz != cur_opts->sys_tz ||
 	    new_opts->time_offset != cur_opts->time_offset ||
-- 
2.43.0


