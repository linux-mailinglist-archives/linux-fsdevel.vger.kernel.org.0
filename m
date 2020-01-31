Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1214EBFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 12:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAaLuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 06:50:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728423AbgAaLuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580471419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2WGviQLsH6AvMNQjdMyzX3t1BULCm9mhpUqub5Zuv+E=;
        b=faizN3swDaIaPLlz4ejrVKZ26IXZF3OhnJ+4valxzC9X5IA6ldOTb76w0lxI70l52SFslX
        EtbOaVsseV2ltc0bAHdrL3VhMGzdxoR1BdyCMvtaEilsW4Cn24OeYaBbajDF7nxUA6nn/d
        2if6USN6oFkqMBpLm4g4/ztn4xtY/WE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-ap7XyLcGPnOlinU_8z2HKw-1; Fri, 31 Jan 2020 06:50:15 -0500
X-MC-Unique: ap7XyLcGPnOlinU_8z2HKw-1
Received: by mail-wr1-f71.google.com with SMTP id k18so3267988wrw.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 03:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WGviQLsH6AvMNQjdMyzX3t1BULCm9mhpUqub5Zuv+E=;
        b=nnScw5/hNRSTIyz53AfCJ60IvUUAhmoXOkBSFn4Vv+hTkRPQXL2cGwNcEkUewJ7Xc6
         hxPWF89HPE27TkN3fk+NzgETV/KZB+0tb+wCVFvaoGDN9HQOGL+xMsCHF6dh7QxTZ4a0
         SllGNacaCSlqKPa7lzrELRcZbWF3AUk1F5/LP59oced3WIc7VKMDE2Gi9nX5xG9J6Di6
         ZWMxlr2TSoWh9/PzlFFvYI3bA7eWXag0YLkY95//HLX0hHs15vlnQI5PcTJrS7vGprOP
         KOjuZF0FzCnMjXBZYvz0Fkdo+CGoM1LC8UdM9tTM3KmCu3jkR6JSP5oTNiQ8sebVDbdy
         6Jxw==
X-Gm-Message-State: APjAAAWcQaeWQ0z36wQ8cLeS/TXB21DLIL6j63a7V+HbnbJejys8/lyb
        PTWhKC0xgiyiaf26ZyGtOVAZI+TdXt+8PVJumVHNFnZ/otSiYJkGWQ18C8HF84+PuLFHGyvtCWE
        aNe4lByPMHeadpOwMtfMl/RhJeQ==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr12489960wrt.229.1580471414691;
        Fri, 31 Jan 2020 03:50:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpyFnDsYUD/UFMSZ5RGBKK5QG7dbAHqvgHv8woAFzPIbBp14lwxTvhrqmj9sRgsB5dMvp6nw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr12489935wrt.229.1580471414456;
        Fri, 31 Jan 2020 03:50:14 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (84-236-74-45.pool.digikabel.hu. [84.236.74.45])
        by smtp.gmail.com with ESMTPSA id s1sm2746622wro.66.2020.01.31.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 03:50:13 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-unionfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH 1/4] ovl: restructure dentry revalidation
Date:   Fri, 31 Jan 2020 12:50:01 +0100
Message-Id: <20200131115004.17410-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200131115004.17410-1-mszeredi@redhat.com>
References: <20200131115004.17410-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a common loop for plain and weak revalidation.  This will aid doing
revalidation on upper layer.

This patch doesn't change behavior.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/super.c | 51 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 319fe0d355b0..852a1816fea1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -113,47 +113,48 @@ static struct dentry *ovl_d_real(struct dentry *dentry,
 	return dentry;
 }
 
-static int ovl_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+static int ovl_revalidate_real(struct dentry *d, unsigned int flags, bool weak)
 {
-	struct ovl_entry *oe = dentry->d_fsdata;
-	unsigned int i;
 	int ret = 1;
 
-	for (i = 0; i < oe->numlower; i++) {
-		struct dentry *d = oe->lowerstack[i].dentry;
-
-		if (d->d_flags & DCACHE_OP_REVALIDATE) {
-			ret = d->d_op->d_revalidate(d, flags);
-			if (ret < 0)
-				return ret;
-			if (!ret) {
-				if (!(flags & LOOKUP_RCU))
-					d_invalidate(d);
-				return -ESTALE;
-			}
+	if (weak) {
+		if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE)
+			ret =  d->d_op->d_weak_revalidate(d, flags);
+	} else if (d->d_flags & DCACHE_OP_REVALIDATE) {
+		ret = d->d_op->d_revalidate(d, flags);
+		if (!ret) {
+			if (!(flags & LOOKUP_RCU))
+				d_invalidate(d);
+			ret = -ESTALE;
 		}
 	}
-	return 1;
+	return ret;
 }
 
-static int ovl_dentry_weak_revalidate(struct dentry *dentry, unsigned int flags)
+static int ovl_dentry_revalidate_common(struct dentry *dentry,
+					unsigned int flags, bool weak)
 {
 	struct ovl_entry *oe = dentry->d_fsdata;
 	unsigned int i;
 	int ret = 1;
 
-	for (i = 0; i < oe->numlower; i++) {
-		struct dentry *d = oe->lowerstack[i].dentry;
-
-		if (d->d_flags & DCACHE_OP_WEAK_REVALIDATE) {
-			ret = d->d_op->d_weak_revalidate(d, flags);
-			if (ret <= 0)
-				break;
-		}
+	for (i = 0; ret > 0 && i < oe->numlower; i++) {
+		ret = ovl_revalidate_real(oe->lowerstack[i].dentry, flags,
+					  weak);
 	}
 	return ret;
 }
 
+static int ovl_dentry_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return ovl_dentry_revalidate_common(dentry, flags, false);
+}
+
+static int ovl_dentry_weak_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	return ovl_dentry_revalidate_common(dentry, flags, true);
+}
+
 static const struct dentry_operations ovl_dentry_operations = {
 	.d_release = ovl_dentry_release,
 	.d_real = ovl_d_real,
-- 
2.21.1

