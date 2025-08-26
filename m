Return-Path: <linux-fsdevel+bounces-59163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC7B35510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC66818A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45B02F6581;
	Tue, 26 Aug 2025 07:14:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD726A1D9
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192474; cv=none; b=Yg9C409REAZgBq7RjKeILb2Z0asZ8uFG0Ifp0piANc1eeFTb7erzjAVI5fI/nDYGrz9Up21Ft9cVgDJLpPst2DmqC32eVYSOXY3lL1qX/Ti4oCvfRi7Vg3rZvpXT5siZXsoRy8xylK+T3Iv+DUyganwxeEGIwDfX5Iufa4XgzSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192474; c=relaxed/simple;
	bh=c119skgSM6HGik+wFvHBiwUqdTIg4OpL/5xZ983/l9U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y4QrCdEuhNplCr/LUOzrG3iRMbgBzJEzB6BwHPORn5azj56NHKxGKd/GbqcTdEZqMf6+7QRB2IrKbDBhEnXFwsejX8iWO98LfEFKWKLqL2dcocftKFuaVYXFLJbbOocK5h+mYHTFhkOJMoAqb9p3XDm9ZR2DJBHeot3pkLB2r/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e5d398a961so144532695ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 00:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192472; x=1756797272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzuemg9lA17JRDU0q2qVaghTZtJ3Jd1gRlqQVTONt/k=;
        b=DmFtDEPRwxcALKpFC5rpnEKdS+UBNdwOwoy3HJcGelEe+W9gWiUjGYfhx85N9A30yh
         FsiwdyNoCcMzxzdJIijV+o1wJ3xmQCaq7maWJP2QiuLNia6DhzSgouagIagWj5GqacJj
         exQc52nhwDYpoDjjBdvRAQBsI1y/rVtcgElKLwoqsyzcaiudzW+BgKsd3/13IYxnx9pW
         clg7uIxX1ktG+0AAhvMm66yhvwaTYqA7hALkm93VcqxES8X4L4TIjI/Sk8WXmsBEBn0G
         LAkTtWZ9HJ67pKTnw06zZqbb5Fa9dkMh9BgB81UWlBq/WdOsKRuo5X/8UbznSG1rrhbb
         rKnw==
X-Forwarded-Encrypted: i=1; AJvYcCXKgPLM9dtneOuY7h1qoTb7TMM8xwnkMRsrLw8bnclpfv+l2XmJjRbwb98V1VM8a1aJSGbld+OExGoR3Clw@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQJ6eN1s8fyO0u8V0eOPtT/b6dWz6rx2dOPlt2P9hiRBVbWK+
	USliiIoLmZ2FEq39qgOZbafgNwxopSsBIWXzBvmV5gmZ6t0mWThyrMMjBqQu6Wj3ZykdonTkrLl
	R2I4P1rPjpxVBngGx7SvlAqtAEdluNq3OavoZ6A3OkdnBQ9WnDzuQVApE3OQ=
X-Google-Smtp-Source: AGHT+IFF+gKMytGGL8/Q++mVXF+zFwEI6PLlA/BbKnZtFj7NdYEhbHt+nHSRyqCbm6tlWxto7dejgGAH3LQjGzWwRt5/CzXTu23/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3ec:ab8:9b43 with SMTP id
 e9e14a558f8ab-3ec0ab89d8cmr87827295ab.7.1756192472347; Tue, 26 Aug 2025
 00:14:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5ed8.050a0220.37038e.00b0.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Aug 2025)
From: syzbot <syzbot+list9ef902aa1d4a209e3050@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 2 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 445     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 63      Yes   INFO: task hung in vfs_unlink (5)
                  https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
<3> 44      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

