Return-Path: <linux-fsdevel+bounces-72659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78965CFEC86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 17:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650C7307A040
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BD399A70;
	Wed,  7 Jan 2026 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDPCSqem"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296739871A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800107; cv=none; b=m7nXrYI5Wu0hRZIr4HG85GQOZ70k3PRAlxa21x3Z6aWVthTHefOaro9xHHNOnBnT5nQjBUBfUYvcNvmVwepYzp2z/En2HrQC1QDFxJIWsszbsPMjO+GPO6Hr7KVvqocXViTdjU+UNGxlJi5r9b1KinpBmD1bTLg8m83DCHj7Cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800107; c=relaxed/simple;
	bh=T7kVRtDmArs/KXDA6UJCem652WSoCrheiHFH0MGwghY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo82zQUxayH8o3ONYxniCTE0yVJzD6JKso10Ef2rvvaKksBHYwhll3uyzv/Be3NJu2fGON0A6kmP0FX9GDcf7QJULMSGoUqDFl1kaMbYsgTHsvGCpfwimSEuXwfo8jNnHRqsjNJDPe80XHBncy1WN61cx+RTf/8KPC42gRnx6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDPCSqem; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45085a4ab72so1326691b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800103; x=1768404903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BslOQ1R3lDLc6puAK0BHaW8erjjx+/BdZBfKYLZomH0=;
        b=YDPCSqemylFWmNwdjKiZbbsOOgCFlGMOQ8D2s3DoBh9Ec1OJySrUIl+Cxh2KSzoIEy
         DOgBy0FkMmE6N1IRvUR54I8X81N2RaRU1D1z/Ry7dzX3XihM9cSIFbXHMktHpgoC4zBg
         qDcNJM83RQWK8owz9yVS7sCzFoOKpCJXyWwAfcf8iKhFXZ6Dx7Dyb10ObDj3zgwmFIvg
         126babvo7OwhKeAWO/Bj9M3xsT0Wnp+ziCpn5C5pNljDsUKMIdfqIPdMfCyapwnpgkl2
         WU/y0n6uqgLl5pkw/g/coF5X/EzQHlzms4XOHgOi0aNTkaM4dj/1e2c2BZRyWbMnfN7q
         0K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800103; x=1768404903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BslOQ1R3lDLc6puAK0BHaW8erjjx+/BdZBfKYLZomH0=;
        b=ikmYPSpdoyuRVWt/cncnRzhh0HtdCfJkOzPSsGwpFkPObhUCM4m0tS0HzjqqhuO+u8
         rc0OE8VWUr028i9JXrGqiGdFYNjRPNW0jcXGklTKKdTXbnHdtin3kdoqrUhtY0l/+yP9
         3ouG/PGYN0Gy/RK/yxtqaLYUGRPBjZ2Awke1nTLTGHUEAsa+A2UThajetz0hHA5RtkHk
         K7ifr2qwIoU/Ll/aqwtPr3+W+oVT2GkIMyqYGPud70TsifRaIE6+ezBlFjAfpuiQKw8H
         0bsmzs9aNGI+12QrsTLB1m6YGd8wJXrggYB/JAjO5kYcN5mN1xCETyxyixV6tLZ7i/s8
         7bmA==
X-Forwarded-Encrypted: i=1; AJvYcCVEVcCMVxLG6+c/Dn9HKAI5ruh0EXRk9yLprQXOiLdM0n2x/AEKrPbHZ8LfEQ/H9CMRCf7JYey/s5dDaYjf@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHoSQCMR+auAdCKcDqDDD9WDnbFpxDmsN9xNGnZt129sEIlmJ
	3ASetWcjDq3ZEuuDFrZniu3faJ4LX77wqIY6YVbZhs1K7d5Xf9Bwevq2
X-Gm-Gg: AY/fxX5AkOIzO4o/OaBxXsSuhQu+7afihtNRSbbVyo2jR7YOkrnkYBJqQ9TMlSF0IlH
	SnhSbIjjyV0nJ+aD9MwqTeVwIdYolJudOwXWpilGUP2fCOahwI6EzGTDl8UXKfULBC7dNaO2psa
	zGuyDkjbYzrqh+4z4IQda41zkg4ClG9X2mCj2rrsh8iyjHNYsiciytRW9FsA2gTs4b5NKkebDZt
	KIwTHXpM1+T/pVwI3J7JXa8426Bl/+pv5rKH4S0xkrgvJhUiYooBjY8mLlUNeSdJvyOxlTqcVE3
	+2vrRrB8rGxa7wRYiwJLlqoAt9RF3sFr9w9NTrAOjh0D3ZQ6eAiKRdFjsB7+0s13H9TACag8JhI
	eD3ml9BFSRVJxn9DdEZ/P0vmQe+l5aMegOkYrvwinK5sHDF8op2XuLqSrqO51g/JlhvWpn8Fzlj
	qv3K+TBUalhNiTXmFgfcTBeHlK4R/GmTA9mPRLdYnG430L
X-Google-Smtp-Source: AGHT+IFJGITn60MlSGetG+LZu+Db9CCtjDGtz1GjRDdVPE59eX1t6Y4D5yt852Xe5lWy1d4GVHK31A==
X-Received: by 2002:a05:6808:300f:b0:44d:badf:f449 with SMTP id 5614622812f47-45a6bd18773mr1110582b6e.1.1767800103393;
        Wed, 07 Jan 2026 07:35:03 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183cd4sm2415499b6e.1.2026.01.07.07.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:35:02 -0800 (PST)
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
Subject: [PATCH 0/2] ndctl: Add daxctl support for the new "famfs" mode of devdax
Date: Wed,  7 Jan 2026 09:34:57 -0600
Message-ID: <20260107153459.64821-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153244.64703-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series adds support and tests to daxctl for famfs[1]. The
famfs kernel patch series, under the same "compound cover" as this
series, adds a new 'fsdev_dax' driver for devdax. When that driver
is bound (instead of device_dax), the device is in 'famfs' mode rather
than 'devdax' mode.

References

[1] - https://famfs.org


John Groves (2):
  daxctl: Add support for famfs mode
  Add test/daxctl-famfs.sh to test famfs mode transitions:

 daxctl/device.c                | 126 ++++++++++++++--
 daxctl/json.c                  |   6 +-
 daxctl/lib/libdaxctl-private.h |   2 +
 daxctl/lib/libdaxctl.c         |  77 ++++++++++
 daxctl/lib/libdaxctl.sym       |   7 +
 daxctl/libdaxctl.h             |   3 +
 test/daxctl-famfs.sh           | 253 +++++++++++++++++++++++++++++++++
 test/meson.build               |   2 +
 8 files changed, 465 insertions(+), 11 deletions(-)
 create mode 100755 test/daxctl-famfs.sh


base-commit: 4f7a1c63b3305c97013d3c46daa6c0f76feff10d
-- 
2.49.0


