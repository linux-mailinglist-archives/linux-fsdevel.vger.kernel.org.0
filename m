Return-Path: <linux-fsdevel+bounces-33723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B108C9BE117
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7412845C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C11D9341;
	Wed,  6 Nov 2024 08:35:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D801D7E3E
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882128; cv=none; b=KycuVYlZR+FLe3iVTssRvIklTzkDdXJOFp1gS9nquY03vbxX5Ts0Xc5nY5fd38xPw4NgNTsdrOsOU4kxM9dsVsIro9ifDZf++CTtWggDu3pVpmsd9prveEwfjvvywrANOMSSRc+YneLo60hLUoEMTSEQVlCzHq9/6wtOXOnFs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882128; c=relaxed/simple;
	bh=t1WaeZXqfAVXlpn/npu+nVOQn/Vs3v7N64kfTPZodSk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UXNI1QMAwmtA3FYXBLm+jZM2OjY6yJz64F4erfImKzXyHGMQ03Uq3VmmD/IdcvKX66mkwU3dyx8pV3IPGcauAOnwMpF8Jwe3wvu6AsCEVxtndQR2sQXMEc02NvP0LkggV13S3aMFElyxk/sqaKW7z61WGqsYTW2dFWXhWz0oBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bb827478so48742875ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882126; x=1731486926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnB8xawJVTltgiDGSn+8C3xEi2E88CR1AX+Gfs41VwY=;
        b=UW+sFYL1/ShMUxypYWDb1oUoRwjCCEcsCOeqzg633VXTJ+/wYnkBEEk9CWqPEZDJGT
         fhqozdq1xXJlQ2tjzlvuNudg/AuXn9YaZngUM5JzeebcgC0PHEsaUZuOFXqdhV1tmU1m
         lh0fR+NwVCVXLwQV5ewpMuXKpUgyA0Fqs/9ZdhUfKivf23HVyCWUP5rA7wBP2BfdtrZM
         D6QIH+NUUiqDF5LVpGaxDnYtyikstK8yYbVClzSiDmmgOnMml1r1/Di1N7GnLAkAtj0F
         YrDgEnsQdtg4OCibFVy5K5ICWkrx/JMIftYE8xmI4wh8dFirXw5oSjWTvHMaxyaW+Tqq
         D/SA==
X-Forwarded-Encrypted: i=1; AJvYcCWGqVKPAen2R4RZPSM/qbW03+hCc9xK7lg/R32kpOFdI6mNq7xk15YaXao7nsd33k4PvbIODKsMTYs3+0zn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqrnt3H9qiHr9r3iUv0DHAscrxiaO44HXVHlaQulcQtTqebFit
	7vf/lNA/qjxXuiosASwDk7iuWgc4lTPm+fdErrkeP4/WAsdwOxySo3pTDo7ywBOHD1U/xtiVIrB
	0BAw3ZcdVlry5TTPlprae2fR5Aqb6aJjzGSl5D44DaWqPdX0tSnhm+6k=
X-Google-Smtp-Source: AGHT+IHh+rwwTLIISK3Gu5Vo3+mBgFl2ihCHw0zNl+TBlvaH7OVlYqPaskk0ZWCGb/oOB9AzjziAzuQYtsnaF2TOMXo3O7MxUApN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a6b02fbee5mr181857015ab.15.1730882125968; Wed, 06 Nov 2024
 00:35:25 -0800 (PST)
Date: Wed, 06 Nov 2024 00:35:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b2a4d.050a0220.2edce.1521.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Nov 2024)
From: syzbot <syzbot+list0e9829fc16403a65ac7f@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 3 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 17 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3108    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 1835    No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<3> 17      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

