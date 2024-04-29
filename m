Return-Path: <linux-fsdevel+bounces-18102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28788B58AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0062888D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4D254746;
	Mon, 29 Apr 2024 12:34:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862CCC15D
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394066; cv=none; b=OiMsU1PjVOPBjEHMshW8EhXvJyfhjXbyXQUctfHxqeiJBr553sM1liktVJnDF5EpayWmuacSEF79K+HY/j4vbE4ucmeO5A+/aRwx3rw+2ZkcPKrmhCDi4axks6kBmTvA0VGACRwgjkcRBVjdEbYSpNWtsbvBOovM5gdvfbAQgTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394066; c=relaxed/simple;
	bh=LqwpeATDEqzTWvBRdvng7xlYCZcHB8eS4iVMqq2dtu0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MFm2H6q5U/kLkujv3gMk64MjRYWu8FtUIkK/Ej/kwco84ItcN+0LJrTmsKbC8AipdOOzGJpRAGuKXwX0fFOqZG25sRbZ3PrQb76lnnOcwGaW39TyRlCxhlybQcpHf7lo0wfx1c5RNokKnuEGF/AE746VGMKrED0rIRx2AOpVDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42114485so511672039f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 05:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394064; x=1714998864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o2AaJZfflPUK1SiENvO14YPAhJrFA9DHhIMvZy5GYW0=;
        b=NfNoET118Zv1tWtKwKa04Y0KzwPv/Qu+hS+xczRBLm/1MyQ62T/rUs+Nqbh5LrEl3s
         uDxH5TD+4NBmVnForJaT2uilPasfJknCfRG3fOWiJNMFHbIjZ6E2/ZNh6hfFaJHQK07T
         2QAX9N4iGGiU3jSpaP7/Z9SGDpc6v9Qr5gshgxGIQTdym3i5EKqjbMVuE07ZFeAZ7/p9
         XPZenJ5Jw6qeQprFJwIR7D0pYJA6th+PcdlbnU82g9qrNx1dSr/wg992Of+idVSvIlGz
         c8OGi3mxZFl6cy2l0jCZd4jac9cL1LAn+WUi2UFu8MgPeajGJFBmgpmk6uDSdOeMyvz2
         ZMyw==
X-Forwarded-Encrypted: i=1; AJvYcCXh4Jw2kcwQiV7hTDeedt9bCB39kVUGprdRrhkYH1TzIGDMBo1i1TOawDaUyPbf7jCb4xiLTh5NCmoBXxMuoSybXRQhUB4eJg5Fa9CleQ==
X-Gm-Message-State: AOJu0Yyq+ZhyTXi3VxNW5qKzgzhuVmp9H7b3zwUCY98l6WLhj/72KZFi
	aDNK1RkjlUKkRC+yuwkcvnhBkCYoZci4IGcUJS2gDv189WDS2lWwYWD+Z8sGBMQh00DHkGCT6tj
	ZxTFbI1r/zQm6ypfvEEEhthrDDtCYgBSsvFKPajqfBclf/pWM54d3+1o=
X-Google-Smtp-Source: AGHT+IGi46mPg6VYHOkhq09yOPOdhU3sHjHJG5X5pp+H4weXhi9VVNVgk4hB8yd7+4pvbOMEdAmO/Q9OK+G6k/Rstmb/Y/v53Onf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4112:b0:487:cc0:9c05 with SMTP id
 ay18-20020a056638411200b004870cc09c05mr893258jab.2.1714394064792; Mon, 29 Apr
 2024 05:34:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cbbff06173b79c8@google.com>
Subject: [syzbot] Monthly xfs report (Apr 2024)
From: syzbot <syzbot+list8709ef9586e8e98ab5ae@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 605     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<2> 190     No    possible deadlock in xfs_ilock (2)
                  https://syzkaller.appspot.com/bug?extid=c6d7bff58a2218f14632
<3> 27      No    possible deadlock in xfs_icwalk_ag (2)
                  https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
<4> 6       No    KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

