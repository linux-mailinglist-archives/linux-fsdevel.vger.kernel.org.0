Return-Path: <linux-fsdevel+bounces-53831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB3AF80A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D94B16721C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EC2F5334;
	Thu,  3 Jul 2025 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQDg/Gfq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4822F5323;
	Thu,  3 Jul 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568666; cv=none; b=EmjHOOt3CGhg462W8laQbPjji2D4R7d5Y+unVoknj73lNHnyn4WZzw7mrk5zU+RkvW7FmPQW35Mst8igOxNn2EfLcq9F8+BglxDmTr195eVSJNkmKU1rp3E57LjYfV/0FLt/6O412l7oiIe13vsneyxjAQ9y7gC3/1mZKeEyPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568666; c=relaxed/simple;
	bh=kGGXBghV4lzKmeRVN+j+pfeJiQeXOVHeL7W4dyeFZvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekUuHTLeBSfYbXWPlqeZNQ/o/eerzP9oWIVHsT1P/C5KNQvMd+dJe1uf9dDhSapws8ruBlSnBnn2rqnUVxI0BP1BOAaR2QwVEIv6gOw5YChLwcCEU+32K9eqaJWrC0jdmiDNPBZ2xQ7cgnhjb2kEMc5UZE4I/I7H4iSWW4cOMBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQDg/Gfq; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-735b2699d5dso153399a34.0;
        Thu, 03 Jul 2025 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568663; x=1752173463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/+tFl2/Decgi2IQHespB0RF7ZlGK7hVUQHMC/s+Z0A=;
        b=mQDg/Gfq9zg6RN7gx9H6Y+3M3Fit6PdZhemdKA3X4Tg+++XVfYUU493ZTkG/vKQWyS
         9od+qPSbfEAS0bnHSL1fXJUPXuzq7mn/82pCFPy/Qle08DNnHP+zMEeiTPDuEXsrAbi8
         qEuq/9TFFTj/WEDy74RIYnOe1G2Mt+CLm8W8iYZc9aqQb6MYJd5IJXJoiLqrQdWTcS3o
         RbHsuhG7yuseuhRLm/RqSkpTFuC/jBR2Xx0O3JZYLZvD+Ru9o7WESHnB+60VXOHfeAfE
         l3xzeqvsOjN4S4kM/Yq3Nm9qaurXV4O66vE+P9jSA3I4ijgqbGtgDCVAcScxOnFuBjWT
         Sdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568663; x=1752173463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/+tFl2/Decgi2IQHespB0RF7ZlGK7hVUQHMC/s+Z0A=;
        b=fi/2UA1gjrR9/Nqt9M4NVGTYwHOeMD8SmzX0TrdSNFNG6pieEJEEB/MbC9B7hD4Ryo
         j6rKliVJFgEJA+mGqpxhzUj0qF8lwrgmc5/Xf+56o/wYTlm+TMxNfQuacPqLEl3imRsW
         W4YyoR6JclbgsnsG5El0T/NmPZe+h56J0vlcjnJX8t3jOLEcdZVDdzp+Y+Mdmrx4t4LJ
         8aIljJ+FyqekPVQdEwJXFsQ7X/ZWYOEONKyn8mzaKT6pXf3xMm/E92+E5znEc+fYuKWs
         57fUD6P6ufRzGOhX5dw9Y3cQN16pHtnBQ0Nq+YAvQ/2kwOiOTLDGWtMikt4fGujatZhx
         fspw==
X-Forwarded-Encrypted: i=1; AJvYcCUcM3g8h4Xz6ajfjT7fbFh6JpW/DhAzmPr3Qq5Oy8e6Gh+HIKyPrHeFirwMzZuRS1G/iwzLIyuvuec8NOnj@vger.kernel.org, AJvYcCVCzRBuIGCOkM6fWtKi5BZ4TomLtYvcm3ES1MdzEqzSNWDp9ncCp4zFsXMiqsioozKRiTHmwrmY7+/NSbWEAg==@vger.kernel.org, AJvYcCWW1ZUh/8SFl3PBh7cGL5sZME3Zxd4g9rMnoJ1P8BiE2roBvYiQOktYSmwfkhd4mDEzz/gHy27ZFhKd@vger.kernel.org, AJvYcCWoIDSQedsCvczWyDU08i2arfJBnkC6fepkfvLoX+ixjpKpc5jc5LM7Q+nZdXSsWoY/GRzr9kq0caY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+c1FQi3JN+88i5NaKIzF3lIRKO2CYnDxbC/uW9cSqVxs83If
	CTunc08mG3/6OQDa/fmhMDMjHorVEO2C5dIwJQ9wgOM3AkuunwMR9XoJ
X-Gm-Gg: ASbGncuXO226wIS6BBoiZzzxfazPOmwXp0Ii112agQNCHziLM4h+ykQeelSMSJ4uDDR
	LnxysAWXvTLEnmRC8eW11SSyQYzsktQHbost3xvCoh+F6uJDkEzQniTsDfAsIQoPojDbVUQilgk
	dyaigopSWyYvjBhOoChjRhwfk4p6nrx42dehJHX7J8ptbOD7huri73bO9ecU14wrZaK3SQsqLQg
	KtKHJrFZ/OWay0GsS1rKC6td7Xfz8jcls+qGSjWaO6LLl7E0FQ+58HIdgu7N0xXm1rGXBy4RNJY
	TaVpjQc4iZzD4m7IS6XDXpTY1mW4BnJy4UdtLE9CAF4tSSz3AaT9ITlvbQxrUYX+jfB3I9yS/5U
	R2kQPzsKqrIW25A==
X-Google-Smtp-Source: AGHT+IGO7sODaaFj8dS4msIF49YLoYQDdi+gB7SnaLJLRU0NcABvpJXyxo3DQ89xtl0K0dJU2j4aYw==
X-Received: by 2002:a05:6830:630d:b0:73a:6904:1b45 with SMTP id 46e09a7af769-73b4c9c704bmr7359023a34.8.1751568662976;
        Thu, 03 Jul 2025 11:51:02 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:01 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 08/18] famfs_fuse: Kconfig
Date: Thu,  3 Jul 2025 13:50:22 -0500
Message-Id: <20250703185032.46568-9-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add FUSE_FAMFS_DAX config parameter, to control compilation of famfs
within fuse.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e..e6d554f2a21c 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,3 +75,16 @@ config FUSE_IO_URING
 
 	  If you want to allow fuse server/client communication through io-uring,
 	  answer Y
+
+config FUSE_FAMFS_DAX
+	bool "FUSE support for fs-dax filesystems backed by devdax"
+	depends on FUSE_FS
+	default FUSE_FS
+	select DEV_DAX_IOMAP
+	help
+	  This enables the fabric-attached memory file system (famfs),
+	  which enables formatting devdax memory as a file system. Famfs
+	  is primarily intended for scale-out shared access to
+	  disaggregated memory.
+
+	  To enable famfs or other fuse/fs-dax file systems, answer Y
-- 
2.49.0


