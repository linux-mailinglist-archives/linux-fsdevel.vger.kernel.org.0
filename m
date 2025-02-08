Return-Path: <linux-fsdevel+bounces-41281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32851A2D47E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 08:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1873E3AB25F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C236C1AA791;
	Sat,  8 Feb 2025 07:25:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED419DF98
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738999508; cv=none; b=BlpF6/o3ZHHNk9drdSiPAodm85Jpt3jc9Eg1KCFXqe/wpfIwwRUBzIiiDWyBeEaCxNkP9Yh3SJYHY6oNSr3Unde9tCaX8ezm4ta0CCgrk8ee93TeXJu+WMS7B9wOsX/7w+dGrYA8VWXww2Jp12shmJhfVpyVRyV98r54h79weJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738999508; c=relaxed/simple;
	bh=nO3hchjOsaP1RONuy97ZQXYJfj/XWV3o1xs5m2QVd2Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BBNOh1qXBzz5xnpW+hcygJfc/RfUnxuFOHn2ghdZyY/G4CpTSNXFb0cmjmJcMCtN56FYy8xRnHdJiViX+B6hZdJxfH9Rm5xWmZu8c+T5bVC52bUI8nM/g/V0vOtcxZYYnAPKd7HJHaI6CxKVN8Ae7nuchckVqBCjsNjHtZ5RulU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-84cb445557aso609677639f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 23:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738999506; x=1739604306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTLH3DE1scVq8ZV/C5ZLGjBap6ga1IZ5cXcRDj04E4E=;
        b=M+P+l35uF17PmE8mXBh/nZeFdRuv4xnjLjiDLBdn3Ole0l46+9XdeTtqRib8WkvUDh
         HqXq56so6/XkOiqgVihov+4ziGGQMSh7cldrnrOgCbJSPZuluXahWEqotPhGsx6oZOzB
         mdEOBp5zw3l6bCRciBZBHFlJt8ypGYepRwZu6qCQQwXWibbRnsNOk5fjuG+tGLT3dztz
         CQGJ+Mix17PAVXu6Qkh8wF3pS4ad0aaH3o+h0m42YBdIS8mOKfHwbqYFB0a22lUQIarG
         ZRQWshlyxYxrvdjxbWsUOdbZP9z4NgTvAm4QlMWxX1iVj1hZV3OosSzmb2iTpx+QbIP6
         m3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXTll72lTFslNkM1SaA5wL+msyOCESa5j7Wf27KUaw6b2OM8zqWHEutt3c71UXgmrVeHUTOsaOkAlqrHGoe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+08EWx7BkD4OYc5DQNY2+LRWKSVz04sT7lysUZQh9bb8arhK1
	81OZdcNjUkwvYIRy5wu6oVoumqTRZmM35JRAkjwnZM3Ii6OxEczO9BR4v0ZGIsPYn+447mg08rQ
	XoqqZywTaLSLg9tV9588NRW3zWVWLhdsPy89HKqm7oEF0U4mJio1FkNE=
X-Google-Smtp-Source: AGHT+IGKkh/0FawH2W86AI8WUkzUTbydbSlAtwptxUOjYiSCq8r5MPZ/xLAa/+mPU/8D2xKFQdArsfXVcM8/oj6kp6MWTlj6YvS/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:481c:b0:3cf:b626:66c2 with SMTP id
 e9e14a558f8ab-3d13df546c4mr45042965ab.19.1738999505985; Fri, 07 Feb 2025
 23:25:05 -0800 (PST)
Date: Fri, 07 Feb 2025 23:25:05 -0800
In-Reply-To: <67a4b9e8.050a0220.d6d27.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a706d1.050a0220.3d72c.0020.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in clone_private_mount
From: syzbot <syzbot+62dfea789a2cedac1298@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, lizhi.xu@windriver.com, mike@mbaynton.com, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ae63304102ecd597130ecea27395739a6a6371b7
Author: Christian Brauner <brauner@kernel.org>
Date:   Thu Jan 23 19:19:48 2025 +0000

    fs: allow detached mounts in clone_private_mount()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cb5ca4580000
start commit:   808eb958781e Add linux-next specific files for 20250206
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12cb5ca4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14cb5ca4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88b25e5d30d576e4
dashboard link: https://syzkaller.appspot.com/bug?extid=62dfea789a2cedac1298
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16346df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117e80e4580000

Reported-by: syzbot+62dfea789a2cedac1298@syzkaller.appspotmail.com
Fixes: ae63304102ec ("fs: allow detached mounts in clone_private_mount()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

