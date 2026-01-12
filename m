Return-Path: <linux-fsdevel+bounces-73191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461BD1147F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE1930A50D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4938342CA7;
	Mon, 12 Jan 2026 08:40:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69D6341653
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207236; cv=none; b=q7Wd2HiBPZu3vbUHwy0pc89x87PYhAJ0EntXYcj6f8Gptzor+PDEPh55OF7Jhy07pE1iqzYq8evC7WrNWTeL2Sc4TaPz2dr/SraZLCB62O9Y/oFmk1mXOOCJqiBwzxhfrvZ6GiHZNgA1Pi47O8ma3Q7nTVJlmSorkxaPLwIXCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207236; c=relaxed/simple;
	bh=0u7vmXJFHFyN4Kw9FjZ5fIP8IUPsPsQmiTJW29Sg7Y4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DrvGH3qzUmPMo+OQClVVdkw9YsvxKeh9d7QYT95uXhcORv5xgYwrO1ujtenDHx0nTQ+zsOg/f5nlFicqmbXGSUiOrj+g7zipOLXmoCa+lS5GBRtJWxQJL8dPrL34L456ccktZtE0NETe+jzna0cNEkdf/N5bb75v4Fl2zeG0Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-65f453d9603so14696550eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 00:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768207233; x=1768812033;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKz7Yn8N73sX9Dlaxuf2DnEhcWxo8lZD8okbQynhZPY=;
        b=eSDE0TqcOsq0u3E0yvfVdgJ21EoXccCJUeRAo84fCBbtmbJ7+Ja0hb1UsVSIsDnHU+
         qErjYOnason1MORlu4N+HlCZ0ZGFYwwdaGwCdWdnLP6DgHVoR7ydWRSUYGwZ9yTtZiFC
         wDwsInUMXdyARTmwI8xr1WnyYqG1UgF7FIReFDd+B4BJNBITSULX30ypnKPbHBBWFMc+
         pZNWdbsq6SN6UvAY5Y7mIKwqRTfMF/1Bio636gy+Qwyx3xP015dobBCeG/eog66iRCZm
         so46Ok3+4MaZfJHVRRoeNQE8Q6/aFA3L6irCNwk7RKfGlNpEJB49TErH8j0IooeHn89x
         sWvA==
X-Forwarded-Encrypted: i=1; AJvYcCXh+keA3hOqEV547pTcOievWkWnKS5PD6Ohlsg8iiyWpVKG/xlLBHL5jtlxLWeA8MpQD7/dysC77yFFp8Uh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0p79J/6F/SD5sLUZwui87tUMZ36VtGgGoiLgen6vztC+xJxbm
	32xL/50LL+iOrbBPws8NByUXSHiTJ5fTLY9Qv5WoXzLvDWKO6io7l7Dlf8zvPZiTzO0TYRctv9m
	Chqk9iOXxUnSXnLXWUrNHQc/B7bpp3ePhRz6yKsHu7X/zVaHDEoINr7Mf4g8=
X-Google-Smtp-Source: AGHT+IHwXpBJKuN3m2Zvw3Hrgf5XCeY5VaMF/x7201bV5FGowPoRd1oPNSwtiSiGY5D6uA6U2gXrJoqPb+Tt41mBCSWlYCfeWlcb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f022:b0:65c:fe8b:53c6 with SMTP id
 006d021491bc7-65f54f50761mr8137199eaf.43.1768207233636; Mon, 12 Jan 2026
 00:40:33 -0800 (PST)
Date: Mon, 12 Jan 2026 00:40:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6964b381.050a0220.eaf7.0090.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Jan 2026)
From: syzbot <syzbot+listd748077f5628637d8a70@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 846     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 65      Yes   INFO: task hung in vfs_unlink (5)
                  https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
<3> 21      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

