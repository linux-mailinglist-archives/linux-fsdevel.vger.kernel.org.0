Return-Path: <linux-fsdevel+bounces-46749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E34A94A40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792C63B05E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC756189B9C;
	Mon, 21 Apr 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4K50SGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DD18732B;
	Mon, 21 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199255; cv=none; b=QZrfRB5yWY/TizEZjmD7imsUp52w7s4Aj4yoDNaUOSEDCVrIgk+QhVrnlAGe6WZMIilobHMXaNgY3+nFC9mqNjNvQDDwttVaf+cdKh2mNmBxm2eM/R+P+d2tJryZ4LeT75/OMLkjIrgnZXo0NWsZLqzDOTSPfUlHi3/pMvYbpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199255; c=relaxed/simple;
	bh=3KazfK/QQTaTKMCPWi0YxDdEC7X6OVxJtOIOm2yyTcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieQRBJ2nTa2bf3pvIjCavuwXdho+QJXgwXgsgZpZ5ocfGVa6a2/whGRFMpna6vs4pmOtykubvOiCWhFwOoJR6hPvrQrVhJk8p7oD6ScOScfjB0wfcPbyqkw+r5WRaIclMc6bcvE3BtYkdTntsTT2GVDjCDjzanRD/UgRcLv7GDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4K50SGO; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so2070891fac.1;
        Sun, 20 Apr 2025 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199252; x=1745804052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaZvyCikUvPqtnjUjM92+A61XpmMjGb4Ba8q0a5FCxQ=;
        b=k4K50SGOagZkCVK1g+jBKel8P3tEzO0umPfFgTg66344ZszA6PzSIXYggpH69qGF6D
         /ipRt72iarDoH7/6nNQEX46ms71ZsxETMB4q/JH1csvybaUK26zFVWk4+lOakPm0Pkt3
         SbJhuS8YUjrweyls/NEPIOTNSv51XNVZg8H9yKy5FQBQ6iD0sdqqDKqIRf+5ukmgr2HY
         489p79Kt8AASTmp+WXaE8doa+GhHhSxrwHl8h0S9+YtIWWsVlxjQxth1MVcqOpAVqRGm
         A7w7yxEdf0K+GC+HcjMmphygoV/3NG0Y9ypmG8x/1gSye8wsRaRxX/I5i0MsHjtieDLu
         jLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199252; x=1745804052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PaZvyCikUvPqtnjUjM92+A61XpmMjGb4Ba8q0a5FCxQ=;
        b=wmpvGVcaB5S4vZuwaRfvxPjwEh5bgxryGkWLfO0xuVuBzOjBmht52hB3fAMEpxM9ma
         lKLRJ2IQlEfkf6tHgNPP429bp8n5C+4wvPeq5ZYvj8W50lP7Qi0Ctaiipy1yM19NcWxB
         jndx3vi4jzySRBQZbLt43xKmnBf9I518TLwGEIN9QZmIpLWaJ95otYEH5uAfVz7LIJbl
         rbzxHMW+Cr6c6wx7lqEOnLPhtl8+Bp5/877KYLH71sQnNeH9K2YuELht5bTr1x5MBLM5
         oN4AUljCJ5OEYp2r0LrccLVED2mxfn3c7dsAS0Pz3LIgPlDx1EQaECurRdHGmHQ9lKr2
         M3XA==
X-Forwarded-Encrypted: i=1; AJvYcCU1xB/b1vqXmPIk9nF+MCCDaYDxyvkkp9jhGzz9ADxvszndn88iqXHV27Lgw/x41bovvjskmoTgOig=@vger.kernel.org, AJvYcCWwMuoGso0g0UnTZXR8HePsw/Sgm9qVYrFTM5j+ojrwL2ECR0qabB1GLFeQPoiKtRgBIpOGbia+ultVu1N1@vger.kernel.org, AJvYcCX9mQ+WBjdzdxOL9j92YVFj00n81Zkys6/3SbmBU7hpEv/vLLutdLvbJgRvwOk6O5XP7MGgtoykXmKV@vger.kernel.org, AJvYcCXWW21oJd1NsVRnlTxAxXj6a7SIEADXukdOklg1E6bXBG4Pu99g90K0xFMahyMlFGwvUzvsbmMXNtDl9Sb2hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUgGZT/7BUorb357lLea38WHnupMZJ5m5VvXrLAB7fyKNxG6I
	A51advt3OjxkQeMC08PMr2TY/+V/2+muixcBcfL9Ic6ByCEth0QF
X-Gm-Gg: ASbGncuxTcZC8AbdKCwfb4kkceFbAJxEqGcfjjn7fQm0ddu8CGDsiUJ7ggPUM95qlA4
	t/KAB0L7co5b7y4owAVlgN4WfZIdEoo9/cpftSZi2Vb9173HB3yOFocVcgS/qNNo/SLrHY4MA4S
	I3T0RFmR3h/bORyDufZ18QYUixeUNdGrqgi7AOgaPUl+4/mUYFMVZBYzxNu8IRYN8WjswLebfiN
	gdpxePKReDd3Pd4lL5Z++On33M47NKzSBmhyDoA2LdYQvZUnr4Wq9BNA8KFztc8vTOlYfODcu7M
	WnjQcg+/mcB3bUY77OI0FvrX2EtuF5lqYPDNbTcu8w/x+faiVK/9FnItN56rVjfKyXDOGjClFyU
	RVTfn
X-Google-Smtp-Source: AGHT+IGCQNEZypkRNMPI57FiYqCy8iQHVYwKVOXbiWyff9YUegbi0IX622RgL2rwTfO/kYbxNmvVtg==
X-Received: by 2002:a05:6871:24ca:b0:29f:bdf0:f0f5 with SMTP id 586e51a60fabf-2d51df20f01mr6123664fac.17.1745199252117;
        Sun, 20 Apr 2025 18:34:12 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:11 -0700 (PDT)
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
Subject: [RFC PATCH 05/19] dev_dax_iomap: export dax_dev_get()
Date: Sun, 20 Apr 2025 20:33:32 -0500
Message-Id: <20250421013346.32530-6-john@groves.net>
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

famfs needs access to dev_dax_get()

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 48bab9b5f341..033fd841c2bb 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -452,7 +452,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -475,6 +475,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 86bf5922f1b0..c7bf03535b52 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 #if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)
 int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
+struct dax_device *dax_dev_get(dev_t devt);
 #endif
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
-- 
2.49.0


