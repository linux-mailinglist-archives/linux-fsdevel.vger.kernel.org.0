Return-Path: <linux-fsdevel+bounces-70018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DBC8E649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3014E88BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242D5239581;
	Thu, 27 Nov 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECx58Eh5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197C2144C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249333; cv=none; b=S9K0CXte53wL2oQTq4EYGxZlUK7vuIPrl3CPedhg6XkAD39DVriZhXPJINVmyNLbCnKlKfCR4dyD+nd1C15RZ7JWF2bV4gclr+ZU2dgvfnCeiQpZHHczQr4H1cqu8Ox4x891jKG3EBMkHGbusyjoeZ4IMqNcE6aMDk4yDuHo5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249333; c=relaxed/simple;
	bh=NhxLz/AEP33wGpx1J5GIWfydpq2C0Alpu/x1FSI4C9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TAV858mj1h53QRctzw6Wb/bH42r+ruIwjmq18V0sUl3ZoADfrGFZiHs0fPkUIfKgPumL2syij50DdPRr0NcuoiVl+pM0XIemfNSlqkJuhcvPBq7F9/RiV7yHIguqqqu2Jv7h+oAsUFSThHXqOtA1TLWbs+pcJSQWng/jIOggso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECx58Eh5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7291af7190so134888566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764249330; x=1764854130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tRUSB+8z0GMLMvxEZa0ALdOwVMKFqCZ7bv5e3MQ2iRw=;
        b=ECx58Eh5wtDKUS7q3DweN0tKtuPYe0aieOwsz5hOIYSiSfqW63xq3owaTsZG6tLYcs
         XY+hQko94evawkQ+N8mfCLpPggBC/efE/pMGwhfdkAVwp8dPC/JVJveTq6f+4I76d5ab
         x4PQb4fpGdPv5GEDRbxCHHJ9mIAoZ7zugSZTbfWm944TXQVxv1PC8uHRiHMf8uj2dz54
         p0r+6Nmw8sPpS+HX5H9KmquETJCoN/GS8auhcOhbG4V2txYFbda+mG/27ra63Z8Zbr9y
         vWgT4nwEpM3s2ijRQtp/OKaGb8/Gfg+64XwsNW9UJD5EXmAhE3p/+BdzDXw/8XLCty+b
         uWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764249330; x=1764854130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRUSB+8z0GMLMvxEZa0ALdOwVMKFqCZ7bv5e3MQ2iRw=;
        b=R9JLZf+0ExB6y26IWQNtOW7xoHcRMh4+a7Of+dQHwRUIoLyPlnBzAat0y/sD5d59Qx
         L+HGitJ9NSHOPQoDDra3zJ7EHcGFaQoOu5RxPmpLKU7YFEmeaoJQDxnfywSn7t9UTBjV
         SfmoPfhqHjkKG0SM6IOc0B70Oo/i9oHWyGMFmBRn+mA6+PaRT6RrF8Ok3dEevL5JThJR
         yCXMMRcnl2C0kim7GkH+fLOAc3/2yOTIM7fkDJe16klW+JmjAIQR+P/oO4CC0QFgh8Bg
         LH8TPsZGY696E1e5kwwj2JtWOo/OhJBN88x3m2JsHsJnSKT1OROeAQ2HZCkQzd62qXyC
         j2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW87QzlsWP+Zsg8rbLAPDMaZ5j4LcMDMmny9gy0OMaGM/fKkl/TX+zEveRuecvizKpBSq+kj9ZpHBOcQ47@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsJ2hiLJ9TQ4zpz5GXDsg9dY2mASf4bqP9QB4c0H/RhBHBR7+
	yLhB2c3ziJ4tVLdBhguxoJrgBWHaBvYU0+Xm+jiB3UdQjpXhggugZwNd
X-Gm-Gg: ASbGncuNKmF8Y+B+HfCN2EQ+DnUPsg887EOlhEVXoXnB4WH5iKCq3ty64eMD/vEOn4f
	7kmuvM4J9uDO1yf39pWtjVUqZA8qYyx2XtW79WvDOxtefByVGJC7V3xs7TbDg13eaWimdhrjcqS
	RcbhJxJ+C5cbipPWK6EdurlizbK4ySecJIA1k7bB32teW4qv0eemFWBO115d19eoF5NNhz75tNL
	ZTGKmEiOFQF85f05R+jEPTCs57tLBZDyQtgpURw/F3IcAC9XH+iHRaJgXz0If0uiLOJcmI/xfCg
	n1+nh4sv22c3vgItViAkJ/6afUPNzkwy6xI32BvxzRve1nM3yQI/TqJ0W+PxU0xknTJ2KZQ59ui
	VMw/4wL0O10f0D7jMAMH9m5uMftO+sc/UuI2Muo1aHXACj3t9S2SHnpL1Id64BjtJR4BCeCIck8
	JYD3XuhnhMzSGZpPx3puM+sCeUd9FchD/0NZ661jVbThNs6/hLSBX8Hi6CMXg=
X-Google-Smtp-Source: AGHT+IHTdXZt2L4k95r0xbM3BoEPbnIX0nU85H61ECXdxu7XozaXch2P1ClAIz0ZRxfh7lXZmmJChw==
X-Received: by 2002:a17:907:1b0c:b0:b76:3dbe:7bf0 with SMTP id a640c23a62f3a-b767150b850mr2128257366b.2.1764249329718;
        Thu, 27 Nov 2025 05:15:29 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f519e2f0sm161963966b.21.2025.11.27.05.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:15:29 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] dcache: touch up predicts in __d_lookup_rcu()
Date: Thu, 27 Nov 2025 14:15:26 +0100
Message-ID: <20251127131526.4137768-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rationale is that if the parent dentry is the same and the length is the
same, then you have to be unlucky for the name to not match.

At the same time the dentry was literally just found on the hash, so you
have to be even more unlucky to determine it is unhashed.

While here add commentary while d_unhashed() is necessary. It was
already removed once and brought back in:
2e321806b681b192 ("Revert "vfs: remove unnecessary d_unhashed() check from __d_lookup_rcu"")

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

- move and precit on d_unhashed as well
- add commentary on it

this obsoletes https://lore.kernel.org/linux-fsdevel/20251127122412.4131818-1-mjguzik@gmail.com/T/#u

 fs/dcache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 23d1752c29e6..dc2fff4811d1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2342,11 +2342,20 @@ struct dentry *__d_lookup_rcu(const struct dentry *parent,
 		seq = raw_seqcount_begin(&dentry->d_seq);
 		if (dentry->d_parent != parent)
 			continue;
-		if (d_unhashed(dentry))
-			continue;
 		if (dentry->d_name.hash_len != hashlen)
 			continue;
-		if (dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0)
+		if (unlikely(dentry_cmp(dentry, str, hashlen_len(hashlen)) != 0))
+			continue;
+		/*
+		 * Check for the dentry being unhashed.
+		 *
+		 * As tempting as it is, we *can't* skip it because of a race window
+		 * between us finding the dentry before it gets unhashed and loading
+		 * the sequence counter after unhashing is finished.
+		 *
+		 * We can at least predict on it.
+		 */
+		if (unlikely(d_unhashed(dentry)))
 			continue;
 		*seqp = seq;
 		return dentry;
-- 
2.34.1


