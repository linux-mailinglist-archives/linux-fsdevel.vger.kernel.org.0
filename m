Return-Path: <linux-fsdevel+bounces-8288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03608324D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 08:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26411C22C62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 07:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6422BDDA9;
	Fri, 19 Jan 2024 07:05:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF25D531
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647910; cv=none; b=d2A5eW+kQIj0KG676h5L5ab9cihOqEBdwTASMYoMKYn8yaUn9ke5bagwoMSF+3acEKR4/GNu0ZmyFSrkrN7+VfXKN8qqHruHFzOYdOPB/56Jrb4G19m4YRLiMGY2Qu5truqcy9PxAfH02N6hmAqVjMOvtZ0LTt7bzhKivrgYBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647910; c=relaxed/simple;
	bh=PRCcc6n8SezOmBcjJ1w6ADI1y4YbyE6RB38U2xwAsw0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HayM/PclFloYLWqZhMkHyj9Sqe2g0WRP40xCembtusxAnyag62dgyFuMy55+zKIldtZEXdbVYx9HEpm5RQwaENjfq1sTaUpiQQvKWfcv0Zxv5Qr06t+tauJhJ8LUGBdD4o+BM2Z6n7EnbyLmhTLF+awPqyJUSRbl1rWFQj/GWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf5fe1ca9fso76666639f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 23:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705647908; x=1706252708;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHAoXMaxOaUZ8hGAc5thrJTPKmiHqe68fKrRjO5mByM=;
        b=FFKAxrTEZGb+S08ntLlfQ3SNKj2zrWgutIqlApbVX+CoqjSwykmMA7qKmE31nhhfzs
         FS1M50+Ye/VKLpJG2cLGd1GcU64SmP5v9VQS/sgeVwDuRKWKEnl2avCV+ykWFwYuBJwv
         FpREbel2qaNnmqA1S2x4I9+k7O/ze1Y51VjVQHvTOMrxKuhHG7j3iLedGMYFyBUlyNtJ
         qQQUh9D26arz3a4ZfrRujvb8LxvqAR8sM5NIGD67R+Tq4IZBe2G0o/N+trPPxWDAtNAv
         O8mNHVkQaevBDGmpjKGBUvffL2a4xFjUx2L6AJe+iP7CJntSj/5ABpoOVN01lbtAS/aW
         6qOQ==
X-Gm-Message-State: AOJu0YwvUn2d0EdtEuEZ9QjVRsXSDqsFPQaAqQlPETsg/NNbTmGiq1jl
	xZT4+eiTXUPa6SuHN5anWzuR9FCcrWjN85nNE3gKNH5aY/Phng7RaCWfQGAcH+AZbKSr50GLW6E
	xVvy8uEt5iB4aFXoTCZJcrrJrdhWtRfeiy/qpkWXO19e7bqSeccONkew=
X-Google-Smtp-Source: AGHT+IFxmbK7qK6jiqTPmsRka4RwZvaBVbSkxnFcVZuSGO731Si1AsheewJm27UvDyBlCoamByT9xUL0ORVqiICJsAtkOp3Q6aS/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a8e:b0:46e:6716:e6a3 with SMTP id
 ce14-20020a0566381a8e00b0046e6716e6a3mr7025jab.3.1705647908011; Thu, 18 Jan
 2024 23:05:08 -0800 (PST)
Date: Thu, 18 Jan 2024 23:05:07 -0800
In-Reply-To: <000000000000e38e4105e9d6e741@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab49d0060f4719a4@google.com>
Subject: Re: [syzbot] [jfs] WARNING in ea_get
From: syzbot <syzbot+5dd35da975e32d9df9ab@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b95fdbe80000
start commit:   49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd35da975e32d9df9ab
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1173d7ff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2ea70880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

