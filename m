Return-Path: <linux-fsdevel+bounces-45598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4781CA79B43
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 07:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DA91749B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 05:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A7D19E7F8;
	Thu,  3 Apr 2025 05:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH4G765w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234519D065;
	Thu,  3 Apr 2025 05:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658095; cv=none; b=kR8qT3Uyz07UuAKE3d0D3RgsrclHfYRsQ8WDhPh9WnlINhSk/IbvY4G/ARBWQviqeDYv80TtLlGxj2QNzjGeYK+YWmIZWLj4oYXDl51BU0NbtSeSqkwJ9KGG8rPISvSV4anV+V/+lxU0dU1urLT2xm0Xn9AvnYakkdO0aoD4jk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658095; c=relaxed/simple;
	bh=ablVFuA06C0J29dzcF/q8RicjJAWLm1LkqyJq3zLGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCuoyVioqt6SVvqgpoqHcBDl+7KVs2Ou0M/s0B+0VU6LUFdCoUjSud9OgdshKka5VnWQvCUIJINdSCFt6ihIDHP7LFRyRMT30brk0cmeoT3XLa76Ze1hb86ZNZfmVu23fvGyuLd/nCohwntMYv1otJW9eITOnI8KIhymQESiUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH4G765w; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so449332b3a.0;
        Wed, 02 Apr 2025 22:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658093; x=1744262893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=StDYUD7CYFFKgLT10v5qHsCOJxby6VYxth9kuac+LSM=;
        b=IH4G765wa5X2PMk6GCi4vyKgIN92b+fLsCrIRPPH1bH1jfByiLqjTAV17EGEZceR++
         fEPGFNKDS4ld3Gox8CgWUZmWitDpKzUzUx3AMig1KQN+z63JCxSiIX92XttwwHP3A3+O
         5Is7a9+TvvVzS4CIwckBoYZnkNzC5LjCTMa5TgfixIRusI9/9JrTVTr7uuGte2iNqLu8
         VaafArp8H308SUV0BSFfsXU3fUeNl1LENarrEjsqmMRei7CjcwEKIaDr4uSV9dUSgQxP
         uZJWwZ2hQCXAp/yGU+6eIrhiLbeJv0U0fk9iPdVelf9WKCq6UiBL4FBh8hQvWmWLu8RI
         uJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658093; x=1744262893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StDYUD7CYFFKgLT10v5qHsCOJxby6VYxth9kuac+LSM=;
        b=F0BRLdDXb8G041+ErjOVOg6RwWLayXLLoDW1Zy0/0+0XoJEdQZjDcfdi+KdL6Wkz/J
         W/ViCE0et2JuKc8Xy7muwn1dHa2HeL/YDvOWzLS7ZvEFnkT4SnJbS2DRWrIrOQgQl/xC
         LDxMYN2QUCYhosH2gjhrJHV7hP5sM2ARWTcBOwmxH6G6qQpR1Y1FmY17ASf29mtgiNed
         +kj368z0wJs3q2Xxz9xK7/Rk5U5B7AJ8d/F6DfLzkvIWB7N5PD1w93Qj9R/9aaW/XiCR
         a6eve+gIWSbOVjrA+H6SVbvh3TgBSlw+4tqdUEtgq8/OybeEp/ZXqM31xWBmeltdgSHJ
         OaiA==
X-Forwarded-Encrypted: i=1; AJvYcCU2guNXjzOORlKyE+JFYdw5yY/36yeAGOzrykTJ1rRKoEAq/tdOgodVlR7cLbLxjBOZeMNmtKtOF6uhMiuW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyud5v0OwyW8rVE7+QOopdnIc1vpTeDNmDPHGb1dGzI/lluCpB
	EYdgteYweXK3bi470py27GZ+AR/py1Njx2nYv5hr5/T/sY1CmDBdPwmXuA==
X-Gm-Gg: ASbGncvy1PGFJY6TBI1MixWP+5z3Izs3Tt3yRDLZ+yjRbtfNKs54n4KPhbNWGdmFDbl
	jkPcl5YpKNER6JL5L/JuRpJaN5QCWLk4EpzF9uPmU5d0kjiF1tt47OCzhIqcCTdul1RrLptFtwO
	Ih6yDksQlvys63b1ioyO2Pjw8f+vD8Tra5/NipCeCl/15b5kJCKB4rrJWsA7RWT1JKPJxMco803
	rhbu6ozST6GFoB2sIY3GInFoBneSCxsrl1yPgvzSJVAV8r4BfcQbeEMAUqPH0i7+u+46oaSt5qk
	xVl0Oa1nPjOoZooE/t3Boifi9i1NLq4eWajJHNEHRFCnyUsNCg==
X-Google-Smtp-Source: AGHT+IH76oAzOf2n/1347hmtRzYUYFyy8et/1n6aBjDfBicof8YbnylTMps1+zfYM71ktapq7D722Q==
X-Received: by 2002:a05:6a00:398f:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-739c78430demr5736643b3a.2.1743658092660;
        Wed, 02 Apr 2025 22:28:12 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.86.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea09a5sm541830b3a.107.2025.04.02.22.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:28:11 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	axboe@kernel.dk,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC] traceevent/block: Add REQ_ATOMIC flag to block trace events
Date: Thu,  3 Apr 2025 10:58:03 +0530
Message-ID: <1cbcee1a6a39abb41768a6b1c69ec8751ed0215a.1743656654.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystems like XFS can implement atomic write I/O using either REQ_ATOMIC
flag set in the bio or via CoW operation. It will be useful if we have a
flag in trace events to distinguish between the two. This patch adds
char 'a' to rwbs field of the trace events if REQ_ATOMIC flag is set in
the bio.

<W/ REQ_ATOMIC>
=================
xfs_io-1107    [002] .....   406.206441: block_rq_issue: 8,48 WSa 16384 () 768 + 32 none,0,0 [xfs_io]
<idle>-0       [002] ..s1.   406.209918: block_rq_complete: 8,48 WSa () 768 + 32 none,0,0 [0]

<W/O REQ_ATOMIC>
===============
xfs_io-1108    [002] .....   411.212317: block_rq_issue: 8,48 WS 16384 () 1024 + 32 none,0,0 [xfs_io]
<idle>-0       [002] ..s1.   411.215842: block_rq_complete: 8,48 WS () 1024 + 32 none,0,0 [0]

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/trace/events/block.h | 2 +-
 kernel/trace/blktrace.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index bd0ea07338eb..de538b110ea1 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -11,7 +11,7 @@
 #include <linux/tracepoint.h>
 #include <uapi/linux/ioprio.h>

-#define RWBS_LEN	8
+#define RWBS_LEN	9

 #define IOPRIO_CLASS_STRINGS \
 	{ IOPRIO_CLASS_NONE,	"none" }, \
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3679a6d18934..6badf296ab2b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1896,6 +1896,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 		rwbs[i++] = 'S';
 	if (opf & REQ_META)
 		rwbs[i++] = 'M';
+	if (opf & REQ_ATOMIC)
+		rwbs[i++] = 'a';

 	rwbs[i] = '\0';
 }
--
2.48.1


