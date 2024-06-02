Return-Path: <linux-fsdevel+bounces-20729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D58D74BB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F6282281
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D986637703;
	Sun,  2 Jun 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Um0aWvdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3CA21
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717323420; cv=none; b=ogjYOAu55QBa3dTaSW8vSbofBSJhsI4WnQHNenXwfC1BxgwSOPG29BtLWpCOWU3skRZ9GIaEtDbDXJxkG5PCAZTimCDjXGi8abeRimahG+9FXPN1kASv5TthO4PaSql3sp+23+EtlQccqvfvGSlaopC5AJv082LOeiBtKHiFg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717323420; c=relaxed/simple;
	bh=yUcu5ZhMJ76iR7nE8A2EtC5tQTiifrETLT1ZqPj2Trc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv9YRthqdWauA0wHLNXjpSrUFd5cyNysevuDS2svAx6UU681AkyetKb0RWXm0dINWWp1/TBypOkLNywcNFeZ5s0Cw4985PtUlPXygkd3mDcldR1MQG/7JQFHEGCNYpolnBo8Ow2Fv9tJCDstVTpmMDURLEH4zwu0cgS3pD8Wdi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Um0aWvdI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so1078179f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717323417; x=1717928217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OKR6ACuuSUyRzCi9kmvzKqaFwdsC9dBrDR9WibPo+Q=;
        b=Um0aWvdIqs8VfI36wuEwuPr0/PzcBy+rJZd8dfP9cjj7srCz07dViz9YxYmUPhxf2T
         UbqzeSqTMtfr2FolJfaBQ1L6RF+n6xTYD4QVVdJSHi4zx/oBa2ISaWxEwejCqZ6G8rxp
         HXaBeof/iTGdJHJnBg8/jGW04o9bOyvZ7wlOzqaXzNjroFdlMum49//tstWbVmnXsEWJ
         uHiEaHo+LRaOEToeL4jAaodvEeqGTI0Oto98xusOKKKlC4SFpoIo9ul3HsqgolDRATN8
         dk+P68XSXNfuN+aVNusnr0j3Jbm1WcqUYRLF5fZFA6I5I2rtFbFoHuUaFWkv4cWE0267
         NhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717323417; x=1717928217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OKR6ACuuSUyRzCi9kmvzKqaFwdsC9dBrDR9WibPo+Q=;
        b=j9XsLZ1gveRFFEQ2qdm6OICl8taezaYdkNsvg0tnCMih+k8b48seq/E6tbSST84HPp
         R/pmgacoRnmIFH//pj7bqc4U2CaPr+1byTZvHRaAd42X89Kvr3YfxNFvXfMzBuu5L/Pn
         x6JFe0P3AcME5zUThu9TEUY5h1ovGVJBBiHxefJo0aOonnRY45X8dhB6gPiJomkH5wxb
         BubCSGGmao7MdzBzXCl3+nyPHgaQvj2KHUB+U4m0Q6459Zt5snOzgtIoXtuLWIUERLYp
         3aw6qNyg7m0PSVbfOURpiyRUrMtaWOF5+uVgyybaWDHvUPgmD6IMoWG9Cr8Cedgp7p1a
         8EiQ==
X-Gm-Message-State: AOJu0Yx7ngU/mSl83FI2AnRXjbQpQxKO1n2+ARH2dmleSgCN6tzUI7q3
	koE1tpmsee2ny7dVB5VPk4hZk9joqoaRqoZwg/BvqmWRBdlPF0B9v2hLDqXuW4w=
X-Google-Smtp-Source: AGHT+IHiajIY8OlAv+K5TPOBGfQEsw40eH9SJPmOGgbGrZD9TIDr12iJR1he85deR732ex66YnvK1A==
X-Received: by 2002:a5d:538d:0:b0:354:fcbf:f3c0 with SMTP id ffacd0b85a97d-35e0f25508emr6255048f8f.4.1717323416659;
        Sun, 02 Jun 2024 03:16:56 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-81.dynamic.mnet-online.de. [82.135.80.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04ca482sm5728149f8f.32.2024.06.02.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 03:16:56 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] readdir: Remove unused header include
Date: Sun,  2 Jun 2024 12:15:35 +0200
Message-ID: <20240602101534.348159-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit c512c6918719 ("uaccess: implement a proper
unsafe_copy_to_user() and switch filldir over to it") the header file is
no longer needed.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/readdir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 5045e32f1cb6..d6c82421902a 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -22,8 +22,6 @@
 #include <linux/compat.h>
 #include <linux/uaccess.h>
 
-#include <asm/unaligned.h>
-
 /*
  * Some filesystems were never converted to '->iterate_shared()'
  * and their directory iterators want the inode lock held for
-- 
2.45.1


