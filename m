Return-Path: <linux-fsdevel+bounces-75940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNo1GuCqfGkaOQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:58:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6BABACE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 13:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0C6930C24B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 12:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAB37F8DF;
	Fri, 30 Jan 2026 12:50:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430C37F752
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769777429; cv=none; b=F9RDOIC6bRtn9ptPAuZfu00QaedOJOWhm73R2njOkp/IzgnLB69eM3tc9oCBfc3jTTJe+oXJWDIi1jvUN0SN9ctuYhXTRCxGk4Uozj6gZ4iFNggJAMn5DO04dz+xM3CPMzHO9UHZiE9/QsVAZIv2rUAayrQCAmSKTmjm9i+9CnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769777429; c=relaxed/simple;
	bh=dbtSk+C8xttayPMdaT/yplzn4Jv0Qmz50ZGMPO6Tagk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nlfl+JYVmS4VXvR6SbUl8k0srHu19njA3osoZ+55IsGewJA74wAPLRtpL21jzXju2NQQxzTXK/Fu0vN25wdUnRz9oIggcPJvfkhfwkjAoh6nJM+7ciAgshRZ6FudjSpCT8vpWOBUrAfy/WUU5AWBhs6+jV+CDbNyZASOmMXd5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-40996e43ddaso1929444fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 04:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769777427; x=1770382227;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pWFgusOM2wZb+8GH3srJr1EHgtwYW1D6+tgeN3uAoZk=;
        b=g4L4rkT+PptCHbBqGsDEZsEid26ttBuu/OB1Q3/esUA8SHI8NkNJOKc5jJCppvjIQK
         PlopWqCEhxr5Fcr5FmQfdHEdZL3kqDfjh31xlAKKSUwGqVqxg56fTMHhoycokz3JrZlJ
         Wvw22hUFQINv1y1jodg3MOYGxTRNQll3UtuKH1hyXEVsdNJv0fF6s71jcIFeHNAioMtf
         R3VS2QBCHNbrh6cxiZsdAohgBUh7cW1VktpDSBHIJfqCR7kENkbdc0W4Pg3ZutsaSP8a
         GJx70HWNt51wjOYtZERh16pG7ejEKc1LHrCS/3uUv4Jvr6HOZqrewhXPMC1qGdcPCssD
         zJyg==
X-Gm-Message-State: AOJu0YxL+szu7YlUyN5xPMt/yAyNH3Y656c6p1vubfydIYz8ZpTQr4qQ
	Bk9OfloGOpTGjPMEfZgLg5P5Eye/ZjTyCcQAZnX+QJB8xZpNDz2zcbmqU6VEnPNTha9utYC5rFH
	IF0cg6g8XKoj5U0md5RzXcStnqPKHzrtPGKsv3xitOGwNMtQmcHs+GxZR0ro=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f014:b0:660:fdeb:12ca with SMTP id
 006d021491bc7-6630f004e44mr1280684eaf.10.1769777426930; Fri, 30 Jan 2026
 04:50:26 -0800 (PST)
Date: Fri, 30 Jan 2026 04:50:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697ca912.a70a0220.6f39b.0242.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Jan 2026)
From: syzbot <syzbot+listc55d3ace2c56808802e9@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75940-lists,linux-fsdevel=lfdr.de,listc55d3ace2c56808802e9];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF6BABACE0
X-Rspamd-Action: no action

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 12764   Yes   possible deadlock in __folio_end_writeback
                  https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
<2> 532     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<3> 47      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

