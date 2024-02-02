Return-Path: <linux-fsdevel+bounces-10111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7B847B55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB7CB25D46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6938593E;
	Fri,  2 Feb 2024 21:05:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC38175A
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=XvunikQyMcEvoqqGPeuQIGG8p+D/MWxkKJsld9lcVt5Xbh7/keed/KYJXugaO0S0uRz4I1fOhqFgyZSYqNTnGlDC8uu2ufWNze9j+dO33dqmYLSz+Ppha4Xg5uAJWeZIN3GaHOFoXmWZQJtfK4lZ60NKZMZG9pPT3rdeAPDn0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=zVEZF3UmOBGaFQWlFwsyEckv1Kv26SyyTDwlsRJ2Ctk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jBpM/6k4+zCyyyYKKbJhKQYGbXcNkVZQort/MSBP5a3tZvTyMn9I8jp1tKRqUn0vHnIkcfOdbLntkgI5pJVzCPDwORd3/POftukLw7UyKbYpP3pkP8apKcb4NRXIzdV/DEB0sigsvgkReQnDhCy5VSJxC6aejZuILcFvQ3rW4cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36379b4590aso24955285ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbpB9CkzBKZ5YTB7Sbfot3j8a0vy9QxqN92wrcvFWh0=;
        b=WLBAEKkWe6deu2dl4R0eSynnVSHxFgI23H+M8ASLKvyXRutQ7luPMkVSfZKLO0OqK9
         m+kj/LGUy4irEJsKLdYdFJYeSW4A6F3pnsqFO/XC0o6zgUVRPl0IYODigo+5BsvTJ+Lc
         5yua2JtboPzCDMWCup1FzvuBw/XREYjEhh5EHUEEzOg8v6AV0+l7mhQSL7WHcNTyFkvm
         sq69N7MscHwshKdrXAQ6U7u4A3nzV89cN3de3NntApWIi9xfAFkcwMmlBbbTzI8Npmzx
         FVQWNqHpBvwBNytg1KF8dJnys8zki8iQn2nN3QxH8OPlOBDJ9BN3U3WezF6N4QpRARto
         Nk5w==
X-Gm-Message-State: AOJu0YxcQtWjLv1Z9HyOeZyqZVLgtfx0HhS7kdcFgsD5iSiPJ1qweokV
	nem8rctBnqp3pi43R/QatYlHzMJFgTj+EzlBbp7IcmcmUf7TM9WcUpQ6glzsygEp7efMFDl/x+p
	/aTWqPPNlVgVwkjINNZHS50ToZqirwnJaZ+8y0QqFjFTEnI5Xeo2hC+g=
X-Google-Smtp-Source: AGHT+IEI8OXCfeauopidytDzSIZbNGtVMQpXAP1br3oXmhVIQDyUj9v/vVb7+FQJTlApf+zfmh2v1Juc07EX1h3FuRAuwJBtuQTI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:363:32d1:80ce with SMTP id
 t14-20020a056e02160e00b0036332d180cemr733331ilu.5.1706907923416; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000708ebb06106c7865@google.com>
Subject: [syzbot] Monthly nilfs report (Feb 2024)
From: syzbot <syzbot+lista589ce3cf9a23bf25db5@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 475     Yes   kernel BUG at fs/buffer.c:LINE!
                  https://syzkaller.appspot.com/bug?extid=cfed5b56649bddf80d6e
<2> 114     Yes   INFO: task hung in nilfs_detach_log_writer
                  https://syzkaller.appspot.com/bug?extid=e3973c409251e136fdd0
<3> 24      No    KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

