Return-Path: <linux-fsdevel+bounces-77122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNcmAj/9jmmOGwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:30:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3D0135187
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F0A63008D49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 10:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205F352C3D;
	Fri, 13 Feb 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WljyDgqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092AC30DEB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770978620; cv=none; b=FB/mgxfYqSyuTvOzkSZ70F0rcLhtt2UZY0cxmcvNwkqnUBHK4zm48K0Mt+bzuAXlzio/U0ywOwyl1U8qCEAfbKmhDB2oUrmkn2jFepEnkl5fFUFnpFDXOFvvY8TTE3gQh89fcuul14hbnkhZUGUdsUGYXnfQPz0EqZKxl/xTqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770978620; c=relaxed/simple;
	bh=QBF3Ac3xkxqkAp9xA1hj0iOQsUrkxSjabfkicvCF9sI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RRqVYnbJfwblguyTXXBgiJLxV5YC+FBM+ZadwTAvE6tXmT9GqaB1GUHwjXH332xSeYqJZAYxuPBUUnLBIDk/sMLOWFxTPHrmegQ3AcCt7osjRwPTmLeb3Gl82WDwu1xIq1S0gDjkdfiHUbEoRSnrNxT9SglI+/lOvd28+39op+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WljyDgqm; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48378136adcso575435e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770978616; x=1771583416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fZJdgmpU6BMeb8xlHnJIHlivKZtK56Jb2TWWXtoNlQ=;
        b=WljyDgqmx0pdcMzTIo2xIScXOMl97WWiS0DTVp6Q6qenryqlZYLQ9atL6v8OjCnJ2k
         jxKVufGU+cxNUwqDAZQlWUTxk3tvkY/gApLhu6KfP3dgNRbceQVVLhcjqfO1vRPQEpCy
         oCT0OI1DbNeUqHMWn5yRRlbB9pYouIER1jWi0LqrJF+MigN7Qp4MgWfgk8Z2GcdamKHr
         EkZY8m1vx3IDhdwT2zmSuar3ggnqOY79ObzvIDKqMWgke8K8JLk5SQuWyEfzx03ez2nL
         IhCdh0t8jnjxm7Gz1vMb+3AnxKDg4sVyDedLd9fEUW7MFNvrUCiAR3VodKfTn0cWls1W
         oyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770978616; x=1771583416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fZJdgmpU6BMeb8xlHnJIHlivKZtK56Jb2TWWXtoNlQ=;
        b=LTS4qJ55ZQfbAKogGzIFTNrW7spl+jcmnLnDikFwKILBPlZYAA1e5vWnuNkhJ6J2GQ
         yrGH1s7CVUdNKChGxcjQmyagK+j7aU4QlXh9FhT7J+17mYOvjquIe194MBxVihnigFzV
         UdnPt1M6a3tKaOJanv1Tw6NySz/UEzxzdsjAkahDlD/6tQJ1UsrT292eW0awnoBYxKx0
         YU8GRpnO9CsnlfX6Pj5RcvqkuZ3sm9vldweMo420kedOQzvry6mfxN9YJOwFoMvtCnEc
         4t64tdMjRB/SpDwSh6Uk2BAT1MQzhREzujD7NRjJ/aMhr6Mlmp/xD9vSmh3nUy8fvRyJ
         j5og==
X-Gm-Message-State: AOJu0YyLrVNfR5smCx31ovoMX7Ea5Gbb/B0HBQKaU9bsFf9pmxGgyn34
	DmIar5Nbw7o4TnYls8HtGdn32mE8O8joYGr5ic+RNsLfHweqJGSPU/+h
X-Gm-Gg: AZuq6aLONC1uZnyC3r3TNa9ajPErZekqrdcvFr8sKt3o5LRxk7NzNZ1nfgPttQgK34n
	+D0g8tKoUOD/zwTrAgRsp/ZMKqC5qrSTCmL1pXS5hX8lhSZZIPf3/PnHJndRgvXQ59827P/S/Sb
	YHTFUioa5ni0dsjYsHb8udbliJQshITx4/hW7KlorKUaaVdH+lzJ1/wAKSOrBf081Edrg4J4fUU
	Z+JmUYDGjVaoU0olQbtbP5ktz7a6EFb5ku7pQ7yvHGp4gK4ICDp4OK6I74lc46V+LOKeCx8ZJeD
	8MRWKjXviZxjbXupYjUg13vonCCSRKhmYMagNYcSxBVdYqJgwR0VDVBmEDPpQins06wthDcaoBq
	uPp3KgoDKTKUsyYtL3nhhnRF1nnUG0rVKvkjUCsofrCZ0sCm3QYzNjdjzJ97oFWD1DrpqmbYZmu
	tt6Q0hpC1257g0vK1nRoA/QtfLiPATgYxZQ2r1Xe5eDvFn7bvvwptdeU5iQ+pu
X-Received: by 2002:a05:600c:1909:b0:480:1c85:88bf with SMTP id 5b1f17b1804b1-48373a7438bmr18702645e9.27.1770978616023;
        Fri, 13 Feb 2026 02:30:16 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfafcdsm311730715e9.9.2026.02.13.02.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:30:15 -0800 (PST)
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
Subject: [PATCH v3] statmount: Fix the null-ptr-deref in do_statmount()
Date: Fri, 13 Feb 2026 18:30:06 +0800
Message-Id: <20260213103006.2472569-1-wangqing7171@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,virtuozzo.com,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77122-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F3D0135187
X-Rspamd-Action: no action

If the mount is internal, it's mnt_ns will be MNT_NS_INTERNAL, which is
defined as ERR_PTR(-EINVAL). So, in the do_statmount(), need to check ns
of mount by IS_ERR() and return.

Fixes: 0e5032237ee5 ("statmount: accept fd as a parameter")
Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698e287a.a70a0220.2c38d7.009e.GAE@google.com/
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 fs/namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..90700df65f0d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5678,6 +5678,8 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 
 		s->mnt = mnt_file->f_path.mnt;
 		ns = real_mount(s->mnt)->mnt_ns;
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
 		if (!ns)
 			/*
 			 * We can't set mount point and mnt_ns_id since we don't have a
-- 
2.34.1


