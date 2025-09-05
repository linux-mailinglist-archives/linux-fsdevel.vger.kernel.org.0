Return-Path: <linux-fsdevel+bounces-60376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABEB4641A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1663B3BF904
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A528C5D5;
	Fri,  5 Sep 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ZoKYS9GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B127A46F
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102511; cv=none; b=M1I4+8S4xODfki0IzPg5sQQuh9oyUXIA/sxr5ToaHnR3NmCyzi9czuK131U1barc23mYPl6/BBgzFBc1qtink1YcJ1T/Lc7EjOnNqaCKAJQeTcBmTDgMdLs/zdl5FxOuCqS+4RfnRH6ekbUtNQP31+O6quh0W2LCUPG3j/KMQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102511; c=relaxed/simple;
	bh=9jtlf/krizDkOIprWZoV2qhZCkuJgtwjIljwr8RMNmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clkr0+ox/KLNGS/nmW/LnLKEKvpxEMyrCuLpqOu5D/el0r/6zu7kTbiiv7kmEgYeOWgea/12Ean9+ItAXoQPffREDVYhjFIENGnzOyvif0gF+cAHsmlvndpIELDPmm9AtqS5QPK7J+xSzOzCYJmdJVn7xd/Wgdio23NH8gm2Vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ZoKYS9GW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d605c6501so26425137b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102508; x=1757707308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Pxp+PP2D9JPqoOUwSCs12Do/JSAVu31Lefgsp/HENc=;
        b=ZoKYS9GWzzmdQOnF78IM+M7Jma/i9Cc3xVC4bFc3FwhVp5Vhy/g4srSNoPUoz8ljDv
         Xadr1ke3NQ/20YGab3cg51YIbNhrj/l5zJa9O43OV3hS0BrvX2f8bZarKoJAK+kEpgGu
         9kc75dPlfWkL4iv2sLYAAdU03aoGclds6GFeQ4413/IMCYR6Z38jHwtKzCLtW/c77MdM
         3R3iD53PckW0UiGw5wakjcvrTO6icFgmbVYxjD4ApZj+qrNhYwgOwtLYp9Ty14+6EabQ
         e8s1U/QTTaE6xNKl9J49SlWUyZG6EaxyOm7+OLlKnxbZ2SC37xebAo00dxkg28fWW34b
         y2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102508; x=1757707308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Pxp+PP2D9JPqoOUwSCs12Do/JSAVu31Lefgsp/HENc=;
        b=sXxOJV4E20907Acf0P+2Z89lDPnD9j/4lVXtq8mqBKe1iflCsTwvBZucqgr/gXGJTk
         Bspvk7VDYIdX7sVFH8HWgB8mVGoU6t/nb2hc1DXI1o5oCVJqCNc9T9CGtGas1FoAiz9s
         39CGYerdlVxHlJHkemsKHIJw1Ui6/NUYppjeWYoJlRlXX/ivMfl9oOggW7MljOozhAB3
         HSwSDzHhygCU/64y938HlJzafZOrvMaExDG1o4MyXXLvBnHqkNoBle1M3sgZr5sH2MOj
         1nWAwNaLiX7oRT0m5IlQvRH9J9PIiwEED9N84K7GtplSj5XsR5IY1Dzz2TI8OXIEiEgu
         HkcA==
X-Forwarded-Encrypted: i=1; AJvYcCUzvlWyPx3L2OLKxkK0jrrvyBJ2PXIhak6B7NsoMlVPjEewF69K9k4iSxNSMOMRIR7XRQ84DyCtHndkkhUn@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWwjQVdwp1hln2Vf0Z9UJTJpyJwyW3oT1EV5vc+gmrfgiZ+EB
	IDDrx9tGLA47Wp+qHQudd6phxEGx4gY796AOfzuppDr9/HJQkp2oTmK2XhfazI1NQ5Q=
X-Gm-Gg: ASbGncuLxK+aHE5S9fiWYY9l8PH6c3SMajJhdpN05sIoEutM2skoWWX/c55wU0nrr/+
	s0+VcmKJMgSdMrkIrqHZNDY0SyCPpl6DOIprPfS6P/f1j/PerUPhMCuqR0IFAS0I2nm3lOLHhJu
	B3pIYchRM2rjkMYAmeWOmv/wRv6F1QpGb/bKKbDFOAQNDMgUxvYhbvTiF21UIxbEVBPG/IvymKQ
	PZRLlBJKbEqPwJoZJ0lmRgv8rIYq+1rV4FhsMvnPjJoXEYh9nRk/U7f/J66gAhMVA/ybdvyy9x6
	RieiVfvGD/z+ZWMmg8HUaUcJI/Vex8ByGfykj11EIV8R0xPdRlQ5RWp43SN3s8kEjkljsXpuGbT
	uyM1JIwsaJPmMom98Md7JH0uTxyXVEHSwaRH3V+ryhcDvpeXe72w=
X-Google-Smtp-Source: AGHT+IFW4FGpjYdcjvZZ0/e6e3FCzxjARdw8hXw3Pzh3K0KEgYqqFtNt66+mxG//k0E+uu5F0qQwKg==
X-Received: by 2002:a05:690c:3503:b0:720:5fbc:20c2 with SMTP id 00721157ae682-727f544457dmr1101187b3.36.1757102508358;
        Fri, 05 Sep 2025 13:01:48 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:47 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 02/20] ceph: add comments to metadata structures in buffer.h
Date: Fri,  5 Sep 2025 13:00:50 -0700
Message-ID: <20250905200108.151563-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch adds comments for struct ceph_buffer in
include/linux/ceph/buffer.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/buffer.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/buffer.h b/include/linux/ceph/buffer.h
index 11cdc7c60480..e04f216d2347 100644
--- a/include/linux/ceph/buffer.h
+++ b/include/linux/ceph/buffer.h
@@ -9,13 +9,16 @@
 #include <linux/uio.h>
 
 /*
- * a simple reference counted buffer.
- *
- * use kmalloc for smaller sizes, vmalloc for larger sizes.
+ * Reference counted buffer metadata: Simple buffer management with automatic
+ * memory allocation strategy. Uses kmalloc for smaller buffers and vmalloc
+ * for larger buffers to optimize memory usage and fragmentation.
  */
 struct ceph_buffer {
+	/* Reference counting for safe shared access */
 	struct kref kref;
+	/* Kernel vector containing buffer pointer and length */
 	struct kvec vec;
+	/* Total allocated buffer size (may be larger than vec.iov_len) */
 	size_t alloc_len;
 };
 
-- 
2.51.0


