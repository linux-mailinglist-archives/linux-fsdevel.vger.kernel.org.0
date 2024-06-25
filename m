Return-Path: <linux-fsdevel+bounces-22433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9B9170BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F953B21336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C017C211;
	Tue, 25 Jun 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sBRrajmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAC146585
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341815; cv=none; b=fZnQIX1A/2rOjjAUGjj/xHGoFxocAfQFLx7kc7aMQKsLyBxTKL01YQf+korj5qPxxaer+ZusZxXLLBbFfHMICKMn2XaA8f6mxhK+leOHKHJ0OObXCQc1Lidc2tlfOtz20mdRRniXJR2nPLmSWeJ5qy+L0pxzgK69gRqDc4aY+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341815; c=relaxed/simple;
	bh=HkLJiM7D0/mdnPA0z5KDqMd10QtP1f+2z+uRHqOUngM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mbQLU+FucZTvSx1sNvKV7RVWlt7KR4eywAUgbEzYxkUQIXeP12j7/w39J55+F/UL3eLu2HYgrczH/emB0H1t6HHjcX8nAiE7/knTfFs5IhEokW6iWsJ4Y0dxaCVOshKhfiQuhsczRgUeVXgGtzRkpg6/dyL65fjXKvtcvRO6yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sBRrajmA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4435f782553so33564451cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719341813; x=1719946613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=51eLEnk83r8na3eoO3+jqc8AR08CiZDA3coqeUzH2CM=;
        b=sBRrajmAuRuVWonZIgwtlMyA7SagXS1HvWp0yDXcESaoOIF/+Bs20K7ehPsZ+xAGeB
         tSg/9dqNuOdpGfi9ILrScI/Ffp0MGvMxooA7zBiusXi5WM2OwN6zYaQqAK/JQYDABFxC
         xaTeDmW025NXvv7+86dz9SI836hd/JDsDD/ECxf5REqTZSkkd9UvosIYPNy2MkY8lNI2
         mIAtgjtxP6/oOVJrL7NeKGUti/Khai5xQXw4VG3r/QeQf8yzeYNu08OOwoQWOAErsJ2a
         taIIA+3cnpBplJbZGTkMNIuf2l6xXvR1c/Eyu/e1BMMDPA63rDgSOb7/O/LtlW5ZlAF2
         r0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341813; x=1719946613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51eLEnk83r8na3eoO3+jqc8AR08CiZDA3coqeUzH2CM=;
        b=Un/9zSyz5GU3LMA8QLbQlMnAHptlijS9LA7U76/SP9vfyQjjKdk1edIAc1Cmcxa9/4
         dFTLwBl4J9jJd1PhqShWmK2o97d0mEAiXtXRtDoY66OZZl9hYcPAY0a0mWJuHOiS9wIQ
         Rfyt/MuNZkrT0b1Z1K9m8EWarMvbubG39+eGAcwWC0UpsQmjcyC3ZFED6goH7KVDZR8W
         Yg5qLsJju6Cpk+L0UBoQKGqF9bCwqWzoC9Lttmo25xGH8b4TG/XeP5MRhOcXa/ks++Ii
         ZihCFX9/dceTAvkQ3gAlMdi4exFkFdNwn+amTskKD+m6sbhRnYJn/pHjWPeMpmf/WDed
         2QUg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwjWiR13q1VR+fQ14jDQ4XQhZZBkg8G8cIVjBiJ6YEInUNj2YDBB4Kmof8q5Lkm88WebIi7aAa74rrMM37oreH5qT7MjqqscV5LdZCQ==
X-Gm-Message-State: AOJu0Yw5RGviz8URphoc86kG/w5/RQ42hP0L+UGgeXF1zZecvfjUh/V7
	LCMH35IOoHzKwb/cIuuFqHkf5VU9QhyQBQOdv7g5dmCqvNrrWfDFhlu0tGrfsRE=
X-Google-Smtp-Source: AGHT+IGBpRCysoATM/2tFmrDN27JGFssq9mqHVQEb/J5w03j9KZjKl+xKY2TgHwoEqU8gdOyKLQogA==
X-Received: by 2002:a05:622a:1894:b0:441:51a6:b60d with SMTP id d75a77b69052e-444d9215013mr96367741cf.52.1719341812881;
        Tue, 25 Jun 2024 11:56:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44504b1b0f7sm841451cf.19.2024.06.25.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:56:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH 0/3] man-pages: add documentation for statmount/listmount
Date: Tue, 25 Jun 2024 14:56:03 -0400
Message-ID: <cover.1719341580.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We don't have docs for statmount(2) or listmount(2) yet, so here is a first pass
at this.  I've never had to write man pages, and the `make lint` thing doesn't
work because it's looking for checkpatch, but if I put checkpatch.pl in my path
it messes up.

I was able to run make check and fix up a variety of format things, so hopefully
these are usable.

In any case I've added to the statx(2) doc for the new STATX_MNT_ID_UNIQUE that
is needed to utlize any of this.

I've added two man pages, one for statmount(2) and listmount(2).  This reflects
the current state of what is in Linus's tree, it doesn't have any of the
additions Christian and I have done recently, I will fix them up later when
those changes are merged.  Thanks,

Josef

Josef Bacik (3):
  statx.2: Document STATX_MNT_ID_UNIQUE
  statmount.2: New page describing the statmount syscall
  listmount.2: New page describing the listmount syscall

 man/man2/listmount.2 | 107 +++++++++++++++++
 man/man2/statmount.2 | 274 +++++++++++++++++++++++++++++++++++++++++++
 man/man2/statx.2     |  12 +-
 3 files changed, 391 insertions(+), 2 deletions(-)
 create mode 100644 man/man2/listmount.2
 create mode 100644 man/man2/statmount.2

-- 
2.43.0


