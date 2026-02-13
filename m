Return-Path: <linux-fsdevel+bounces-77118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACFQEUj6jmljGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:17:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A39E7134F6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 803C83048093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6896032C928;
	Fri, 13 Feb 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cffyKMuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031922BE02A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977857; cv=none; b=Qj2bNSz+H4VMNgP5YK5Qq4dSgh7wbJpsOhTL9mwQVwfjIHJZZKsuLXGXB4bA+9X2a2pyVf/4HnjOV/eDY1fUprEiyeLIuofXTdVa8rew3QauMxn0qcM7ZufewqLtycURq99TRYbjS6ZVOF4Hs8LdF1XAFv7QrQSAaf8dLfrfOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977857; c=relaxed/simple;
	bh=xqSlC/3z6bxxyxnU8/W/940/ETB6pCeEtGgHV4pjbyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msd/oCAbVToeeTy3IYBAERV2ZEtQ8tBt9VecwaoPItO0Ka8SLH7WiwYiNlDkgSfq4/Lcciy2BgQz0t2KFGVsG7LZv/kU/Ek/m4KmaGKC2hposvmPu1g4/Y85sA31JLQbDvqtP1Qro0i3ZsuW1UIcwwwUNlmSn8Eky0JBgmxAx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cffyKMuR; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2aad1bb5058so8055895ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770977855; x=1771582655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCK+l6Mm8f6wIMSyDkoJB6QHrq8mlbnpJwATISq3RKQ=;
        b=cffyKMuRftq2Q2SpkS1R3QiQ7DSbaYylkMGxMfOOYqErRJy8wV74W/bfCgMmCSYGqO
         iDy87hMSYT+Z+SQgHUoXNiwDONbzaI7cFlHvKWCHX64LvUzgnAJ6YbbTxUCXL/xuW/hf
         dpb3w94g4eM9L2Ys8x2CdkDcTyeTin72fBNjqVToqOL81anHM6RFNKtzkf/ALD87HOmH
         fujz/bbqFjlHwY15G8BcJcyTase6KKPbNC0sWBkDi1e4of87AbO/xp60aJeGQclTGOrL
         umtbexd386xq+90Kyk6olbTNLWAkKQP/aufqJiLB791JyjjtIw+mBaHWsgqwrKaI33pq
         GAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977855; x=1771582655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCK+l6Mm8f6wIMSyDkoJB6QHrq8mlbnpJwATISq3RKQ=;
        b=TD5+3IDtwcvdGIB3DvYdXhPwmncEf5SU7ID/asqu1PEXFKL3BZhgiYgDBqQvcX5H3T
         BfJUbx/RSvtgIjdR3Mqh7poG52irJ0noKPR5EJDfzhjiVOfp9Wb7lh6Pd88EtiAkI9MK
         RmdEj0EpUte506aoilC1b7RpAdhinCmoGGONBXhrLXzU0/45SrHDwbS8gP0I1/QLmb68
         v0jQHYHwIhvVwx3kUVWNSm3HNvtL8ngeMSKnbsqTW0i5ZzruPj9ukaOHUXRzkkOXWZrX
         6T+jYXweZkukVR8GKiOt85FvVxaCA0QVL/X6GZf78g0Z//Asu/olOAzVmykm3cxoxf8W
         IiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB+35nqKy5tw39apLCuap4dqU8Y3YGF4EB3/S/EMJl3G8nLp63XdI6E/TlPLOGqb3X5Fvykr1svKHRd5q1@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAWmlIKKadHa9HuCCgLte8rIsdo3pIqe2Qg7Iclrc+bP+V4J/
	YUiDyoW4DYPycJPJ+wv/3d6QnbPnD/cnvqIbS6PGnec/+HjGFTEfSjOI
X-Gm-Gg: AZuq6aIpxUyL8+GDCzZ4xVPwQcvgO33C+crIDbBZK5c7uAbiFLFu67RZwVlXh25CCpy
	yW80CEcW9Cs9L3+BdEpJairAgOFZwS9pQz+3bJjTaagEBakUwRH18ILw1R31wQ0HbPVVGTH/Drv
	+BxMcrsni/LaeFGAh/bQozzhPVhBSrx3j40efssuo1s32xHd1NJYnN73VJBDnFHEk50kDTSXZJo
	7t06kQVyyM3Tk4TSr7S2Js7ST3dwnL/UUeQ5QYd/EfpJ9gLesSZ81HJHUH9In1bX7EU3LAh9Pd8
	qBfhGZpsug0LyPLKgUaQ6Ybh6CDMDwxAoqqVt7OmsUiV7RC2Arl9I68zx33VRe08LA/Qh8FA1qV
	I/dvVSBCZDVKZ0I9XLXlbrFJbsMey9pFlvXl8+7ok0OyDcIXU844/Zjziu+Z9dz/1zog1C6LSaZ
	nAJEeVyFfQidCFemaiXwPJc3ZAKECK4WU4M4BOtiGUPOAB4fOVZA==
X-Received: by 2002:a17:903:1a24:b0:2aa:3b3:d633 with SMTP id d9443c01a7336-2ab5060e0b8mr13986075ad.61.1770977855399;
        Fri, 13 Feb 2026 02:17:35 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29966612sm108794905ad.59.2026.02.13.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:17:35 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in grab_requested_root
Date: Fri, 13 Feb 2026 18:17:30 +0800
Message-Id: <20260213101730.2466521-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698e287a.a70a0220.2c38d7.009e.GAE@google.com>
References: <698e287a.a70a0220.2c38d7.009e.GAE@google.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77118-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A39E7134F6C
X-Rspamd-Action: no action

#syz test

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

