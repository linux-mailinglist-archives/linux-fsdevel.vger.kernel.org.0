Return-Path: <linux-fsdevel+bounces-16350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8374B89BA46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56B21C2244F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC33A1B5;
	Mon,  8 Apr 2024 08:30:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5232E651
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712565029; cv=none; b=t3FRWyXNG1dSsh5zWu3+Wn7RPN8oJwYPybsHl2p/fRPOpjgn9UriBSNVPX/uHk8Z81iOMuvUPIjynW3f6IZhOw/jy79MqYVPvb6iW6WSUJ92RUE6apap4woMHDK/i5gaL9HTpDBAhLE1SCe5L05P342X3a1ehzS3pSCU/y3Cp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712565029; c=relaxed/simple;
	bh=EjHDMrAz69vatng6jA+oa2JUOP7etuQq0dSwTmjyrss=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DsOqXAWIcMTdSlZd5X8gqT/qWA2K3fQ0EoAnW1QmJL1wvsuitOcZGU6a0+wXHfIbrxRcZmf7M2atAtTS8JdNEfHt4UNsi/y/mH2YeAdl6RBOKehbtPOrtFhh8KpJMD13aQ0/XhnfaKn2BFv0+e9NYZOcyT5ErP9FeiLx0tDtqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5d650eaafso129098139f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712565027; x=1713169827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGfa/fu0qaR4580gV0wkow51swbUTo/cyHbTrBarevM=;
        b=FWMEENeTba/+//qsYvLasv+mDz/4god7NIuDIPID9z7N4piH1praa2qzC8gLxPzPon
         E2qbVXEbhZ8E4U/lvw3y5ZRSYVCf4QldMw6yU8lWH3WxGNKHwBVnx9yA4M/b5op+NDhx
         jY52YRbyIHEaL1hqcQtm/PqK478TNGJKg4KO5zw2JSvojKV1wwADBFyJutlTOHmyCl1/
         VKWOsNaOGpN8o5ON4Uka7XNmsZPvvT9qD0nfxICF7nJHAZsEv+4nOwPFoxgU7r8Mk8Vi
         1Ayp+Jh0HLojl+6bLi8Hy0xpueo2F49nR7GN/PjT0T3z45C2dvyH71vRr/b+l/+jEyhM
         EL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkZqmH9PUrh6aauWubnsEfQJGvgMut4zGmYhULfNwoKUU0L2xQLW11NtDhsk8ZsfM/iMd0E7tE5cXAAKkoAp2UvXZoY2phV6LQE0/yxg==
X-Gm-Message-State: AOJu0YzEn19H/wBTIURQRgYeAmAOa7uNQ2e9CkJd5Afmp8XcVQ6nQw+b
	vOmMdO/2FBmKzUNWdLGg5co1dGDcf/L+WOBjS7ZGnEkoqn7GgB3Kgwiw7FeDs/BB/gqx7qPQY/T
	6mxgpVOSu59AWgLzQ01Rv9+fKLNj5aHm6TkbO9lxYbCCpdSoZRc6qpfc=
X-Google-Smtp-Source: AGHT+IFvl1fTIIj4OYvRlREsAD81IC2U/G3exMy15fGzFJ2jssxxq3RDlP7eisgtQ6PK3mGhUk/4Rj4WOKEZd/Xg/haoZESMefy+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2485:b0:47e:c070:517c with SMTP id
 x5-20020a056638248500b0047ec070517cmr170534jat.5.1712565027407; Mon, 08 Apr
 2024 01:30:27 -0700 (PDT)
Date: Mon, 08 Apr 2024 01:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d17cc0615919e05@google.com>
Subject: [syzbot] Monthly kernfs report (Apr 2024)
From: syzbot <syzbot+list286f9999cfeae62e8ab6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 175     No    possible deadlock in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<2> 38      Yes   KASAN: use-after-free Read in kernfs_add_one
                  https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
<3> 36      Yes   INFO: rcu detected stall in sys_openat (3)
                  https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<4> 7       No    possible deadlock in mnt_want_write (3)
                  https://syzkaller.appspot.com/bug?extid=3800901c18018cf7ff68

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

