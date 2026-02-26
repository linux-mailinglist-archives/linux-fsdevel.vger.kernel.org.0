Return-Path: <linux-fsdevel+bounces-78590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Lz7IV6JoGlvkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:56:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285921AD115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DDD03252437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCBC3603FE;
	Thu, 26 Feb 2026 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfBu1XsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40F364927
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122173; cv=none; b=rK1bkupX7cB9WuSMW3pT9TcCxgpXXpKl6/MSfgXBFzVYGOY86YV2JnH4nlka+umnpnUz/jX0jtUjtg3kvAnypK28ENvlSFM+qqQXJx6N2vtBcVTt3YpgJLmXB5D1iyyqloVuTrLGnCju63hdRPP1PeprW7G8yZ8ldtpVGhPAg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122173; c=relaxed/simple;
	bh=BNXRnQsioUUb9bosFAHfjcgiZPyuhfz+W0IXydZGb0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUt3wRXBsv4eRaqu5BCZ5Zc3nE+Fm4C9UZKqmDtveh5Em0tun1PtySO4gm213o/yB4P+kTMc2hFrsBGmq5gqEA4Q4xSWaGFKv2vegQmXvMF5sGR3kiC2457w0b+jI4i6hcnYJKzue+hc/nTF6rehQu5nUXRPzNk0GeFkAehmxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfBu1XsT; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7927261a3acso8061117b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 08:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122167; x=1772726967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr9OUWJlzV6KyFu2dUOpeqmh+0oHETiN+VeCYXo8ah4=;
        b=cfBu1XsTQkI1a008eCqXGxY3tkKfttEch8XfgjUSLaN8RqWwIFWszHDIBhHVAcMFEX
         ryVUiGjxrSp/2kHB698H8IAgs/skkoefYEzd3d1/K9/nnS2Z8pqCDp4ZqRqTEoFpHHf0
         5OgU/iJVI7i7IinkTtnl2gIAXniZTlPRd/c5Tby697L9VsPdDBGWCHO9LwV3uVOt0sZk
         /u0Opluor8xrkGCh0O2F9eGR3ANL6/GkrQ/jimX63g1eCFxVjQ7BK0KIWmVR+9gI+H0p
         LDSFJfNK+oChvOZ5lMbVsR35tgfr1fU3OlCS0gons5+yroukFRK8EpVfCouf7/PemKs7
         8v5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122167; x=1772726967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr9OUWJlzV6KyFu2dUOpeqmh+0oHETiN+VeCYXo8ah4=;
        b=US/Z11qMBQl43REc2h5XxwxQSAj+F+9qCcxAHEM7uNuXkhZVCSs0dOpVnDc7a3d5ZK
         MVxCy9oxRpUyNsc2wh4bu3zOXJ7ChHrTeGl1J2mvOwelsmlmTQijEveZQOPP/S8dCHZo
         OCnn11MnChJzWGIniusgPSW2aazmZ/lCo8TY+rpNJz2B3Gn3MbwXcJkSbr9VS89y0q/D
         ERPZHQa054i0onvYjvElK5fRFb2GFK4VfRsG7tkUDD3aGLTKala0xXl+HzwmHnWvJzYJ
         5d8bkquyp7vrzBj5PUuyHA3KadwAMTv9/6LalRLkZKyc9DGxP4OcbqmSPGhi3igSCm53
         TGSw==
X-Gm-Message-State: AOJu0Yz1GXKSDrAtjW0H0waOb5mcduNbvRH0h92PLtolgDMwJ2crAa1b
	e2zzUOIpJpvK6neeeHVjAj7FjRLwjI7p131mDIxPcU77X18FidPkcqOt
X-Gm-Gg: ATEYQzxfEpsITvWHPyqMRbCHeG2xLkAAoEvyyTsLRERH4RcfEY2QC4lVYx+qXSZIfqW
	XkFd5YycuC+C7hroLzSoyGb3A4sW60qdhXfIcA1OT75dKL0wC13y/QpHSvAF27ee1c69xiKs/hg
	25EOP5cU05sZI7EnMKbR+CwwwCGLHJerrgBx8qsMNAO0wR8FhHjyivbhnQR+MZV5ooRGWU+/I8Y
	fnORC9SHVcgOIKW8Yy94UyxQ7cxkSKvEFry+M6Dc0U9NHPHy3BQoLk4/17kxD2aPVbi+LAqd/ry
	wIgeFGFLlhd5EIsVUc+a/LKnEVD/1DNn/X4EQSlUNaVJIomm9n8slB0KtOc688tbQN1D4RSHlK+
	J2AyJ9GOTREN/SSSLfdIEv/6g4/SqqRRhQgB2f9QmTVXZ0Bn5hXyircbQnnPPWvjxtpWPtZWlTm
	UQIVpEVIG1Lc8SnFK2GfMg00ezzFCEgBwgNWKr1xA3mYaqRP8EEiBgdZ06vJ6gix/ilOBYAJLOx
	WmeVBXxYgLW7DixauPsr00t
X-Received: by 2002:a05:690c:389:b0:798:270:fec0 with SMTP id 00721157ae682-7986fc9b3afmr44428927b3.5.1772122167314;
        Thu, 26 Feb 2026 08:09:27 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876cb9f19sm10225967b3.53.2026.02.26.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:09:26 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 3/3] ntfs: Fix possible deadlock
Date: Thu, 26 Feb 2026 10:09:06 -0600
Message-ID: <20260226160906.7175-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226160906.7175-1-ethantidmore06@gmail.com>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78590-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 285921AD115
X-Rspamd-Action: no action

In the error path for ntfs_attr_map_whole_runlist() the lock is not
released.

Add release for lock.

Detected by Smatch:
fs/ntfs/attrib.c:5197 ntfs_non_resident_attr_collapse_range() warn:
inconsistent returns '&ni->runlist.lock'.

Fixes: 495e90fa33482 ("ntfs: update attrib operations")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/attrib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 71ad870eceac..2af45df2aab1 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -5124,8 +5124,10 @@ int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn,
 
 	down_write(&ni->runlist.lock);
 	ret = ntfs_attr_map_whole_runlist(ni);
-	if (ret)
+	if (ret) {
+		up_write(&ni->runlist.lock);
 		return ret;
+	}
 
 	len = min(len, end_vcn - start_vcn);
 	for (rl = ni->runlist.rl, dst_cnt = 0; rl && rl->length; rl++)
-- 
2.53.0


