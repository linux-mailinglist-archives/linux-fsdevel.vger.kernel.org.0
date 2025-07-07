Return-Path: <linux-fsdevel+bounces-54072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED6AFAFBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F104C7A6CAF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAAB293C59;
	Mon,  7 Jul 2025 09:30:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AB292B31
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751880605; cv=none; b=HHi15CYYVZjlf/UHCGYsnVSDGdQ0O4AGyQnStdjFfm40ZYv957bWhd5aZQPy8mXObVzbNCnwRID9mN4i07i40Zy0EmV2ogZKnQhuQGR2wT1X+aTb95pwfcr+hJvFTHnEPKmDq/dwK7ZqsmjCKVSBA0oZt37ULVVOIFHakF38gTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751880605; c=relaxed/simple;
	bh=pMhlVEkUFYx16frqYD2ys/zp4Vacync+fTFQLO8Y7j8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=msfdcxmLNtcvn8WhllRCToQU/eQhYmV5HRNUG8og2cAKHkEuilPXxtDcVTB+lsjrl9wxFAGe8ZStCLKMbTQ3u+TxFGNc45ysOgHfgs6gU/RztHPgmK0ivP9Xq8y5i6/MPyFGKcNM0Kxl3v4cESFTVyzPmtnKWKZDDl0TxR1Wg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df4189cd09so59052755ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 02:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751880603; x=1752485403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3FrwSzkZRQpjEv5ax7x7GcgrRUZI1/BeJkblnIIDas=;
        b=JB3is4+7UaKBTtXN0VrS3lPuGGpc6gjNJn7Gd4AeR189ADjkD1Spr6Zn2q0FlSWOrW
         YmsBqqBfBMyzXFx7AhR1RU87bT1vD28JBeOUelJuFNtlmrcKW5NQHOwxeWsVZSM7Z3lV
         lpnhspk2JeSPx6gZ+LydDi2lPyQIu49r6vhGUyORkcum2zv8rAlNJL3yKYQe3IcN28wE
         Mw2ge9CmAfa6OiYNV+eGS0v2cogYKWo9gmdaAL8p9jM503W09n33G25UldncBOgeqLI8
         5de14rZ3N+ybHgc1KOaIdoJOqUfwFX/j3bgHnynb9dCpC2J/UbbKrcpYuyNXy+1qBUgO
         m4+g==
X-Forwarded-Encrypted: i=1; AJvYcCW22KnOeYU1gkNmDjyXQns1UZC5LGg9BwcSdosH59aT6RA47S7FYUE61rS02l1R1YMBdebn/vZX87q4bJu5@vger.kernel.org
X-Gm-Message-State: AOJu0YxfANg1UuM/XFPRrlyjtIDwE3egJ5VNwOx0QEUyuHwsg63E4jto
	WLYXrZwjbyD39oKSnGsxkqaGcTWU35y6V06wYHSAptOLLedmqo/f+AUS9SLHTM6hSEj3av7ln6s
	TlmT6R8kWUEU0TO3c2iu1XayHweuYLm23BuJL45zta9CAds2Au291vulwnmE=
X-Google-Smtp-Source: AGHT+IH5hJ99iBdAZ2eUEYhkALrqUM1smJuemUwvFzbEb4CHV+YszENd6TVowh9yRirN1q24ejmtOnIeaAYKcZbBaU/7HfoXhukt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:3df:4738:977e with SMTP id
 e9e14a558f8ab-3e1371d527fmr93550285ab.10.1751880602735; Mon, 07 Jul 2025
 02:30:02 -0700 (PDT)
Date: Mon, 07 Jul 2025 02:30:02 -0700
In-Reply-To: <67917ed8.050a0220.15cac.02eb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686b939a.a00a0220.c7b3.007e.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: corrupted list in remove_wait_queue (2)
From: syzbot <syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, lizhi.xu@windriver.com, mchehab@kernel.org, 
	standback@126.com, superman.xpt@gmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed Apr 14 08:58:10 2021 +0000

    staging: comedi: move out of staging directory

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13009f70580000
start commit:   05df91921da6 Merge tag 'v6.16-rc4-smb3-client-fixes' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10809f70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17009f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45bd916a213c79bb
dashboard link: https://syzkaller.appspot.com/bug?extid=4e21d5f67b886a692b55
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cdc8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d1a582580000

Reported-by: syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com
Fixes: 8ffdff6a8cfb ("staging: comedi: move out of staging directory")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

