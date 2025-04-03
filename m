Return-Path: <linux-fsdevel+bounces-45578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14309A79939
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBFE16D3C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700374A18;
	Thu,  3 Apr 2025 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rA2LcBhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F621854
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638918; cv=none; b=XIeWi2DdYyUktHd31j8q6u/Xiq+OL0YEw1Jhw+14DpFH6PYYVF88aR1QFOQ+WOmzardv1VD7LuO0L3jRBHm9qKej73Wy0AxzSSuW3eG5qCHcbjU4UyvwEuLGgjmzWNJjZ8ICht5fAZDG5sa+u2MhKtJbdv+WfDQVHlRTydbhUNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638918; c=relaxed/simple;
	bh=hTAzDrPsZKafbecdYqshErtWX+i2KvAc7ypCbGygK2o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i2Vv8C+mjj4yx95t7UejOc/Wy8AFGLui4N/e4QMpA7KFT3tWmDFyEkvIqw6Z9XPTwiOehiaDPB+h+ui5/xfs8GgqYeHdeBwfUWuJ/qGc4DEF1e+U33HN5tk8/BquR2e0eoEMROHNSZe0Kpji5pVSe4WjgaG1r2g8+7jGfrPWNdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rA2LcBhH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so487768a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743638917; x=1744243717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5lR/rBMuVOIoUwLH4/co+le8IOHRMi1RqbQlc2/Z8Y=;
        b=rA2LcBhHshk/J3K/0DDG1sWrivwtO8jN1BdI0Xbe7lUnSSV9tmYamXFGFrr9Mcb76k
         RfNjSJIImgwgoHRcvq9Yct88cHdTVclYes9rgzhHgU+7mJtwdqYOSCzLmposHtFumDHu
         NOVsZJz/g2Bl2qfCk/voagVlJpo+iE4PliQudJCUef0igSxAYZt3lzHNLqYKYxiVYWGK
         yA7ywRZ/pAMDvTu2U7cha+JFhy8ApRU30pCn3Leind0YEwp2M82JY6XKQqun7ZRrfbpg
         RhlSBRaOWT0ltu0V06+QiB39yop5l4IuHArjuTulZTVZrK1Tq50f0grQpq84eAT8+geM
         Nbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743638917; x=1744243717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5lR/rBMuVOIoUwLH4/co+le8IOHRMi1RqbQlc2/Z8Y=;
        b=Rf5FjHsDf9R6oWX/s8qZdpRte9r7fjJ5xRK4J5QFZR9vcNQLodjvWMSBF+y42swVzz
         AkfVcOoPBoP54EkHYpuTDnpq9mlP3aq0wqHyuyz247p+mOBLFPbthqrpW1pWONaZNGvU
         XAzSTQTyHqSaMjGMe6ApOZ7k8Tv0SEbFZk2nfjLdes/k3seVt18KzxrmCzHd+ZCnfD/9
         ejFDmMd0H7fq1lxHy3GMX1o7ynAWv2UyswG372JFagKCPi2Ro8+umO9Ld3oLISD5WaVK
         5OtRvd/0aotZY6/w6NqJ5afnfj5VeA95k2rAzOAVkIkoL2fh9rNaT/v4z79EWVzWofPK
         HKQg==
X-Forwarded-Encrypted: i=1; AJvYcCUh/4CbldgyR4tm5FGgNJlX+3tkIn0QTL/B6GE+FIWdKX40H4fS4iRzv0CMbLNWI40aCLNN7/IaRs1C8yik@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDay8T6qUJ3ftzH0V9LrOsFwi1IL4mfivOpCR1se/i8uWw/tS
	rVS1B/U1p9UTN2qxjPvbKB/5YWPiyHPR4BlTaVS0zKfltaMiDKS2BL8oMpv7rngUuw==
X-Google-Smtp-Source: AGHT+IHuAOxtXzCgPBrdp5bAmlVDtunUBAbbk6Zek1hc3Rqn5Vy7UfRbt6b5OUG2vQgJn7Pm/udst/k=
X-Received: from pjbsi7.prod.google.com ([2002:a17:90b:5287:b0:2fc:2e92:6cf])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b50:b0:301:1bce:c258
 with SMTP id 98e67ed59e1d1-3053215e7femr21514740a91.22.1743638916776; Wed, 02
 Apr 2025 17:08:36 -0700 (PDT)
Date: Wed,  2 Apr 2025 17:06:58 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250403000703.2584581-1-pcc@google.com>
Subject: [PATCH v5 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
From: Peter Collingbourne <pcc@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Peter Collingbourne <pcc@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where strscpy() would sometimes trigger
a false positive KASAN report with MTE.

v5:
- add test for unreadable first byte of strscpy() source

v4:
- clarify commit message
- improve comment

v3:
- simplify test case

Peter Collingbourne (1):
  string: Add load_unaligned_zeropad() code path to sized_strscpy()

Vincenzo Frascino (1):
  kasan: Add strscpy() test to trigger tag fault on arm64

 lib/string.c            | 13 ++++++++++---
 mm/kasan/kasan_test_c.c | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


