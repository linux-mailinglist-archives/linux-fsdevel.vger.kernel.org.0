Return-Path: <linux-fsdevel+bounces-31668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B563999DF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B69C1C2012A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620920B219;
	Fri, 11 Oct 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRz2EOxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1419B20B204
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631885; cv=none; b=nZUzfDmf6AlVZ/qErJ9B8hERsckYU/0I0tAIS20MSQ/ziCivaL4KZNCqD5wVDiqsqRz5HZs72eBjj8a3IxUm9L+P+/qyyGD63wTz9J2g4GTl+VLZqPgkcHWOO7HAPyBgGXrURIXPEiy+pUASV+lwIW7JZ09I435tJzE/yx7Hrgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631885; c=relaxed/simple;
	bh=Xe26Bp8gHEAiwGIs7RHL/NO77RSdideardrkLGG2ZOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oiZckYI9lKayUT09CS3k6/K4XBtWoLboEmrz9mL6Zhfxw//PbVUb1fPQ/XZPbWTUAwh8EoRNDzEuAKQ6KYJeNaQDCDtII2imqtJmbcT5H1A+suBI13BWtBKVhScGqoNG6fZWrg38qQXobs/0IqmiG/oNKBdq27/vKTsLmC1Xz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRz2EOxE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e347b1e29dso5756697b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728631883; x=1729236683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieo7ZHNuo7RJzAqC+Thl/FRfm1f3ThfajYdgqPFwDO8=;
        b=GRz2EOxEwwOLL1Y1HI114e+YWm2alx8yV0E3cGt3h4aI4B9Y4w+B7Y5aUA4Nr6k2nu
         N4hR1pGTuSmBQFZmhGwPcU4MwrzvGB781AvH+XS9dsvSZaSm8wTyGOgmwpHDDS4BH6jc
         tL5VNhdmoDGDoUR23/FTaqufwVt2bfYWixB+EuLSy5RW/kHeceDIpxoIpbVqOYK+qL3I
         yao9DNm3uh5GsY9YPSFgbJH4TKbhg3uC9+6OHHXLyYc45jWKD/sNlNGxBxjjRqoKYxCp
         u83XZGrv0qhG5W4NOjs1OGKyEumVBQoh366++MaV6DtqPl+/xgxiVa1v6ws4jSo2Z2gC
         UDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728631883; x=1729236683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieo7ZHNuo7RJzAqC+Thl/FRfm1f3ThfajYdgqPFwDO8=;
        b=Y6K9fhkGDp0+3n41V5ZtnQ8SCwLeLxFEXh9+BQC2QVSbFMMLYb99MMPpGQN52EOsss
         xNZ6tIjmLLhSVckrUOREx3vrnSdns2jTxLM6zmBhLHwTzd8/BuIkO/g3487nj+NvlSOJ
         PgzWr1TA1jb2Sp8uI203wXNQPr8qOZynTbYJvlnU0mqbnTd9jGmDgmrBHdTtmUWD362m
         Cbye2FN7Qq6bl182INdLGdl46zHhFj4q1XEb6E04kU2+O6rkSqtHNDyySaej6Z6f7ryB
         CxQIkLeZnsLBdp3Y9RbSvvqInKAUGRBs9QR2Iw9Hu3xzqzPmyPlnixtfo6SouScwwe0R
         yJDw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRpATOim/O5Mg7ShCDyUmVFc3UkLaXinMPPQlbBAfcZS2xm4cfTV7DfgXQC8IjQz50ooPEULWysQ0Xy84@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2I7fi0dkcHak0hPZKSGTwtP31XTeG5XSe89Ubpfg9yZWpxEE
	0dzHD4d61NLA/fR3ULNcIcRZ2PStoOmws2/tcXjQuvJvjiGzn7ijiw3S+SzcXd8oWHvS84ZxqW/
	pf3orECHvZA==
X-Google-Smtp-Source: AGHT+IGG0g8IxhAAOBToCYFjY2+/Nqb4qOh7xXJ3HzDIkyIPWZmvA5SROzdPJywLrzQPXDDBI1zKCIOhPFL/Kg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:c09:b0:6e3:1702:b3e6 with SMTP
 id 00721157ae682-6e347b368d2mr364247b3.4.1728631883040; Fri, 11 Oct 2024
 00:31:23 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:25:10 +0800
In-Reply-To: <20241011072509.3068328-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011072509.3068328-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011072509.3068328-8-davidgow@google.com>
Subject: [PATCH 6/6] unicode: kunit: change tests filename and path
From: David Gow <davidgow@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Gabriela Bittencourt <gbittencourt@lkcamp.dev>, linux-fsdevel@vger.kernel.org, 
	~lkcamp/patches@lists.sr.ht, Pedro Orlando <porlando@lkcamp.dev>, 
	Danilo Pereira <dpereira@lkcamp.dev>, Gabriel Krisman Bertazi <gabriel@krisman.be>, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

Change utf8 kunit test filename and path to follow the style
convention on Documentation/dev-tools/kunit/style.rst

Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
Reviewed-by: David Gow <davidgow@google.com>
[Rebased, fixed module build (Gabriel Krisman Bertazi)]
Signed-off-by: David Gow <davidgow@google.com>
---
 fs/unicode/Makefile                                | 2 +-
 fs/unicode/{ => tests}/.kunitconfig                | 0
 fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename fs/unicode/{ => tests}/.kunitconfig (100%)
 rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (100%)

diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index 37bbcbc628a1..d95be7fb9f6b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -4,7 +4,7 @@ ifneq ($(CONFIG_UNICODE),)
 obj-y			+= unicode.o
 endif
 obj-$(CONFIG_UNICODE)	+= utf8data.o
-obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_NORMALIZATION_KUNIT_TEST) += tests/utf8_kunit.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
diff --git a/fs/unicode/.kunitconfig b/fs/unicode/tests/.kunitconfig
similarity index 100%
rename from fs/unicode/.kunitconfig
rename to fs/unicode/tests/.kunitconfig
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/tests/utf8_kunit.c
similarity index 100%
rename from fs/unicode/utf8-selftest.c
rename to fs/unicode/tests/utf8_kunit.c
-- 
2.47.0.rc1.288.g06298d1525-goog


