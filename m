Return-Path: <linux-fsdevel+bounces-77117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PLWE6D5jmnbGAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:14:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED3134F53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62A263019447
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E03350D7D;
	Fri, 13 Feb 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkMJSyfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159A350D55
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977688; cv=none; b=CcRV2Xg7wmUipwnsFe5FI47PogRDvHfagqD3xA/5hNSGDl243k/z9sgY+V1hQzu9sETCXRdYJ/zMft72j42czXCb3hvSsaoRYCd+uMOxacQ0SrdBUEqvvawO6tS7EetYR33QuHBGmfk/Lh+wlGlrPlbbdU9zvVR2dPZ5eBGcMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977688; c=relaxed/simple;
	bh=/M98330tGPOt+Za6gFovoLt2EsfedQMkDZQubmEbXQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rrybPnm2PR7DfDJGnsdBSgby8lgHdOBUibrA06OtynV5CZDF25gYN3HTQGsEj2wSbIfM9rrQD7WVtJjYuLk0Vb4in421oFiLTAmzn5JoiYWD60nUrdS+JO1CrpUfFAmsxW7aZ6DO72ZWzQk5nlYqe0U6gO54Hbmvj04v9CmQNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkMJSyfg; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82311f4070cso463806b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770977687; x=1771582487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTXyYT/ElXmFJ1iam/3e+mf315SeVPe3Y1VsH7pqfO8=;
        b=GkMJSyfgL1VaCtdZBJBFzNlbgjtPxJHgyDtE3AkZazCpu8VqnZI5FwSvEDMdl96zX3
         C3tC54OmV8/EikeNM+8TW7yUGkYIe7HXajN93qv2rpB+InFG7x7a5VsT3eoR7yxf635J
         d6CtWARIKXaaSQ8gQjCRmYTSqp7r17Q9w9zHpl7RfSPmgpC5wxG2vEgG/ZbKuO8fDufu
         Thr7SBSZHDSTZHcq+dNkRFJnpCf+26w4KEGjbY52et9vRZaFIV4fBCWyyw4tkbnEcJfd
         Vm2nFEg0QshwKa/ANxfKPD/mxVcfidCNlCq7H99BIgbrUbfHbM6/ATnCDJQtlw06VQ+y
         AvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977687; x=1771582487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTXyYT/ElXmFJ1iam/3e+mf315SeVPe3Y1VsH7pqfO8=;
        b=SxtXhvfy8apmXxJ/jLfFtLs/A/dLBrS+/9cyiN1o9cox2tFAYd0/hwy9YaKkxAro0Q
         nP0liF4RuI26m5RRES90aFHfy/1t2odWQvosKcp0gVtbHMUfiJiVEDnPy3Tf6w1QwNUR
         5dGP39TaNrBfcsDbmfCwHdB5hEWxLGxDkDQfwZ8XAIsvn4z/rWg9WVlyE+uxLY2Ua77x
         /Ak4Khv2Ej4MkN+roatZweTTplYew4K4LSKAGBpC2UZS/WSlJlUEOs4GDW30bSTYkpWO
         cSdhEuEnjX7psR0MHKF+HUJipC6M+NiYtc+o0yhKuuzjJrQM0epV/4WzqJ4+OBh7VjOf
         dPVw==
X-Gm-Message-State: AOJu0Yz3LROYcdAmJTsBzCpI5KlrJy/RvJIOV9NSLttCtraCWr2+fIUD
	AxgDfkZR6etnsJJRA4alJ8GRWGeEky1tyL28ihvxiHW4SG8cDALbFS1s
X-Gm-Gg: AZuq6aKHmyjgi/AXuTdIgU2yn+L3HoH/Dh7tsj2ejt+8Qdj/SHtAHVYlHelyWnB3WgD
	/zwo7jkVCoext45rLOkAZVx8Kp7QmxgtNhi0SSHWXMTVREWEBS5rfv9JuVCLKoMs8wsxtWoNj70
	gQ5eW5gxfhVQQrZcRHIIJm1TWQF3pt+7AAoTDpnwgAH6nDC1NsWsqKU0q0oHm6Uj1fgGrZdBgO+
	Fa6qEbTTumLt4hHBXk5rtEjGaMFPSPpb4n6ogJcPyYawBTfBu9Pl0CL+EBZzracDBGwv3HEwHSj
	kivMBMhBbMWfkAQz1Gv/P5vBiZW4AIhXB9imZvNMYjAVBBNRBmljxQrjQ7jyBxNu3rVJe6o55lY
	3FEVc+MCJmu877TzSv5yw1YGnpoHwfhuefjR0u7kNIK//6/3YYbgLSfEhGn4D+WKZuvtF1m7WQf
	h7Qeg11MR+AupJsCklEc3yjudiEOzhpLO6sbvstxeB1vp/Q5Vr/w==
X-Received: by 2002:a05:6a00:2e87:b0:81f:544b:3998 with SMTP id d2e1a72fcca58-824c9d5f175mr1363882b3a.26.1770977686630;
        Fri, 13 Feb 2026 02:14:46 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e936sm2128284b3a.6.2026.02.13.02.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:14:46 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Andrei Vagin <avagin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Subject: [PATCH v2] statmount: Fix the null-ptr-deref in do_statmount()
Date: Fri, 13 Feb 2026 18:14:38 +0800
Message-Id: <20260213101438.2465246-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77117-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B8ED3134F53
X-Rspamd-Action: no action

If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
of mount by IS_ERR() and return.

Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@google.com/
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 fs/namespace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..eb7d2774ee1c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,13 +5678,16 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 
 		s->mnt = mnt_file->f_path.mnt;
 		ns = real_mount(s->mnt)->mnt_ns;
-		if (!ns)
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+		if (!ns) {
 			/*
 			 * We can't set mount point and mnt_ns_id since we don't have a
 			 * ns for the mount. This can happen if the mount is unmounted
 			 * with MNT_DETACH.
 			 */
 			s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
+		}
 	} else {
 		/* Has the namespace already been emptied? */
 		if (mnt_ns_id && mnt_ns_empty(ns))
-- 
2.34.1


