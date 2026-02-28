Return-Path: <linux-fsdevel+bounces-78819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCklHimvomm54wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 10:02:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD241C1949
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 10:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37437304752B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F593EBF2E;
	Sat, 28 Feb 2026 09:02:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFD288D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269325; cv=none; b=jE7SHIZebnIl0qcrOqVUvG8X0yHQuQ3zs5IDyQP10bMzoNsw+YCwnVy15mDafzlzaXRc15K/e1x0diuLIgshrmrQGbjLAI/MCmtgFfUcJWjcBxLYZxfMs9THGMWPuAkO0pBr3TDp4AfVgy+D+7lp8VYuZYqP6vGSx/2HqNZVxeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269325; c=relaxed/simple;
	bh=e7pe42o/NJEcT5RKB58+4L0JjwFI1ZwGRLBBqW1dWmw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P/QL0VoQSDR+HAcDWDTH6jPmikhXXEPaOaUUXJ5Eq/iF1wC8II1js6UkOWp8kMlcOxi/wafg3k/AN894rKmG+0xMqzdsujPzJzeNptQR2/lzuarWsS7hMYI8fKDtA2K2brKE6g9wPbghNIq7Nd2QpaFx5wws5nc1EDq8yeNJ++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dcf1f680so74960670eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772269323; x=1772874123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMMeZnIENDkfG/wFtS+AEcbt/4uqhNSNz00R+7tQIcM=;
        b=mmbQnobbo9czbocAhBcR3dHI4HDKFhCDQ3iWM1kdI8k4TUccqwk8I9LhwsG+aH9Jdq
         Xn08c3K5/hmAaKMmcIcaJlhCy7UounDgodzPHmitFpEvNqHoTxmBqxM+4JvKioGwujcW
         x5rG0yDty3DpGL8BUAunA4IamkjwsnrEFGIk087Phow0fCxgUcvDtfLq1i2/U+sifoYn
         E1S7eFgbqJDXsjWEGnC30P3msyLKeO9HErLgDRM+o8TSzB7+zfH7HBI+FPMhdYFRpHP0
         HqX8nUuhpEpX8UmQFm95UTApXWt0lglkZAIiAUGYgdaxjKUnc1aq+qE8cPUai51Y1Ghz
         TZVg==
X-Forwarded-Encrypted: i=1; AJvYcCXBWQCePwGSKuEYwWutgJnY2Q522CK9F8nD7YVhzoTz5zzJV4eKiTDiViwaP18pIyAejZqAmS2L+mSG1gW3@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHmD/qwt76eaKpTllhv4HYmWSQ92Wo3f68tirr/us+oDR9jzs
	xcZSRxR8M94CBp1Q65ZCTPcVBTlcXSw5GGU+N2+4xLgHCeNYAN/LgNwR/AOd/WPrTk2jJn2IZx4
	gU5E292ztFS/7wgNdHAXIHX/X/KZZIoN9wro5Q4SFMQbPwQ2USgUjnaNq0AE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150a:b0:679:e7b2:9fc7 with SMTP id
 006d021491bc7-679fadc29b8mr3518993eaf.7.1772269322909; Sat, 28 Feb 2026
 01:02:02 -0800 (PST)
Date: Sat, 28 Feb 2026 01:02:02 -0800
In-Reply-To: <20260228082942.1853224-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a2af0a.050a0220.3a55be.0036.GAE@google.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
From: syzbot <syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78819-lists,linux-fsdevel=lfdr.de,512459401510e2a9a39f];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,suse.cz,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: CAD241C1949
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Tested-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com

Tested on:

commit:         4d349ee5 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b7f1aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70fe0401f305d8d4
dashboard link: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d62202580000

Note: testing is done by a robot and is best-effort only.

