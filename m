Return-Path: <linux-fsdevel+bounces-77087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCckOiLVjmlFFQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:39:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42651133A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580643046046
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8A72FF15B;
	Fri, 13 Feb 2026 07:39:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B602FF144
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968344; cv=none; b=GaH9rC2sLd39JdSMylb88nz9p2upVV+d3TnEn4nGHYbrQD7Z4VzcHjMy0TpGKRf/FAz5Kz14Lw7yj+CCyXUpaPIepCF287c/shTDoAjjFI3arJnKWhxC94sfkGVtt8bqK5dzISzYo/QbevCGujaXF+EnQM5Jn5AKzxEcGzw1BLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968344; c=relaxed/simple;
	bh=Xx6DQILe2PwTy/Yci82SV2CW8HsOBkVD5PcI116/6zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p9hNgF1NlNNC3bCsM5YyCcmcollrdPvQSMaZ6G8+3iZGPi4XJ4nBbS4+ppRpvkUjBtEw40BD9KBrfRCkEcx16utkA2gQhWSD4mIOJWDaXxY8+v3+bcpYTiV35QQ50kwkE2jZ6wpoAwcp/OSNJVNCTOk+WeWIL5+fO8mAWpsuTQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45ca5b0a968so3378836b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968342; x=1771573142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTeBe/P/ZznzTB69OiaepB/KGja0N7pN2z4gD06rnzc=;
        b=i6sJcTQAatlzx/kT1804esh3DaaLhFpI9DwVepqU1lO42kgurl9a2seIPubfwI4XQI
         06CycOxoaTNr2wrDwlchGliseTUpdvqHEx8O4/MKCk6QsJ2uprK5XsbSKWuvZt0Fzjis
         LXDYNs2nN73+4jv2DTN9FoBmIvROD90pcXUt4GEtafjMXyX2p+Jw0Cl5cT38ZfYquVha
         9TrNDbRtM3+hC9I4y9WDA5+mbceZjZXlziPI7N1w7KUmNiy9bri40YFfYFkI9jggVSDS
         7qhQG4LBlfawM5XIGwwb8W+6BNUFEvdliaycZXC/WATCTYufs3lUVWIEaiSc9VIXyNsV
         lDlA==
X-Forwarded-Encrypted: i=1; AJvYcCVN10hpASXGBoh7W9uqu2B4wVnsqWpojPqS6AODmxjqRbmJj5Y4nXtKIW4E0ktVEty2ejIsyluUHETJSXAn@vger.kernel.org
X-Gm-Message-State: AOJu0YxofnARJLiqqUZSoU/EewuCi9FhMbcvYG53zPxo8x3pyHMUJmME
	HPQdBk6CMaTcfMrHLgya9ThDiAHLRtLhEEeoZlN292li37LJxjcOoi2yoX+aDQheRo+XNgZJTp+
	VIy9Kt2f8RDupzGV3yk3TwfnjZpEBTHCvWH3b0YQDXvDa3oVkrn28F0MfAeo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:490a:b0:659:9a49:8f9a with SMTP id
 006d021491bc7-6776719e06bmr303002eaf.19.1770968342536; Thu, 12 Feb 2026
 23:39:02 -0800 (PST)
Date: Thu, 12 Feb 2026 23:39:02 -0800
In-Reply-To: <20260213070113.2371490-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ed516.a70a0220.2c38d7.00b7.GAE@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.cz,vger.kernel.org,googlegroups.com,zeniv.linux.org.uk,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77087-lists,linux-fsdevel=lfdr.de,9e03a9535ea65f687a44];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42651133A64
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com
Tested-by: syzbot+9e03a9535ea65f687a44@syzkaller.appspotmail.com

Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155f7a52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe62ec9519bfdb19
dashboard link: https://syzkaller.appspot.com/bug?extid=9e03a9535ea65f687a44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1089ab3a580000

Note: testing is done by a robot and is best-effort only.

