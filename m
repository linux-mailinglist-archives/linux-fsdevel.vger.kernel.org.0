Return-Path: <linux-fsdevel+bounces-76041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI9NDoKggGni/wIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:02:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88128CC90C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43775304AAE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBB366573;
	Mon,  2 Feb 2026 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fddfBVP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2013EBF3B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037267; cv=none; b=Ki4dkh0wbi1zVnrLAXq2ctB5wLtUTOCKqx2reSPzU11WSvfHd7MdgRD/SGlNo/S5NUSguAUDp9en/HBHNxZHyI1HitMlCXcA1M6FE3T6vsVKr6M5MdpMcQ3U8M75F82cABZVPjwoDV/sB3JCz9QQmQEfJktraEiuWCOe2bx60+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037267; c=relaxed/simple;
	bh=RP6S1ivaYAK6Fs5+VhDcT3M8k5FicM0n51mqRABDv7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hepulm7ies4NQvFIhk4T6tl/aRxxRMn+S0yhEp4jiHORFT5nnSIasPGop0IwprA5wi1n+rKkbuhuCvOssWnOf6G/OLMk+/JaF5KKHqlnEaOWRpL6l/wraLGRsv0A5wORJshOWw89m1G43KoFUxR2EHrYQFXs8KAScOjiQTfdjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fddfBVP8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81dab89f286so2153818b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 05:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770037264; x=1770642064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n05z2JgZ055VI92yGkVjhSrgVttdCiXX4GMR4DMFah4=;
        b=fddfBVP8UIFQqZbOTkv2622/ujj7xN6O5ywbBO2It8D89SfN0y7G8RyqQvqDdBJV4O
         j40HB9YGKNcXxPk51dkhJAgvQmeoIRBf7nheI2FpJc33HvEh9Zu0UM+kMxHo3Y62wLny
         yd0Clmi9Q7jkMGgIi0DTp0J1/z+LXFt/2gF+K0dnmqH3exi5yPfuSaLw37jN+qiqAnJ2
         1hIQoJdYN5QNefGZd1kvZjn3S7LjjnbOXGV0XpqJVFB+8yrkQpE7HSiVvvGs3a66CSLg
         zWBjjy1yuOhoBqpVIokNPRY0tNE/VZoLiBBchRvtUiiP4xcVOy3CRajNufMQVQumoazB
         bVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037264; x=1770642064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n05z2JgZ055VI92yGkVjhSrgVttdCiXX4GMR4DMFah4=;
        b=fN06qOGrg2JMKzFghcVTN5rm1vnxDOhb3tFNdWQeCWMzHvjMHBASQqyEpS74aODRSU
         Esqmb7Nhw4xoM9nv3mK8nHLH2PeNZEeKHi0rPAckl430zAqcka8wKnWYsXUAtS7uNgq3
         HPLj4rgthOlG6Mkq6gT9O7s6BzXdWLpyhoaziCkjtfGSceedRTzFvqjbdC6u1Us8CHLQ
         g046xvvGoQxYJrArR0/jKmCQuPPjb7GUbyD7LEvMVY0ABYmiMuucjuVEZ34zbCQZOIxj
         8Tjncy0QQyCXI1ulMQIp4EAcAYGMTp0nmZqkuLprOeqklGFBf2trtKb3nIzMIn/uLNau
         8uTA==
X-Forwarded-Encrypted: i=1; AJvYcCUiPtwUg9/QBIeZMxCpxvTB/btLhjh230yv9ppjGx21HNtfv81C7jhbSGOOhy3z17LfFHRVGgx8fsPY5s7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyufcHlFJZAWIr2ln5Q8KiEpCf2q+4A75NJ2trrGB1Wq6LMl4tY
	HFuB3vPXB8McbJPmGw4SwMoxf3iOrPaw11UAIaqMVbeVM4gC/ZyY9zYq
X-Gm-Gg: AZuq6aJSZblBzD/q74efRvu2Xfim/h8Bh2sOZbxsseglc2ZDqxkgIihk9ktL71pHyeF
	q1o1a6p1a45cRTOUG3dUsARcMaBip4vIdaacI9r0wFWdW94Tg8M8gePJVB9ftzJZnPFH+wP0ieU
	eCTUx4zjXtCJEIAoX73osEZweACfmQrlzoh2N/eFcRtDZjaIV08R8pzhfenmMS/Xhmb/NJwzlI9
	nQGn3uDB1AgwPDl7WEL4RUWme2dAuHkWme5P59Gyoce9pgvtsZGi3WjWXSh1zKEmvm7W5wXRcVh
	4bQ2m9ogKrKy3PyNBMSlmCpe5de/qCJoKwh7TvYd4veLb10H1lw7AnXHdpGPcyHCa8QXdkVY2FA
	WQH/juvY+zG0EQ9VUUCFRpRA2p6gw8IeB/saPLab10pXwGJ31kQn/E9/sBWY/ITr04enUlEXu/C
	4UszPstSh/4HSKmORkBsFQzCGYlv0kldjukf7WX2MQkzlnRBiiXPgyeQlkloAm2+pMtho7GOZCy
	1ajf3NrXXByKSDRvLmFupULyZCVQwUiwWZzF0eD6OcqbA==
X-Received: by 2002:a05:6a21:2d4a:b0:38b:e70c:63f5 with SMTP id adf61e73a8af0-392e0163a0cmr11067617637.70.1770037263916;
        Mon, 02 Feb 2026 05:01:03 -0800 (PST)
Received: from lorddaniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm149584745ad.93.2026.02.02.05.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:01:03 -0800 (PST)
From: Piyush Patle <piyushpatle228@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Subject: [PATCH] iomap: handle iterator position advancing beyond current mapping
Date: Mon,  2 Feb 2026 18:30:44 +0530
Message-Id: <20260202130044.567989-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76041-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[piyushpatle228@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,bd5ca596a01d01bfa083];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 88128CC90C
X-Rspamd-Action: no action

syzbot reports a WARN_ON in iomap_iter_done() when iter->pos advances
past the end of the current iomap during buffered writes.

This happens when a write completes and updates iter->pos beyond the
mapped extent before a new iomap is obtained, violating the invariant
that iter->pos must lie within the active iomap range.

Detect this condition early and mark the mapping stale so the iterator
restarts with a fresh iomap covering the current position.

Fixes: a66191c590b3b58eaff05d2277971f854772bd5b ("iomap: tighten iterator state validation")
Tested-by: Piyush Patle <piyushpatle288@gmail.com>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reported-by: syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=bd5ca596a01d01bfa083
---
 fs/iomap/iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index c04796f6e57f..466a12b0c094 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -111,6 +111,13 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 			       &iter->iomap, &iter->srcmap);
 	if (ret < 0)
 		return ret;
+	if (iter->iomap.length &&
+	    iter->iomap.offset + iter->iomap.length <= iter->pos) {
+		iter->iomap.flags |= IOMAP_F_STALE;
+		iomap_iter_reset_iomap(iter);
+		return 1;
+	}
+
 	iomap_iter_done(iter);
 	return 1;
 }
-- 
2.34.1


