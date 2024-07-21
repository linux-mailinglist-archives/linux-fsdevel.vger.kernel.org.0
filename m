Return-Path: <linux-fsdevel+bounces-24044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2FB93839A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2024 08:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D35B20FED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jul 2024 06:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCD6FD3;
	Sun, 21 Jul 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ON7OQgcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF12C567D;
	Sun, 21 Jul 2024 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721543375; cv=none; b=WULjK9Tue5JPOvBJvWiP+4/NmYLO191dTbq0xNA8ZZHuJBP/9MOwO0AP08lmMV6q4R1ugHX036tu9oMFsxWSwqKqiS4890Z9g+w5teCL0nqGRUwaX03xdkAQWDuXAnDWzp8UuDuIU7nHfCdFcFtJ3UXhMg3X0QdIeFQUr+UF25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721543375; c=relaxed/simple;
	bh=/gdBAJiMUTns4D9YraZESwr+JyDyTaIqZ4wvYBlOuTk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LKKUv+UxkIgF5GzGF2P5hahrEdBWA7E5U2SqxzIxFXqzIxvvxc6p+1zUI+WC7csuebgQYwlZt1RBy+Z4sf1t7tm6wy0Uxoohh99vGsFnYPoRkA40LxjVtTAZY1OOuE78WHTQtPF0JjGDH+tGlultuTD/pBl9DE++uCAkb+ZQCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ON7OQgcz; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721543367; bh=JVx1yfEQudvZZ2X93CvZ9TFOULgY3PnaLrfa1OgBBh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ON7OQgczX5kyaygJgi3WRUNBsUi4Aq5GSsMrwGePtHr7/KmjtIKMYDfKMLXR/tzfn
	 l8hWcXwrKobVi5ItBJaKfHvV92Z9PMEqNCbK41IUCnEj19v6/PY3xWZeZQmqexiy7l
	 v12a8bLFI672Mocga7FaAXiSC4u13+qylvrMzlpM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 5CBBDC07; Sun, 21 Jul 2024 14:23:11 +0800
X-QQ-mid: xmsmtpt1721542991tuvhwlcl5
Message-ID: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
X-QQ-XMAILINFO: MgQY1K25Ph0mS5q9poqhnbqhbEzBhyZQXnV+dXEH9R9kGMLNOlMOsuZSZVY7dK
	 wKJdk3y3myt7/uIxtTYr0SriMArZX4zJvCkcbkJweDgar9ugWv+H+YoQCmdj8gqJECdQ6TewXQ1c
	 V2JiZFpbDdHVBvkO8XOAgaj8o4yn/+N1gpYwdzq1RpRw5uqe/ptnuCp1fPDcv+cquMlBjW64XMr2
	 X4ix+T+RUTguhfdb/ThX+ZHfban8Kz7lHQy1zSdQ1PvmXCSXCMiNrxA6JRUCbveS2j2KYftfixe1
	 BrYqUW4zzHFaoc74l7V8tCNHB7nKqR7q6qzBtZOTpUhx2Ly7AJ121dt0JZk4lhLCg48jiJADB4Ok
	 +mbkW2hWB1VLWdG+S1U+Y318qDHifT5sipSuXdp/eakVLjdAScuW+6CKho2eNzou1rp66dzEOKoE
	 3lS1vazmDpIc9oYWfoXRV81ajjx1FEfvSYBJZRCH+Ulh8v5lNf3n0p4xBJ3avylOjJiin+IJJCsG
	 k8yrwMQFqBQO3WvEGJsSppS+KM33CwvBjjoq/w8WwIb8RWCr9zbbw0xvVcZfxxDkN5353jdcyJ+q
	 fd2rNJ8GciAvTmCf1fIK+hVp8QNVtzl99oYyO/J4HzRmRBLcvLxALXZ+4ONnoNH2VgceonAWO7Go
	 +uIiZoZk2wUpnlyZBfnq9q/gUmrktjxcQxFaH3B4/aVQcV+LP5iy4JvFJ5nYZEgrW8HP3WfreWlw
	 28s0ZPiI1DHW3KA+9+PqgbZQKQIOKgduNa6uttbKZM9kPMsUREZNTewEnag8xYJmRTa3vdpgkjVk
	 l071Udks/VqRC48uESv0+6Jlff5nYGk0I1KECbSIze8PHXt3CseavDwD+XEAQb8WMlLLwiWO5YBF
	 AYx7+Gewqfq2Kg6XdmKnQRDlMxTRUTys4EHROq4V6BNQVaq/lW9a0aM0AmeZaVwQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] fs/pidfs: when time ns disabled add check for ioctl
Date: Sun, 21 Jul 2024 14:23:12 +0800
X-OQ-MSGID: <20240721062311.1681234-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cf8462061db0699c@google.com>
References: <000000000000cf8462061db0699c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot call pidfd_ioctl() with cmd "PIDFD_GET_TIME_NAMESPACE" and disabled
CONFIG_TIME_NS, since time_ns is NULL, it will make NULL ponter deref in
open_namespace.

Reported-and-tested-by: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=34a0ee986f61f15da35d
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/pidfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c9cb14181def..fe0ddab48f57 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -168,6 +168,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PIDFD_GET_TIME_NAMESPACE:
 		get_time_ns(nsp->time_ns);
 		ns_common = to_ns_common(nsp->time_ns);
+		if (!nsp->time_ns)
+			return -EINVAL;
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
 		get_time_ns(nsp->time_ns_for_children);
-- 
2.43.0


