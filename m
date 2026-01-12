Return-Path: <linux-fsdevel+bounces-73246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C09D136F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77A1D307C46A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6E2DEA98;
	Mon, 12 Jan 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMG56w4X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ij/wwzLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636F2DE715
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229432; cv=none; b=spCQL+ikeR40g3u+pspLV8chUplkvcwrN1mr2PLpWlRmnQM+0V+bHupmtVa6iHXWRzYt60szVosO8QbNHY14ywbHONmJ7m1XTsa4lC6fLV3+sLfjVf+PZlWA6nQ10B4eEaCWmaAo5k3IKDhfhKqX4oUMPqVZzXnpl9qFymfA5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229432; c=relaxed/simple;
	bh=srquItat3iIisx24yelRLxoGuZRV8LO1BEtV0r7CHkc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvbNElnFEQNO2M4X/2zgzakWIAeLqd0mESJPbbsZXhOVStrj7r3btQVyOsOlIXtwtA9F9lE/4NL9SJmabq41gkojIshuaJzKfy5uhmPbtkE8v4+8MNOvl8bxf4M5mSDxT2jdTucNj743/H1j6jQGgzEUHCMxbcd/LTykh3c3sZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMG56w4X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ij/wwzLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7m5yP4ArOwgDB+QQS/sWnqQ++oA8WiS4/X74cxkt+wA=;
	b=DMG56w4Xf4lE4yLtD/h5brEAOnmidamYKTgh9q6NlfhrKBhGpYXdrLUbk0kl/5aXCfKkR2
	WvzpCgEnP+mzgQdyuvG+eKkQo+ux6qonQFd0JJzRjNY6DfGPjgkt7x8H7znEOKeJKuvSYZ
	sPpSmL236lktMsgFuFUylDUCL7DsYXw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-I2bvzm3lP2i99Ecklvh_mA-1; Mon, 12 Jan 2026 09:50:21 -0500
X-MC-Unique: I2bvzm3lP2i99Ecklvh_mA-1
X-Mimecast-MFC-AGG-ID: I2bvzm3lP2i99Ecklvh_mA_1768229420
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b800ee1a176so1130199466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229420; x=1768834220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7m5yP4ArOwgDB+QQS/sWnqQ++oA8WiS4/X74cxkt+wA=;
        b=Ij/wwzLNC6HHDKZhUKuIDT6vzsLFXF3k5rV74hEsRv7wvrXgVfc/LXzuqGCip5q1Re
         lg8wshyrHH45VD6ZclLabX0gzx7h5I+X13nPUpJvlCvs8f3E3AAkN3N2ETUX4n6JdnfO
         i2iWgt0C24VLX+ruK8VKQaeF6DzHPD8tB20QE2HMUEExzSoyh+hG/4Wq3jkWEPmJnUmi
         inIj580DrR164coUbZvpYAKUANuR2Omtsyg85AhIymSwinfN+U8jZO6qCnD7FKR4dUSg
         cpNqrPo7MfHFNw3eHrf8EqEtAaWiev7H+w34zleyEmT02ww/FLJ2bctAKmedlp9t4lUl
         isRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229420; x=1768834220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m5yP4ArOwgDB+QQS/sWnqQ++oA8WiS4/X74cxkt+wA=;
        b=iYwtQsfVgjvjZ7gapuPvj96rBwvw5A5EYNhXimZsiI+97hkYSDvUBsP7V6gzPuDHrB
         QosxPi2MO2JCBqdQYR4oA/ozrSuyGAp15pkH39n0DsICA/aDeeK7P0EzPtwm65rfxMLO
         e2sxuG6Y61sLxFFXJXzATQYeNveECGVjdxwrfY6rX6GcVkDwtMQJHER2aLA5dHl/XK1O
         VHTNQ9rH3Cn3+zDbFLSUIXjF3ecwqsotOmIPzsnVjKGwopCv3AGC+vZObtveNvhwvCu+
         iifqMbPbbfkvuDjobeRwO4TfNv5S2tkfDJnujrmdPCz0tBqN9o2dFIprseJP/cZ40Pwn
         E1JA==
X-Forwarded-Encrypted: i=1; AJvYcCXDgeWPUPl43p7oCV+hSuJIFJ9PotMKp0k/zirNUjOPbHSNZumOgNASre0RjCf4yThb2FjrclE1BOE4qX3L@vger.kernel.org
X-Gm-Message-State: AOJu0YzdQ8/2JCz3sCpRKHCHJekGwjsA+srDuQrrEFtuIzp78sn6vQ9d
	hEHoeu5+SEYb1z9ZU0hy/X8y+rwoyUfDFkkVYqol5uXkCH3EDKCPAa7salCHzHrfaH2onr0dWBC
	+T/N0W/MqC/hTRsAwYe0REb43jd0PpDXJ2rHZBx8atuI1YfZbAweI6N9tkff+ys2PXQ==
X-Gm-Gg: AY/fxX53TjoWe31HU5zkEnP37fyXSHfkkUfonCKb33CMcOk0/NW2W3XxmCRA/PriQfl
	ylKjiin5fyFkWCdcSJyaOIyq4MpxTFCQdg1O4HMNLmxOLhKsmuQskOScoUe/mzzTEJhzCdTf2U2
	1fmmzYfc52r5xgwpAzvozhD8mBfvmi1H+LOScrA+XS6Vu2pWbbTgVdBS1iZC9l+Zie7ZRA7KfgB
	pgnMov5JuuvUIf05T6iMYmiZWNz0tqSg3NHCv1cB5of95Dg/eufUvsfogQowSNZgsSU6iitGuxE
	UsNh86UdCcyS0yaPzOXbuzqE59M8TW1/soctb0YedV/10aHnFn9uFUWSJnqHgKgGEOR1yZ0sils
	=
X-Received: by 2002:a17:907:8693:b0:b80:40cd:ea6c with SMTP id a640c23a62f3a-b844540fafbmr1740779466b.61.1768229419957;
        Mon, 12 Jan 2026 06:50:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrXKO0CxWBOf2w/I7WXqz590chwScxO7BnYwI6Yf1sI5Y18FioHghi8Y+cIJhX4GNkkBv03A==
X-Received: by 2002:a17:907:8693:b0:b80:40cd:ea6c with SMTP id a640c23a62f3a-b844540fafbmr1740777166b.61.1768229419488;
        Mon, 12 Jan 2026 06:50:19 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87207e08a7sm232426666b.55.2026.01.12.06.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:19 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:18 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take iocb
 without file
Message-ID: <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

This will be necessary for XFS to use iomap_file_buffered_write() in
context without file pointer.

As the only user of this is XFS fsverity let's set necessary
IOMAP_F_BEYOND_EOF flag if no file provided instead of adding new flags
to iocb->ki_flags.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index cc1cbf2a4c..79d1c97f02 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1173,7 +1173,6 @@
 		const struct iomap_write_ops *write_ops, void *private)
 {
 	struct iomap_iter iter = {
-		.inode		= iocb->ki_filp->f_mapping->host,
 		.pos		= iocb->ki_pos,
 		.len		= iov_iter_count(i),
 		.flags		= IOMAP_WRITE,
@@ -1181,6 +1180,13 @@
 	};
 	ssize_t ret;
 
+	if (iocb->ki_filp) {
+		iter.inode = iocb->ki_filp->f_mapping->host;
+	} else {
+		iter.inode = (struct inode *)private;
+		iter.flags |= IOMAP_F_BEYOND_EOF;
+	}
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)

-- 
- Andrey


