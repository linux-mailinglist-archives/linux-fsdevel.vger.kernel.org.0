Return-Path: <linux-fsdevel+bounces-76188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMqpA5HxgWlAMwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:01:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3ED9867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58BE3301C33B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5A34B404;
	Tue,  3 Feb 2026 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxHVMkOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A11241665
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123657; cv=none; b=X7UjgwW/QXuI7eTPO4pBGNhdoHTA8Z9k8Weg1aH7jM8xV/xcbFw/mtdiJVJew4D/PDo1XOtGWbURljfMoLIjUy3pFQDgUzu6wOME87cYPNM4KcdDGIHopOENKrW21OY2X4huQtCgF7csIMEf83/olqrP1OTg/GZcmuNZIePIV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123657; c=relaxed/simple;
	bh=bjhxM7cFwGkKS2BZNc+CrEavaUZjQgYiUP9WQm4pkRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbu7wMcuv4H0tda4iCJBs/eVNrIF5MuVA3HbiKooTiSxx++bBQCrG+YRnNxs5SYTfffDSbFrgpR37RQLep5XgKjJf58/WtnM9U7L01Gn9ktUT+WEsUwo0cu+lowqco647erdGVK2y4/e9wZ4sy8WlAvTBnekL2fVH5ujFaq2JWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxHVMkOr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so59588575e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770123654; x=1770728454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AsUIVOzdDRdVEL17P1YS6XyOc6ergbsNaCqKh0AjEKo=;
        b=SxHVMkOrG4t90Gpe9WLEnrT4k9QIZbZGSaQ63E4Bf5/RZR6ageVWds+lwyYmtvCWtb
         Ns7QB5487vIf3xwuYTtDu1qRQUrNDXb3uxZm91q1QKxfQ4VjExeukslkjKK5Og0yHFDj
         yuXor2ecQMcoKdzuzWyvmRzfUcz0EuQJ+8UBYiKpmBYRtKwt1yp3t2DxtYvlIYtvopAK
         vplQlS334zoA2HzUjc1VptSHOk/ZPrz/6e2BpV596+1IPm7dLitvpksQOn/vD3bxQOy1
         R2PaVuVgBXUkRbAfDCChCPY0/TRBfovF8P8zsVB2UoRi+CZop24sBIUQDp2iUIiwFL7c
         uBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770123654; x=1770728454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsUIVOzdDRdVEL17P1YS6XyOc6ergbsNaCqKh0AjEKo=;
        b=BgOE76lYKiywVecz2Dst0NlVJccW3FGgd+wRDmkZ/86nK6R6I76hq0VYHQSxiF1BR9
         ZGZ+P8jiv385dtIo9H0loFmb3t6jAtyCGHMGU3NKa73ObbBUm7NWYizsALGRsTkLKD+y
         vVRrMCi6x5oakW9f4H14HG21Wk266GWN8SyNnbFcESS19bmOYLsceO6UYUkx13kpR0hJ
         PkYlQSMygKGw/HPqD/doDqhBz1w4tOe574bP4zeMRCKSoENoAGfzBNrxN/1p11FW7oTz
         qVRektXbPX0rS7OYZgNJQpWsA5qBNoMiEAVNbrYWFqz9eGejTs3L8Zd7u/WS+NttzcMB
         4hMw==
X-Forwarded-Encrypted: i=1; AJvYcCV34T1yzIsPbyeADhBQv0jvmgiwBLVplCyXfrq5RL3/T8qHAZyQBXJMmyLHHxn7yVfR7p3vzT6ED4Q7TIKS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+Ye/pbyFNCTD+0T65Ft5WiPjIZ2WRLm/w3iZJ9gRWP2ZrZmu
	RsznGsNw9ntIKgndkm4mQreMbHqhtue/fhpgJkP5ooDYUwjoQzNTk73R
X-Gm-Gg: AZuq6aLa/fZSe8nIR3F5o7RRSowToTeOWoXSKYCgHgRbs09b1orFvu4FbZ/B5lMtP9A
	AVQZmQyy2+JPfE92amiekUsdF0pJfLwLcr6aHgx7h2tXRyABuqamDhrz8BTpz3yyRF4fzTsYasf
	0i+JCdpB4rEm7wYjWy55LiNYkVCp2u3SJTVjp8h8rh07aFXEqxpuuFDuFZTdpFi2jFoZ4DeEz8E
	DRpb/oynHb8K9DHRMhdeY7K1MGhofhtYfgCFFY82ylt5DdJwgdwbFDmO6XlLbO9lz0YJvM0NzW5
	gKgKJH6rsyT50FuF3lyePYKOh1jXhX5abr11vPGf2a89BYkwQ0RF/ElqMx/ZQhdorg/vN22szfO
	lCTkiuwkybja5yoOoOv40ldl/z61dIE9dsTbPQhp30yNNN6MxxQPVfKnaESFKqTVYwuekvhK5a7
	nh/mf4bRQWBWBnOg0fVtSHPd0KdaJeIgxmTdh6X1o6rgrDqKt4z7uywKsBOm331w==
X-Received: by 2002:a05:600c:4e12:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-482db481c85mr206809705e9.22.1770123654157;
        Tue, 03 Feb 2026 05:00:54 -0800 (PST)
Received: from f.. (cst-prg-85-136.cust.vodafone.cz. [46.135.85.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e047d863sm125188435e9.1.2026.02.03.05.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:00:53 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: add porting notes about readlink_copy()
Date: Tue,  3 Feb 2026 14:00:31 +0100
Message-ID: <20260203130032.315177-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-76188-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70B3ED9867
X-Rspamd-Action: no action

Calling convention has changed in  ea382199071931d1 ("vfs: support caching symlink lengths in inodes")

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 Documentation/filesystems/porting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 3397937ed838..bd4128ccbb67 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1334,3 +1334,13 @@ end_creating() and the parent will be unlocked precisely when necessary.
 
 kill_litter_super() is gone; convert to DCACHE_PERSISTENT use (as all
 in-tree filesystems have done).
+
+---
+
+**mandatory**
+
+readlink_copy() now requires link length as the 4th argument. Said length needs
+to match what strlen() would return if it was ran on the string.
+
+However, if the string is freely accessible for the duration of inode's
+lifetime, consider using inode_set_cached_link() instead.
-- 
2.43.0


