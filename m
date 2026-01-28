Return-Path: <linux-fsdevel+bounces-75709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GOiDEzseWkF1AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:00:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB49FDB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90183020D79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 10:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2B338F36;
	Wed, 28 Jan 2026 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLqI9YlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A312DC798
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597852; cv=none; b=BdjfEMWD25l+/TKQDadwjE7TywedEMRKsYIKPxnLfrMT/YjxCv0FiTrnBT+LgeL02hI76fgrUYxb6TJACoCOQ/lFnVFBGpOBVPfQlo381VSN74/YVAH4MK2X7IIgrUXeSt8vIQ52EjPZCBuYSYmv44eB91RJwUIpAWnqqUDNpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597852; c=relaxed/simple;
	bh=MiZk0yV+ehAx1vsEnQqtv3E90tV22HvjkRcKqms7wt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3/cP7KNAzAFRulr7+RS5uw28dUODrqte9f+osncKvVvh6gZ7fkcZqhJDi/Thq9fxKvuymm/OcGFe1rwELOaopvas1iqSJGa8wpzRAJ2oSBdRroWrdmMYS6aebjujEHMZYD41ufuzUK8Ju5XfIfnzVUS9nH2OgOwPW5YczJTyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLqI9YlO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c5265d06c3so79017185a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597850; x=1770202650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNhwl6noO9rWukaFPcFXprUPvgSLEFAYx36dCWzCTLo=;
        b=XLqI9YlOEOJkE6xqkf79K0UkwNPl1JD2SHRIvZb9YkRWAQY4qG8SmfwTXht7MbBIuH
         mhqNrXuhSKQfUDbaGb7oT0PTnIL1lyhnpC6cJ11K7lcB9mUsTQezBLpTnFgq+0cbpTUB
         CzbBaENCZwbMSqlf+EfTInC4jJ2f8CYxPV8wCuXeT3s+Uv954KILNIadID0XQfOKGSaC
         VS2nUGMH237izIKJZhNPAC7F92EaQnbQ33P0EnlODWpkOor86IE/IpwzK8zvJc0sGroc
         QgIirc9USbMwAkkrp9JdpxYEZK/O4gPzf/touQKdg9d424gQdD7gUJ155oeO3Z/LPj24
         WDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597850; x=1770202650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNhwl6noO9rWukaFPcFXprUPvgSLEFAYx36dCWzCTLo=;
        b=IsEkmcvq6FuQUDgxZtjjYrU7/mU1A0ewlETDTp1K5vGQ750w1bFoquIauhbGQnluDO
         xdYddn/J8s9mlP+bTPBMsNHCBnRENuNg4Jcd1GwWTkEy1Qxhtcf9XAhZfCaA/IXSR12o
         aaE0RER3iC3P+r32sRfYtUWTr7/XqdKrRei9H0T8f4lNuK+Z/Zc/6Hc8fsKJddHu+2zD
         cOrX3EaiSUnXPkt9HcR524l/CvJzzKb38FAhg5OiGujHCFL36Srps3vFlkl6lfznl0GD
         VfD3rC4h6lsvAT26cP3rvxR3+kGXPjv58LnVDNAAnfNDiM9uWFXCxPDp7jpw68Zy3hRw
         2c0w==
X-Gm-Message-State: AOJu0Yz57/suU2FdJvgcjmrrhDGZmJeUq6FbSmDCDH5vhremOC6cuckN
	Sh3gWqQVOmhGllOyXNYbcUKkMGvW7wzElWydrrTVhx+FuX4/I/p3sthc
X-Gm-Gg: AZuq6aLn7tZhN6TLKkMwjRwQ3Gx/+fkgxDR4L5vxuGJlq7QNXi4OQVz5khGmGE/FPTn
	P8ZltC44lWma4QZEihQA/2/vOEITq3Yaha05CHAw3XW9fwAqRG/xVRHDAAzts8R/ZQlhaInDtxL
	YhqdhmURDDk5cmCa25HgdXVV90tWZKSGnijC+WT7d/IHdiURNNijeyAeogxCTXwTpeGdUm5W6sD
	uOhR4b/86PsxmowXhd3mW4XGz7go0MrfnMXNi7xvSCogWlZXai9Wq8IR+7pLPIE317bGUYm6U7z
	5WiAFKI5GlSgqkNW0qUA6G4e7f6AILY/Rzei+6uHuNrTzRw/lcUP+nqjcVkqopDNQnx1TlWYDS/
	0VTJZClIVnYgQB984NjQfmBnNR3zKCJ2B2ru40UkZwhCtWaDdTCPwKYGXx0UnmQuzMudUjLbEzc
	dS4JbgWLInNwBFu2HtHk9017v+QjarDQbvuBZBNlYOHExUj7mwMQ==
X-Received: by 2002:a05:620a:4086:b0:89f:cc73:386 with SMTP id af79cd13be357-8c70c18a01emr530778585a.13.1769597850363;
        Wed, 28 Jan 2026 02:57:30 -0800 (PST)
Received: from cr-x-redhat96-client-1.fyre.ibm.com ([129.41.87.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7b380sm164320985a.10.2026.01.28.02.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:57:29 -0800 (PST)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] fs: dcache: fix typo in enum d_walk_ret comment
Date: Wed, 28 Jan 2026 02:57:09 -0800
Message-ID: <20260128105709.3475258-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-75709-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chelsyratnawat2001@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FCB49FDB2
X-Rspamd-Action: no action

Fix a spelling error in the documentation comment for
D_WALK_CONTINUE.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 66dd1bb830d1..5b591a5f955f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1299,7 +1299,7 @@ EXPORT_SYMBOL(shrink_dcache_sb);
 
 /**
  * enum d_walk_ret - action to talke during tree walk
- * @D_WALK_CONTINUE:	contrinue walk
+ * @D_WALK_CONTINUE:	continue walk
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
-- 
2.47.3


