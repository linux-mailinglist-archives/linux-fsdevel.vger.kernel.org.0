Return-Path: <linux-fsdevel+bounces-75849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGM0EZQ1e2mGCQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:25:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877DAE9C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D3A23018759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688DE33F373;
	Thu, 29 Jan 2026 10:20:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DA1304BC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682030; cv=none; b=Du49WYKZ6QwwGSA3vu66tQAyE7vATpME5YqwwSRkUti+iTOBIPfW2Iehkx+ZSkvXeGqcr6Iy6pWEee8vn4OPKXM5m7xorOz/BPqBZlWO2P79k5zK49lzUye0VjKJ8PKrZJbdzWGs4Z0wsJe9wCeW3SpOAxdqslg9QdOd8jER+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682030; c=relaxed/simple;
	bh=StdiNAPN1rb3OPpPsE/ggmQ+pqour6ItCTk2m4fs14Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RVAJGLlfqGq6svfoXyLSj9wnjA0Ph/9xWLZhpx8Wj9rDGdKgk5N2e5qVmmJEvltokBMMFu9e4JTodF1AR57SX2fg3vZB6YcdZ4JcP3yOldZ2UXfxqrq3XaT1xw1bwW4Hh3WNBeCecycHwQYndelrQ66eH7eQox7cr2FdrS9fo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-402d5d2706fso1093799fac.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 02:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682027; x=1770286827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVAV+ZNF15w4YOZeDygqF9CqeV7Yow+KrDxYfY/A+3Q=;
        b=bSf+czUqoWGDNuMUIaG2Rso6HJQ5sGe4TIJ2Z3rbB1RfX52MqEJm3QQlhqw7ppxjQO
         0DKXLFebuhwaSvahFpUtHrm0wv0KxRemFPB/QH9nsuQtRExw/gyMRtenwIe9tWxG6LjH
         JWBSU85RTpa5h9RXMApT0NXxC31Xf+RDJF5ccimG/BE22wvBuh8zeYJjr+e1OzJhtZpn
         3RNK2MDME7QuAqjBW/qT3/mYzhDw69URH+L8LZKp7bFQXMOkotRxGxaLsn2f3EC2Edrx
         OTUfkxCeIzaPkVcaJZLPLiNDLM3kKlU1z9RGd/6EXflDkOk9nreFqeTHISNHD5inPkST
         gxoA==
X-Forwarded-Encrypted: i=1; AJvYcCWekmweppUhZ35eZCk7dV89aAmw9AqernLzy9PoCewryagjAOgjun3dbR0xzmQKsgSRQK9iDP35053ZpDgZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXdhfhAFexOkXUpyjCDtFFBgUX5PG5S/Sgdk9CSYZ9rdr3zOq
	6muixME7qD7heH9vq0VnSM2BxcB5liUXtCNpljxPXh60SiZlFVO8yd1y82oJp8Vrf4tECbFFhOB
	reMuIf4HCXTu2c3Suc3h/wCchrtLDKYXL9k3GagyEhoscAk5vUd7fOHa9rF8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a0:b0:662:faec:7d4e with SMTP id
 006d021491bc7-662faec8d53mr2867329eaf.43.1769682027669; Thu, 29 Jan 2026
 02:20:27 -0800 (PST)
Date: Thu, 29 Jan 2026 02:20:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697b346b.a00a0220.35f26.0007.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Jan 2026)
From: syzbot <syzbot+list790f75f6e31e4979cd98@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75849-lists,linux-fsdevel=lfdr.de,list790f75f6e31e4979cd98];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9877DAE9C5
X-Rspamd-Action: no action

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 27 issues are still open and 31 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  171177  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  15126   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  6459    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<4>  6097    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<5>  3448    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb
<6>  1848    Yes   KMSAN: uninit-value in hfsplus_rename_cat
                   https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
<7>  939     Yes   possible deadlock in hfsplus_find_init
                   https://syzkaller.appspot.com/bug?extid=f8ce6c197125ab9d72ce
<8>  877     Yes   WARNING in mark_buffer_dirty (7)
                   https://syzkaller.appspot.com/bug?extid=2327bccb02eef9291c1c
<9>  763     Yes   possible deadlock in hfsplus_file_extend (2)
                   https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
<10> 469     Yes   KASAN: wild-memory-access Read in hfsplus_bnode_dump
                   https://syzkaller.appspot.com/bug?extid=f687659f3c2acfa34201

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

