Return-Path: <linux-fsdevel+bounces-76524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ieu/EghrhWm/BQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:16:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AAF9EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 05:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 973433024A23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 04:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6D24A05D;
	Fri,  6 Feb 2026 04:16:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E72AF1D
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351365; cv=none; b=Shy0c70/kE9y/pEYgvjyo0MmbKeclKlSIG9dBevs/3Ut7e8hraGYcs/+KfU7IzN7u7aQa+UmLYJvYov5ysX7mXr25bchackfkRZLDSUSOEqmebQl8dT0+XWQZakOrucEVafnaHw0jaNvRD9hqqx/GHBKZsHtc52epI14YZB6bW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351365; c=relaxed/simple;
	bh=hr3W/AM8zY1xVbmyKhwprP1xRsFjnuTTNhS9swqb9NM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q9Y0Ud/86K7oQ8M/1QxKC20h+39b5bDjkumYVB2o5LI+grkGYMdWreNruSgRiSZFIgHIyPVpT/DEPNvPwMpC+EmquAFYYLiosvc9at5hdt7/7GGCOaydsE1NSwK+5A6YRvAowgEcifi6M+ElIHj5Bq1vVj8kaq8vEB3MmuBlfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662f839d680so370164eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 20:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351364; x=1770956164;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/+oy2R46Fnx4+wB9Hhk2uiq/Unz2ea+if9sMHfpzpQ=;
        b=G6DxtFT9T0hBWR7KYmGvHzbsGfwDftNF9kwXpEJqwXaFWoj7m9UBk6rkMh1MIdl9XN
         qO/NrMt6EUcGo9/dSH9eg0iqRzSZjCWTefqlXxvBMov+hFTMuCw/sk0UkLe1RazlkABR
         hIcuPq+8ZxaJAP8VW0PoHvqkiK1In8oPQtBNHhHCFAIMm2tIVZ5zfmtSRCtaM/bY34ku
         T/sdcHt32B0/dNSSI82OZHi48hpjIqMqVyp0iGDJnu4ZdWsVU0mg9jUty1ZFJSnSoqKe
         rq5FDI5rHiGTyBk0Sryxbcy04W2ydRPzobOUxlyniGxym3UKFuUz6c3Edw7xr2Y+EiX1
         nF9w==
X-Gm-Message-State: AOJu0Yzux5Ylfzju64IUJF3ZqNXytAtW5u+IDsLoe9nugA1x4DEJ/RGy
	5sJHOGVpJWPLxPKR0WzQbaWfvFwD7GA63YNTjbDLFcqhg6WEMe2MskLGM093eTiCo+Z/aO3pOX/
	FXBS+UR6R2Cf/weDM9B1HrlNv+Yus8zjWWuIAS5pMwGuy1897EMWuklu7Fwc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:160a:b0:662:b608:d5ae with SMTP id
 006d021491bc7-66d0c667fc0mr694903eaf.57.1770351363956; Thu, 05 Feb 2026
 20:16:03 -0800 (PST)
Date: Thu, 05 Feb 2026 20:16:03 -0800
In-Reply-To: <20260206034631.1189468-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69856b03.a00a0220.34fa92.0023.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_fileattr_get
From: syzbot <syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76524-lists,linux-fsdevel=lfdr.de,7c31755f2cea07838b0c];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,szeredi.hu,googlegroups.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD1AAF9EE0
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Tested-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com

Tested on:

commit:         06bc4e26 Merge tag 'block-6.19-20260205' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1498e402580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9682a42d8ec8b05c
dashboard link: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17f0e402580000

Note: testing is done by a robot and is best-effort only.

