Return-Path: <linux-fsdevel+bounces-44090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CDFA61FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2143B84EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732B2066E9;
	Fri, 14 Mar 2025 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="HI+ABt86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF982063D4;
	Fri, 14 Mar 2025 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989543; cv=none; b=AfAMFMbG0h22cV/Cl9lfJP9iYj73WbyfBwMib0402wnklDpRNWwXlICLqorhpRGnwm/Is08h2EWqzHCM0h7cxKtvvi2mGQCE2PbtDOtlaY5HpYxrXe1qbI+R6HKxvVsLkJTXIC/Srwu9amLkyJCtlwGlzKHy7TNvz1Z9dSxydGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989543; c=relaxed/simple;
	bh=XwrOaqoCSUfpN8PsnlGDN/e0dRAxKku8q5lDRHwjPyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLGe6dvNRNoENrZD9QdkRZy8QzXSAz0pk6e75mXclfQqeVd88Fm6UoIiZ+Ju9v98GGSUaH979pfENpD6TauJG1CS2inYloi55o92y7EAhqGKF5NFQ8/0nlgWYgyBl1WAS5dkCUl6FVHW0XCOOcgy6FCbfNTy4XOgXCqfRIdiFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=HI+ABt86; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZDytk2HHRz9spX;
	Fri, 14 Mar 2025 22:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741989534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkoEAcgk3bMxHoSf5ioxQmjsai/hXTvAVkfYJY/2Duk=;
	b=HI+ABt86NAoK93OaoqwnSwZQ+QPdsJnmwVc3PKac/doKcwvUBb631n5Wg0noMEyY/YDnFW
	2pbAiIJJhXQBxBGQw1mW/KcrGprDy3blo5jkal9tDbndZq5Bzayk1PF7k6A3ohuO14AYyN
	DdrfKDYGL2Lx6CFY2vlZ0PqK4IAcSQbns2ZAwoE9vAJX8qnUsY05N96mFn89kGFDYFoLj7
	xQWKg2S4tf/kbrNNYpI4AhTJSJ8aD+C/CQ8/TEdfiV8lFCU4n6EsEVRobmt1SVJ5Cv9Cui
	A414mHPip+1LtgwYzJ40zg/pHqcPAyf0/69PizZLzIYKRKb+tnBUhzkcK8SIoQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 17:57:54 -0400
Subject: [PATCH RFC 8/8] MAINTAINERS: apfs: add entry and relevant
 information
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-apfs-v1-8-ddfaa6836b5c@ethancedwards.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu
Cc: ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=XwrOaqoCSUfpN8PsnlGDN/e0dRAxKku8q5lDRHwjPyA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOVpWc0ZzbzIzcDdNbTdTKzJLeWpTV0RSWnZIdkwzCnZFcFZQQmMwV2YvWlg5MU85
 NmlPVWhZR01TNEdXVEZGbHY4NXlta1BOV2NvN1B6cjBnUXpoNVVKWkFnREY2Y0EKVE1TMG5wSGh
 rWGpDOG13MWg2UDdFd3hpU3k1TjNyMy9KT3Y4NU5jM24vdDExa1RVdDY0VVp2anZ1SDdQdmNLSw
 pOcDY3UncvVTVSM3ZPc0I2ZCt1amo5OE9HM3pkVzdmemMvY2RiZ0M5R1ZDbQo9elV2VQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZDytk2HHRz9spX

Add the APFS driver to staging/ and add myself as the maintainer.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 625f3758c880081b9466e2109b6a7b7bef7b0c91..04661fd5fcac35fc8371c9084f585409274ba244 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,6 +683,12 @@ F:	Documentation/filesystems/afs.rst
 F:	fs/afs/
 F:	include/trace/events/afs.h
 
+APFS FILESYSTEM
+M:	Ethan Carter Edwards <ethan@ethancedwards.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/apfs
+
 AGPGART DRIVER
 M:	David Airlie <airlied@redhat.com>
 L:	dri-devel@lists.freedesktop.org

-- 
2.48.1


