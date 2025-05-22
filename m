Return-Path: <linux-fsdevel+bounces-49678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67357AC0D4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96123A26C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2028C2A9;
	Thu, 22 May 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/rCble6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2928A1DC;
	Thu, 22 May 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921886; cv=none; b=LYbXDOsILNk0GWsHVFfmqPAXViWl/GqQCzbBDJ+zJD9e8dz+eRRu/41R7dc04ho12Sb5XZfwL65qpktJxO4ZexJUiHLXBhXVq/mw8WBcf+Vk3hlvsyy3Qkk6+ZdY1rKnVBfX5oDrTgpUpBWVByezm5ipqjkfT77SJULfLJq+YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921886; c=relaxed/simple;
	bh=IFCHmgpCwvEpsMGGei6Eq3nb3pQrhHESHm77Wp7BOhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLJP92LubK2zBKC4ruhg6S3flkwW9HrnHgJRPgYwfr+UYXBqDhF1J1kjaRfDPQ+XctliMbZ1wfz2Ggvpmx5Hfa3DX2ovJtxSP8V6ml4qH6Fyo6gxQxDTOmZFIg5DDqEq4RGuZ5+x0odY8cVOtbtl+xD/eD81mjfrhDojbSpZ0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/rCble6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so7817495b3a.3;
        Thu, 22 May 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747921883; x=1748526683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RobnKU9KOucG9hKxcDzKA3QVziQD4DYIMl/kGFJ+p6I=;
        b=Z/rCble64FkEISCFMVLbJ7PI/nfWWJSfg0m1UyI8Q0WHDoQlcksm3ou1TnnPs0AHFm
         w78UJFtUz/tlA7zazovuRwj4+zxjtR/UaagqrRUyFlU4/BV4seYbx5Bzz5p2YyVfNLrL
         KNxSTeaO7A9aCA7XN6xGNP1WbDaQNbdD2u6Cu1ZDBUsLbdb/G1OarMv+p6B0Ho3cU5kE
         Rn2iWcFXlZ9E0oD8UJ/I1S4vsUiFsbtrqkjk9sBrAZ43v/f7Ys7GRAD+N6QaNHuc2RRK
         7qCmRtG52/OAl+VNdoi5IPYcNuyRvb8Va7YVZjY+nEDR6KKDs1Sm+yT0e3qGOkDHuGGG
         HB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747921883; x=1748526683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RobnKU9KOucG9hKxcDzKA3QVziQD4DYIMl/kGFJ+p6I=;
        b=JzQJQTK77zpm1NMykMOkDla/VFE6OM37woxro8sadIvLvZfHWjykaNDNrbqCuGOVHr
         ke8KXOwgQgytZOrIa4dcQMGWEJaqZ2ysdpxovMPCkiIvaWQ/hsEKuISEy6UXnGGBgEyv
         0iCqGbBBmKJliWoALDAlgNku7jrmR3KYUWpyjIZID9mvaZs9+iYY+Exv3fCiooWhMgQH
         mm6fQxxsjR4evbv+mJehWI0g+fIMSHq/L98K2RohH3m/9z1aqgPCz6sQb4NGHN7XnJ+G
         Terr1AF9JJZq8WkSQUgmCqTguzu//cP1OpxZbsfu0q34hhXe3pXlAAyKszWHzpgjIAew
         DiAA==
X-Forwarded-Encrypted: i=1; AJvYcCXVnu+UNj5vnBzJRIJIs9FLQ1fHUZ1GamUNvsb2sMnQkHs9sUqFMgBfSP8rUnxpA3k3lzkSc0GrnAApwq5m@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRtFeN2hK+3az+eQqKq2Dppp9IE8cc5hQiDER8VggbUEnbuYn
	hBT+JIc+Vcl2kGTUMgw6BddRtzoICkh7G9dGl3c6Uar2+DWW+9uQ/aRkk1zHDg==
X-Gm-Gg: ASbGnctHt51t7pBKK16anM+cSljO+TNVaVd5uHWIksUD0i9LU0QFv3au8cpCD8VDe19
	t92KcPKybC87O854jHolUX+u02nSGOaRqYX3zlL4refvvTCkP6XYt4EhIqqwk0kh7Wp+5dKqxFT
	HFzHTcwtdTjTivQl2cPo1jYQ/YtivS++BT5qfQHQ803H19lg6yibtEUawtfT5JPiqb1LTLkPIwd
	vSEQGHFDjnWyV42bQ/egrr1kEolXiBmv1epNxrq+M3aMBE6ly15LmPvTKr9lReKwkoBY60R/mBt
	vGvsCBj4sjg4BXruQ7S9HfAyWTBWU76RQUa1RmWaLq3eTGYJzTDNf2el7XLibZscUYCw
X-Google-Smtp-Source: AGHT+IFuY0+8rn07hN2qTZHmYWLQumKlpWDqJzADbMiSlhqlGM9wL4eqJEGTQij+E4PAaz0j/DHcPQ==
X-Received: by 2002:a17:902:e882:b0:223:65dc:4580 with SMTP id d9443c01a7336-231d45952aamr321983325ad.52.1747921883513;
        Thu, 22 May 2025 06:51:23 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-232044a0a23sm90562105ad.112.2025.05.22.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:51:22 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	djwong@kernel.org,
	ojaswin@linux.ibm.com,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2] traceevent/block: Add REQ_ATOMIC flag to block trace events
Date: Thu, 22 May 2025 19:21:10 +0530
Message-ID: <44317cb2ec4588f6a2c1501a96684e6a1196e8ba.1747921498.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystems like XFS can implement atomic write I/O using either
REQ_ATOMIC flag set in the bio or via CoW operation. It will be useful
if we have a flag in trace events to distinguish between the two. This
patch adds char 'U' (Untorn writes) to rwbs field of the trace events
if REQ_ATOMIC flag is set in the bio.

<W/ REQ_ATOMIC>
=================
xfs_io-4238    [009] .....  4148.126843: block_rq_issue: 259,0 WFSU 16384 () 768 + 32 none,0,0 [xfs_io]
<idle>-0       [009] d.h1.  4148.129864: block_rq_complete: 259,0 WFSU () 768 + 32 none,0,0 [0]

<W/O REQ_ATOMIC>
===============
xfs_io-4237    [010] .....  4143.325616: block_rq_issue: 259,0 WS 16384 () 768 + 32 none,0,0 [xfs_io]
<idle>-0       [010] d.H1.  4143.329138: block_rq_complete: 259,0 WS () 768 + 32 none,0,0 [0]

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---

v1 -> v2:
=========
1. Changed char 'a' to 'U' (Untorn Writes)


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
index 3679a6d18934..fc62a9767203 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1896,6 +1896,8 @@ void blk_fill_rwbs(char *rwbs, blk_opf_t opf)
 		rwbs[i++] = 'S';
 	if (opf & REQ_META)
 		rwbs[i++] = 'M';
+	if (opf & REQ_ATOMIC)
+		rwbs[i++] = 'U';

 	rwbs[i] = '\0';
 }
--
2.39.5


