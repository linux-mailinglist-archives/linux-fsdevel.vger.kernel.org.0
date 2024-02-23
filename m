Return-Path: <linux-fsdevel+bounces-12629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151FE861F0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 22:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9869D283F71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 21:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981C1493A9;
	Fri, 23 Feb 2024 21:27:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56485149382
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723647; cv=none; b=fkfDlMLX15h0BwLrBbfBNjhPpvJTSEjV3fRiWlAhoni6kHb9VUtFkaQh4xT31jij6QkIp1uexRB1X+yQD1JTdU3YGJEnsK4OOohNcaZPCAPJVL7SXhSPEkvBYL9pudIBpB49WWeE1h/P60UvMzc2xeK1KJ9kJoz28ePFwrKbXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723647; c=relaxed/simple;
	bh=VLMGcoKqB8lRoDP0aswhFqwwhXnudyVIBfdJQmMCSS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tw4KPr8oMJuZ5c+Mn1M3Wk7+qssQUEwTQn2zDeDRzr4huIcXM0e1i3TQUnKYE1GkkFyoakXvVXrsq3Mi1cjAaSLgklu+YARtanqtc/uDfkdtNA0dLFZKHFnBaLa4rb/7hE6AMIzvUkQrMUqlp7Bu8u0ikiUhBmVWVupZXlpEAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3657ae3e87fso9340115ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:27:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723645; x=1709328445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=044LH8cJATSgHllL+X3xvCtVZ2tnyTB+fC4voAuIDv4=;
        b=HGxjN1y40mx9jJocmd9a4Wfm3O49qrbaNNsIjf+nKoI7+t3aRFDW2WMZ2F+Nm3o0KU
         OI9xX49SwcTKUHZZTFHtIZzkVaZQM4PKGkOIcOPQpH5qjEkF1A8qRjelf/DhrbMojHYp
         bVCIzyNgQ83EIC2xn4xt6nEgANk3zpJ9BnBhh9W5LMcIuz0j4pAHBEfbvpI9U3YLJ8KS
         PazuRrf+NPbnLXIVr6IbTjTWJPHSEUXoU6pOh4OEZ8BxT5jVEchpu+jKSd5/BoeiGHi0
         SrgrYvJOPq5HjZm/SSqCzD7lOptwkeSiQX+93I4+BkpGLh5EOZdCWxln4BIqa+JZwD6V
         r8KA==
X-Forwarded-Encrypted: i=1; AJvYcCWQNn6Iu8sEdFsZNq371js8jIKB55FsNf9q7s0zr73pMOI0aNBRJ4M/QXZuyqHvoBh+fQSfRF3cgnNEg0Q/oeT0v26zpDkTmXMRgQ6nYQ==
X-Gm-Message-State: AOJu0Yx/+0GJR9NDHKZdZR8sAg/pisxoDLaKHm71q6o4CSJ0FNgS/8Nc
	dEPwcpiXm70W449/3oGdU5UvND2Tx+/9szDiVPcZCJPXCVpFHFMO8X+hPPJk0PmiTssPCU1xtpz
	DSOdR41oztWpEZ3A9brsCTNRW5lVrZLYTXpQ1y8SHf1NUf9M4yDMTXdU=
X-Google-Smtp-Source: AGHT+IEmu9pZ71VokjjsFo+IJZvhbi2GgLkE2nE4NjmMnazl1hkHlv+sO/TWslddmfx2T7/pAl2sJLeumUQjPljJFUW5MPVJAyUz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c08:b0:365:5dbd:b956 with SMTP id
 l8-20020a056e021c0800b003655dbdb956mr52445ilh.3.1708723645570; Fri, 23 Feb
 2024 13:27:25 -0800 (PST)
Date: Fri, 23 Feb 2024 13:27:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9e80e061213394a@google.com>
Subject: [syzbot] Monthly gfs2 report (Feb 2024)
From: syzbot <syzbot+list72751ee4e1b31b4ea4be@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 29 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5640    Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 697     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 2       Yes   general protection fault in gfs2_rindex_update
                  https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

