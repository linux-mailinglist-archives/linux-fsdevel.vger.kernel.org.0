Return-Path: <linux-fsdevel+bounces-73824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4BD21622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 22:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0229130B3A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF4374197;
	Wed, 14 Jan 2026 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvgSH3Ga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48A36CE05
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426617; cv=none; b=PYsPQG6NvXzHQn61WiJrGDOZOJk5o/Q9muvs2fsasaC1EBzWD42Citxv3Rs5IgEiNlsS+s58tCz05QrMCM2PBv0FpLf/knkc2wDQtYtnJPwp6ORwktfPPeiE/WY/BBQGM84LSz0CAjIjkZg6uueFn1hpENWGTIUZ1sOv205FNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426617; c=relaxed/simple;
	bh=Ps/bSVqx4OehI5EayA5JYJNwyYnTQ9jqZuLjt15n6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8SXV47Zq+6PwGfIRshwNfMc6wYppzpS4+Yucx9oem4MojLgP6/PWlakesoe8/tB3WN204gXlemJ9mxoAgKIt1Eqmm+cC5df70GWbfmfispPe1TEhy6z7ZZy+uq84t9cguTfBbvyYyEQcW1vKjzznCTJy84kqNxQxDbMi57vD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvgSH3Ga; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c87d82bd2so157358b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426595; x=1769031395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04R2Ca8mGblkvXlxAEPOlC0zVWkPjjtROdHv+tYqk9o=;
        b=RvgSH3GaAHU1t0N1CZ5nfsOQmi7DqacwW+b69iVojbtks4RT/uFe0fvovMINkLq6OP
         KwmPKtHv5L+rm5KcAx9hK7U6PJl6C4zph04YRDo6gw7SjT+5ubbzjyKPz5MVh8BQClFp
         scDCuvzdIr+z5bJsCIu9S0Pe/UEtcFS0h7U0l0hS+gCsyRbW9RBFe2s2nDEeIMvMb/5h
         wlC1ZHiinAXy+eVrUaEPogBUpH6iif/jXrjhwMu3i4qiO16ggy3Fr8k74BgT59XNio5k
         /zO+xdiaSpAYl/EZceXXZquowJf1SJTYpr+ynLXPny+/IY6mG9adJt8zYcZpydVAEH3w
         S49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426595; x=1769031395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04R2Ca8mGblkvXlxAEPOlC0zVWkPjjtROdHv+tYqk9o=;
        b=aSfEbofi5HpwDZjJZlInFEB8mWBJ9NiYvwl0cy+rGJmVUybM+mCno9p60F08gpe45a
         QDGutAaW77+cJVzx3+RRHoe/qgUdcDjnBrV2cc+6N5mC/+eDlntPeXlGRK1E0lkwP4RC
         3kd3X8uaEsts1j8fgHgbOmhtNk59CviCXe5yq4xSZwRykd630e/i5NDX6Zz1vP2QfvFB
         peD/AHnVFjsWGOOBO4DdwBgGbbXmI0KwWyXuhRW+b9x3akhukbxDA0sJdUA2R4tnA2Vz
         YXCFTDQrZfUg+YpbfhAg2djRH0L6lPtKANXVREXg2VXMdcWVXVPYn/HEyudhRMHRlx+8
         +QNA==
X-Forwarded-Encrypted: i=1; AJvYcCWfCcndb/HQVysZAduQXpge4/zsaRl2X+o1TAce/1ZPUAo3l+CxZib7Em7ePWt8XUbFS6+X+diLM6CKk2Wo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7m0inxll2zh99Hd/pBczs4W/e6nm7lPNcFyt7v+fuBE99tASt
	Nou233zcn0FXsiZ7WgpuTHOMq3CbNj/VoqvkX3mTvsE/OaY55mkwH7mp
X-Gm-Gg: AY/fxX57HI/qRoKqHwrCatWSUyezVr3E7zzlyQbeD2cu/jgVqe9t9XkH6SqazH8xGHN
	t0GpaMKD7Gb9TnnBL7/v6+YKsDRjJQagaVhCarzNvCDXLK6c7AfaVuuLSA1Ojl9CZCKGA3i6Pkn
	SThAHv456+kAzqC+TzLGEvr+n4C4IoIoyhX17xKQlljc7gD6ygQKhrG5WZ9pYZ/nrJCcwBmEVFI
	hbdiqISwO3weLVSC02RlercWtNnHPxs9el513Y3Z77797SW9z3MScU8UM2rQuNQWIK1IFeoWpFW
	y9V4ba3hF8c+CVySZIgop3ZtSnMuhbA6s2vCiO/fVl5hOFjU490Ez6aNQukjFbaNKDQdA5tLfQy
	VsSpvMth9wV6n1wIW3G5WUGEuyHUIncPAGee7Gd4Z1k3sSiXI6Z3Q7G+IfEX3dMHaS4sBFq5m2s
	ZsbXow9NdNjyaAywEaWhklBCBdfJVsn68bj/lZTjX7wu7z
X-Received: by 2002:a05:6808:4f1f:b0:45a:5584:9c58 with SMTP id 5614622812f47-45c73d67fd3mr2620000b6e.21.1768426595172;
        Wed, 14 Jan 2026 13:36:35 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4040cba2d2asm2418156fac.5.2026.01.14.13.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:36:34 -0800 (PST)
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
Subject: [PATCH V4 08/19] dax: export dax_dev_get()
Date: Wed, 14 Jan 2026 15:31:55 -0600
Message-ID: <20260114213209.29453-9-john@groves.net>
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

famfs needs to look up a dax_device by dev_t when resolving fmap
entries that reference character dax devices.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 00c330ef437c..d097561d78db 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -513,7 +513,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -536,6 +536,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 6897c5736543..1ef9b03f9671 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
+struct dax_device *dax_dev_get(dev_t devt);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
 bool dax_synchronous(struct dax_device *dax_dev);
-- 
2.52.0


