Return-Path: <linux-fsdevel+bounces-79591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIAPDs7AqmlXWQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:55:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C521FEF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB51D311818C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF174366828;
	Fri,  6 Mar 2026 11:53:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB7365A18
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798001; cv=none; b=nxvW4l9QkEJQxM1yzhfrZOggme1dcSLvouWIwocsZVYZNPDK2t6DWLqBJd14XJt0K6Kk+sXmToceH5PlZK+UPvhp98/ePx4zB0KqWyrjz2mQwnD5xLrAL1l/IdjZyEw1bzoYCQuem8E+mcP/ETW3pr2y89Qv+vE/BpBxmzN9Tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798001; c=relaxed/simple;
	bh=m+C7ElA3bRPaH0W1UtP7FgRTLi7nAINy2AyJxyBcanQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZlY9nJWzOLrxyR/VSa4iJU4PAxKGoE2bY2HjtwwgNA4S/JUIpBw+gJEbeYDxQ9BIttsKcoCWySoDpfy+ipx7MIx26gjeQU+WaXTsGK7Yuriq1I56x1OQ9Hfd38NLg6B9WNoanyRdo2+4DXrpNzb4QkwxqpFmcEtmRGWg4W+7EPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dcf1f680so176771744eaf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 03:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772797999; x=1773402799;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htYTekGI96RRzHG8EdGkIPequJxrAfxWaa5pkEEJZKY=;
        b=GR2WnmjnxCAVr7Y3kk/NPBLKiUH4Nwb8x9AZn/6uFu0JdvW2Cfe6Vw1TJ+1su4d8WJ
         3hZxppO+efrjAT3R0BkIHK39joOsSnf6ilcWuW6DGK/IkmiXvTD0DgOE0jzUtfabVVv+
         Lxvw/3P2ybC8WNFYFTZ8h9Y7ylB5iOeiI/w8fgu+jOgujrMxmsYTX+Cnr92pfnldPt8H
         wohS8UIf4eimDeoKTsrv0fiAmD5pgfsObs+622o7SicZ6RAK888bd12UXQCrw7nF2gTT
         iP4woONS4mFOlrgttk3BkmtE1sogcOvZlKmm6keYf9MkfDULSZYPoWJb8JSda5OecoCN
         nTiQ==
X-Gm-Message-State: AOJu0YwtmLQCHs3Kqst7h0E2CPu9mPl0Y2mnVylKUj0of0r6gkcMRo3D
	pDM5GWRo8oLmxuAaQzYbeY2g6B134GbgV3MQp8MJ2dwXffHMls370bE4SCajXqMOkwBuLxTSSa9
	ln01lHGGRF6jJYfxSdfyg0wbHMvgjb1M4jXh7QfTOEGgdRkw9cxN0caVF1eU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81d0:b0:65f:1012:69c5 with SMTP id
 006d021491bc7-67b9bd8f1f7mr1120617eaf.76.1772797999387; Fri, 06 Mar 2026
 03:53:19 -0800 (PST)
Date: Fri, 06 Mar 2026 03:53:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69aac02f.050a0220.13f275.001d.GAE@google.com>
Subject: [syzbot] Monthly fs report (Mar 2026)
From: syzbot <syzbot+list8af9c88e9e1bcf5eee09@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8E8C521FEF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	REDIRECTOR_URL(0.00)[goo.gl];
	NEURAL_HAM(-0.00)[-0.992];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79591-lists,linux-fsdevel=lfdr.de,list8af9c88e9e1bcf5eee09];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Action: no action

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 1 new issues were detected and 2 were fixed.
In total, 59 issues are still open and 631 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19138   Yes   WARNING in path_noexec (2)
                   https://syzkaller.appspot.com/bug?extid=a9391462075ffb9f77c6
<2>  6953    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<3>  6821    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<4>  6409    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<5>  4748    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<6>  2554    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<7>  2540    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  1956    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<9>  1683    Yes   kernel BUG in __filemap_add_folio
                   https://syzkaller.appspot.com/bug?extid=4d3cc33ef7a77041efa6
<10> 1310    Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

