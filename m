Return-Path: <linux-fsdevel+bounces-29747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA7197D565
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 14:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FEB1C21A08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8405D4D8D0;
	Fri, 20 Sep 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j72DXoR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4279FE;
	Fri, 20 Sep 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835431; cv=none; b=lYNztgpFIPDDQ/KbxJD34L9H9EFvEzgpJ37VE5tJjpa15KaVgT2k6msSx/vehWImoROo7EIabIWAM3mIFw0XccIPEtoa/fizGB+CC6jl+scCWbknSP4vTJ3atWDbwQ2Es44FdNh+Dqi7PB5G45nwaDrNYv/9vhXyz8KrXOzd/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835431; c=relaxed/simple;
	bh=vXL+U8ZESkDW3Fz7CembrXw7G0oLm5YisvxKnt8RenU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1M4wPZg2Xct/KW4Yg3qaIUK5fPqqf71Km1Cb9FIa1Zeum/09s8qRS73gaqkmGZ13H0rJBQyWAT8xQOf+HPqhOsWfMz1MB2wv9yWf7U07qS4ywCudeK1JM9BN3OIAoqpMccKrQ1rsOTFFuqon1zlS7wWVFq6ZqvXQBcLLIsGY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j72DXoR/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2daaa9706a9so1753355a91.1;
        Fri, 20 Sep 2024 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726835428; x=1727440228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3rt44kILya/FqXwE7282lJPi+mCIQi4p14blEdUGEI=;
        b=j72DXoR/SprDxSji90oTpAOgRjmWtIVw0MPuIWxjs5uXe0mX4iH5nk8bZ4wxIinqcI
         vU9fwAy+ze0diHdPZYFPBPV0VZtR9I9GXZ+XjXbPSRTZmmZfEH2iicQu6DTUPXf2tX8v
         hdWfzgMN8yWV64itNDvNwk+aTwdkg3JF4SF8briTO8xUr9VPgp2JUJgKYaydEyIKp7gy
         ARhMK/zh+QFGyG9neR6aSt2QB4yX0DsMQlFB5IR9RC0/y+EWYlQIkHhpNeU4W9k58UCC
         SNbNcsCWlj3V7Vwu9AeBWx1OuKw6dPrG1+uqE6vqthqZHF8RfhuS3IAMa0m6Xwe2Nwbj
         gPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726835428; x=1727440228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3rt44kILya/FqXwE7282lJPi+mCIQi4p14blEdUGEI=;
        b=ctk+G8dS4cHpR7YiXQv2vN+mPwfh1pKL7zvbQXRKW8/IbwRg/zl/ucGaKj+ex3Clwd
         WPaeY2bJpNGG1lpT/kdV7Xd1SpgvR+2ZCJhLWmQSscjLkBO8DU063MCYqCIHJ8TcI8tw
         06MsjRH3jh5cwr9egyIaQs4O+69IvMPxSXxJEObQspPFW7ZzltUJGs4LV3ZvKviXbC2C
         tdjV9NKPU1o/lLldQJRFgPHR55i+q/xJuTF6BtdjpRV5t5Rayr0/9aEJB99kTv431Mpf
         vocdppaO1F9JQLwrQap2UZqSI7ltlhyxUSPmU5g8VJ/LrG4SPC0tOW9y8chNXuzE5pLD
         ph7w==
X-Forwarded-Encrypted: i=1; AJvYcCVSAxMMOJVquGJqORiIMxqVgYae42yrgL1IAcR5ZiTSj+3jECxm3nXcjhOaQ117Qvq3jQvDfm0VGeU=@vger.kernel.org, AJvYcCWdsOdJm85tj2bXfJ81uTiGs4LvH1z1mL1HY3A57HmbCWJdQO0vlc4ziERWK2qUmv2YrLgTPpPl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CxBSLz5E93dkQmOV6baV0M2W5gyw7+ys/Sn0+27N0siohgtJ
	OFOmHQrBv+cJcwwBQXU15GjI61ABthtkqHD7e3/AhAHl0xvDNW+659yWKK16
X-Google-Smtp-Source: AGHT+IF6OJMj3uXNKT4dsEF2MiKr4TPtyooRzradxtXH9Wn1TlHix4eQ+dNsZR+YJQ9ThxwgLRqRPA==
X-Received: by 2002:a17:90b:1c8c:b0:2d8:9c97:3c33 with SMTP id 98e67ed59e1d1-2dd7f6b7597mr3778730a91.28.1726835428233;
        Fri, 20 Sep 2024 05:30:28 -0700 (PDT)
Received: from localhost ([38.207.141.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f8302edsm1794926a91.16.2024.09.20.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:30:27 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	stable@vger.kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
Date: Fri, 20 Sep 2024 20:30:22 +0800
Message-Id: <20240920123022.215863-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep it consistent with the handling of the same check within
generic_copy_file_checks().
Also, returning -EOVERFLOW in this case is more appropriate.

Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 6fdeb3c8cb70..a26521ded5c8 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -42,7 +42,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 
 	/* The start of both ranges must be aligned to an fs block. */
 	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
-		return -EINVAL;
+		return -EOVERFLOW;
 
 	/* Ensure offsets don't wrap. */
 	if (check_add_overflow(pos_in, count, &tmp) ||
-- 
2.39.2


