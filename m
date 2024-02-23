Return-Path: <linux-fsdevel+bounces-12601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921E8861A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460B11F275A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92B513792F;
	Fri, 23 Feb 2024 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUxcLdcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932BB13F010;
	Fri, 23 Feb 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710158; cv=none; b=ockawiUsHzHbR6OC5qo12ojYc19VfvryNrfwFEz9Kd2tP8hYbmDB/2M+uJLOIjM7nCqa/YEsL2Fb3IESDxCJX6Ux++Gz0c86WzQfxBORlm9nTcz9RlLQwOYGTSg8xgcoTd9kvUjNsyA8Xn2NjNNwBOiIf6Pwjb6R2VGa8X2wlIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710158; c=relaxed/simple;
	bh=B2obSwDEVHBkcnZehtnKyWZ0YBP4Jo3Z+lXXRsHPDaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EfHJCh+lwPXeMVgwTwbH4PDXba15aklG1SO2zWgL6KruxGsC1Jl85m6x6TIXeaRIhxp8D+sXJyuDuGLT+midrmTagKnqpdOox0/r+B+JX/q2s8oDpJXVXiIk3EFwMeOR1mFcSWEe6vq0kwWtpoNfvkmEDNQajrUngo2LJBznHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUxcLdcb; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-204235d0913so761133fac.1;
        Fri, 23 Feb 2024 09:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710154; x=1709314954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFTut3+4qkGhS8AYHqbTNfHoA7qF2QMx6EtGEpLVCik=;
        b=eUxcLdcbAegkQyfGlz1MY8amd3BF5iXItKpIK4QAJROOvCCRmvpaab9mhd2mBGKrTd
         r3sdqZLz9rSiel3kYzYRW17rBzS1FQ2OaTJOpCrmnuLPj0crUbVjMi1J1tJo5TXWj+EH
         uaAIBGCuaAcE9G+dBebjZHn3SR7wxUTUOtQ2lLOAPtRh+26ixRoezc3gXBvt9/e/EGBU
         uOK3nDzHqVGbK9P+q5+ICC91/UrX5iZs61M05DIVeDDiz1XhxFkprHONOsNs+naI+nqo
         y4k0NtsFdcZB/iz8asCrTbDzCELR1lh6Uv4VWYQuURMf2byUnTaLhJDJVPyQnYFJy72E
         7V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710154; x=1709314954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFTut3+4qkGhS8AYHqbTNfHoA7qF2QMx6EtGEpLVCik=;
        b=eF334JAaMimfrFteYOTlseO6cu4XkUYcRmk9HENcGRYV10vluOeYJ7xJFvuXlZ8xuj
         18E5x8rnbK6H3ewRPLLDJRUyjamyMRgBpvmuNH69SGJSyc27GudHnnQmO1UcILV832Q8
         ZDqQRm5sslA3h5NzcZ+w0vbJpOe/n2aiKXilVxd8E8ZmUKZXtvWR9CVh9+5qyk95mFcm
         n15nsbxcKfOOHqYFrNeQDhVROhLzO/ZchDbAqIe9fxHuw4SM5o3Aj3iWSch2xQeujS+9
         7aXhNp2c4JV27ZIf8E9UmgwDEE5g1k/rH5rIOQD3oHyEhzFztFcTT3PSHGADcGGJvGkv
         vGew==
X-Forwarded-Encrypted: i=1; AJvYcCVY1U5MI0knWJRBoL7ghjBiuaNLfqRFD7Vh/5kc0KkgJJG/buHgMRrG5eImBWCnPZexyGoFN0guNpX4PbKnHz6P/Yy3+Qkc6mY9mtkGSsKoHSj+pmKXyc5my97OaQTwxk6tYycmoT40HyK/ygacVMhlE7ngFyYsRGAGMS1LxJCiOxO0Ml/4ZnKXP3QOcuDRN0/lZ6F+1+0oy6Tom4ja1KNkzw==
X-Gm-Message-State: AOJu0Yy21zHEeFq2iv5KrkLPgpoq1d/ng0bD1kfez4YlKHj31jfCetrH
	GvvTx/tfuD9/rxQMwVbQTP+y1WX9Isgv51kcTKBAHUwUAZfHMS94
X-Google-Smtp-Source: AGHT+IHKTLvZO2eArKSdPtAv4KEnKXuwuYYaVhAXebKDRq6B4BATf8gx4jBDt1zV4RE8roWGKtQyow==
X-Received: by 2002:a05:6870:f6a1:b0:21e:9b99:53d8 with SMTP id el33-20020a056870f6a100b0021e9b9953d8mr561935oab.22.1708710154758;
        Fri, 23 Feb 2024 09:42:34 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:34 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 06/20] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel build parameter
Date: Fri, 23 Feb 2024 11:41:50 -0600
Message-Id: <13365680ad42ba718c36b90165c56c3db43e8fdf.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the CONFIG_DEV_DAX_IOMAP kernel config parameter to control building
of the iomap functionality to support fsdax on devdax.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index a88744244149..b1ebcc77120b 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -78,4 +78,10 @@ config DEV_DAX_KMEM
 
 	  Say N if unsure.
 
+config DEV_DAX_IOMAP
+       depends on DEV_DAX && DAX
+       def_bool y
+       help
+         Support iomap mapping of devdax devices (for FS-DAX file
+         systems that reside on character /dev/dax devices)
 endif
-- 
2.43.0


