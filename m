Return-Path: <linux-fsdevel+bounces-53839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5CAF80C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25258541F5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032D21F91C5;
	Thu,  3 Jul 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alGk5z21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51362F85CF;
	Thu,  3 Jul 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568695; cv=none; b=TQSkAw3tzvKfqy6EmXzzrAd9wOMRUw8fJTRUJm6Jts6+r3nau5qqtL6Syhc9OM2lBcYXyS0BhiVcEFLv+H7LEA1x+vc8bqyaejncaiFWNnGkYW2Cp9GQ/31Ha5fJPDdO8kAJP9M8sjiPSzIdSGkU/oZvHL0WIi5sfRVeIAkoR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568695; c=relaxed/simple;
	bh=PqmaxnJIHXHdpAtoc4Brn2JoOI6Zdfs/rpGuWzqN4FY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsf5VreMJZj2RLbS0Cb/oPjcieTO+Bzokw90MB8lSgwgoOyNLL47+IEyCu6D8KAGoZ712cuCt1/2F+vIApAHFse+ZvFUSYRRzai71QY5BiEe7INjfMQ+KA3MTQSAQGPzmhJWBNS2vQCwBO7hvmhWn2eSJbKXr/FKheNzP1iKdKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alGk5z21; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40abe6f8f08so226686b6e.0;
        Thu, 03 Jul 2025 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568693; x=1752173493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOOgV+Jpk1CRsXiqsiDMUbyUGi7OO3TH0ZkMJhZELeU=;
        b=alGk5z21EEM14eDXdC9KFUxRvQEOygUsOc9mOuJCr+phfoUEeHnutdCGWS0kyn19Xt
         kP3MS4qW2DkjKq7tIwU5HR2PBUI6Itwmkvm9Uo6/3VAk7t4j6fmgrlkdXoxgjgtQ5mz6
         K3SI/RAEHKzBMdhgIudnD7z1hjMvGR1DUoy1qS1c8t4yDaM4n+P995/Kxf1aCtgh0AQ+
         Q2oc1RvrUh0o/UzkteuVzKoAUZ2iZ9PQ96H8d9HIGliEObXiUaysqWLJj0kWbdB0mDN4
         IZXeGGW5hZyVcWNVqnj+/hri+aR+glAgjunFviRBh3O27+bctFIUnDzLYJVlQIF0JzHr
         Eybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568693; x=1752173493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOOgV+Jpk1CRsXiqsiDMUbyUGi7OO3TH0ZkMJhZELeU=;
        b=VmvUZlaneLB82DbpGswIxys/bg8mdUXMSifehIHHpCQifCPNnbUZsFpJp1Gm+Oax2O
         VhhVT2Y64W8ipbWg0CIdIZ6wsGm0aHiPKLnjNuX+7jQxQz9eLzO1794X5OdlRXKLbnuo
         hQNTCisdVv/rbEQJJrW27Ww6AXcnCMWyYWZ1Q7UfpMxJOzkHKoiR0rQ/91dJ9v8SO/Ec
         eDR7SgqToxOAqmqsqmd0VBYEAS+EEFHdK+2939rY8fvFyo8Is7crMx2TaZ9XilO1qGgj
         l5tccX1Ff6eBpFio9luDVc+dkEsU5QRIgdNfn0FSseTVHQZKfvgHR1f/60wYz7lbvbli
         a97A==
X-Forwarded-Encrypted: i=1; AJvYcCUIr175H9GfBuSc+iziOOiactzqJh2favjvxtqCjBNmpzxMvsv80sqw2JSEQCmJFR7W58FJNVgXO90=@vger.kernel.org, AJvYcCWbD09sHJX/TcKZ9n6a8q/T3QW74aF5oYU1FB+VyUYIO8o3I1cTrAxh6nPFLko4bL+fzq6D/Z8i5Ti9K0Su@vger.kernel.org, AJvYcCWdcC38muUYNk9SPJqh9j67VRJKBT3EMC1018ZFhwnTHI39tVCXmy+jijz4qA1Cfo86OJw/zz8tyZDh@vger.kernel.org, AJvYcCWjPJfZjRfV1vvqk1rnAC8kNU2wSpePP3RZy/jKUt+0CfHf0UZNEljzHCdwIiVXsO0f747jKWKmYUMqARKOeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wPTDrFDrMNqJ2hl7ort8EUZto5A06SLg0OIQVGb8NV7mAPuZ
	bhEAKKizvDx2v/OyOYIEhM5iQ/XH/uQEUo7XNoa3YvQl2MJwHjM6lExa
X-Gm-Gg: ASbGncvAirJ9ak5OLbf4oJoY0Sxx5w2tNSNPBjJh7XHhXGyHlw9AfYfvcH0ACtsqL8m
	mf6PoFtjMeFCAdA4EGXa2iHPDLKw1C0Y0nOnoHYxy3cvPR8OOMV5pEcbjOVCtpBaD1b8Bc+1x3O
	d2TAd0WUnHn0agBn/VwaA/PTobIE86FKpyTkwyoHadUXFagUybI3/a0D4b5JxrWZUMbpbY0j3Uk
	GGQKumBLLolBw/cV+CtNjXttOgjJU6GKQclWsjwVF7JfCv/sk67ZMk0mdkPfX+ux3cQAQ0QZpVa
	HMLsRg5Y6H4kQIH1QIyeFnMf8LIP+gWWwPKUDXmrRPXoK1AnuRWWu1TCd1uteL9KGFPSDzPVCXz
	iH5xcaohfPvLMWw==
X-Google-Smtp-Source: AGHT+IF9Qqe/sVn4WtiU4VKCMm5wn96/NUIAh0VWVYCM001PD+1WVs4eZFRWpr4uPXB+DulmACrV7Q==
X-Received: by 2002:a05:6808:1887:b0:3fa:82f6:f74d with SMTP id 5614622812f47-40b88e07fa0mr6745164b6e.23.1751568692616;
        Thu, 03 Jul 2025 11:51:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.51.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:51:31 -0700 (PDT)
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
Subject: [RFC V2 16/18] famfs_fuse: Add holder_operations for dax notify_failure()
Date: Thu,  3 Jul 2025 13:50:30 -0500
Message-Id: <20250703185032.46568-17-john@groves.net>
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

If we get a notify_failure() call on a daxdev, set its error flag and
prevent further access to that device.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 1973eb10b60b..62c01d5b9d78 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -20,6 +20,26 @@
 #include "famfs_kfmap.h"
 #include "fuse_i.h"
 
+static void famfs_set_daxdev_err(
+	struct fuse_conn *fc, struct dax_device *dax_devp);
+
+static int
+famfs_dax_notify_failure(struct dax_device *dax_devp, u64 offset,
+			u64 len, int mf_flags)
+{
+	struct fuse_conn *fc = dax_holder(dax_devp);
+
+	famfs_set_daxdev_err(fc, dax_devp);
+
+	return 0;
+}
+
+static const struct dax_holder_operations famfs_fuse_dax_holder_ops = {
+	.notify_failure		= famfs_dax_notify_failure,
+};
+
+/*****************************************************************************/
+
 /*
  * famfs_teardown()
  *
@@ -164,6 +184,15 @@ famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
 		goto out;
 	}
 
+	err = fs_dax_get(daxdev->devp, fc, &famfs_fuse_dax_holder_ops);
+	if (err) {
+		up_write(&fc->famfs_devlist_sem);
+		pr_err("%s: fs_dax_get(%lld) failed\n",
+		       __func__, (u64)daxdev->devno);
+		err = -EBUSY;
+		goto out;
+	}
+
 	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
 	wmb(); /* all daxdev fields must be visible before marking it valid */
 	daxdev->valid = 1;
@@ -243,6 +272,38 @@ famfs_update_daxdev_table(
 	return 0;
 }
 
+static void
+famfs_set_daxdev_err(
+	struct fuse_conn *fc,
+	struct dax_device *dax_devp)
+{
+	int i;
+
+	/* Gotta search the list by dax_devp;
+	 * read lock because we're not adding or removing daxdev entries
+	 */
+	down_read(&fc->famfs_devlist_sem);
+	for (i = 0; i < fc->dax_devlist->nslots; i++) {
+		if (fc->dax_devlist->devlist[i].valid) {
+			struct famfs_daxdev *dd = &fc->dax_devlist->devlist[i];
+
+			if (dd->devp != dax_devp)
+				continue;
+
+			dd->error = true;
+			up_read(&fc->famfs_devlist_sem);
+
+			pr_err("%s: memory error on daxdev %s (%d)\n",
+			       __func__, dd->name, i);
+			goto done;
+		}
+	}
+	up_read(&fc->famfs_devlist_sem);
+	pr_err("%s: memory err on unrecognized daxdev\n", __func__);
+
+done:
+}
+
 /***************************************************************************/
 
 void
@@ -631,6 +692,7 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 
 		/* Is the data is in this striped extent? */
 		if (local_offset < ext_size) {
+			struct famfs_daxdev *dd;
 			u64 chunk_num       = local_offset / chunk_size;
 			u64 chunk_offset    = local_offset % chunk_size;
 			u64 stripe_num      = chunk_num / nstrips;
@@ -640,9 +702,11 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
 			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
 
-			if (!fc->dax_devlist->devlist[strip_devidx].valid) {
-				pr_err("%s: daxdev=%lld invalid\n", __func__,
-					strip_devidx);
+			dd = &fc->dax_devlist->devlist[strip_devidx];
+			if (!dd->valid || dd->error) {
+				pr_err("%s: daxdev=%lld %s\n", __func__,
+				       strip_devidx,
+				       dd->valid ? "error" : "invalid");
 				goto err_out;
 			}
 			iomap->addr    = strip_dax_ofs + strip_offset;
-- 
2.49.0


