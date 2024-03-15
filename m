Return-Path: <linux-fsdevel+bounces-14435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89A87CC86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 12:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBDB1C21B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 11:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF619250E5;
	Fri, 15 Mar 2024 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S/Aww/rt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D11CA82;
	Fri, 15 Mar 2024 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502746; cv=none; b=mA4Zl7F+fMJstBKm95fTMU7hp1nJXGXQ4raGdkUeSdnuimd+RxNUGY83HjV04LEuHSDs3YQGaBMpdLdbHeaamwCJ5m9f1PhObDGTPD00OHutROJXjFEEhDod+Erhg0ARvKonLq7C+Qs7qxFXzS5TCrAjHHqUFa/0Z2AIjLgbCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502746; c=relaxed/simple;
	bh=9tCjsbVJ/fo/2whI+Hw22WMDXZdhrVzR/9TP7a13ecA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW0iOhV0RPioUOs/NsXcfMb9cM/ueZNNmsS8C8rT17swHH89P40H8Lp+/lVq6YPMxgZLM15Pp7gF+qPGxmk5tLRu7wpZHMEIjC5y9E5Jm7FlALZEpHEeWbnN3hxV36crJ7iS1Va04iEf210WUJiDXLTyc4a5aF+5SJJ0S8He/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S/Aww/rt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so2578956a12.0;
        Fri, 15 Mar 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502742; x=1711107542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqSJTvrldRF8cbM7TJxtJrnkF01DJRZddF+rymqV+ys=;
        b=S/Aww/rtWdgBKiueou8NEiS1coXOCisoDZJU5P+IDO9Akh2MgblpknjLJSEDWzhz4n
         c85iB7gOBvZMpVvdZiaiOicp9oqVdx68ARJI9OY/5zzL7+LmhXTCaw3DpaDRTWAkAD+o
         MPXyx5AQngEzjogSG/XSAK+X8h76n5zY3RiKfZURzZoTjkHhPU7AbzQs7Alpty+OOoOf
         QHW/OPBEZWREcdU1rRbqg//Q43J1C7ac4QMUqO04pC39nYJzapDBZJBstfMIJpTmRQtk
         TP1RzJgZs6ttLQ07rFYnu9vudaueeRuRwer/y6GmqBg1lw11mA8SBixRxIQeLQVzmpiD
         FDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502742; x=1711107542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqSJTvrldRF8cbM7TJxtJrnkF01DJRZddF+rymqV+ys=;
        b=dkOmJhAfAZ1vaDLE18HwdH1FbUTIOIrB+GQX5nQh6hcwnot0cncd3azgOLtVNAu/RB
         c9WBNMOos3rAuZ+JKYsm3SfTRqEp2MkvB9x3AH9W8zfYeciJjLhOdqCgtwVRUKEcFEAA
         WUqQ31WS/m4Jm0Yr39VBT2GnNyVMr5NpERFS6XXN6YxpzGqewfD5aox5XERaMwvt7Gja
         MsjJkS2BUbfgJ4cCqVQ9xEF93VG9QV2m0x3wwl4Mg34ENipNcTskbz/2hxlXh5g54Dqu
         rkBrNwSFYlGOLYH4O3raMh0rfaaG3FYr4ttEOeS3PUHCfFOUc8YoRxzLj5E14AU79QFN
         9XhA==
X-Forwarded-Encrypted: i=1; AJvYcCW/RmdL0zRYEnIiF67es9izmA8nnB7dy+77Ps6RsWDRJlZXpemgW5h3tXl7uDGyY7iLAwf+74iG+Z35n8lh/xDEdmeIlmZoZLmlOXSZcUjeEqZ/ES32sQ9zS8RBgqvImVCf2ltWFpQWa5npWXylG3sIHZZixECzTwkeCzJNsoCrfw==
X-Gm-Message-State: AOJu0YxaIGnsCYcmAkiORgOjVdKRulr/iIfyYANzlY/WPrGn3xjkhHTh
	z3iy952e6tbFTfml8LZfqkgFz8Ep2ZqhnJb8jyR8TKAb7BjUi9BmVqw5rOboE8ganQ==
X-Google-Smtp-Source: AGHT+IHVrm+oaqT4IHcuat6PtAnzsvv3PZGBlHGbf+6XCYTlxZd2pqsN/rkNVVex9ofvPc0Zr06h/A==
X-Received: by 2002:a05:6402:612:b0:568:1983:4913 with SMTP id n18-20020a056402061200b0056819834913mr2376571edv.23.1710502742568;
        Fri, 15 Mar 2024 04:39:02 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:02 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 06/10] fs: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:27 +0100
Message-ID: <20240315113828.258005-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
v3:
   rename to capable_any()
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 50c8a8596b52..9d02698ed5d4 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -784,7 +784,7 @@ bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 
 bool pipe_is_unprivileged_user(void)
 {
-	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
 }
 
 struct pipe_inode_info *alloc_pipe_info(void)
-- 
2.43.0


