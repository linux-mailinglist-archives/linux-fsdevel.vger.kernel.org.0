Return-Path: <linux-fsdevel+bounces-76055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLV1DdLGgGl3AgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:46:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DECE68C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E4563002B62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01597376BD0;
	Mon,  2 Feb 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbnDctMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6242636405E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047104; cv=none; b=QEVqcRpC1RQbXtQPbRWsq8X3prymLif7JigClVDYQwhH7EvJwvcLQRwxIs5jDWidGTyEIchkhd6PAmzJWxBlL4Jf+qTciYHuQmV/aBqPx183f0NtpGvCsiJsEW5LJC9Adz+Yvq+RmL73srtcTgYBsYSSAgg+WawFERCjscxqTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047104; c=relaxed/simple;
	bh=apmosNlmlGXu84xxAwbeHewfRKLaSp4Y/cXTo8RIVDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EP2JBnLsPDN7FbkAbdB1ivEpZ7EKNd+fxcauY0OhaBzcNmY0M1k7qCOXEU3kxtarH4IwmBrikV1hFyNB70KCFQfdC4xKbajFJuMwIYtwS6zkaL4Qz/IYcGQWIZLvHmjfFkaGVcSMiJHLEPXHJ7WQellv2zjzMJ6aK9gq1rFtBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbnDctMW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso2847894b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770047103; x=1770651903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK/86Nyk/EKSMMzdzRby3gSajMQfUiZyejcUNvrlmaI=;
        b=YbnDctMWIILWQWskhbR+4tTXyETdbS6st6Enj2mJO0kWkeGloerpg1yF+9v+X1t5W8
         Sj9syCkLZJn7KjVVY3gbLNxPDq9Hd2DRzwg/Eez5uviN+mnPbti+LhqQGLY5CM+BmmhH
         NvgoZlr5M31rSlr8XSAp1aDKEAah2MeZc+rQ/bAd5lFlh52C78qfufmRt/Mh3pWDhmrp
         EKiwyMcpXOpBcxowwNql9IE1Nv5a8VjFV8l9EbfQYuZP+xDqx+K7ih8/UL8DcCalXwOn
         oFmPQp1GU7Ub4r3dr0icNp6qTESH1RSLXM9RSHnDWGnqK/pratDDzyBr3gPXxmfq4Iv1
         j6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770047103; x=1770651903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bK/86Nyk/EKSMMzdzRby3gSajMQfUiZyejcUNvrlmaI=;
        b=s+ctDnc9BnDZ9eJDVkhQmdGdBXi0b6IfsoF7FljxSaW9R1MG+kN1MKOfmL2UBg94ua
         FVcXmfWhwde6DcX+XnL/NB44V5/HdZw3xuZHIDSwRXOVd3yifC8Uga9tB0MVBIcBlVym
         HsXesPXfCm9+k4J7skqFnBmmsIeR168oroiWCsCgZBJ0Uab4WvuAmsCl9kR7cbvdt0uK
         rQPoerZhb6RWGKmXPWaou/jbgZxeowZRxuODZtFhbHXIlgaKnS0RdoxSeB/3EXfK0mb6
         TnSBhEoYNGZhuEZsX+v6xXm+WjyLsnA0tIHoFDsX8yBEMCdowydVxY05z3OqZ7IZX+fE
         S4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWL9uvrloYLGbrelpGKsGNIKf1OjZ0Izy/VhEtL5pmC+5S9qyBbV4jLR2KTDKRG3ZCsC8u76vrpxNrpffo0@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7KKqYriqpjlw+mbDJh1CTHjMLofpWWwXzbsMK88T5olgRoRl
	PcxPGhNwSg7/Zocvf0XaM2f96qiuEkBHoerXX4ppWu7yelnHJtOg82Fh
X-Gm-Gg: AZuq6aKZ6LXO81AV0p/L/eFMWo2vVZllygidLPQJiMTRFrgGJhxrujB7tIUC+eG4f6n
	C3AipuOKZ8nst5LzxhxMH2DMv4vE2YbIc/VL/h5VDHrAWGFs6q7epOHhtxgA5cxNECYmtp7tmyO
	qhwgnb4KdsG4wu435uwpY6JYxz5NwWgt3dhL2U4zyfvsSSL2qzRExpfHViq/SvFZxpqtX1rc9nH
	q9X00ARdNi/EVVBolgVUiSlRFWUc3lMRS6sN6p5tqTECXv5ZLyCvbme9lvUzbeuPixLDir+M4OR
	3KkaHlUrc8/wNGW5DOqs7+W6a6A62Oj4vo635uLHqtSumNJtVD9rpjtoiQDEemeuvsSJJYQ9ecb
	pTBhJTPTA4qV00/1WTOnSMfvZNsPVpCTxNK0dVlVaKSsxcnggSRNu6SGXDF2djbZVNXFM1Y4dMd
	PSfDZUInymHnUlYbMv3qp06oQdyYUHumF/L37p/LeUxA69xJDx+3VIN4n0uNQTVxzG/W7pSR3bH
	Dz6fUyDU/5jpHIeuBnZ3MhlRjtuQvEmELVkM4WnKmWC3rwiP6+UJ1RX
X-Received: by 2002:a05:6a00:9185:b0:823:5f7:ecb6 with SMTP id d2e1a72fcca58-823aa43a1camr10597514b3a.17.1770047102767;
        Mon, 02 Feb 2026 07:45:02 -0800 (PST)
Received: from lorddaniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b4ea8bsm20074206b3a.22.2026.02.02.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:45:02 -0800 (PST)
From: Piyush Patle <piyushpatle228@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Subject: [PATCH] iomap: handle iterator position advancing beyond current mapping
Date: Mon,  2 Feb 2026 21:14:53 +0530
Message-Id: <20260202154453.650471-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202130044.567989-1-piyushpatle228@gmail.com>
References: <20260202130044.567989-1-piyushpatle228@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76055-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C1DECE68C
X-Rspamd-Action: no action

iomap_iter_done() expects that the iterator position always lies within
the current iomap range.  However, during buffered writes combined with
truncate or overwrite operations, the iterator position can advance past
the end of the current iomap without the mapping being invalidated.

When this happens, iomap_iter_done() triggers a warning because
iomap.offset + iomap.length no longer covers iter->pos, even though this
state can legitimately occur due to extent invalidation or write completion
advancing the iterator position.

Detect this condition immediately after iomap_begin(), mark the mapping
as stale, reset the iterator state, and retry mapping from the current
position.  This ensures that iomap_end() invariants are preserved and
prevents spurious warnings.

Fixes: a66191c590b3b58eaff05d2277971f854772bd5b ("iomap: tighten iterator state validation")
Tested-by: Piyush Patle <piyushpatle288@gmail.com>
Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reported-by: syzbot+bd5ca596a01d01bfa083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bd5ca596a01d01bfa083
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


