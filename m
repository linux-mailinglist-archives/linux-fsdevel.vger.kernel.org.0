Return-Path: <linux-fsdevel+bounces-13179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324486C605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BED1F24DFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6F629E7;
	Thu, 29 Feb 2024 09:50:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D18627FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200205; cv=none; b=q7FKuDXfJTwTDU6zXQ30ulr8JyhlDWIDvHcJ7OuoWy1nMVwDsfH2In+Z7ixD6aPBeuCnxf0WSM7lNfKcK6axQQbouSlaFFBvxqqW5eXJ3E64tlmhumxKr/SiBLjiXEBIltoKYKG4sjjt17M/BC87nUgdXD0dzGEgs47XLrkkjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200205; c=relaxed/simple;
	bh=xi6HIJAD+eeBu9LW7f4Hh3oqUUXdFVpYzkHwowOaOQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s8jwgTfOq4JcRX7AynByCl5+M7cu9C1gkITg2Mn3N4qkRoAbKsqwq/QXKMTbp090TrJENF6mw0BSG0vzhRIiqj4mIbI6XpLYvoa805YFc2/N7ugjVgW2D5KEA124Huq8aBumyQEilEieuE/JL+dyUv8R04MnzA9flnuy6MeOpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36576ec006aso7680285ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 01:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200203; x=1709805003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDGmgKlqgwk985gGaF2O6kw62GJaKE8V/tYQe0mxx8U=;
        b=d6dmEEcPNQxOlqhNrHEywBi8cCrtvZTtiS3w69vH7+xT0bQWBC8Cnyr7KRfKfbgjDR
         yMnn0VtCY11jkwDbYILQWS/hH5uIAdr6dJvqFJom/G3hUunACRfl2lFku9+3tdKQv8vW
         A1wtSU6lBYh3vZPYAruPM/UIFGmRYg5ISfx2HDmpQgZnW6/m8OWtc+oMnJ81j9xg6+3Y
         AT//f0Hwkh2J7yE66I1AGaWhGZJYRGA5AACDJlUihdUp8vZWjh5Em1mMES9xA1PnDWQo
         G6F+jEi4Qtt/QO22iM7CTHB8L1fYvlzUUDnlbCPV6MlUGPOtXM19EszFJPircylSO684
         PZDA==
X-Forwarded-Encrypted: i=1; AJvYcCWCjPSnAF2e9rqNgz2n360uX0SlT2jivTKujd3vxmErL0bXaDl4k0KtlfHeJgwnV1FAraMpZV6WigHycqiJ/L2ap7gCNMKCrBwVLTyjsQ==
X-Gm-Message-State: AOJu0YydWCNITUSuF9iB6QwX6ksSAvfBS9dJTXz+wTK6wrJM7EdahrfI
	EGas3HoP3LDPRvk63rN/Ye4sK8FCv0Z0C/ABtuw/3rHOLYsLo9xCOk3ICmqPYqIsi5NDhvPQKLx
	+3tHf9w2EGRTTilaV0LGlHG8h7R32osvhDfxERA76UAqQAfSPkVxhtz8=
X-Google-Smtp-Source: AGHT+IG4QI0KeghT/04h1y+qObg0of7pbkvKUpoiyWTfn6I+VKPKB7VJiBDBfJC6+j8HBzzrx2DohQ/EipLv3inF8Xn6oz88XXxK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:365:1c10:9cfa with SMTP id
 h14-20020a92c26e000000b003651c109cfamr129745ild.5.1709200203621; Thu, 29 Feb
 2024 01:50:03 -0800 (PST)
Date: Thu, 29 Feb 2024 01:50:03 -0800
In-Reply-To: <000000000000e2c68a05ff02fe43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcae190612822e30@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel panic: corrupted stack end in do_sys_ftruncate
From: syzbot <syzbot+3e32db5854a2dc0011ff@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12203874180000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=3e32db5854a2dc0011ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a44d50a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bee4cb280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

