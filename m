Return-Path: <linux-fsdevel+bounces-72644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD3DCFF0B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 606E8300D64F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3F38A70E;
	Wed,  7 Jan 2026 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4GZnOim"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA838947A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800049; cv=none; b=Ls+G2hQnppeT7lriDgLOz0QHT4umjuEs1wA8TE3Lkkg6ndRu1OfoadlA7uWeJMt5hcMQJ+/uZCynJw67gPcZuAb2+Afm2nrpNVssBaWXGhbB6pASFRAQEayHme5GxbSzWTnngw16KuqLENqpygvUMTwqJJjvuCIqZcVcfjB0c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800049; c=relaxed/simple;
	bh=rXk3y4C8WJeOSfMI8cZ5ZlL/TCkv73ERx5NvQkCSpyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrlhNlVfE6EvdeFl2YA0a5qoVB2pPPNjHBESThpiqxJZTZLbVC/uU+5XhBbFl1e8+QNORRWHKtEuNE5MZgKeLPMAQ14TCFrOvercFcxwL5hYsPz4cnRNt8J+xLo08Vd2OSN2KS7p7Gi8LHXdIFf1lEyRIZRIvsFUsFHZGygQ/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4GZnOim; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4557f0e5e60so1412482b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800045; x=1768404845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEjVEszBS1bXBch+QTu9nax0OtrFw3AqtXa5XoSe9fA=;
        b=G4GZnOimGKYLaHQGRjcwbXlnk11Hf9ZpstIvvG+0jiRuMet2ipinn4hboqAiV/4XKU
         yZo4+HdbHWHL/gZz9FrZ95shPbqvj8ssUBjlKn3Ca3futo8WkJmJDXdA1vN9p3X2qt6A
         qi4bBIojc8Pzmcyy06LC47Hk53pQHCRdibIi0tfU/kCsHXrVqe1DzFmXUhC50GkGRWb2
         52lVIoswD4+b0GJM6x0ps+eK+B6WBo4vc7LGsU0EzzEqQkJpMoKbohZplLpxxCODZfq/
         u7KxjGCjENGGHp0bxE8yTSNFTnTaGIgTMeiQvNfNKiGvzcXhMZCTbnSakdMEPoVCchdS
         AASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800045; x=1768404845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEjVEszBS1bXBch+QTu9nax0OtrFw3AqtXa5XoSe9fA=;
        b=SKuFMj9E4CR1x1Ot6ugeUQsEOx1nmO9vrmu5hJuP0d8UhmXGfL0NGCmRRW00ZDozpC
         wSgH/1jscnvF/OApxcT/AFkLh4ewyPW1+ZoKkKJovLiWQXid7OYXdVPQdwTZMqsEE46+
         mywK/SincvVBQn/0UXwyTcgQPlU0h6TQobHtpxHfpF6d4TXr1WdTNAqRoMNUqCh2qLy/
         6TBqhYN6IBzRA7USEW0EM1P4K4MEQnEgEp8ZqfvvMsQezHtHEhm3dcs1bDmhUr5223Dd
         34RhyjCYNSaJZWGziMxxxCk7EIuXIXN6D9534nuaJNsLaddjeluj6IVaVHfDWCoqItG4
         Z6KA==
X-Forwarded-Encrypted: i=1; AJvYcCV934m1mdiNQMv0N7eSc14LvAapQsJ5EEnsy78dPLUPctOj0PnDq5euTRMs8qlZaMZEFWU+cc9qpM5bThBu@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWPWMLYH8gKGzdSenUe3IhevFGe9Dg/uj4GuRhjz1RT/SO0KS
	ECzUdkkM2e8x0n3A0YA5zEpTrsIKzduxWCAdDcgc9G5P+ZdbCuvh5xm3
X-Gm-Gg: AY/fxX6Yqe2nREHqGkXF2lHv2LGmW0E3FGuYz0nX/Rb7pIgKq64gR5SqiZjn+kIm2hg
	5dpRhViTbzEBWLc3jWYC1CLfHvwcXhgYuIf3wxMuPNwL+H5cbGRIHmbjfHdGQ9KTpjoXgKbxhOF
	PCdwKtE+IAtIHrnhR0LIzOio4ytZ737tk24kbStHWvQ2dPvHOCDs13vjLnuKqICFuxMy9utB3kH
	IQdDgCQ9oFcflf7ILpb61BmOVNequ/ERS2uBnq8oSsM3v1PRT6ucmin3Jv5wyvzTCLU5kMbphy8
	drIiO6C4DgQk3lVBUeYqMXyGcMGsiB5B3nYtN1LaHScY+K4w/XDVTl3oNhNRgbFADQZeF2iDeKz
	O93L+0s5V+yntvcWXlYFhaRNwOh7DLZ346uZfTxXXAlv+J6iKDdOa0mRyhPYxvihMV6xFBQcfZU
	MC9vKhfgsUzNvanM0vcuazJF5cd5bG0TiPGI7LydD2mgqMFTY1YYP/1U4=
X-Google-Smtp-Source: AGHT+IFX5hj+WsCZcQN0F9ui7U4tLr7OXye3gCol3kbUSaMg5lrVm0TVcSYSe8f2gPxdB0ZE4wEzIg==
X-Received: by 2002:a05:6808:c28c:b0:43f:2a62:8b79 with SMTP id 5614622812f47-45a6bd4ad18mr1041781b6e.29.1767800044921;
        Wed, 07 Jan 2026 07:34:04 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:04 -0800 (PST)
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
Subject: [PATCH V3 08/21] dax: export dax_dev_get()
Date: Wed,  7 Jan 2026 09:33:17 -0600
Message-ID: <20260107153332.64727-9-john@groves.net>
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

famfs needs to look up a dax_device by dev_t when resolving fmap
entries that reference character dax devices.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 68c45b918cff..c14b07be6a4e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -511,7 +511,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -534,6 +534,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 76f2a75f3144..2a04c3535806 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -56,6 +56,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
 #endif
+struct dax_device *dax_dev_get(dev_t devt);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-- 
2.49.0


