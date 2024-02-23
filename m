Return-Path: <linux-fsdevel+bounces-12614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C375861A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46172287AFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8014C587;
	Fri, 23 Feb 2024 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvP0kNUp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55D1493AE;
	Fri, 23 Feb 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710195; cv=none; b=GNaLXzFLiAdEDIDa68fK6EMSDD7If9EONPB0bbriZCXeKeQ6UznS9vZqwbWRXAoEMKAgR8acZu1z/KhbvvDTTOabewwXLNQ6wBVn1weqajlSzZmFWxsGQhNVR/WI6hPaxwuUr+We79sVYQkgtukzT90So2rvTAIlCNuq+GD+PAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710195; c=relaxed/simple;
	bh=VoCzY5krde0vG9xzX7YuziwxGBvoU+0AQ32A7C7kBBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rc12CMDCscTPWgX+1xIacHHt/IRxMjAfBsgc0Hkn/JWbdHNrUsH9mJD3PnAT1AHgWE13pJvzY/Or562vY4kAjJR//Mu2Szgy0XdvkDNn90ZNyJfnohPppNEnDuK4pPbFl9TW0PCgZYpEzWKB61jtpPQQ1i8nemefmW9dmaOpJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvP0kNUp; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21f3a4ba205so420871fac.1;
        Fri, 23 Feb 2024 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710192; x=1709314992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jGr2qgI9ixdABJ86GK3tMFCGdZwdm8K72HznrZ7mbI=;
        b=MvP0kNUpSb14mAbo43VKxIF8NbHNaIF7GNnXnNSBwAR696nVrt8w4RqepvmK+Nu/Ry
         2PcqzUP18ZS2ogg3WAC6dRQSCXrSqvTi61o+mBfvx1HNXqPEbzFEiDFjvFymQ3xJH186
         84UVw70m9E+pTE86Fs07aMYf/eaoC2Qi+gWMWc6CKzIvd8J2onHU3xPEi3Bd2AB2XTe0
         icSmbQ9cgFQ+INpVWLomQv1yBvID3/8Q81l4MnfwaM3feGnJx9AFGXpzfRfenJvH2t6p
         NJfZKoRDuz5sjXwT9JrFo1txnkaOgREE7QBz2QvsByt3g1ldZPyBu6aWjwh1mpDmST8g
         vVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710192; x=1709314992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+jGr2qgI9ixdABJ86GK3tMFCGdZwdm8K72HznrZ7mbI=;
        b=gU5oN5N+nTR7KbUSnYLtB9SSRXx5oMCBgP92zKLItkqLOD/evqlhqfDF7N4Bta2MA3
         vVKWH4/SS2CbrEt+iYQkUIohsorA9eE1HxROON9r8PaMSfDSz8Atl5dGwwFsy9A2TaYk
         Q7wsnzEf7fcKD0n3p08QOjyU1J149M+F6zzUk277QDb9Okjntp/KP62786qAro7eTiId
         k0APv9diAx2LmTwbr4ufgpg53w3awThy6gIFZ9S6mw7+bpIu4bQSDYOZ8I/xO7IJAGb5
         2O0C5Oc7tDpm2e1k00VDMAA1FWVZJ1dj6lDMChtjnaU7ftbg/tF56H7uvBfBAXnN+LBZ
         oZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGTfwdhLium3AEZW3tiFnpZyImCp5B7JReg5WjXpp0FAVP0Trf/fb+5J39eRQ8Bzbx3v6gQgwgm48bN3y2QnKL1w8A78/OxbMbNYnveFxh/bL0ZNbHiOGO86XsEc/W3DlfKgiGr+uEFlyBorSmVNCE7evGeci4YZ7TJast/GJEzmozj+b/B9kok/S4YyKNIMRt/koAqXJXLt//XIBLxeWxYQ==
X-Gm-Message-State: AOJu0YyQI1lXqrSkglexIzLnlLtMi4lNN/vc96tiP4iVl1rvGh8VfWth
	TpIjRd96Q9gKXyGnQ5RGFYDuRZ8vDXOD/ekEVhmRZfUgTWxdNev9
X-Google-Smtp-Source: AGHT+IHXbrGyG5qkT8Cy2XG92vn+Onolbp2qVyL5iQ2JVI9EfiggCFq+5eaMS2dVqFrORwDcrGzuZA==
X-Received: by 2002:a05:6871:431a:b0:21e:6716:65c4 with SMTP id lu26-20020a056871431a00b0021e671665c4mr576037oab.26.1708710192669;
        Fri, 23 Feb 2024 09:43:12 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.43.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:12 -0800 (PST)
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
Subject: [RFC PATCH 19/20] famfs: Update MAINTAINERS file
Date: Fri, 23 Feb 2024 11:42:03 -0600
Message-Id: <451185e79c5b848d94eddaa3e778b834f7a35657.1708709155.git.john@groves.net>
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

This patch introduces famfs into the MAINTAINERS file

Signed-off-by: John Groves <john@groves.net>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 73d898383e51..e4e8bf3602bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8097,6 +8097,17 @@ F:	Documentation/networking/failover.rst
 F:	include/net/failover.h
 F:	net/core/failover.c
 
+FAMFS
+M:	John Groves <jgroves@micron.com>
+M:	John Groves <John@Groves.net>
+M:	John Groves <john@jagalactic.com>
+L:	linux-cxl@vger.kernel.org
+L:	linux-fsdevel@vger.kernel.org
+S:	Supported
+F:	Documentation/filesystems/famfs.rst
+F:	fs/famfs
+F:	include/uapi/linux/famfs_ioctl.h
+
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.43.0


