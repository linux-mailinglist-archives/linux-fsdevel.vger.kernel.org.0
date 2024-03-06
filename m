Return-Path: <linux-fsdevel+bounces-13673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD70872C9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 03:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAB41C21769
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 02:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFAD53F;
	Wed,  6 Mar 2024 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Sd1xb/lx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD9D51D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709691482; cv=none; b=FnEObz7YArGxtjnoYMrij0rvzhLEgWWuFdkNiX6W/h/P9bqoUgLIRT7dfbadTleJCJGiqL8dlNy+XFiJsCS1TC3X94YRQnIic5ZzB/1BM181OS2i4QmcsM/HhJLJ8eTzTbVXcYChBRAkROxycaQIK4+GbRbWKjZqwp3Iry01HlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709691482; c=relaxed/simple;
	bh=7QxPLaPJXKvedTsbmIe1O5pO0B3ttI5FE+itFDdHBBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0CVrZp/a1vhTCQvUEqyECdZS6K2lceR5DixtDb2v0z06zKNOH/QALjsZ8e+UiOV0BUUZpGPZ0KEVHcKK2ZQVAv5zjLXuOeJ5rmrswyjbTRg9bYA7hsJ+mbqacJM0zHzDWz0cOf04SHrXsgROLCA59Ia7G+cgC4No06oDAUH49c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Sd1xb/lx; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Received: from nebulosa.vulpes.eutheria.net (71-212-26-68.tukw.qwest.net [71.212.26.68])
	by endrift.com (Postfix) with ESMTPSA id C250EA0F7;
	Tue,  5 Mar 2024 18:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1709690925; bh=7QxPLaPJXKvedTsbmIe1O5pO0B3ttI5FE+itFDdHBBc=;
	h=From:To:Cc:Subject:Date:From;
	b=Sd1xb/lx5Ux38dux/DpdqBagiXHZvR5mbV2ZWeXkyt7maKqpBPJNjbMDSt4df94p4
	 lGTNylnZpKLBEElCgppDCUEezxn6A7Oq70pmRCIjLdI3Y8Dz9EIfL/Uyvu+MUdJ7qS
	 IThRWJJ/UQLLEk/5jZxdkEOseAYrnO2l0EajjCwbedV+NhE8hZJhy39zQ+8e4oX3Kd
	 kn3Uwc0lY8CZm9Fmtl50fhjCUUP6ECY5ERaJRfTf1vaeEUOHwn/6LcPEebMi5Ot2u6
	 4zRv6Gf0gNgULsHDaEn3lLBZ1a4AdT03RNCP2J1XNSAjWbqXtoMkAek2x5KhV0PUtw
	 qQLBtNAJIH/5Q==
From: Vicki Pfau <vi@endrift.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH 1/3] inotify: Fix misspelling of "writable"
Date: Tue,  5 Mar 2024 18:08:26 -0800
Message-ID: <20240306020831.1404033-1-vi@endrift.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several file system notification system headers have "writable" misspelled as
"writtable" in the comments. This patch fixes it in the inotify header.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 include/uapi/linux/inotify.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
index b3e165853d5b..d94f20e38e5d 100644
--- a/include/uapi/linux/inotify.h
+++ b/include/uapi/linux/inotify.h
@@ -30,8 +30,8 @@ struct inotify_event {
 #define IN_ACCESS		0x00000001	/* File was accessed */
 #define IN_MODIFY		0x00000002	/* File was modified */
 #define IN_ATTRIB		0x00000004	/* Metadata changed */
-#define IN_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
-#define IN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
+#define IN_CLOSE_WRITE		0x00000008	/* Writable file was closed */
+#define IN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
 #define IN_OPEN			0x00000020	/* File was opened */
 #define IN_MOVED_FROM		0x00000040	/* File was moved from X */
 #define IN_MOVED_TO		0x00000080	/* File was moved to Y */
-- 
2.44.0


