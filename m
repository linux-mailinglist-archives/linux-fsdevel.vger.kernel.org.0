Return-Path: <linux-fsdevel+bounces-74318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1BAD39914
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 19:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A483010A96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C22FD68A;
	Sun, 18 Jan 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUTNbPod";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWiHCYIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495793002B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760699; cv=none; b=Dub48aHLs4Y7JhoCWpBx7eCbAvcGd0kC7Khr9AYDUCzH3SUY4MRoW83e/dTj0LiewF5dTDycTM4yi9LEr+Yja1IY+oMqHy8QHATlkf2VAJ+o39irJssZoCh6cYiodUD61nrZuQsXCe+ZPuU6IeITzulJtMUDZcV8nVgYVD/DjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760699; c=relaxed/simple;
	bh=B4xyzwDKGxq/vyrw5rw3MiyV1PFc/MXbtlIPEadsNuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pU21M2FsoxsF/aLArpg0Vi+0nkTrsuy8gnG1PoluwQ+bNQ5lZ0Qtho7le2GTDuA6rvUKGK2NpRQFhTOYfw0xzA23Sm7uO42Q9e5XIgEydBO+/3Hec98ATM3l4fHifihh8/5vnGLjK2MpmhO1q16ATJXqJ3hrHIPz0sNpzQhPwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RUTNbPod; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWiHCYIN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768760695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
	b=RUTNbPodIsbl75Jm5TVnX043QYRd22rTzNoAMY11GZI9oGBUkjU3gBSPQ3aK3viUo6Mn05
	blD06c6nwW27Gfb7JoLEGr3FK5jROyyrMEHeivjqBPzHnO2odvdLa9XZLvICn0GayOkLtY
	Bll1zNNYi/pyUrubCOtn1Cu3gQi8oq0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-XAtpGbcQPIapmXTUks3Cpg-1; Sun, 18 Jan 2026 13:24:53 -0500
X-MC-Unique: XAtpGbcQPIapmXTUks3Cpg-1
X-Mimecast-MFC-AGG-ID: XAtpGbcQPIapmXTUks3Cpg_1768760692
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d589a5799so5506570a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768760692; x=1769365492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=LWiHCYINKJThgM2k5S9KKgs/TwnO7kQLvlMWjchP2klwGUtIlCIKEDX1b3R7jAdqU/
         YnN0JxjHFVEPTWWddT1lAXcj8pfMWrz4NAIPg4mAQWhMawKG5vLZSOsHXPuoVwbF55dk
         htrsrIZ3qGYmYq/osNCwzVXbS1GPj0iQu/MYA2F0j3p7UYx6rNtp8X42jCFDKUtXmF9s
         5vTAy+Xuy2UYnxheBT7p5DLycREacGau++8mMr4wDtS1XOZyfGsYR8/EHDMOlfiGW3Oy
         T0uoAAxbH2YZ0KtPFTx/p5onnnWBWYJ6zW7pea0XHl5bWI62ErcesaZlPgk8ro/3w5OZ
         GxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760692; x=1769365492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jcDCLLxng0aZwTmIpvTEU2QWfymaHSnvSLSvvAB+tII=;
        b=rkBhzxeuQRzBXXrWyvzTQAASo3QcAQt5esFUaIncxpuNvyOrHlxMxNCQH9anfERp8O
         4KksdHW6tGp/SvJfMUsr7xE9Q2Zv2x27ZzAmoJu7nSZF2MjaXZ3mcTlkiL4sfdE4Ml0A
         /hMJllDTtGytvI4GFpE0F+AaNWQmjar8dbciPkw5bkOyb28Oqgok227uirfpOKXp3fUE
         2v9pHmF4sWXwgNEeysNHpcw/lOSlidMDcrv8B4gQKuFMfjOJPNWw9Lt8A7XRF4zylsl2
         +paEPpSmFQFxrZcxl/lxQQXYlfFOnxXeigUg4lClutOsOktwa5rSwZAIc79q2vZKlIrf
         +7/w==
X-Forwarded-Encrypted: i=1; AJvYcCWEuK5TvOgqK1YyBFKppwgFM9UzEbkNqG/NG7QfHM+1oAmPwtFtkMpcgwo4c8KUb/xBIFH6O4dQO33mOSIV@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXwX1fHT3uSMXQLtC6qIBdp7+TN+BFolEQDVQL8DRSGYS1NzD
	ywC+MaP+l+VfS0ecZgILU7J4DoZsHpKf7kVmhxfaO8zA9G1bm6KgvbIWVfgJFCbD5+wjtX2VjAO
	gjKG+gubW84OfedQ0I+vVLGGG935Yj1c+VFaLt4fdkLsPG8KdTTcA7nB3bvUT0F78uTo=
X-Gm-Gg: AY/fxX40mSDlnV6Fob8rVTa/DV73Y1TOuIZqaZjn1u2Ajn+Vh/ENKfBzD171R1g3QLr
	r4gnCf/ehf/WnZ2j3LEmkHIdtlpyn4temFIIJGbdw3lFztFo32r6dI04rAd4YGPGFKPLxXGLuM0
	WWw/CWLXP9Ty8AQqWAAKXgz1qSKumMpwkyhS3rbL34yxjWVZ1q9mgmgw99l8stke6Jf1rSKoAm1
	32G2Ldi2oJ0QHExuX3NwBzAkNCgmFAkKM5h1KwWTnSd/aEZuRYd2qqxruIgiP0xryryve6Mpr3v
	oxXjG1f0/yYtUALwSlg5P3a/hskTQSiHmlcSHMKLHzWWo0OWgG1FJRmZ8gkivJ5+vBma/tAj1qU
	S+3Sk6UiZLChtRGiSawhqSkOcfoiyJU/yaKaYbATj5Ac=
X-Received: by 2002:a17:907:7212:b0:b86:edaf:5553 with SMTP id a640c23a62f3a-b8796bb20f6mr815437666b.59.1768760692185;
        Sun, 18 Jan 2026 10:24:52 -0800 (PST)
X-Received: by 2002:a17:907:7212:b0:b86:edaf:5553 with SMTP id a640c23a62f3a-b8796bb20f6mr815435666b.59.1768760691744;
        Sun, 18 Jan 2026 10:24:51 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e8d1sm907624666b.2.2026.01.18.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:24:51 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v5 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Sun, 18 Jan 2026 18:24:44 +0000
Message-Id: <20260118182446.3514417-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118182446.3514417-1-amarkuze@redhat.com>
References: <20260118182446.3514417-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add forward-compatible handling for the new versioned field introduced
in InodeStat v8. This patch only skips the field without using it,
preparing for future protocol extensions.

The v8 encoding adds a versioned sub-structure that needs to be properly
decoded and skipped to maintain compatibility with newer MDS versions.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1740047aef0f..d7d8178e1f9a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -231,6 +231,26 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/*
+		 * InodeStat encoding versions:
+		 *   v1-v7: various fields added over time
+		 *   v8: added optmetadata (versioned sub-structure containing
+		 *       optional inode metadata like charmap for case-insensitive
+		 *       filesystems). The kernel client doesn't support
+		 *       case-insensitive lookups, so we skip this field.
+		 *   v9: added subvolume_id (parsed below)
+		 */
+		if (struct_v >= 8) {
+			u32 v8_struct_len;
+
+			/* skip optmetadata versioned sub-structure */
+			ceph_decode_skip_8(p, end, bad);  /* struct_v */
+			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1


