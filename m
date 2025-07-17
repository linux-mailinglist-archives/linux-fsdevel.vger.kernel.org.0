Return-Path: <linux-fsdevel+bounces-55210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CAB08750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF85177FD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF22571B8;
	Thu, 17 Jul 2025 07:47:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6521ADA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738425; cv=none; b=Ey8JNtrmNDwJFdu1PTZSO5Okv19Hu0ZukRh13v1KGKNf1lU6Qlktd8ngAYxeuPmM8aA/+vg5g+svshdqF3+eCSOM2529gEyb6A1izwZ8UUKFHjwnzaWZRFhXy/w/yVA28TYzdAaI5Q6TB3F1ur0aemgdvOAZVfhO/D2PhVvGCzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738425; c=relaxed/simple;
	bh=oAushCkBvV9QVtlmVzcvZy/T7QeVNIgehZzoxP8tyJI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z0mHPk4vJgmufb2LTjPyu9FRbQDQxnVOyhVZjoBSUwBB+tCC7wiqxVRj3o9br7hlnt9iTKfW7rbWlKLsWChlQZF4U6wP5Of/fe5lGrFkz7im6hmoZwHV7Xcu/fnHvKCb+VJ8kcPY3qbpAqBmdtIQ1ZMgHCTKOAWRj3xVgGUx8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c056ae7c0so38623139f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 00:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738423; x=1753343223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4XNUZgAi+l283TvCsQpiUhvK+cuI7VeHcRlXxmM9i8=;
        b=MugakHTLwA7LDb7b5nDdMiMnKgbw8oxY8+eHthgCxE8PwgH45xsYbPuU/OETc+AqwN
         mmBSzBms0dEHDzOh9YWIYIVYm5xFUTOT0VfxRdZPMDDXLWxwP5lLGICiPD9h2uUfR4Xl
         I+6oRiEIL9ASjp72GwuXGkwHS8HdHmZWOaWK8FCtKMWPKWpaA7SUFqT0B00Po09hvZB2
         cyfpPNCUA3J9165xqwvMHJ5QziNK1vCibGFUf4HR7MJZHj097LhzMl+Ns84J49abQA/z
         dMT9fJAAlHFls1p+CauiV3Sb5x3MyRQWrdcrE9OZ+v0I0aPvWZKqxSQz7CkfqhiGfROW
         9K1g==
X-Forwarded-Encrypted: i=1; AJvYcCUbWF5MWY4obv2Q0tilSH1CTt20uuRqs0faasH0bAMMxsrRudkAjd3lt6+BILKpS3WdyoI7F+E6Y+yZzybN@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTfdQmmesYqIfZfwEwJVHEalKryQkGZlu7SB1kpi+Wh8rwWWv
	OxBIBOjLlMwJDifFzMvPjJ6dUCVsmc5XEg/Znf5d+u5+50YXtcaSj0Gxol9EzaHl9mBrw7wVQex
	WVtHPwhkQS9wJmnFKkUv77V5RF32NuviPtOA+t3FKu8FMpIJsXOL7QrHRmq8=
X-Google-Smtp-Source: AGHT+IGz8aHEsyxj7rtahA3L5ydsmqjP1wxPohxhGBIyDbGW2LUyNzgIO3XefJSSds12HTndVIt9ieUIDcFlGhYdL3f9rFlmxmh/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0d:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-879c0892211mr769810239f.2.1752738423049; Thu, 17 Jul 2025
 00:47:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 00:47:03 -0700
In-Reply-To: <6828591c.a00a0220.398d88.0248.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6878aa77.a70a0220.693ce.0040.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_listxattr
From: syzbot <syzbot+4125590f2a9f5b3cdf43@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, lizhi.xu@windriver.com, miklos@szeredi.hu, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 800d0b9b6a8b1b354637b4194cc167ad1ce2bdd3
Author: Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu Jun 5 16:51:16 2025 +0000

    fs/xattr.c: fix simple_xattr_list()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173de382580000
start commit:   e9565e23cd89 Merge tag 'sched_ext-for-6.15-rc6-fixes' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5929ac65be9baf3c
dashboard link: https://syzkaller.appspot.com/bug?extid=4125590f2a9f5b3cdf43
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cb6af4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1301f670580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/xattr.c: fix simple_xattr_list()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

