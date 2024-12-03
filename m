Return-Path: <linux-fsdevel+bounces-36357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB3C9E234D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1AC286ECA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5B1FC7D3;
	Tue,  3 Dec 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VcxAfTER"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE961FBC90
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239972; cv=none; b=GrBqgBFQs+yhy2OtHyS0N0h+RXfeCkFKGDJFJxJw29q7ZvkQ/4tpiS+2TYaUjrJrJmZjESblt+ElIbZ+oFDaEjQgZsVrnk4i1BF0ALZR+9NPcYuog7vgW4rgNnrqLLoo+76vdPDSzy9vzz+61m+yZpWz2S2wcf8bafK0OIMVl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239972; c=relaxed/simple;
	bh=q5+uRl+k/fn3TorBhDOZ+b9X6VZ/V2geJNnascX9Tuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdcYAS80V3EluPddSj4dL2DczDCP3UxerEN+NzOCcSrzA/Kx+HpYfjSxZejW4sM5QV4fiRckSNA000TCiOl/rnYDGDK4gUVuDkZI9K8iYbjU5smnCIp1ua0xq8CUihwPg/fPgytzT3H7Ri04b4n61yKSnZSGBtiwazAbXhNtOcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VcxAfTER; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea33a922afso2780357b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2024 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733239970; x=1733844770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSQf4jIfLBAkAFBsDD5CVUxWLID5QVKIZqR96ciKoMc=;
        b=VcxAfTERfrNCIjV4y56ah0/NIhjSnwZk+jEWqkNNz9Hga7fwuUrtk8VHECMIOKYbVL
         lP+1zgU68BxKo9y3CM0lkavVEVfY0mNlIKEMhg+OsemQxjokI3iXWRiamfutr66xSjgh
         MCQ1iJ+fWAqoKWCPNFG3jGqEgU3VLkSPeGFEjbRb2ATyMOrCZpztKXDftsKZiRzzVbDB
         4PygPEUE0cYiNgP2yH/zNZI/JJi2VmviFY+rgGzyQaWZfbs1u3ukrWOdYkaASV6u0HZP
         JBAKdEucpfgW8VqPv2uAv8mKGuD7KR5bxdyoqP3S3xEnZMUHgCpLs5Lw5qE8R7UI41Rf
         zYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239970; x=1733844770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSQf4jIfLBAkAFBsDD5CVUxWLID5QVKIZqR96ciKoMc=;
        b=TvjbYcLgovSCROtQ/E0I/tMLwnXv2RSyc1ummdRL/C1KTojbgPQ/mSX/QeDPTtiQVd
         qL+GWQmUI7YNvidNRh2GusPag3QO1tePUtncP16E4tAV7JDYUWY54IVW/h9Bb8AD4GYb
         WOn7subTbBCMPTH440mxiHPlaSsrzFvaFLd5x3FM4jSuM6pfEoxn46KlZtrOy2lZwT2/
         +5rCvdKMdOMxWH6SEHWzatSlXfH97gKO3LLaNRc/ObNsMi0vm95ojjnZELXG26wcKKIi
         /jGrbSDQbW2Sbm6vOWOxeSFOL+Muj853jLw83+OPsQ7pYGHr4qNSOiaNL5oyyOPQSjxu
         FF3A==
X-Forwarded-Encrypted: i=1; AJvYcCUTMd3d/6+G9AXi/IrtRCgk4GYh9olSMkvNTDITHTxht48pTBQzVATgIlkSapLltfg9MRHHqu0OmWTX0G05@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkope8JHeKcv9+u/kZC9Jp+aTMBm48hKYDr1jaVdpRvzWvP/d
	johSsnUAm1eEmDsnDGZqlsT5Hryj0AB/QUB4fBJ1CLvB65OB45GJTI+8V0LhJZQ=
X-Gm-Gg: ASbGnct+KYkT8UEXqbKIPVTLWG6GhzJEWBTCQthNeDMJy7VOW+pvnXNk341A6/zBlOh
	+5tchOSMOxitJMNLPVtFFkl1v96Kd6JREbEUi05ShAFCZuHykgV4DX70NfhH10mxApD8/arX+nm
	EtsFBG8T6WgT8+kUZNhm/aHngs3FsPdciDmz7UrrbGaqjlVjfw1AAW1tKY8QvP081Lu98weFySu
	YAaQ3lyGL6S+52kPoOJn3xsC9HMAb1ySJu28maX1wCRrncRR94H/8qmPSM=
X-Google-Smtp-Source: AGHT+IF59+hbl1oxKnagTF4XdkSvu7+brogdJGlmHp3dV6C6q4drpkxZSCaanT7IxLge7RXlKXRl5g==
X-Received: by 2002:a05:6808:1795:b0:3e7:9e07:432b with SMTP id 5614622812f47-3eae505e041mr2729493b6e.29.1733239969773;
        Tue, 03 Dec 2024 07:32:49 -0800 (PST)
Received: from localhost.localdomain ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ea86036cbbsm2891878b6e.8.2024.12.03.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 07:32:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/12] mm: add PG_uncached page flag
Date: Tue,  3 Dec 2024 08:31:39 -0700
Message-ID: <20241203153232.92224-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a page flag that file IO can use to indicate that the IO being done
is uncached, as in it should not persist in the page cache after the IO
has been completed.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/page-flags.h     | 5 +++++
 include/trace/events/mmflags.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2220bfec278e..14346fa2470f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_uncached,		/* uncached read/write IO */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,10 @@ PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
 FOLIO_FLAG(readahead, FOLIO_HEAD_PAGE)
 	FOLIO_TEST_CLEAR_FLAG(readahead, FOLIO_HEAD_PAGE)
 
+FOLIO_FLAG(uncached, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(uncached, FOLIO_HEAD_PAGE)
+	__FOLIO_SET_FLAG(uncached, FOLIO_HEAD_PAGE)
+
 #ifdef CONFIG_HIGHMEM
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..b60057284102 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -116,7 +116,8 @@
 	DEF_PAGEFLAG_NAME(head),					\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(uncached)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
 IF_HAVE_PG_IDLE(idle)							\
-- 
2.45.2


