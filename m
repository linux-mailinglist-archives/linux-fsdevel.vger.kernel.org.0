Return-Path: <linux-fsdevel+bounces-14191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D19A8790FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD286282844
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0728079956;
	Tue, 12 Mar 2024 09:29:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87278290
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235771; cv=none; b=lOgYf3IPc+dBQywtIug26lTy4rXuJyywW+5GXnH0VWE+NkkdSsls0zhnxnfynetO77Il0HWWNT9uDTMYZTwRT7GSjLO40rauKDXo19u4zvRHGYFjFN1aimac8LLYDdiQHRNxLUV+IKIwDrGJ+RIye2XILcZert1S3QeQ87HJjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235771; c=relaxed/simple;
	bh=ehWpkfkMr4Exik6vYYe2yGX8sbZqG5YleARftCleK0U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nmH2oR3vOFaiZ9qx/32IBpBSsCUM62hpBUzImS11Bd3HqyNJ5ZqLd5u6+zhhQ0Y1+AKtV/wPBH2pl+aE9iDHbTalc16Oum3kMJNw71oCwVYWawzRBRmE1OgKFT65etrcJtlIuzcFhUcs4hT+GYED9Ny53g0O38uZPLqfQmk+GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8ae14c2ccso192847839f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 02:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235769; x=1710840569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFetsjEr0kUioGW5XrIiMJoGBxEPtRzAwYLRDfXTaMY=;
        b=dit+6L0+nNjDpo8ijb6FLZRjsSD03sGMJZMcsuaaAhqXIEk0ivZEE5T9U2L1WQup61
         rrox9c6pYpXnatS2WFlBF9oXmkXaOaPWn9mIxJe1J8saIdhiH5J9pKWv8/cELdxZIIy5
         uC4YxUPDryH3Q4tuMNdND4d+dNdDVBruof5Wc42UFxTw9BYaVce6V2E/lbJDNICFATC5
         +MoaNLPOFvET6XMwFyIaBANlF8O12H2cAqXyTMHraTY/tUW/RasZ5qjiSCRFtn0O8I+G
         wyYXVfp/qEhaoxKZtEQEam4FFRmWiRZBeZvQqaauOLl5BnWuN8qAwbd46mJmeME5wFiA
         KTmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYlIm6YxTecncOhgp/pQLdUobjOsu1VJiRu4mh+xHhpEaQCt3TeOj2ieT2G97AZku1pw/MsrCOfauSfG9mM+c5a1/xYkr6n2PkJW1UMQ==
X-Gm-Message-State: AOJu0YwoZnrRr2mg6qzun3nToYBeNYoorPwYDkCwmwt2cmZIBshlYw1v
	VdgVSDQUHSzvtwrpOyC9UviNG6Yj+GZQMcMR7Fu4XJsD1ZjD/Uw5CyXZu0Y1TRpyVrBnkfKisP+
	8cShG9mxR3Juu9Ba5NQRBPH/6ekWckLUnngC60IzTbePKJjljIjhZ5no=
X-Google-Smtp-Source: AGHT+IHhz/Axrt0zZCKf3PniY1Mh1aydPtxkbDwqNPaTDtF0sB8pBoy7STMPAKzoXmjYPCvamqPfzoT6Mma8+3/tz7bzOG/dk9wy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1506:b0:476:d5dc:b729 with SMTP id
 b6-20020a056638150600b00476d5dcb729mr93611jat.4.1710235768831; Tue, 12 Mar
 2024 02:29:28 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bfda60613734bdf@google.com>
Subject: [syzbot] Monthly ext4 report (Mar 2024)
From: syzbot <syzbot+list9a35871b40c53fa1b44b@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 1 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 130 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8629    Yes   WARNING: locking bug in ext4_move_extents
                   https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2>  697     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3>  401     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4>  173     No    possible deadlock in evict (3)
                   https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5>  81      No    WARNING in ext4_write_inode (2)
                   https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<6>  23      No    possible deadlock in ext4_da_get_block_prep
                   https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
<7>  22      No    possible deadlock in start_this_handle (4)
                   https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<8>  18      Yes   INFO: rcu detected stall in sys_unlink (3)
                   https://syzkaller.appspot.com/bug?extid=c4f62ba28cc1290de764
<9>  18      Yes   kernel BUG in __ext4_journal_stop
                   https://syzkaller.appspot.com/bug?extid=bdab24d5bf96d57c50b0
<10> 7       Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

