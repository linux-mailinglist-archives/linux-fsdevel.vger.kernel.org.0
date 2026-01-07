Return-Path: <linux-fsdevel+bounces-72645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 999F0CFFC64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C3133008F09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C138A727;
	Wed,  7 Jan 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFpr9umO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7B318EE2
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800050; cv=none; b=EI3WXTqLiD7H5hexTHCUj7BKV1wd+ctL341n7HBzKLfEYTihj2ju6D8oeCKWKrEjOAuztZXPWWcnZwnQPCAYZOPLXtKHybEbsiC9rdHRl2C5RgDX0cgPvAVi1G9Oxjitz9SVrHgTJHM3XwEkMUZYRVdiWuIym1XI2xwCGdn2MYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800050; c=relaxed/simple;
	bh=G0p06p4Oj55Eoe9gPvplGLniqIrk/l49GkW6H+icHvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBZcRLYS8DQDUuoyIvNJ45kt6jJx/oD3BEZJ8rlHSAVLWXB3bmBFHIOJWFCkZhp9qvjDAeYv6XjzylzGv4mvhX593hhvWtZW2C46eF+Ek5NV8fXmsgwGmJGo1suN77ifVZEHsy/SLyvS18YLA9zCmeCU9rTl3x8XV92XOrNoi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFpr9umO; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-450c65f3510so1427092b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800048; x=1768404848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO9EJ1SzMv+Xy0KnqPrEHfvHLOumowI49Qpx0L6iCR4=;
        b=WFpr9umOXk3BBFeUe/mPboHm7D0pgGFB+1BB2X7hNWI2t+0tyMml5JDSL1v35KrOQK
         9bSl416Mg7zGl+XaNaKe6fcqQDcSooHqQrP9M8+dG4qV3eMHeOl5QplIkjCYCdYTNyBW
         c1kt6GwVqdQMiT4BFJknc1tS5BA4eEPmeaY6mYi3xq12EmvIjG1KqrVocqOmStrTmNZP
         jK//xnxq4Gj1YVGIUhUC222VfIDWmQ37s4KglsjdH324e0Rue9802EMvRR6GVwc9NXyY
         lJeWfaLK4ThnjYD00slpHxKppa56s3xA15rsp8XCWUhWmYvlyp/FOlUtqCA/oQbzAc42
         syPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800048; x=1768404848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO9EJ1SzMv+Xy0KnqPrEHfvHLOumowI49Qpx0L6iCR4=;
        b=a1Gq0Zd5INUHeK9U0nzAGJnfNIVd1MOspjmoCXFxe+QxuLeU/tvQhmjSKmY4/f5Vr1
         OizLO0nwcR47I+XEg5SFerG+DSq90zXOcjGRmvLDZUQu4NN7lQkGWcDn0yorZFzilw/3
         0MTVkcmvHA8tsrQpm7BPDSqE6AVV8HCdOEIqvHCKyWwsA8RYq/IwaY/j18+vo2l1bV/+
         +CSklCHgnTKyFFeNKK26YGchQHTSIogihR3plF7UJXmhdDRWG47TfQtOLNGeHbn8WbpJ
         6EAaXODoVXZCv/jPk6wpQ7qUuJCsySq9KpWqIdLKfhZkcTpBM//8sMjdfP33e39aHbit
         2PVA==
X-Forwarded-Encrypted: i=1; AJvYcCU7M68E+dSsVtM0/9SZTlsYrs0O5BdY5VJl/R7oKW85REg2nkLIrakSK+wo2oP+fXOiW13PYWD7gSBpsYUY@vger.kernel.org
X-Gm-Message-State: AOJu0YyhGDcmqNn+lXY7+DyFD5+6EvQYQ7XxiI4prMFwzojC3668g8YB
	b05vxK8KyZRNufjokB4Uh2jlAeHdAFEiDSTtVMIYgW45PMpY+/ZWxL89
X-Gm-Gg: AY/fxX4QFW5IVB3upW4Igr21BAKEhY/TiYwxprb3q8kctYBjOi+how9ZmqMEa3RDV1X
	tKWRfGOt5mH1l/0fz42uHuAcE2OoR63kR6fAmtuNvpKpXydmN9s/XvzqOD7jpLsCCroFsiRK3ZA
	lf7KrH35UBxkxcPzkov8T2otPDQ81ayewz8eMweOhIUPJ+QJLz6BvKvFCdb9l+RzOpJMt5FchAd
	zWFZpqhyyyi6y0sRchSaVXywqNskNYeQLgJbfN4rhMt4t4uZflWsuHMyME+HlGVVpNBnEZyiQR0
	TC+3bPJlKlln8YfYIqOizA8FBqdM1qf5KNdTMuZcuiSrthVJ2YmKQ6i9RmHKkEKf1JACS66KT+2
	u86hAYAegryE9GVufhbiazctG0TcVt2yzVKTB+AougaPlVjc9esN1ufZ9Z3jkAZRnNfCjjFVcfg
	Cq4JoDtSAnsCsXvK4/XgJUONUvd98P6rZRzOoFOpWStWw3
X-Google-Smtp-Source: AGHT+IGtCDu0G6eYH3g3wT1M6IKy3YB9HAJ3+3EJ/cXXN1DdsBvhXWe62M+fG6NKVgTW6NRYPp6OFA==
X-Received: by 2002:a05:6808:18aa:b0:450:32f0:4887 with SMTP id 5614622812f47-45a6bdfd28fmr1087090b6e.31.1767800047653;
        Wed, 07 Jan 2026 07:34:07 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:07 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 09/21] famfs_fuse: magic.h: Add famfs magic numbers
Date: Wed,  7 Jan 2026 09:33:18 -0600
Message-ID: <20260107153332.64727-10-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Famfs distinguishes between its on-media and in-memory superblocks. This
reserves the numbers, but they are only used by the user space
components of famfs.

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..712b097bf2a5 100644
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


