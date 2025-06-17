Return-Path: <linux-fsdevel+bounces-51989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B105ADDF65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03B63B8ED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23987296150;
	Tue, 17 Jun 2025 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnUCvvON"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C12F532C;
	Tue, 17 Jun 2025 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201794; cv=none; b=qpAMJI+SVHGhxKQSN3xGh3R5MlkwwqIMYLeLUMmtGpO7ISoFYIGYa/fye03H09P595bMf6FejA+zKZu6jWq13no/lKd88BJixydRV3z4T5A/IwzTHe+l3aoru7wQ1/uat2g6/zBk596TF5M1RE52QsWM0FAqCcoZtHtQRGspgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201794; c=relaxed/simple;
	bh=4mlsD4R+YlfaDZH1rr1OERln+xr4wTttNjF3y5BbMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCMiQGSD5vBc+jYuZM9Z5za4pj8Uf2ilI3lb1NWSZ8f8U7Wb6NKOTtlDmLI7Ewoeiy0ej9oXQHRkPydIGNGRWn4JRUIlZVVg4txC8er6X3DLltZPfcDf57SI0x9OQWWYWENj8ty27eV++VtalFjvXjOrk/ilCUWGVuJlQ6t4GEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnUCvvON; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso12661160a12.1;
        Tue, 17 Jun 2025 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750201791; x=1750806591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ijuXcN+9xKfs803mnDn4fM0Qa1boQaJPIZqmUO1kH4=;
        b=dnUCvvONEzt3JkMHSc6LZc+TNht/wLYp/5f4dKRnI/UcRta+IhSa59oSugnDLk5Lba
         ozzDZnegJTHewnHDISTxkrwxwVSskjH4v/Y6MLBk+glz9sATHr6iGHbwAoDKjuMCTDLl
         Q7sBgetTuM4zZuMH7SSdrFbPlFkEeABYEPp5eUMzdUz6jTCdkK8hZoeyj7H4oRb0y822
         d2Dlp94BHuAdkRnnex24xnen+QVGpDTtGgqzX3EZ9yfNAMr9kvFLpPHxphI/106PwoUs
         Y1cdA/U1pckkBN3kD6089mf2Crn20Lc7cLACgEKLelyGNLwOuYTPkBjiquDFHBrg15Z1
         gnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750201791; x=1750806591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ijuXcN+9xKfs803mnDn4fM0Qa1boQaJPIZqmUO1kH4=;
        b=bZOPXtV9THyLGO2agH/uoY4n1mjm+4iGuBiHLMgwbWdvuVpHEeTC1hYmTipIGlV5oY
         h3eghjzzhHZeiBLVHQnijWxNzEpkocGq52qcnV5pc4ZZXuFJA7HPPvYmz6LYxaFtcaki
         10nhFIf0p7KTbV7Eb0hqb+z0dlbjAvlPcyzJ1OA6Btdh7snFYFeUNI957/nEZQD2kUaM
         n7lseO89x1/sTqRlLCy8cIEJGDNb4/f2TdO31g9UU/eOleh9hqMVYQmQ9p5VXjfJrEkg
         I3glOufcA3b1l8FW3eGeahr5enj4vOeOD27C2ScqU2LZ8MERXwNaxdJNGSoA2EuzpnXa
         a/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ehxan46ElCWwQvROycbgIpFwMV6azpe9CH2tc9UyYQftafQTIczfTW+RrH4tnK6JQimn1S02ipdlVboc@vger.kernel.org, AJvYcCX65phqRlccDlH/qIIwBX7JHLu1iYsnDsv1mWU+fO7Y32FicczLabqOE5T/KdkGy0r1J3tUNz2dmhnKdypP@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQ1jHM1ULRdsS6WFg2O1VArsB/mn8gcLc7GRd6ZnVPnZQgUDC
	XFzQh5B2tPo8QytCqbMWc6q7aMXb8JbkHgF2DHpZx0YQxB/0r1zdp/vK
X-Gm-Gg: ASbGncvOSfJS/qskrF9Y7eWWH7hQTRJRtmQdbWk4g7c0bUopZnauaEE2iLRm5zXjt9H
	TTb7DhfkeI36cWSOu8olEdpYdBk6egH3PX5Dkq+ttpGTetsTu4nbPb/IXXoI4AnGGTzK16ZG/Oh
	/CC0YMoIICIDlc0ShqsF50r3cjLld5Dn3kn7u+3kuhOJoBIfDEa7jQGwRJCICqQLkqdYjPjC+0I
	6T7gZ0AQYqPCZOCrUj1Pf213nXwCHtHz3O2Gn91hMGAbLTXGWeAajAExHHOpCYFbNvKmQl9rpFW
	NDYAVCHfKw2TdejUfk+pVNePoSyNVtddvon30U95somOT66/FVmRzB/EVSLhoEqMwrczdF8O5Fo
	o4ZTSdt2co8i4Plz2wg==
X-Google-Smtp-Source: AGHT+IEkWNe5n2i3tNvju+E4XDIP5jku/6cLDxMf7MZin5vvhN+GTV/ap3DVtiwvf//9mQ+V/3xFog==
X-Received: by 2002:a05:6402:5186:b0:608:64ff:c9b5 with SMTP id 4fb4d7f45d1cf-608d08b4922mr13425767a12.8.1750201790977;
        Tue, 17 Jun 2025 16:09:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3035:ee0:8caf:dee0:4ae2:6dd4:be2c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608f8e20459sm6216126a12.37.2025.06.17.16.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:09:50 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH] fs_context: fix parameter name in infofc() macro
Date: Wed, 18 Jun 2025 01:09:27 +0200
Message-ID: <20250617230927.1790401-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The macro takes a parameter called "p" but references "fc" internally.
This happens to compile as long as callers pass a variable named fc,
but breaks otherwise. Rename the first parameter to “fc” to match the
usage and to be consistent with warnfc() / errorfc().

Fixes: a3ff937b33d9 ("prefix-handling analogues of errorf() and friends")
Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 include/linux/fs_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index a19e4bd32e4d..7773eb870039 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -200,7 +200,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
  */
 #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
 #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
-#define infofc(p, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
+#define infofc(fc, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
 
 /**
  * warnf - Store supplementary warning message
-- 
2.49.0


