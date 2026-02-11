Return-Path: <linux-fsdevel+bounces-76973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJezKwLojGnquwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:35:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A331276F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 21:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5993630495FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 20:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9545D359718;
	Wed, 11 Feb 2026 20:33:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F88350D79
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842015; cv=none; b=GC8kwaZmzN1xAcVaVBzX7kavhTInFOw/Cjv83y9SRqtYNZv3hS8VKFwz9hWpQ6liazAiUHe0uAh7ln/9Js0K8roi5O6B/0F5fjhsJFWpD5PLykJGPifwqW3B7pZjlAWpmNYl9htahfY0gIduYOkbXEEnzOTAlZMTaoWW3K4O4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842015; c=relaxed/simple;
	bh=g/bYbD2lec8B1Ij1UF64lKsQQ7eOeK0n2gKprKNK2aM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B4DaD50QOUhAgMwdTAFCsw4uE7ql2rdt7rS2mn898FwxXH8ekWbUcgXwSz8bSzyJ/yhiLGdOy58W8Z6jY8sEVzfbkD+LV1QOr4VftdbrQ+UV+mGryd4PyisiwaFmR6HT9lveUFZfNy+OYP0qFibPZd/oS+Raf1OvJ5BDopdQQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-45ee5c38131so8922269b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 12:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770842013; x=1771446813;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aco4E5NxrOj50zgvcmi9Xm+aMa0bGVdNlht4zvso6Yw=;
        b=M8L8385UZyHdoU9Lf8gnLICtzNeQAV7S7F45ENs5chDFWi98Lend2omZMBn6w2cneD
         22SOltcgO/k4ryhMF0//4C2ZbgiUNOP/l7gRMpbY1m4GsuZVugn2jGX+AiaRm+5nNNO7
         Qa2gzelZzZt275bim0fDa89PkfcoKU9qfzpQmlHliz0Yo7wLMwk6s/Piy2KQyKiQwya7
         ZITpoZUdxnF403MefYhus3FztG7JODmahDJbBmub31HYdAFf+5wuxa8UoeiYmh/dM6rY
         ocbw6V/OAdA1fWvO/iXYfAZvV9VgQ9SM40AjT0UCEYZSnmqYERoGWNk0OCDZhOqQe2Fo
         lVGg==
X-Forwarded-Encrypted: i=1; AJvYcCVWENghnaHRaWOLfyj4buPfhKG9XhbbBbqAO8ktan6iRm44ed1s9UdzZ0IIBGVVxZ9Wef5YUsbGbe9DPiXf@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcI0PxlFrJIyFLmDcTgwfUsnOVlHepBmg4Xo16a46JbHkrCb8
	u7r8wHsoZ0NrY4iYUjvTaGxXH0KV4GvL0C2QbG9rFFl3YtnCjl/7USsfqe+l3zcks469oXa+eTk
	Tqz1OnZyZUuA8gEh88hDIS9ZpSF0S1flH9jQeZafSzHF/2bSPjjJZufRhXh0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:188b:b0:675:1c78:afde with SMTP id
 006d021491bc7-6759b7c468dmr243926eaf.58.1770842013052; Wed, 11 Feb 2026
 12:33:33 -0800 (PST)
Date: Wed, 11 Feb 2026 12:33:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ce79d.a70a0220.2c38d7.0089.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Feb 2026)
From: syzbot <syzbot+list8b789783c464c3ac2b8e@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,goo.gl:url];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76973-lists,linux-fsdevel=lfdr.de,list8b789783c464c3ac2b8e];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 02A331276F4
X-Rspamd-Action: no action

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 902     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 23      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<3> 6       Yes   INFO: task hung in lock_two_directories (4)
                  https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

