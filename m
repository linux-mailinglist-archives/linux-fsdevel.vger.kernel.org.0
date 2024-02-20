Return-Path: <linux-fsdevel+bounces-12087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36185B25A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E73B21B3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555E57314;
	Tue, 20 Feb 2024 05:39:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184754FA0
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407544; cv=none; b=fCEw9E6NBSzD9lWgqsiAJcNzLxS/xKs5J0oaZNPju+BraeQtZrsOZnUWXDB8OIYei1vHUcrlf6CCvDBdfWrFBEpaXbK0EOjrfy7Kqz3AP5KMRoknEWR+ZuzBKKgCWVbWKk752Ivvr/Rok2cJotft+8P209z9ia3fn4j9erQy+/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407544; c=relaxed/simple;
	bh=3D6cn9XjzHjFbMm3ls5qO6AWGUO8EiGBOnsyhAWwwdw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p/tVctbUxGLGvVQACWE740zR8RM6v9M/nP1Jeuh5QJ116sAHmYSjF/NR6idBPuAu24GToYPKD0iijLbl1wzNwdb8F7yUwaFYnVNoj08hiqJ9z0uxFj6JRcvR3CPf1wTaPVB1q/Gu1uR/PdrU21pN4+T9YH7OJAScynBkP0rKgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bfe777fe22so380744639f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 21:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407542; x=1709012342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzEimjTxUiPK8QlGUDIMCLBh+dSodnszw3pR8qbBUsU=;
        b=Xp877m1GppUAm8Fy7VO+biZWVBZKjquzIVrxSl9DsgITt6wZtHBQh7WaeV+35voenU
         2YXL2faLNIlpMq8vjyW70NW/ecr3fpuXktr22fRAdjvDn+rxflbNkTt9711eE1vEaR+u
         /Sm9MlrVG/Qgfw4p2G0d8J6KP9T8DCM3nVxBJbmtZGaFxMmUsm0amVy50m6Fw8hnocs3
         OxOxCHPzRyupb6JbQKz/Tw+WM3lk2zQ/lNXftCPWF7jSKTNkSShT+0eQqghmm+ur28t8
         i3t/SaiAYyXegaNALQkqSGN38vlpyPUnvTAq7QlhMrHLiiszkrR1YQxTYgGR2+IR79yO
         jkxg==
X-Forwarded-Encrypted: i=1; AJvYcCU4d2fnUbMk8fjtR7MfJ+PmQQn4zbyL7kAFchV9EmiMMArWBqFHyzvmQ0KDRjWNgCAh77JfruMAAlsmxbiAp2AaM7l8AaG+7LewuciU2Q==
X-Gm-Message-State: AOJu0YwkVhbL2mWNbQOvTYmm+cGcb8kBZ+1a1RvNjWeo2ESsGDR3GZfH
	1q5zNm9GSq9hOfXVwzzAIkOrqtB9QDU1tb3zxIEqT5LkfMReKx7xBFuXvWtn7iKRXsYhsQiMSNl
	P21nlz4ak2r9fqQy98euu/eZuijoJV2bX9jMER8Q9gjW/dEMx4XbNEjw=
X-Google-Smtp-Source: AGHT+IEOpIm03ZiZ2lJ/lHSHFI+Mm8U5WA8Q/IrAgn3qmmy4iCtGItZ/O8nuHuz2UprhExvnzs9gW9Vv5lJb7mKBrqgvWKGHB8LF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4905:b0:473:edc2:9589 with SMTP id
 cx5-20020a056638490500b00473edc29589mr271909jab.3.1708407542209; Mon, 19 Feb
 2024 21:39:02 -0800 (PST)
Date: Mon, 19 Feb 2024 21:39:02 -0800
In-Reply-To: <000000000000ae0abc0600e0d534@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af682a0611c9a06f@google.com>
Subject: Re: [syzbot] [apparmor?] [ext4?] general protection fault in common_perm_cond
From: syzbot <syzbot+7d5fa8eb99155f439221@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, apparmor-owner@lists.ubuntu.com, 
	apparmor@lists.ubuntu.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, john.johansen@canonical.com, john@apparmor.net, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1644f22c180000
start commit:   b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
dashboard link: https://syzkaller.appspot.com/bug?extid=7d5fa8eb99155f439221
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137b16dca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14153b7ca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

