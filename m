Return-Path: <linux-fsdevel+bounces-46751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E899A94A48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B1E16FAAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580F18FDAA;
	Mon, 21 Apr 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaPJlKw4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A928190468;
	Mon, 21 Apr 2025 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199260; cv=none; b=UJy+CspAphMChAIjDYU4AgUg8d6GkzKDLJA74KuDvururQuhYCPdPp2rwECLSsEoAKO0CibcoJSzqMVNsDoDyhPMRTuhogWZo3MWJt3ecNs8iPJ9mp7fC0tAZTzuYvVW0BoEMjG2qp6uCm7DLF4ohO+OoyWqYYbWjRwQuoqtaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199260; c=relaxed/simple;
	bh=i2RCOjAti+UF5LQ1PHdINLhvfnaWKUaVeHHuyTJYyzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFO49KbGX4cRzXklJjH80bARzYfMfXn1vroolYxLi8Q0tgev+sJ/QqOzXZlL3e56ndmmcwsW4i0ojYNoE5fLJgax8aNXCFXIylpQAWXENJfjD2NlhZgd5EhO4Z+DgWz0R/dgLV+JJxsYCVLoxAf+Xom47NvfmX7UYGQnnGQvaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaPJlKw4; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c873231e7bso2209059fac.3;
        Sun, 20 Apr 2025 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199257; x=1745804057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2xZpjaui5XzSxxh0Gj0eCk++fJOkriDnBX6FJshI1g=;
        b=GaPJlKw4oOBmhMwXK/KDuouvINdt9HEgtLeeLE6wyWA88ObauK6h6b8ci11MdOAhMC
         0ODtNp85v68Vac4WOfoh8wddkXLaQRtDbnkQEeTufdg4m65203N39Q3s4D5FPsVnfklG
         ic2RXnQpYjw8wqRnoB6r3khzhN0onCDn/nwza1TTJmyN85NiFULVveLLfAzGjPDCSJsG
         4zWs9E8lGa9e1Ckk3vgb7q7g2684OVaIzsCnG3YjGowPE7b6XTfn4MQKhhW6GlIt3eFg
         4xXMAJoaJhqHsHvA8BNSPY863bmuw8EDl+LUXPGiy/jAJlNxOxLCUmVj8H3qVH14Dnka
         vCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199257; x=1745804057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2xZpjaui5XzSxxh0Gj0eCk++fJOkriDnBX6FJshI1g=;
        b=jFjMquyzxN7t3o2d54dyN04PeyqyBeRaV4Vv+eteYZ46+p0kjeTYaFiMzmOKClVK1B
         dEbs4cJOrylKd4dSvFPUC5aVFjywXtmHFu89RQLWdoFwap6Ku00GyChartPg6z2i/Xau
         +Rbrxy0LCsEt4EI93CFXLmK/YnywEwc/u72Jti5SfCFp2ttnNaVZy1KrY9hibUidexym
         ZgY3HlLOR+WjkEBGOa7WOU6mo9MJupf+Rrhbewt1z37DwU1ip0ZFx2ujKXVEVM+VySbu
         u71lQeo/gnGKJnRoq1FP1eGEhmITXD3Q5MJW6WavrNew7CqGPc2GpiooktDCUATGWD91
         B3ig==
X-Forwarded-Encrypted: i=1; AJvYcCU75sESvL2SHq5ab4F/l6B6McNLsmyMkBValUB5CTo3prCUq9d/DhnOhTr23XbW5E0OfD5JshirURg=@vger.kernel.org, AJvYcCUGLHnnDx6hq/2TA3MzY6O7uwhVllVunkprXtXd/ZUyv2kR4gOOGRHwIGoegYsnHy7DZaz1zsty5TljsVh7/Q==@vger.kernel.org, AJvYcCUTJNMrmoZGiWt2VVVYeCf615Y7H/o9uosw4F6/IjeuRn300RwI+VcWcxvlWM3hS6YFVsOOOWqJ3Ca9UpOy@vger.kernel.org, AJvYcCVP5icK94qJVhuR6otovHM3M76CPL6pYQWjpHxUwZKO2MT6OMjhm1WCc9B/DkrwjrQnbbtmDKkrIJOe@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfcRVM7T941CO4jRz7xSbfturnSSAo57Dyjdh+lzA4Z1ZlZC9
	YRYAL8VPW5Zk2OFn9ZBGcycL/SU1F9IYPVzmB7eCnuRhm3kPq+ga
X-Gm-Gg: ASbGncssIf4IRF2kiCOXPjp5/I7Tu5e8NSYHujRqfOUhOlXgwdfhtbdakI/2oaGP0lV
	XYPZFlfG0ixGlOfRaSCjUnIj5KGvBwSpDr4hLUPdhh8uswFTx3+QbO6Gzy4uP9aIiI4iDiJvXT9
	tcGA484a4Pmc8E+zXK4Tz7Tq5hh1n4G2iRFd9KwQyAsKzsXQleXKhp00fOKKQKpvu1fr4NAQ5HE
	jqGEZ+e1J9a0vRmFonb/fh7pDgc1Fa11lvpLUl1fEsbAlnEIDa4sDwIbsqXb5aq1doCQQn4AehB
	l/XqnYLn8e7mZ9EV2KRLk4JG5cH2eLlIJJjAtHoZSfgrZiJvWLV+iaxyDznf0VFnHucnmg==
X-Google-Smtp-Source: AGHT+IHCLVWvYpObY4uNOR1oTBCfkL9tkIi0WbVuxLpCH24LCz6hBnpqZN4tzVwpynAzf1wjqnSRrg==
X-Received: by 2002:a05:6871:bc8a:b0:2d5:6c97:8f92 with SMTP id 586e51a60fabf-2d56c97cb4cmr2290882fac.14.1745199257157;
        Sun, 20 Apr 2025 18:34:17 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:16 -0700 (PDT)
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
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
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
Subject: [RFC PATCH 07/19] famfs_fuse: magic.h: Add famfs magic numbers
Date: Sun, 20 Apr 2025 20:33:34 -0500
Message-Id: <20250421013346.32530-8-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Famfs distinguishes between its on-media and in-memory superblocks

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e..ee497665d8d7 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,8 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define FAMFS_SUPER_MAGIC	0x87b282ff
+#define FAMFS_STATFS_MAGIC      0x87b282fd
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.49.0


