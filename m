Return-Path: <linux-fsdevel+bounces-72643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E7CFFE86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 21:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04A3C30C80CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325D389460;
	Wed,  7 Jan 2026 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJhZzofs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCDE318EE2
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800045; cv=none; b=eRVshbiXvQNtZWOBeet8Sn2Yu+OC1VZWLkykTR55ugDn9olQhKRoMMfEp5ZF66+FYww1VbUVg95vc16vAVwySJMRSa5gS000nrY7Rtd13echBBUI2S/Uvbx2u4RJGgjKDvYCWatEBNJeQP2rnNzH3XBEx2a+J+A7TXNKbCVX4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800045; c=relaxed/simple;
	bh=PyiR4akbn2AeaAQOQjDM80GGb6TmVA/W+ehpX5bfLv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5bX1kUwsk1NCocQgLvDhDGctHkYRDdVOWmyi8tfc3asT3v++G6JHSxMXf3qSrlaMvM9tczzGHRydlwsGYJ+wuAeClx3ojEAcXj97VZ0bLGzowS3PhJqxeaIapo/kcV2ND2xOu4SFYvawpY4D7oLbRwVggI1RXrh2tEz0Y50R+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJhZzofs; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-459993ff4fcso917043b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800042; x=1768404842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU7mq0TXsreClp5X76nq6lsunavYv2TLFlf9O5dybH4=;
        b=ZJhZzofsdnRTqpnyYlsDKwYBdEOS0/pCw8mia1ef9vH+uS06XmJlIPH9JpZQgCs3Kt
         ihKbx8+lT3CenybuDOeJD6Az1nsGSSNadf0WQcFok1FPFTjl+nRXr+gWYtJzOPJ3s/KT
         UmryE8hYvgNMo0q8LYR7SHGOcadrOPeWAo6JPJ5DKJlsvw5oXzP+GF/Zf+htc9TDn0sg
         LFvzrDGg2mfzMm0TyQxJnfv9Wnw2/J0qVg/A9b4v9LH6w708jzN5EzZLxbEUTnkqg3bs
         pncLMUaGjHDH9o8bqsMWs/mKZL0e+9hjzRn2l0UmWQbM7jbwSI8rtapRTsKqfSBrdb9L
         h42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800042; x=1768404842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rU7mq0TXsreClp5X76nq6lsunavYv2TLFlf9O5dybH4=;
        b=lNGfjyl3fAA1k+Q513YPj4gGCZjJhkMuRBk5au4BPSLwCNQGI7F/GZN/agRQ/9lz4K
         B+NLbfhjiX9X+iN7cj4F82RkH3DpNJNyiZ9ZqxR0kWWSH2c86mISd5gXm4zwah78cy3V
         8+jhDKThxQEhNo1VM/ZV8hgY0Db+VJDhwXXPVEt3+VkDcM6Vjy/QGwFyK0cF+L9S2D6I
         G/UNTg8izIA2pWtwpZk5uqdJe+Z5ZfCvl7Rmngztvl+gdRcKjgSctkQVDn/lwY5WsREk
         YuvQxMMNOQtDIo3zdwnv905Pla4h52jnd/xzrBFfo9hq0ds59bWFfryM9MMFr1tdncVB
         kpnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXZn0r+F0FF8slvpvpM3Olsw8tLdXB5PCPt1FSnHEck/2/R1AMM9FHNRmI39YF/9jietb1lCm1cUSgVz+r@vger.kernel.org
X-Gm-Message-State: AOJu0YzqT9fdwkWc0VfNEs9kKtOL8ZFpFpnjZO+ahyX+YDPRVg5oGzBx
	7z1LRvlaRgQ84+JY5Hgy8zwFYX32Mp+OFGynHXCWcrZrKkgOGvvkZpgE
X-Gm-Gg: AY/fxX667x5JxkZYk2C9rPCaVZnRU82Sa3vRRUP32Vxm+GYfKlJnTYb1K+60iNXJWGg
	oKknhAgv3Qm+AGvpo++TvBwC+Cq1BFbydKNZv6XbY9MNu0YHDmnYSoUzxoODnlPejhcyr1yZRwd
	8k9ltgvwpwRRNuHl7nXjr/bF9kL6/NuFeZNqb6GCEcvssio4gX99XcTBBm9FBTwoqJZYQiLKjbE
	cZLsXXjzOW9SEijFvq+lJDaya8q8PSDmzSDir1TTQ0QQMgxrLiqsavhxA9D8SlCFpknakh3yDoq
	IXauzNp7xh9cZlEAyny1kmEYCpLhJtQEiy+H14mn9OyjBuW8PlAUDg8b3eQuV+kCtosDQ1Ki2dp
	ndu/UobhYIOTrbXYFsSj+fEFpLeKzJ0QiNOsu68LbKu/o2WXRgkiobNHUf7hr8Ey+n7GeTtHOEe
	/LXJWyhkOfujvIVY3RzgW0EVMVU1+RGhnNa3kNuxeyLfwzYPI5RR06oZA=
X-Google-Smtp-Source: AGHT+IGGuPhuNMGxMH3hMywT/xZMd9I63HO5XzGofyUeNCfHY8A9ec2ffaSkWkYNbPyHpjuffbFtfA==
X-Received: by 2002:a05:6808:1188:b0:455:7da6:44d5 with SMTP id 5614622812f47-45a6bdaf691mr1055246b6e.27.1767800041948;
        Wed, 07 Jan 2026 07:34:01 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:01 -0800 (PST)
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
Subject: [PATCH V3 07/21] dax: prevent driver unbind while filesystem holds device
Date: Wed,  7 Jan 2026 09:33:16 -0600
Message-ID: <20260107153332.64727-8-john@groves.net>
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

From: John Groves <John@Groves.net>

Add custom bind/unbind sysfs attributes for the dax bus that check
whether a filesystem has registered as a holder (via fs_dax_get())
before allowing driver unbind.

When a filesystem like famfs mounts on a dax device, it registers
itself as the holder via dax_holder_ops. Previously, there was no
mechanism to prevent driver unbind while the filesystem was mounted,
which could cause some havoc.

The new unbind_store() checks dax_holder() and returns -EBUSY if
a holder is registered, giving userspace proper feedback that the
device is in use.

To use our custom bind/unbind handlers instead of the default ones,
set suppress_bind_attrs=true on all dax drivers during registration.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 6e0e28116edc..ed453442739d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -151,9 +151,61 @@ static ssize_t remove_id_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(remove_id);
 
+static const struct bus_type dax_bus_type;
+
+/*
+ * Custom bind/unbind handlers for dax bus.
+ * The unbind handler checks if a filesystem holds the dax device and
+ * returns -EBUSY if so, preventing driver unbind while in use.
+ */
+static ssize_t unbind_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	struct device *dev;
+	int rc = -ENODEV;
+
+	dev = bus_find_device_by_name(&dax_bus_type, NULL, buf);
+	if (dev && dev->driver == drv) {
+		struct dev_dax *dev_dax = to_dev_dax(dev);
+
+		if (dax_holder(dev_dax->dax_dev)) {
+			dev_dbg(dev,
+				"%s: blocking unbind due to active holder\n",
+				__func__);
+			rc = -EBUSY;
+			goto out;
+		}
+		device_release_driver(dev);
+		rc = count;
+	}
+out:
+	put_device(dev);
+	return rc;
+}
+static DRIVER_ATTR_WO(unbind);
+
+static ssize_t bind_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	struct device *dev;
+	int rc = -ENODEV;
+
+	dev = bus_find_device_by_name(&dax_bus_type, NULL, buf);
+	if (dev) {
+		rc = device_driver_attach(drv, dev);
+		if (!rc)
+			rc = count;
+	}
+	put_device(dev);
+	return rc;
+}
+static DRIVER_ATTR_WO(bind);
+
 static struct attribute *dax_drv_attrs[] = {
 	&driver_attr_new_id.attr,
 	&driver_attr_remove_id.attr,
+	&driver_attr_bind.attr,
+	&driver_attr_unbind.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(dax_drv);
@@ -1591,6 +1643,7 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	drv->name = mod_name;
 	drv->mod_name = mod_name;
 	drv->bus = &dax_bus_type;
+	drv->suppress_bind_attrs = true;
 
 	return driver_register(drv);
 }
-- 
2.49.0


