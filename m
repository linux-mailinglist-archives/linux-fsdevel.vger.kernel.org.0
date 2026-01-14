Return-Path: <linux-fsdevel+bounces-73832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A09D21658
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B1D8301D1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6B37E2F2;
	Wed, 14 Jan 2026 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LatlMkST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7937F733
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426902; cv=none; b=OpBUVRZMTTTRHLcY5XmYoiqMxlozUUgtF5xjiMqlnTEjL+fG/HXbCKaa+SnvgD/aozwbITZ1nCm/HJa0JTrtCCwiyzuR5ww9TsH3jj40fBYtjy4Elt9qHDwg4p7U0vr0vZgem8RqWsI1aI5JMESCd6Aw2U4F+Fx6Jj5prSQ0Jkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426902; c=relaxed/simple;
	bh=XuywZGj+XDpfZvHURwVbpU2ahP9/m0Z4xu0nAUB//wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyLdHLQv4qNLek/+bYTJLwTYnd2jxqzRaxVho1vGbO2q16pM6B/hq0c5GMIbd8nUBed3+6+NQ5ypOUBXywHeRbWuZu6+obpJpQqWl+326Vs0qSjqNq+7DLoHbCSG2zX7EQunbabterhyAOsxwrnQz4JfrMVj78vbXpNc6tcrbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LatlMkST; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfd65ea639so36290a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426892; x=1769031692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikg86hLweLFlugyhGYJjhkjBVnchP1h60r6PTv+Ts0E=;
        b=LatlMkSTsYu/l8/Ja0zhCxdgQWUdY82RbwgAi6ykhvIWH63St5yaK2WQx7RNvztPLG
         oUyGbTXDlMNiWUKAEh+WqCpiRj0zEYGQi+uBIiGgDJXPFDYOcKbxvJ4ioMkxBfmTnJB3
         1lbAlpaKoxzad8+wjDMyqf7w2YPLhQj6Vn1WcF3m4nr2jW8779kzpGWAzqnQwHTvTuT2
         qL1QW3qyBZiiFBjjtFkaE87JWBBHQSbtDZ4B1STythH8Axd1OGO7ST1j+pjRaefJz+ZA
         I3ArH83uTzCaIT0gu/ddzrUDEXk6J6iVluSOIR3O6jA81hEzpljJDurnOFWlYByC1S7o
         0vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426892; x=1769031692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikg86hLweLFlugyhGYJjhkjBVnchP1h60r6PTv+Ts0E=;
        b=GSxe+iTbFXyqlUpB1p1O9LzhvG6EDtBvaJ7DoEusbE232ui63I6cIUSqj5giRwGAN/
         TE4PUkXVEM5SqOGBUMDky+kueXDpne1aoWxLqmBZKLzdSwK36f8KYDd/LdO9iiJZ8che
         Ukla/7CqWgzJzKgRyP//FeWDSPu0Lou5GbUg0ECqlF/XefIdEhR3BmvNc8aKCF1tpiw1
         EnIwzjlkVPXu2EmEJVdP0CqFrvVZ7ZKUnV19CTHyVFuKYq4voqBXpCg/3iXRaPeRd4pj
         Rlc4LONciE38PGKoSFIeIl9Q94f0y4yEsL21QtOL2QuP6mvuctoA3+1I0jfLoF32/kdk
         s69A==
X-Forwarded-Encrypted: i=1; AJvYcCV47fgFW0LLkqsrnh8OYGF9EZjdJrpH8JNY1qe8dlHubVwSBtoQ/6g7A7YA+QtnbSxXN8KjxCKM//TRsaTb@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQvurIlLmWUHyamzvG88Z0fZUB9JTPHOt+1bMs3bO17PCzRGZ
	StflIwNacrc9GdHPRAQck9p3OILKAmSuj61aor3x7O4Ao8Xpxe+mFlJN
X-Gm-Gg: AY/fxX6iB7mRZPUD6DU9XfASimRqH9vt53rFu7J0ZNtN63H5H256g5oIm1yCz2S1b9v
	4DyiXN6tDYmXsJ5xB6uKAyCO5yzzpkdRt2cKpW1xEZjfsUohI9onw+3nxQGUnEu/BDCcRu0ltAC
	i+NRTg4PRFNHiYqgPk0whTyQ1lzhGBvmT8gw8HA0UDQg5wrMA9JPVc5buIESrVw/yJFyIkeDhB4
	9hSeSre0sqztngWS2G2N8me3N+QTx0RqVgMHa/+e4lNgFk60/+qJBy0NY1vOIGd1NlIcv1m/ER2
	lM/kRXfdxDsIwF/zw0iUmV2BGHm5HR9/z4As1rapv4RqKNGK+lJky6vWSK/gJXksDnfwPLqsJc0
	GSIwlxGsVHpN7xqrbsm3z+NpiK2Bq+z4D27URTcc7O0r6jk4zfCUFPK4R5CCrVM6x+HNaCcuzWE
	N3MTQJ28oGRHFqkg6yXK5h/LdXkKK3G2F6vwD+OHbIDrP5
X-Received: by 2002:a9d:3e49:0:b0:7c5:3c7d:7e67 with SMTP id 46e09a7af769-7cfc8b5155fmr2043023a34.29.1768426892219;
        Wed, 14 Jan 2026 13:41:32 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm18802373a34.26.2026.01.14.13.41.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:41:31 -0800 (PST)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 17/19] famfs_fuse: Add DAX address_space_operations with noop_dirty_folio
Date: Wed, 14 Jan 2026 15:32:04 -0600
Message-ID: <20260114213209.29453-18-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

Famfs is memory-backed; there is no place to write back to, and no
reason to mark pages dirty at all.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index ee3526175b6b..f98e358ea489 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/dax.h>
 #include <linux/iomap.h>
+#include <linux/pagemap.h>
 #include <linux/path.h>
 #include <linux/namei.h>
 #include <linux/string.h>
@@ -39,6 +40,15 @@ static const struct dax_holder_operations famfs_fuse_dax_holder_ops = {
 	.notify_failure		= famfs_dax_notify_failure,
 };
 
+/*
+ * DAX address_space_operations for famfs.
+ * famfs doesn't need dirty tracking - writes go directly to
+ * memory with no writeback required.
+ */
+static const struct address_space_operations famfs_dax_aops = {
+	.dirty_folio	= noop_dirty_folio,
+};
+
 /*****************************************************************************/
 
 /*
@@ -625,6 +635,7 @@ famfs_file_init_dax(
 		}
 		i_size_write(inode, meta->file_size);
 		inode->i_flags |= S_DAX;
+		inode->i_data.a_ops = &famfs_dax_aops;
 	}
  unlock_out:
 	inode_unlock(inode);
-- 
2.52.0


