Return-Path: <linux-fsdevel+bounces-74571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885CD3BEA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 06:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5705235A21B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E43612D5;
	Tue, 20 Jan 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAJz3C6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C433F381
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768885884; cv=none; b=pHxnsAy0xfQZMGpX5ye+sYF1xyUIbJfQCXWeS1g1K+cj1UC5ztJEZVqs94+dqBatu4BXWIvZfm5aQ/zBXidCF0RbyoDXrItxAoe8XzGgYO6RXL9hXPfKVNhrgDw3AYGcB9uCEQHqHVeUKwQOKUdctd57HggWJw8FHV7NxRCnZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768885884; c=relaxed/simple;
	bh=BVQqtT5e5Nlu7tzj48hWrYh2CC/as4WCfpHt4BWKtvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blhlW6i0SHMDpMaWx0pBiIQM9Lqstjqt0Fi+Ja1sPbkuPcZu863/vkeS0fog9ev/ItLWgxWIjiuP7GwImFYPhDxjk9yyrXWhwOcHZa9qy82oR+2uZI6xTFYGkG8o2jk45aYy5a6I+aTuqBiyF/Cdbo/hWk93kZhj7P4g30WpTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAJz3C6C; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c56188aef06so1898266a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 21:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768885882; x=1769490682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ko1FzMYx8rXlnRUTJ/8NAkzPJbLlUKQ0Y8GgQDxnTs=;
        b=mAJz3C6CbY+KlEXUGTWJqOrVe6PHus6mO0hFQlO5JNlmMYJJ+t52o0Pwb7ZBMdYShC
         N+/qhlqIpRT59FF94QssgF/cXCFdazY13uQQjXMH/kj3fTtl1ET6lXaSs31wHChZZLi/
         VJ5/V/3n3AwO1Gxq8GWKV97hst2L1lv1Sdr4J9HsY//mpdGRx9l/1wl6tNVRY+JvFZH/
         ASlUTxuV99GW92Zsdc69K8m3Qq/02d4a09Cv0MrCB9p8aK0hSCl0OFh+Cvj/hvEXCrB2
         jk9RM94JyJVVXLgq3C83xyxZmNLYoqbtLhs69PeshTNxmdtE3a6sPiW56c8/S58rKnV9
         EimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768885882; x=1769490682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ko1FzMYx8rXlnRUTJ/8NAkzPJbLlUKQ0Y8GgQDxnTs=;
        b=aFF2+nY4mzYyXSwLohYthxEjsaC9Q39U1Bk8DIc5HYly0yqIaulGRIPfzvt2V/Gh2J
         TOfY8LnUFsg8o8ruynpNu+5ln2fTLb0KnkZu8Z9J27xMdrBCvry8nAFcy3ATOBlOAk5A
         8htyZ5kEL2E72A+88y53anffcVM8hsKS4NIcgeIhQy78kYkbNr/CIFkbRsatV3HfNk3m
         Qp0Fc3tehD/+cxne5cce8BW6kcjgAtfJSdAqQfoA0CGvU0VFaAOuS+p303W1mlumTcyF
         6YEq/fewzX25uFWhRraJsUg0iEEWkyup0RmTNRgslqxpWjU5ybXdaw3+4A/5EE3mZMwv
         8xnw==
X-Gm-Message-State: AOJu0Yy8MgyEI2yVLI92BMmhC1Xku4VjLML4DipcgJGZReepVgUSKgUe
	1SeJ1lcLwYsB901fhjrppDDXMd7gq0UxUxmu3JSxqB97f7CYsEOPc+dtwbcfjw==
X-Gm-Gg: AY/fxX4Sa2XfFVZjd76fzlstaU2iH6/subJ8S1GtcGJOkfDOtdYHGKGbY2iKGJqvKhI
	wRLBAbX8Vd2fFNSzLufytjd0yBiw591i4lyTM5VicaMsVf+QfFRIZp9XkG4VDVw+WJEtmI8UOiI
	wXSSIJeOlcup44Qi4J8kOyNWz+hsF292lE0CqKunyfgLZAno6Kh53GhFcuy11DXnoC2UdZIVKwf
	ZOvUhOnTIlCMR9Wnfg07DyJ2gjstvHET6DZauMwhifcATp6DKej5UZQJ1EBARCHqqjMzidAJQas
	g9ZFF/W2bg4gHAaSGPgSVg1DosSQ2/vtSnlyUlHpLWUefDfW1F4LA7bl2JjfubCx8ezbBDsaRlW
	TUNJF6lCCTFYCfkfEMzDJcmoCCk0NcL7AUTjBLSYnksGvCXilm3d8YizdiuzHS4JY6H5C97c39x
	c15md2IBI4QGKkEHTsstD1VIHbkoC43i0lqTCqL7v6KEGYVuHtiVDiQmfCv18NUynlfZM=
X-Received: by 2002:a05:6a21:168b:b0:361:4ca3:e17d with SMTP id adf61e73a8af0-38dfe5902f3mr13465494637.13.1768885882094;
        Mon, 19 Jan 2026 21:11:22 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:f843:2c12:200a:6bd8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf251a6csm10441925a12.13.2026.01.19.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 21:11:21 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
Date: Tue, 20 Jan 2026 10:41:14 +0530
Message-ID: <20260120051114.1281285-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a KMSAN uninit-value issue in hfsplus_strcasecmp() during
filesystem mount operations. The root cause is that hfsplus_find_cat()
declares a local hfsplus_cat_entry variable without initialization before
passing it to hfs_brec_read().

If hfs_brec_read() doesn't completely fill the entire structure (e.g., when
the on-disk data is shorter than sizeof(hfsplus_cat_entry)), the padding
bytes in tmp.thread.nodeName remain uninitialized. These uninitialized
bytes are then copied by hfsplus_cat_build_key_uni() into the search key,
and subsequently accessed by hfsplus_strcasecmp() during catalog lookups,
triggering the KMSAN warning.

Fix this by zeroing the tmp variable before use to ensure all padding
bytes are initialized.

Reported-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d80abb5b890d39261e72
Tested-by: syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hfsplus/catalog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..9c75d1736427 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -199,6 +199,7 @@ int hfsplus_find_cat(struct super_block *sb, u32 cnid,
 	u16 type;
 
 	hfsplus_cat_build_key_with_cnid(sb, fd->search_key, cnid);
+	memset(&tmp, 0, sizeof(tmp));
 	err = hfs_brec_read(fd, &tmp, sizeof(hfsplus_cat_entry));
 	if (err)
 		return err;
-- 
2.43.0


