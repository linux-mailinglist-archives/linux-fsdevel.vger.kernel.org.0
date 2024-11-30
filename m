Return-Path: <linux-fsdevel+bounces-36174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB81B9DEF06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 06:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C3EB215A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 05:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC113E022;
	Sat, 30 Nov 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRjxTGFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF329A0;
	Sat, 30 Nov 2024 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732943841; cv=none; b=uAzVfAewlxiwg2USYkN1xg+SY6bq0AV6VyBKGz0O3a6NYk5jMUSL5xFnLDdvNV9TvRQtXP4o+/8e9MSlhNo1V30wI660+GuqVhbcOXNacUcT+FMVG2ypxSeKUQOePWmxl8iS9NC7P86zeWcV2KZ+Uz8kpI0CJPq85VMjzxV5pQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732943841; c=relaxed/simple;
	bh=/CCbf0H1VV6hedWZPtBJHMXzeDaX3KFpLut0ONcBBqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppsWgEeO4SO36Nq04r6lve2uDvVAgC5/ZmAPWnp8lBiuZ1jemDjsLgrhfFmpjfJvgNKI6tp2BB1QiZDKBlGW3xnmqGVWm7QcU3ZtBkq5OCzQ12cGojm6IFADJPi2s9VT97j7vGRLx4eti1WMau8CEAvfNiVtQMm/N827fJivBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRjxTGFv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso2971071a12.2;
        Fri, 29 Nov 2024 21:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732943838; x=1733548638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucgW3WtYKM4BHGn1NSBKyN1XdPkn7oT4zjIUZaroHKI=;
        b=YRjxTGFvMQ0iMxASYtCINMbRLGurkhdDMU0L/WqGrxK9ZJV+9978Vr6P2uaalY2Sdy
         RWUsew65fDJqP0AqY8Q8WeCG4epOde35Z1kg7iPIvW14ckz3PES5q9IWH67/+4obAKVT
         kfJ5w9oDdvv+D88IB0d3VyQ0s3ds/sIRQT+e2zWbrq3HnScAT59IDdbv7VpOe+L28IPv
         Gmh8NciOR4TXNLqowJ0gP36bPm+EMeCzCq0lcAZnhTsVZBMv8W7SVC1y3E1KM6yhZX0s
         WKLRYxjf3Ix33rOtfOyXkqIVD3jBKsNJ6hGuexiY6ebixjifyIzl4AMIZmno8hHJQrpP
         U0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732943838; x=1733548638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucgW3WtYKM4BHGn1NSBKyN1XdPkn7oT4zjIUZaroHKI=;
        b=OpleZQ6EpvyMz6y/OfO77r4+7d93oszrqNHMzKYt+uqEi9uFYKHTfZCtfRY0hc4dm4
         S8cvhiaV08bDGEXwGFQRJEJ2MQyulXqmzeFTFm5MjSDyC4B8KTo+mNquKwXyfWB/EOkD
         z0MT1ylujbTe1rS5qBHk092wuR/cEl82qSV7R9JTBX2DnjR60VykhPMyE1mxTYJSQTh7
         rWKXxHaUhYbRRy7q2hTQuekAIaw+30PnkJqJPexoZgtz0UgNlKSu9WOp2qb74ByFUGbl
         qPHroaRe76k7WbVCy7Ph/7lN6VDHJz2FlXFZZMatUi1dmSDXoszClSUHSjgR/MFIlL6F
         hyUA==
X-Forwarded-Encrypted: i=1; AJvYcCWQB7KMlxllF0Ag8J8V8CYtnzFmqMHBdMyQhO3CkfIHie7au0ztTROH98dHaem8J/5AqACJd/nWgxkkuv6c@vger.kernel.org, AJvYcCWyzKDaNMf2+CTrr2/vnfGR8GkgWwQStMxamt0CW5lXOKo394fkhMb+X146PXJN1bFY5Nwc9nekHKHVtZV/@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEOWBZzfT85/8Ibesoc7TR2n2lABwITBbdKmLm+q5bGHsLkH6
	Y3ph9bcMH5i/6hljFfE+e44+UxwPt1scDJ6G7VXa8wjN3hCS/1g/
X-Gm-Gg: ASbGncuk0xcVLfBADsq9XDc9nMHArC/kiGoMgaWU3sIGfhpC2ppyTbIUFDuc5FVW0T3
	3dZ+ff0ZhvyS8IQ5I/XoFmsMdnLgnbdd2ILWcZwo7PwTlXPXSvpgwHTkCj46FYcDNLWP3ApV89g
	XB6RoB3CyzNs8GU54dpIvLXrS9TlyjmHIZ6l0KZen6vqckb6OhnQE/UUQFNvUdkUGbpP6VnIi7B
	+W3EmBHC4nWgAkdYfdxtRCKfzmfvI94MR79JLioBHLb0FLH/pv/FaCIUgdFZGOIKMKj
X-Google-Smtp-Source: AGHT+IFL/hRm81BzQO1WKlItblNlHkNI0LVNJpnv2fLxddUrMIeDN1NU6PLeJhXWoj7bECXi7vxVLA==
X-Received: by 2002:a17:907:7748:b0:aa5:3ef2:1542 with SMTP id a640c23a62f3a-aa580ed02b2mr1135808066b.5.1732943837928;
        Fri, 29 Nov 2024 21:17:17 -0800 (PST)
Received: from f.. (cst-prg-85-220.cust.vodafone.cz. [46.135.85.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6345sm243052966b.109.2024.11.29.21.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 21:17:17 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: use a consume fence in mnt_idmap()
Date: Sat, 30 Nov 2024 06:17:11 +0100
Message-ID: <20241130051712.1036527-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is used in link_path_walk() for every path component.

To my reading the entire point of the fence was to grab a fully
populated mnt_idmap, but that's already going to happen with mere
consume fence.

Eliminates an actual fence on arm64.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/mount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mount.h b/include/linux/mount.h
index c34c18b4e8f3..33f17b6e8732 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -76,7 +76,7 @@ struct vfsmount {
 static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
 {
 	/* Pairs with smp_store_release() in do_idmap_mount(). */
-	return smp_load_acquire(&mnt->mnt_idmap);
+	return READ_ONCE(mnt->mnt_idmap);
 }
 
 extern int mnt_want_write(struct vfsmount *mnt);
-- 
2.43.0


