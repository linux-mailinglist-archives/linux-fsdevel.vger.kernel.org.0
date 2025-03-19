Return-Path: <linux-fsdevel+bounces-44385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E7A68128
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 01:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89A93BA4A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86555D477;
	Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="c15ZypT8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D715134BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343340; cv=none; b=Q+XQaeuaxeImQP0pAot9XmskcPF5wrXy7aQex834nMcbG4hhd6KwDm3b3B2oDDWKpdVY3gqiC6H0ypDSDike7tKRpKe2mIcrHByks3M8noBh61T7/fWx6xluk8B+yTflRNc2d+wyS/94vq0Qd5ELnKXdh3isrVywFR5XtfPM/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343340; c=relaxed/simple;
	bh=F+Fl+hJmeyq3YWzTs6D9ZDaWGOG6IPUOQDfOlysIeuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2P7sWwGdjURUIiGxPDrGHj9XOHRs7BOA/65AVYInKcm/APc3QxKugURWFYI9KRvfnj+4aXK25bQlRQOVKzqvUaVpybwUqXwMrHurjE1ddaM1DSIM6CWsyLCHvn6Ar3fGMmVTjMjdSKJobk+o05mUPIWIB38kT/cmH/gbbMAUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=c15ZypT8; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so7127277a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343338; x=1742948138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=c15ZypT8L1mzw749Vu6yvbOQWTg1d566iXrxBwFUrtc04MkaXhvFKCRKYekK66oUAe
         hniCMAklfD3Okow66BOahdsnXukn+F4oQMvLgsBOSizEUMOcBMjoBpiUQYnPgv6OUxjM
         DqbVqJAsPDX3z3pJnmykkXGWnIM9tc5E4SuiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343338; x=1742948138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciean/zWrbirFJ6x0i1/pN9FA0IKn0ZUFy/flQBxt2c=;
        b=igMPVqcqtXevs1Hx6qtFgpeousxr1V/jgwo3n9niFtT7qAAWV4uGhlnuCZ8bYzXM7j
         L6meuGJbId9+ZGv/OEoa2Yyt95vAJ1DDRJosmxoL3Cr2YhBi/1e4AoHPBDn7qZeycdrO
         7/AApoDfLUaIQS452JrESbGGJ/nSYhacBz83UIqHnACnvclPu3VRx+xkpHq56CtGxlTQ
         WKMytA0CjEgtK2i21RXotPpr76pJ5yhDPShyWBnsdFTept78NfDGhV48dbXAoXwbusSP
         OkyijrvP+6CyQeLXv3qH1FH4fyt53W5p35U9zBDYz4+Xzb4TWaDxulcYo/jXQ3sHeWE5
         mqdg==
X-Forwarded-Encrypted: i=1; AJvYcCV1FMWd4sz81h2vsK0qJ/yTx9gRz1Nmi71SrPHRP7inlstVYWbcgZbG6m2M4yTUsnfMb18KUMKXFw9nH4Rx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4wyZiVfE2vPo5Z2ICkkoQBuwl17uihi0HckhK/DQ4uDJ0hrko
	eyXvfRx65B9/7+m4N7bjzfpL9VzANdFJUjJ/oUfXEZHiwaw820xmPEH4fLUQcqI=
X-Gm-Gg: ASbGncvRDVFlpIf/tTXvh0NlL8x63blYaZgs8ahga+Gvf7W+g8MyNu6oCgbNIhuK9m3
	CAEXrWhSyms3Q18g8vNnCt/h8e0vigkpUtQt/TETdmLjDvjkO6eo5ppUNQIQkK4A+2UFPBuUvGr
	mBAQqrxB6M5c0+f4MxT/SeF6BQrv3e9xz9Xk7baDXlNBX0EYQoxLpr3ifRm5sC2PqoRHAMBLbvD
	LLlE+TaD+EzkcS6bVC4CgB+o83ULPeyzZfA166xNujgDyPca5UxnmqvO9c9DGZksHG6cwrkyziX
	ipY3T07NGyfPkFx4MMiyuK3fWnLI91I3yHvUSdLX8Gqj5hkm/Tq98rM7yVsZekA=
X-Google-Smtp-Source: AGHT+IHkLC7P0qxfNOZ7am8oGQAhk+QCLx5pooxaYbMLyunCN1d9iFhe6ACMIi4+onLyvuY52I93jw==
X-Received: by 2002:a17:90b:17c5:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-301be205cfamr891476a91.29.1742343337829;
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 01/10] splice: Add ubuf_info to prepare for ZC
Date: Wed, 19 Mar 2025 00:15:12 +0000
Message-ID: <20250319001521.53249-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update struct splice_desc to include ubuf_info to prepare splice for
zero copy notifications.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/linux/splice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/splice.h b/include/linux/splice.h
index 9dec4861d09f..7477df3916e2 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -10,6 +10,7 @@
 #define SPLICE_H
 
 #include <linux/pipe_fs_i.h>
+#include <linux/skbuff.h>
 
 /*
  * Flags passed in from splice/tee/vmsplice
@@ -43,6 +44,7 @@ struct splice_desc {
 	loff_t *opos;			/* sendfile: output position */
 	size_t num_spliced;		/* number of bytes already spliced */
 	bool need_wakeup;		/* need to wake up writer */
+	struct ubuf_info *ubuf_info;    /* zerocopy infrastructure */
 };
 
 struct partial_page {
-- 
2.43.0


