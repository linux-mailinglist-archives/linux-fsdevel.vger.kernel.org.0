Return-Path: <linux-fsdevel+bounces-32038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8699FA96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 23:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B06A28228A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B121E3D8;
	Tue, 15 Oct 2024 21:53:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2E21E3B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729029211; cv=none; b=QkvffHFWHVfKaw/n+GJHZH5YHzNDwQILCiN2MI43QPJbD6LwBPfiIwRp4BqLLwU6f8mbcuzrX9tVbWmQyTkdT5i1bZREXZSjOD2Gbkaywhd1a7WsAVh6RZOpXa7Xw4/RnZPSW65/UuUmySN2u2NWEq8k9k1zahwehtRXcCVFYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729029211; c=relaxed/simple;
	bh=tIwoo1GAuaJYJ96CjznV+ojvVo9j2e5Q5m5j4XdM98s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GriZd1Ci2pNDURdZT8ZFGXJBsTw9zwfSjzckv9RYTLDr56VP3xR+0pYT4+8TtA7nSGjiDWq6+wgowRfoGqrLvczEvwIq/OxoodcemHLd89/DfHFP7peS52J1dmcvAleQL5yZYsKzJNazfrWT3yIdq8io8p0rn4RXP7ZYn/mNHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso51519905ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 14:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029209; x=1729634009;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ynus5cN7x/oUjf6A6ts6N/0tVLx8bmLVhF+zOw4O4DU=;
        b=K29fyrC31vFykkpQjoH4iq0mBYBp2wPjaiLlk5Y/I76l9CwRV2TdpZXBV7cE/AjIkQ
         xbHl0me0fgc1BFKEHpOvS0Bl/87p0HJJzVWj0ydNT8//2IAmUKQhfG4ciPtEVEF4azYV
         OPLKfFwnk9Az5Jt7wcW4v++yUOkYzhWUvmZggNurPQR7hGEMGxNMX3FWiaRpCaPnFdlK
         G/FqTOEuiw9J0EQt+7AG7JC9+IAkf/ig1WuJNymfaJljhDq6s/ZztzDpAE+lMwL9yzD1
         doV+Y9HzPDuj/13AR56oVbPaAyPZTwfT5L8Lkf7A81DbyKdHx0Krv8Hqnk/mi4an+A2i
         YB9Q==
X-Gm-Message-State: AOJu0Yw4HVp3revR5X13CgTA/7yPYRgWktwqpd8ASb1+6ssNwF45jp3A
	OHdLmYckZuBv6BfFucZfLuQa/PGtlJKK4QHXNUnipdaPOGqnvxbHNWoO796b+btiJblIyfFr6j9
	NN25bpbG6SkP98XgavPNo+WYcAQxlrYuzSLVP2vApm9fZlPXc8CQdLe0=
X-Google-Smtp-Source: AGHT+IH4qVFGP3SIv9P/cwpooKz2y9ek99saj0ZoZApkYImqnxcg09Yt0fj7Nb9wDtLqH8kprpgYjuEgNP2IKIn47DLp0TSzQhtG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:3a2:76c9:f2b7 with SMTP id
 e9e14a558f8ab-3a3b5fc3d1dmr155566285ab.24.1729029209523; Tue, 15 Oct 2024
 14:53:29 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ee459.050a0220.d5849.000e.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Oct 2024)
From: syzbot <syzbot+list01b5ba8302a544f0aff4@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 1 new issues were detected and 1 were fixed.
In total, 4 issues are still open and 38 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 133     Yes   INFO: task hung in walk_component (5)
                  https://syzkaller.appspot.com/bug?extid=8fba0e0286621ce71edd
<2> 46      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47
<3> 5       No    WARNING in fuse_write_file_get (2)
                  https://syzkaller.appspot.com/bug?extid=f69287fa1bf99c7c3321

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

