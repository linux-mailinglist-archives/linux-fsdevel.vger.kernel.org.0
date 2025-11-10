Return-Path: <linux-fsdevel+bounces-67726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE76AC48335
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D140420BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69007280329;
	Mon, 10 Nov 2025 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Xym/2h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAC28313D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793950; cv=none; b=TzPZJoQnWsKsmvdTDnOZ0BJ+aevwy/DUTA8jWNWzJ2sNhU0x+8F1PgtS4nwf7BSa202hIKRZclX/ynDgRglFRSngeG3xIJ0dtS7Jzb9XKV+CRbT9gLIp72duMgCjBHzydOFH3VrlJJ3XYX5T8dZhRM+2z1qk2rIk8HIsHyJ0VBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793950; c=relaxed/simple;
	bh=LYbjQEMZCCtkEu/DlDOm6lolA/HDUDt5lHXbIgawNAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQg9mjUwObU66/kPdKudZXOSp8lcNibZCoFMhNdS79wJzBRDdYRf52l5swAI/Em77Ym9Aa5+tzTCwDAA+Nuq/tKzOik1PgnIv7adQi8wX/xvZ9dUsE7K8KxI4v3nmRVSqWkM5c9+IFD2ah4p2AK0y4Ub8jATio9shwJ2ZIML0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7Xym/2h; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso6005406a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762793947; x=1763398747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6E8F8bYQt96owYWb+j7C22xaikBLl8OvGV7Z+ov47cs=;
        b=a7Xym/2hUspby0lnzO9y/i5EVgs7s8Q/AN0fkm9y7Fet66uCaOKaOxPNWOxhuOmfiG
         WOwECjuUbpSKMDA2/UBgoZIY2fSBdRo8RHvB3Rdt9ZZgv/ATaIxokc1ejO99yYkGL69I
         /UwvDWMcZCnb9LjL/Xz5sJRLji9ACCkESjyLQ3znR71d3AtqnERRSqc0VGaNOtaz+fQw
         eip4JiHsMtiWElrtwP1oDmZbc9Fu638A6dfOIG0JydEUuIJ9cpPkJ8kSs3kPZVIRoNC8
         /ROhad0ozbYMs04YI3eARP4pNV+1PySAvO84mC1mtNtg6d8kfcDRqVUD5NhuItwkGNW0
         dejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762793947; x=1763398747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E8F8bYQt96owYWb+j7C22xaikBLl8OvGV7Z+ov47cs=;
        b=FCil3W/fDsHo8IGdZUmJzBNm+t14++CYUN9V4Da1Hmbhatl57mxCjJGJnNNm082K4w
         yUf7MKGa99OFof5Q62v4Ko1NFSbvZfWf9ZkXOuaRW3HaZbSaMh2SeOjxcomD8zHPmf7h
         L+qKrEVrJWfyPw3RRUXThAEHzEdHVB2O6wbEeKWkzCUXcA/zbPZ1uBi+gr5v60aeP4RY
         oP/5EtYePfFWdpSPs/Dj2HcBJTvLWYVyEngY25GSY+o3eHlcdnEd4pzzy4Imyh5RBzMq
         7c9tZshpAP//Sdl5H8RhRa/6h6Q4vKQHMXZsha7dft0jRQ3KueIiBGvEj0HQBu1NoCZu
         5xOw==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZyioDB4jKal1HrcVe6KlcwcOAFgiUvovm6vtiQYCZXlwSR+Gjp9WqxHhV7mx4Ogn5zXvJzTIMa30m9J8@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjxxWdKgcTxN9RNRI2d6MyoZwFxjRchFv5auhIPNCtk235qqS
	4rroM6glXy8/i164v21Gn8RqASnXeTZfEf+/16zrUoL4/KeUPKi0QeNK
X-Gm-Gg: ASbGncsEbZ83tUWSHCbcXzrN3vBYxQ7fvK+hDsPK6a3pSeC/iBCtE5kA/5rOZwopGDW
	4Uvcg5lX1QpIzG6AoDdMgx/t30wk5poiq6/JfoF5C7M4WfmrAi2fhY0qmMDCETHe9geFqLWE0di
	vZsUJeMFmh55rKKdBgyTbutp/K4jWnx3hWeBuryuy+tGEYtabsnsIweGMuatxDNMbuafupXedSk
	xQdBlhuv1c7fLOA6J1Fu+ve9kxpBPVnzNzWhSpu0/ALJJtOF+q02JRewnUZT9a1m1J20Lr8GdWz
	/b8xtOxXA89O6OYTSgj9PwptfPWn9Ij9Og27aQMPTuu5PBaOiLFZR3xprlko5jtVkp9rQX2+3KK
	38erZJWgaUzCcSN2jtUtKnQyYgIH96HHyWnWRAbCYb8WUpEyuAXPpNO7aR7dvOy7V/ZQB49MpOj
	Ezs48GuuCqgk8YJEJ083BGgNvy7jIISpjBuXHBLrgGivXYarIy
X-Google-Smtp-Source: AGHT+IH9HXzouFHF6eIXCeLRTXtlUoXhQtjoFHj+QNHModjG38wGnKmb7jL9MvhrQdpTz+2QkN+Buw==
X-Received: by 2002:a05:6402:51ce:b0:641:72a8:c91b with SMTP id 4fb4d7f45d1cf-64172a8d095mr5839822a12.34.1762793947130;
        Mon, 10 Nov 2025 08:59:07 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e0cesm11894917a12.33.2025.11.10.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:59:06 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] fs: add predicts based on nd->depth
Date: Mon, 10 Nov 2025 17:59:01 +0100
Message-ID: <20251110165901.1491476-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stats from nd->depth usage during the venerable kernel build collected like so:
bpftrace -e 'kprobe:terminate_walk,kprobe:walk_component,kprobe:legitimize_links
{ @[probe] = lhist(((struct nameidata *)arg0)->depth, 0, 8, 1); }'

@[kprobe:legitimize_links]:
[0, 1)           6554906 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)              3534 |                                                    |

@[kprobe:terminate_walk]:
[0, 1)          12153664 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@[kprobe:walk_component]:
[0, 1)          53075749 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1, 2)            971421 |                                                    |
[2, 3)             84946 |                                                    |

Given these results:
1. terminate_walk() is called towards the end of the lookup. I failed
   run into a case where it has any depth to clean up. For now predict
   it does not.
2. legitimize_links() is also called towards the end of lookup and most
   of the time there s 0 depth. Patch consumers to avoid calling into it
   in that case.
3. walk_component() is typically called with WALK_MORE and zero depth,
   checked in that order. Check depth first and predict it is 0.
4. link_path_walk() predicts not dealing with a symlink, but the other
   part of symlink handling fails to make the same predict. Add it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v4:
- fix backwards predict in link_path_walk

v3:
- more predicts

This obsoletes the previous patch which only took care of
legitimize_links().

 fs/namei.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a112b2c0951..11295fcf877c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -785,7 +785,8 @@ static void leave_rcu(struct nameidata *nd)
 
 static void terminate_walk(struct nameidata *nd)
 {
-	drop_links(nd);
+	if (unlikely(nd->depth))
+		drop_links(nd);
 	if (!(nd->flags & LOOKUP_RCU)) {
 		int i;
 		path_put(&nd->path);
@@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
 
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out1;
 	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
 		goto out;
@@ -917,7 +918,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 	int res;
 	BUG_ON(!(nd->flags & LOOKUP_RCU));
 
-	if (unlikely(!legitimize_links(nd)))
+	if (unlikely(nd->depth && !legitimize_links(nd)))
 		goto out2;
 	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
 	if (unlikely(res)) {
@@ -2179,7 +2180,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 	 * parent relationships.
 	 */
 	if (unlikely(nd->last_type != LAST_NORM)) {
-		if (!(flags & WALK_MORE) && nd->depth)
+		if (unlikely(nd->depth) && !(flags & WALK_MORE))
 			put_link(nd);
 		return handle_dots(nd, nd->last_type);
 	}
@@ -2191,7 +2192,7 @@ static const char *walk_component(struct nameidata *nd, int flags)
 		if (IS_ERR(dentry))
 			return ERR_CAST(dentry);
 	}
-	if (!(flags & WALK_MORE) && nd->depth)
+	if (unlikely(nd->depth) && !(flags & WALK_MORE))
 		put_link(nd);
 	return step_into(nd, flags, dentry);
 }
@@ -2544,7 +2545,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		if (unlikely(!*name)) {
 OK:
 			/* pathname or trailing symlink, done */
-			if (!depth) {
+			if (likely(!depth)) {
 				nd->dir_vfsuid = i_uid_into_vfsuid(idmap, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
-- 
2.48.1


