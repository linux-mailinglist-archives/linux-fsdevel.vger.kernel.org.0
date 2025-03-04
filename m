Return-Path: <linux-fsdevel+bounces-43091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A65A4DDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D4F177370
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3BA202989;
	Tue,  4 Mar 2025 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KSywNIe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDC200BA1;
	Tue,  4 Mar 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090798; cv=none; b=GTeokQMHcKL/nsfmTN4W1twcLCBBe7Tmh6Z3Ww1dK1Y2MeUQr3oBy3OZzxsH+0I2LEH90SwyUHU1Z2euVHUQXHCISGex3vMjD7GFPmanRSm3n8RtIER39U5vD1M/zhP+xqt8W1DClCuLwBtEG7hEwLgZE8mDuxdnnJyM9jCq73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090798; c=relaxed/simple;
	bh=f4q1bLH6w2xXVfUvn0kD0zQt/FFHG3JSjA1XiDVThds=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KKS0VJzTg2Ws5leF5weAK7GtTkGQooow6wtDHIwQ1NrhB3lyQJtFnF4TLjvXc9lbNDcLf4N2xJHkzSVWM+REh6FqDIXMyx+G1ZtWcNCb8glnAQKTWU0Thkc6qyWO6oxOgNs8M7DAgFyldgYPoUgx5AImYEmxglcK3GMQ0qNcU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KSywNIe4; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741090789;
	bh=HKuwXFlWJWE+SLBn93S8kQVjGWyXEl0tFhvXRtckQ0s=;
	h=From:To:Cc:Subject:Date;
	b=KSywNIe4okjXeljKsM2mZdjWKxsxleihfHliCRJMtK4jhzKXM24Vgxmv6lg0bTue7
	 kFe0D2ZmwfqxHujtMkoVP5muh9dts9fjqIpsS2U8ljsM/5R1vjCdyIlnx5Eog9Ep/3
	 jsy1syGWs4CTcP1xvIKOzUGQlgLddYSNt5siMk2k=
Received: from ubuntu.. ([2409:8a28:c41:ff91:d5aa:18f1:22ed:606f])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D68250FA; Tue, 04 Mar 2025 19:53:40 +0800
X-QQ-mid: xmsmtpt1741089220tumkwg40z
Message-ID: <tencent_4E7B1F143E8051530C21FCADF4E014DCBB06@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XfZq0lcI5Mm0OtEj6DxF4Q4QKBl9lQS6x1/Oz5ug/Hguxrc8jYx
	 kdeu5Y7qXIEhFewIla8I4jA6jsHDV0iURcqfcwny+hCW+f78hxsAQHaFT6YoR6WjIr3tZEVOtZZz
	 nIJ5+oIYs2cSMc5uiIl+114fsVnU4KSydGRjLavuRaC8R5Xf4M8I7pLl2YMpfzyBgVORtn2iLPw8
	 0aOtIrGWjKRn4NufILJUYY3Ezdu/sX9op+o2/+wTKau8l+XR+UpX7tq3NOXfGAIR07/99Uwh3NFB
	 vmfkGchcjiZd8TvSZiH9UNoyXsjRwm7vJVKfQzQVs3FLrIxHAQTj6DTerkgIXyPvzpmIqUkH/Epm
	 iMUFxvjsoJ6ZvzADAtEPlB1b+sCu1XlPPLwyoft8N8FQma3yJUgZjml44DnlHNb7XjxA+AWCYD9T
	 t1jvOThUOatc7J2jA9UDGyGXVLi8iyzCjc3sBJVSDVFMG6hy6G4KkWARHLRswbU9UHTCvCsMFUFX
	 j/k1Pj4+dtfgG5WuGWABuYQRV/tz219gHru6PL7VZNSoFiGqUPe5NmvvALM2vVqj5F7AuhpTDsc9
	 /jun4KM71uW23t1uLhGys6BEAUGEpZmZYUL9ScukykW9U00v6aD1kFZp5+OEUCzzuF44vGzQXeqP
	 TfvpMRCPlF0LbR5nr4BYTU4Oe8Sn4o8Z86fLycrTtrCIrjrNg37KoKuxrBTSKROb8azVodrVsKno
	 l3B3Y9OIqfSylVfK+tbwmRSNThjv9LDqVlN+4H5Q61EsvF1ECL8eZzTXnHz2UVFYw1jJdROIEDEl
	 RW9LJxCnw67HMLx9rhNtjl2wgbi76garqo3guSs6ohfajkfG+1XGTIycmGVwfb5tWq/MkokGBh51
	 secM+PezFUb2AYwJ+ELK+kcPOxm6AeGQl92IaCm9IRGvLdVl7cqsPcEj+RuQlUrDvM3WbU95LGao
	 SmEKK9v/duSEMvy54xjNT0ZFoiEzGsddWKVRgoCfJ+hTjFgwr7mw2p1LkDbfFhwtN/X3ULEVtbUW
	 zrGK22Hv2BGYQOD4Y8
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Aiden Ma <jiaheng.ma@foxmail.com>
To: corbet@lwn.net
Cc: brauner@kernel.org,
	sforshee@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aiden Ma <jiaheng.ma@foxmail.com>
Subject: [RESEND] doc: correcting two prefix errors in idmappings.rst
Date: Tue,  4 Mar 2025 19:54:01 +0800
X-OQ-MSGID: <20250304115401.105754-1-jiaheng.ma@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 'k' prefix to id 21000. And id `u1000` in the third
idmapping should be mapped to `k31000`, not `u31000`.

Signed-off-by: Aiden Ma <jiaheng.ma@foxmail.com>
---
 Documentation/filesystems/idmappings.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/idmappings.rst b/Documentation/filesystems/idmappings.rst
index 90b24b6..58e46f9 100644
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -63,8 +63,8 @@ what id ``k11000`` corresponds to in the second or third idmapping. The
 straightforward algorithm to use is to apply the inverse of the first idmapping,
 mapping ``k11000`` up to ``u1000``. Afterwards, we can map ``u1000`` down using
 either the second idmapping mapping or third idmapping mapping. The second
-idmapping would map ``u1000`` down to ``21000``. The third idmapping would map
-``u1000`` down to ``u31000``.
+idmapping would map ``u1000`` down to ``k21000``. The third idmapping would map
+``u1000`` down to ``k31000``.
 
 If we were given the same task for the following three idmappings::
 
-- 
2.43.0


