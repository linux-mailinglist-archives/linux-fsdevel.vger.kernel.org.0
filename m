Return-Path: <linux-fsdevel+bounces-46750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D836BA94A44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45C91890CA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100718DB10;
	Mon, 21 Apr 2025 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EelSLeUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D918A6A6;
	Mon, 21 Apr 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199257; cv=none; b=DEx55raoXGgGx72qvUsIjMw7I2/Mht5+HkXeA9FQ705uFErYOQ2PgdV1peW1X6WdenNRVkJJSU0CFIF90JPqmpo4txEUudRfaNFoCPcqloMizitJOwWmYdgBwBAY8aMKM9d/530HGDvwtjlgRLNGE43TL1pYKy/gUA1NM8EdB6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199257; c=relaxed/simple;
	bh=9z/0+wP63OG5wXftLWkn27sSwdysRUwo3gRSnRSt66U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jEz1RnnrkzXt4jcUOJI4aen38F6B4o3CeFyPbGkMe0a5BAQrWNpfc0Ty5bZqJ0i5DY5UXXbqU21dDFfdpE1mpa8sFBPRr10H9jY8+6xgEhr0f3XVZcflVRfYQrR9v2+ANZvqNHgkOgMtCz1qQfJjaG4Ofgi77tWXMFo//tVUlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EelSLeUC; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7302a769534so174089a34.1;
        Sun, 20 Apr 2025 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199254; x=1745804054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHFHSP5AI7GYN3LviveRts2reQTV/UFJRypYogMzU4M=;
        b=EelSLeUCJGTHX0cAt60kTIhPcJwX5fi0AhH++YvybKQuQtgLR/VYK7oWThN3kYb9FR
         zRSo7Pf9Eix0uYfRFMO0FJyoWG2Lcifd7peEnEWLxshb//onfTrEu//cNl1tQC8Ksi6T
         Fef6zZ/lRcMnU+NX3afl1SvmjQ7q4hcTvxCCWkSLPETfEEJK151BQ605Z9QBJcGQx0zM
         YQUgF0PhxlwT+BXoq1PV3PKTs95PZd5K92Nut1zOhd+mWgMum+5Rl858sRI/joUgtl+Q
         J/STNQgdTXwc9dKHWJThgc2W6DzwC5JoR9nS5oitGVmoAPVT0uc051TCZCwpLwzhiISQ
         v8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199254; x=1745804054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jHFHSP5AI7GYN3LviveRts2reQTV/UFJRypYogMzU4M=;
        b=O200AVKTtulvWEhctxhc6vLaJQ2L3Rsal2c/CUCmBzJ4CQQgcpqoc25dzoB2xp8ia+
         xV/W21gS4aMBYFKxmzU20d7Pt0FpVNRHpCLH1p0bPsGeWH2H4vjAq1vEXt7raFpiPvjB
         9intTAeS6eFZNNZ9XywRwC+WDB/BOf2q2aLKzi0e2LUOL+BFqEtPCbsweQ2ctrzDZBtz
         Y7B7T048OyhYz+VVF44SwMuXxeFkpEc7wEKwkjM5eaizuKieavteT7SToVg32IGZTSDI
         hHWhZ/ccq4HTPzAO3kRfojG8ZRtIrB6T/mEhHcjrMkngxo2IDUP8VYT8AufV7IK1THGS
         Gi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUumZDw6DM57765jYOOT6d0GkUF0opQ7NN7oqUGhzJHs6uMuaK/I3Kpcbrrp/ZvzGU2lm/prZPApRU3qIi/pQ==@vger.kernel.org, AJvYcCVFkqOf07uSYuR1WM0sSgXqh0Of3OsMZx+g84+Z+MKI+RbmTsPLBrw7d7k9ejJ/fowHI4Dw5k9IIro=@vger.kernel.org, AJvYcCWWZb0zZIjcDvHgS/rkO4xKH5xn/6HevEU1uIPuCQd8El79ewW01kskyNrfhwcXtYaf6Nh4jFlFV9ADuphz@vger.kernel.org, AJvYcCXFgDo7l7f5eKXITi7INTTHbbSpw1YKY+8BGtvdRmBaD7OODvbxNNd+gavUWv+NreJOYJv02galTS9G@vger.kernel.org
X-Gm-Message-State: AOJu0Yziqzm2DVrLQ2xWHeMoc5n+4ai8FC50766Zh6BrRaEJhEerHI8x
	nHrfQ6q+powbNfaoXR1AGMBQHBiIZMP1lic0QOdsMWFloBY7RO9m
X-Gm-Gg: ASbGncv6gf1K5zm5R+ef36G8YSGeSBH2X/hKBTvGNs2hkAW7JE7pkBQsGVeb1Rhoooj
	Ljcxhv+9UsjSzSRNDH0aCsMupiBeIjv/POXB68Mt9R4w3OJ/gP+FkLExPbToQbPj02K9JTX4kGk
	5maX07SakbU9PnSTbJLUe0Zma0tAYjsgOEkiDTI6oMtnIBxozM8sVv9FOnzWxfWuCTnZ7CDpzxv
	tkWJYEspAzna+HIDFM+OYjq+vws32aEevrX1d4n0XoNmLPIdNxl5n8q5EGhJkUhXTvEvP1ZZSrG
	ZtQP/ad7P440Q5ZXLAy66QUru6Wh9p0AAcwn+QCoiBg62EeapKRYKr1AO548ppRYC5ipxsLnKke
	Nc2py
X-Google-Smtp-Source: AGHT+IFU3nJijIBNsm6B3bDuLSoCNQ73pwfzPnYiqQH6OAqYrzMNb3svUhszpN80Fdd0UtVEY411YA==
X-Received: by 2002:a05:6830:618d:b0:72b:946e:ccc7 with SMTP id 46e09a7af769-730060b501amr6213415a34.0.1745199254417;
        Sun, 20 Apr 2025 18:34:14 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:14 -0700 (PDT)
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
Subject: [RFC PATCH 06/19] dev_dax_iomap: (ignore!) Drop poisoned page warning in fs/dax.c
Date: Sun, 20 Apr 2025 20:33:33 -0500
Message-Id: <20250421013346.32530-7-john@groves.net>
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

This just works around a the "poisoned page" warning that will be
properly fixed in a future version of this patch set. Please ignore
for the moment.

Signed-off-by: John Groves <john@groves.net>
---
 fs/dax.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 21b47402b3dc..635937593d5e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -369,7 +369,6 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 		if (shared) {
 			dax_page_share_get(page);
 		} else {
-			WARN_ON_ONCE(page->mapping);
 			page->mapping = mapping;
 			page->index = index + i++;
 		}
-- 
2.49.0


