Return-Path: <linux-fsdevel+bounces-63811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFDBCEA11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C213A4F7DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1A303C8A;
	Fri, 10 Oct 2025 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx4kS1kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE869303A2F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132551; cv=none; b=tNUuyB0/F8dq2Y26zU3gk+7jRf1oMiHTqHRyfi1cSnzv6zwrwl/6wutlr2iFJSucc05JBSyDNHbP2zRz9Jj4YQr+64O0ZXAiaWupdic9s0mlHP8D0UPy/nLVnwYuX1aQ7qGTZPUPC78YdfBH7qA3vjealy7waL6pVmmpbqVPD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132551; c=relaxed/simple;
	bh=iq2e/sv+Zi9ciUHjCrlUp5Jvva2s5vbwXLIaUxZ7+K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGvJjAshRoTIhFytkd2nlbMGs09MqAaLvEkPilbaDz/zaWJHrQ/9oIrpROXlgGW0ihU1dNioGbHu4ztHf0GihdR1iooDJk1x3uqCeo1YbpURG7Q7CudnmU9CBE8RYjowk+9+tARHpot5dKrSAvHTnE6xy34XKE7vsYXJt90QfMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kx4kS1kd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
	b=Kx4kS1kds/9BoOA5CSz/4UmA8r9Klh2wClozbfB/lDWiNGugEzoHUkqcWPBgUIuJxjDyIT
	K6dhw7G0kuiNepVG0FN23x+RDMrtCLaDSV15gwMNlRd8s7ODxUCeuoxoWqXY1/GVSQyTAf
	h1Hr6z8JLD+JYqQzjluIVQ90xFZsayo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-WEhIHLCIMsaI7dKcahyU6Q-1; Fri, 10 Oct 2025 17:42:27 -0400
X-MC-Unique: WEhIHLCIMsaI7dKcahyU6Q-1
X-Mimecast-MFC-AGG-ID: WEhIHLCIMsaI7dKcahyU6Q_1760132547
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-426d38c1e8fso62355135ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132546; x=1760737346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQTrdZe6qZc3CMSCwVfDCC92bOCqOE6gyRvkJ7nko6k=;
        b=VmleS+p+fozL7/Xh4ZFNvjjfaCwUVsypJnLtJQ4MIXXACYOv9clPXLLRBPRMaZmS0m
         wQjPb3Xo5Jc5v4CuJYy0NGq+eKFMXdL9kDX7hEJwY6lIvrAtdhevDpJBns23nNA5VyA8
         gLnMyP8msXY6iGyMQQpsNzkG+pPv4sstWNHd7EIsE3jfyUsXsIjxzPHPwcVXysbo9nvC
         6h6HMsDxoWBYwzVpvmbLLkEjIcp1U8vg77ZGz1DwR6x7O874nU9t4cm2IQFVm5UAfnqJ
         uKkl+ZieiyOh3j0fY3l6Sg2+p5vZPWszwwtXy0jN0/aPvMDNUwj4PaU4ziesq+vvJGvo
         G+Dg==
X-Gm-Message-State: AOJu0Ywn4wVy3TJzs5mIO0BqZ2tNfVAoHkkMNxw8nx+kDnVHuvefqw1k
	Hc9Bh3eWliDWQ7/5nkgKWKDdan0UJH8G3dBTpayp0whg19R1gX44WMOvvPYiLzOq1f7ssMDuOrR
	+mNoAfZbfmEyIJTjA/lW2BAvYCUDt6iS8G6mM0hfrGDUbM6KjMGVlaPICIiV+hgfmrFo=
X-Gm-Gg: ASbGnctlhJ60T2pIn7mDpsf6cmRci8qzdtgIRc0gYR0EDC/W72zbE0+4nvW9ZR6MfT2
	3hmiPrRS0eTavkKrc0PYTqPuHDwKU+6jzVK+6ODxHocg5ZuiHAgtT8rPobrkpqMk7vphApRcfKn
	xn49Xf9MJiHHEVhx9NR8idQJNncwCVnNiD7GjQ5IIFj1TS9qKgSmHgRnvqzEd/lqoLC6MIh3m5S
	A/h2ov7F065cbw3764UPf2eRsVVuxRHxhYEYAQMpnuZktTSp1yb+krgnhvgVpgPIEmu1E/MWMNL
	A+JxorOt0Qb3cbUHFZdtnq1AX01K8s36rMCK8GPSgxmoo+p/ir87lfY=
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127614395ab.8.1760132546320;
        Fri, 10 Oct 2025 14:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8wowT6uDx6IYvItIFqvayc0HgxnQWRhznxzbTVphFWlfOlNrKFLBVqyZESk0W8ghcY0ggsQ==
X-Received: by 2002:a05:6e02:1849:b0:429:6c5a:61f3 with SMTP id e9e14a558f8ab-42f87373153mr127613725ab.8.1760132545634;
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:25 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 1/4] fs/fs_parse: add back fsparam_u32hex
Date: Fri, 10 Oct 2025 16:36:16 -0500
Message-ID: <20251010214222.1347785-2-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

296b67059 removed fsparam_u32hex because there were no callers
(yet) and it didn't build due to using the nonexistent symbol
fs_param_is_u32_hex.

fs/9p will need this parser, so add it back with the appropriate
fix (use fs_param_is_u32).

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/linux/fs_parser.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 5a0e897cae80..5e8a3b546033 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -120,6 +120,8 @@ static inline bool fs_validate_description(const char *name,
 #define fsparam_u32(NAME, OPT)	__fsparam(fs_param_is_u32, NAME, OPT, 0, NULL)
 #define fsparam_u32oct(NAME, OPT) \
 			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)8)
+#define fsparam_u32hex(NAME, OPT) \
+			__fsparam(fs_param_is_u32, NAME, OPT, 0, (void *)16)
 #define fsparam_s32(NAME, OPT)	__fsparam(fs_param_is_s32, NAME, OPT, 0, NULL)
 #define fsparam_u64(NAME, OPT)	__fsparam(fs_param_is_u64, NAME, OPT, 0, NULL)
 #define fsparam_enum(NAME, OPT, array)	__fsparam(fs_param_is_enum, NAME, OPT, 0, array)
-- 
2.51.0


