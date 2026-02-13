Return-Path: <linux-fsdevel+bounces-77111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KSNJlHkjmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:44:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED101342AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1584C3073F68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D1833F388;
	Fri, 13 Feb 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZJgcu95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05033EAEA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770972188; cv=none; b=sCsOXGEdLSLHquQCmpq3OP5SmCCE2bRK0uuli+0kliBeBQh6Tu8vXNU//zEGJkoWFwBIs6I54DHj04AuR1AgqigtLNdlQvgUHjsQ69QVZQqJ0U5ypc255KIFeHE0F1zRB0BTF0Y8WisAhhEG8W2CFJIR7SSbQ38pL9h4u3lJJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770972188; c=relaxed/simple;
	bh=NxCYqN34WLJTc9Pcc4BBDRodegrRP2eI+h4ZqaAjuug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ry/hdMV50CKMY05yZSf/WmV9Da1MDr51rHQdHTulCoYCb9xevE3zlbCrEOMava4SIfTCUIhIfDwui0nRp4i5SNX5a5HyfVUF9gGP123GLOBzFxW7MFIzXVNkZm49Txj+lmdX7xfVnMNpHpR01S5QBewbvKTfZUvCfGDaB11zvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZJgcu95; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82318b640beso364354b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770972187; x=1771576987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKwph4S2MzqY9v322yTKXjJqoikUFMHZn7P1jGTDzr0=;
        b=DZJgcu95MKY/mqE6xT5ZY7gnkFKKZKpjk3AIys2UsMj0eCuadQqQ+ZfngbDsHuc4d7
         cV8I4rwPBO/+SPTHmVISPE0KAjzxxj7hlLJY6FajKV62Nn0hPPMlBVCmgUeSLKlIXUlH
         5RBhwd4eH0WuUm3LBaNgfyfx7dJfXcR3flBFaSWshbk5djd7eiLpEQpLT3j2ptTuSUi+
         m6thuKA3PyFBNMnyUochOUs/tHKbL0vG+m2a1sFvb/S8CvAGrv1FB5NJzQv2clz+GRu4
         qHVF8TSrOkGQCmHkWTU9Avd9S9BRl8NiCcjr1v/ldrnvxh1jt9bg/b9krc/adYEJxB1x
         GsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770972187; x=1771576987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKwph4S2MzqY9v322yTKXjJqoikUFMHZn7P1jGTDzr0=;
        b=YDHaX7c4fJ3uGkK760VnExPuQ3lWqIrsA8urnjmkBmYXXafmU6urGgRnzmp5CCiY+Y
         LrqfP/e71zbAe2dHewxmXttoCRlusuzoznMgxr5x3FjQg8qlJ8yz8FX56o7ZMQ13txki
         MKx6fClyp5/iH0OurUNePWrqgRTWB+koRTIbIMVqR4IGISaHLcKNseoqp3eTZWIJj3qe
         2GlfNsI0g1De55HL4+CGnqzPb6muBGE+wDklCyBgn0lwZwR2+HD0Cj9njY7lh7pY2UwK
         KIr//EDRPq1uvhsKLuYhJIDI1OBRudXJ1xHhDd0m5Pp+iZRE78CM9AVaudjhQwdGyhRN
         SRVg==
X-Gm-Message-State: AOJu0YyuQfom0elQ77FYMKuZEar4wb4ZTs31pHwMBwEYZUreRC2p1vRP
	ZxQjp9KhXUneOcV3Lr/vyz7xK+JQHBkVvsll4D+oiqQT8UiGCcQ/xFTd
X-Gm-Gg: AZuq6aJ120YUnWbkoFrj2NWy076FKTJJoeOM9WsgFsiqR/kj66pGS4o8qdaylclCe/A
	ry1892apg+IzZtw6CyPpSR38hztULhUkO6Qo8+iFJ/7BRce8Wyw/VDtUD53KUWdeHa6hByxX2eW
	rOWsWyJEAHAa4Ixg/qB3oC3aiQ5qz3vEY2SfybpBKXqv5lMvQKIdlIeWvFe5/xaHJEXK2FhXlzs
	xqT/yyqTzXgvCGiYq0Q6ArT+6hSWiRmhq15k/FFKlEs2PTPld9w1umTHdUcHwbkcvaIbjsBhrFU
	v0D2WsUFBWlPeOpgG+hHvza1LaTgUeDCnA+GEKWtNKc8VPXtqXYsoMfzBVBPV8pXjZRCvoxDSai
	S+V9ga3601UKoQXTXh9PJKjAtdoVkFHRwq2N3jSdlpLxYB6RjmPplCoKZn8y6QiJYjQ81vBhyVn
	qDA/qeSkFAm0AKYNkrvg97jGsBED2XSNU72ug/eGP+jimos/piOg==
X-Received: by 2002:a05:6a00:6c8a:b0:820:2f9b:fe31 with SMTP id d2e1a72fcca58-824c94efd3emr1305748b3a.30.1770972186853;
        Fri, 13 Feb 2026 00:43:06 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a62c48sm1695723b3a.29.2026.02.13.00.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:43:06 -0800 (PST)
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
Subject: [PATCH] statmount: Fix the null-ptr-deref in do_statmount()
Date: Fri, 13 Feb 2026 16:42:59 +0800
Message-Id: <20260213084259.2423971-1-wangqing7171@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com,gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77111-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 2ED101342AD
X-Rspamd-Action: no action

If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
of mount by IS_ERR_OR_NULL().

Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@google.com/
Tested-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..d769d50de5d6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,13 +5678,15 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 
 		s->mnt = mnt_file->f_path.mnt;
 		ns = real_mount(s->mnt)->mnt_ns;
-		if (!ns)
+		if (IS_ERR_OR_NULL(ns)) {
 			/*
 			 * We can't set mount point and mnt_ns_id since we don't have a
 			 * ns for the mount. This can happen if the mount is unmounted
-			 * with MNT_DETACH.
+			 * with MNT_DETACH or if it's an internal mount.
 			 */
 			s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
+			ns = NULL;
+		}
 	} else {
 		/* Has the namespace already been emptied? */
 		if (mnt_ns_id && mnt_ns_empty(ns))
-- 
2.34.1


