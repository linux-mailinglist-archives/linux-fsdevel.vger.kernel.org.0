Return-Path: <linux-fsdevel+bounces-77077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAkGK0fMjmkRFAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:01:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437C1335C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C60283019D73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421072727F3;
	Fri, 13 Feb 2026 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzaLE8NS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83514F70
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770966080; cv=none; b=EqQr82BfWbkXa0VGBwpFR8gq7YFNY1xBtiQFQxf96SIh+sx7d2I1o/Qt7QPDmQEDW1FnkBUGJlTs4KKSgsfXfjku3ongzQya2N/e9tU6jAQl89NSKNUkLudE0fABkJVvTiPoLKDrP5SlvzskK1Vn77Y25R28Gj7L6LRLQvrXa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770966080; c=relaxed/simple;
	bh=tYhq5O/J5HyEwiMGqj2LEElR75ZRjhFOE1ByAPWfPQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rm5M8zqjatGF7m0F1wJotasjzNu/VDfHCvG2J2owALB6YqYvC3Kz+lzANOyAyZyC9qTReHHOqZeQJS44VGEYvxd0Yp7roeDe3v1mCjq/z8voE388MEXDzeS3zkyc3EP7Wkkm/IVTrCf3LUNg2x33yOhhlIvNXDu02Jk4gczSbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzaLE8NS; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-823210d1d8eso362392b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770966079; x=1771570879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akk4OBm6V8gf9IwSXnVntd6+9BeCLj/YUzGcRSAKCaA=;
        b=kzaLE8NS29qFyp6HeWaagj/84v3Dz5QtHQlzZZoGq0EZzSKiIhFi9NwH3Q6boXy/eg
         Gv4EZbBeahRGrruQpafNkvOIq4NJjZxIs9sMn5+jxeZx+JmzQNSHvCIagyVO30EuO0cI
         e920CQSVmwV8aAKukBsxcYPsHFr0FuQHZu+JcGSWvFQS5RAjcW8Vvyknycxx3WL8Cnct
         2n0napaR3QumWAvI8aHy+k7sB99Om61TOBqWMo9HYE516lKv1szkUqLxTvGy2fysW8wk
         wPrTSOvXtgdmXTicHM/zRSzqbpMCU863JTttdyV+4pIx2djSF0gTcMFlgDbcB7PQhMgH
         GAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770966079; x=1771570879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akk4OBm6V8gf9IwSXnVntd6+9BeCLj/YUzGcRSAKCaA=;
        b=YR4Q1L9x9oeSrE0r77s5rMxfwjNb2lnKcEnoXSW6S4GrVl7WiQ8vUkcwKUIOgcKd+S
         GgKftEfEOO0TSvcwIaM6ghaFiV+oKN8cSwjvB1W1fAbuvmgpsFlqYrlp9ysUym6wlJrr
         BKgPmOY8J8+kwZUXUsRXoICTfqzb4Fw6QstdsML8UaFAjABkxsZE4UW51bKwaYyiuoBd
         zwJlE99fufSZ8PkBIwJVmpvzJFQY08I4Y1nF7B8NlJL8iaIf4GJkyZulUttOO5Ejrjl5
         W6pCcMudCgI7OYG8WBKBCekbWj7V3iSa1sBopwaqamS2KchknDnTNyu44IXyucK15RdQ
         lU2A==
X-Forwarded-Encrypted: i=1; AJvYcCVN8r0+C28sejmPO64dTB952XtDmk4r7ZBBQb28RzXes8mUAQvOhRrVjxf1v1ff90bt14glTLtwY0Z9zdmH@vger.kernel.org
X-Gm-Message-State: AOJu0YxegrC+mFWYAAu52/Zr7WIx5DBbwB+1f6xv0YcnPEi+JjatGWJu
	y+fy4r8JTZ7iC9rqLfcUq5NXdENwnK+xRWsQd+O8KAXUHB0ODIjVRVfM
X-Gm-Gg: AZuq6aIR+OL4c2cOJJu5TEoHXqpzX9IB9S8pWaptrRuuytVfps/Uc7Sbc92NR4So1ax
	TnhHQ1uolNU8CvK5ehdGxKGX2V60+cZxoFTKZmL8Uetb9V1c4kF/v54ctAPamdbfUfCWrYhQH6w
	j/OH0iB1lvgaZq48+tWa/rsrtgC5twneUHQqFgQneYhQsTMurBk708xZgn/ApWIeh/oAKYdM9T5
	1pjcolUALNfHAWYkqYF+H9J4GY96KzfnEBwLzO64Lr/VFbj/owVPIgdIbQY4DedliJW1h3uSaq9
	aPV/iOvYoEsgwshSCgNLizToSuqQHbF4o3tiG7EATQ/ejuCcYTY5HohMk/0XrCZBwzqoSuPNPuY
	yOYqK6KRxtqH6cnLG9CtVSKjMDk0iOnh4YYvoV5Ll4TmmPENgUdXDlI12xIEnWXiXHcmCsNZB7V
	Zq8XzxiYsuMid8lPi4M55HZ8Os8W4DLN/0iR4wOSewCgHFWZwRNw==
X-Received: by 2002:a05:6a00:bc8c:b0:81e:b6fb:7561 with SMTP id d2e1a72fcca58-824c966b13bmr936820b3a.70.1770966078637;
        Thu, 12 Feb 2026 23:01:18 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e936sm1329702b3a.6.2026.02.12.23.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 23:01:18 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] general protection fault in grab_requested_root
Date: Fri, 13 Feb 2026 15:01:13 +0800
Message-Id: <20260213070113.2371490-1-wangqing7171@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-77077-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9e03a9535ea65f687a44];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5437C1335C8
X-Rspamd-Action: no action

#syz test

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..8124f33d89a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,13 +5678,17 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 
 		s->mnt = mnt_file->f_path.mnt;
 		ns = real_mount(s->mnt)->mnt_ns;
-		if (!ns)
+		if (IS_ERR_OR_NULL(ns)) {
 			/*
 			 * We can't set mount point and mnt_ns_id since we don't have a
 			 * ns for the mount. This can happen if the mount is unmounted
 			 * with MNT_DETACH.
 			 */
 			s->mask &= ~(STATMOUNT_MNT_POINT | STATMOUNT_MNT_NS_ID);
+			if (IS_ERR(ns))
+				return PTR_ERR(ns);
+			ns = NULL;
+		}
 	} else {
 		/* Has the namespace already been emptied? */
 		if (mnt_ns_id && mnt_ns_empty(ns))

