Return-Path: <linux-fsdevel+bounces-77094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHqJDzXfjmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:22:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C1133F5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8874F300E633
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E4631D39A;
	Fri, 13 Feb 2026 08:22:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA32FE579
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770970926; cv=none; b=XhNwH+e2XmyiTohSYcyFZ5jSk7T1VFuGDcq0coZUww4cTsaD/E3TkK8M1a2XGptflyPPk8qsBeVRVQOZIU+nXywLPGIsk7WxuSmyHGRWGE4ouikmaSpKo3Z5MsZbqmnNcAYM6NIsTNq4O0GmA/XksUb+cwpX98hLT8RqoWnR2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770970926; c=relaxed/simple;
	bh=M2Kfo3RGOZqSwg1fxpMbLgQnaMf47rliiYptySh/RIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pPb25mfz5VRWKFO41AfkVvTKe+ulY+xUzZu4e2RpE1uuAWX03FMD+WPwi/FfUYtS74kXA2pMb8GcLsAzF8ivprp9VqYhC0xmfs/m1pKamzC8CckBvlwM0J/bf9zH1iJRYA7zlmhHLhIzEsHOMNzolUhUV8bNuXKD555tNOKtLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-672c40f3873so5191204eaf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770970924; x=1771575724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZKPRNss2kh9itDU2rY99szg1CFvGRkRY1T3z3c5+1A=;
        b=WodENzHwVozl+obdPn+u4l+UHvm2bIAW+v5suTxiTELFH11pTRe118yuJt8TVfWxWY
         J63dEdzjOrOSIXxyCl9o2A9vu92e569xbqpjA6mv2ykY/sjlmFZdMwaOv6D3Ao9SWULo
         ou1mIiKVP9nwNyLTbqwgTeBMaW4Dh1QAPqTyHqomod8hChrkS6+sTosKJV9jklyVkbvC
         erpUTKQgjSYzV9KZ+9u1Y3OfoHAMnF3CTjYaFaOwZtxSL5MI08kbSRIzt95Cb4ByylEL
         Lqs0NeaaCh7pBwZjESuhIHNWlCKgtJMiYF8CBAbTuEQTKFhP0vphEQB2PXChPrIhHeP1
         cXfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxvUn1N6O7HmYlqn4aLXBzTQFqoH2d02k8Rj4lXBfilNIKk6pcu+MtsMTApK8p1MH8Miwvg5Xcox1GMmoC@vger.kernel.org
X-Gm-Message-State: AOJu0YyisLnQiHOuWoCRfJoNUKXcNY5OjtwOj4yDpcEjAFR6ZyfZZYa3
	hITGWWs/0uMoES0dsd8Po+cPsWo/09vufefG99z8y0qb7AJeKMOgvxd8UspDW+qUfrEZNWk7zBa
	MpQRdEw3P3d1Y8eWg9fwKC5TJip76W5Wde0LJjvo5iaqyojGj+UrfZDm9ZBA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1607:b0:65b:24f6:be21 with SMTP id
 006d021491bc7-67766ad650emr400703eaf.2.1770970924408; Fri, 13 Feb 2026
 00:22:04 -0800 (PST)
Date: Fri, 13 Feb 2026 00:22:04 -0800
In-Reply-To: <20260213075742.2398200-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698edf2c.a70a0220.2c38d7.00b9.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in grab_requested_root
From: syzbot <syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fe62ec9519bfdb19];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.cz,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk,gmail.com];
	TAGGED_FROM(0.00)[bounces-77094-lists,linux-fsdevel=lfdr.de,9e03a9535ea65f687a44];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: AD8C1133F5E
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Tested-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com

Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173eaf8a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe62ec9519bfdb19
dashboard link: https://syzkaller.appspot.com/bug?extid=9e03a9535ea65f687a44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1183615a580000

Note: testing is done by a robot and is best-effort only.

