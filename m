Return-Path: <linux-fsdevel+bounces-11020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F97284FE04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D442D28402C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415F175B0;
	Fri,  9 Feb 2024 20:57:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDCDF54
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512246; cv=none; b=lyPBFpt9HMKf1UbicX9Ijy7pNmh6wJniui2wAEqy1/fYSxiVXHznDYEX5SvL2zditnVraWbL/O0LE9BhGdQ1iwm7eJoFFv9ybSljlhvpwcnHTWo4bViHRTu5249+DNAMOVuMmvuQkb9IsU94I0gIh/gOeHNuPIQP6Pd6ckGdGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512246; c=relaxed/simple;
	bh=+dMAMw2dcfKDAd2+MvSLxA08RleTfIVCrxnfRUmLKyY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aBVOCvNpODc5yGehy4l22FkyjddKMQQzJOOGIPKW4x2TFLz79MHD2Ed/RtNaAJmizjc5nI5mz1j0OKQE7VP8Wa1CbiZoQlPiu5EZCQ2BOXRvVwNmzLb9nPHpxPTPNncvU9GZYqtLkUs2Xtakm4sqNuc3b2wbYiEPETWNrisO8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-360c3346ecbso9996065ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 12:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512244; x=1708117044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFTg0K7lXY4y3frjmYpGnm3YS05WUyZS/wLOJo/jHGs=;
        b=MWlY5mCia63cSpf97d6hgaAgolA3ECOT36jNvM2g+1zOw95G4TK7y9sWi85b8CKjqs
         MzJCL8fGYMLlYOB7a0MSqUTFGc4Mu0G2I+vfW0IJA9jX++e0JdBoojaCAD35BLIWj/2x
         d36QBIxkLzmXJO/Gn2t5ZT9/tnn2RsZfgagmQ3oYI4oKK+SQnGGhHi10a9j3X1Amuhnr
         PV1UYt/IOVxJEOn39HijZGm+X4jRqiFdDV00whM5N40AUPw61aZz06JKrDEo27WUMfUV
         lflv7eN/T5a6l5cN0/aBoDhUL6/gCDvQ4+Z6J/hCZTFfDZQQLJ2EoEGux2DM/Jl2/6Gt
         9Q5w==
X-Gm-Message-State: AOJu0YwMel4/8UhVSs1feh0G04ahBBL8lHYt7YHDJjRjGKXrVjAQa67u
	h5Hw5pQVIw72L9aSnb0UtPJBfrvXZ9foTdMFkEd4MdWIP9YZSc9zsJ86ifurcoNWVyINLtpQQd9
	2ymWewTb2BqppyA+ad398TQ1DHt0xtlum49HrusKQMTj0x04R5VUevJo=
X-Google-Smtp-Source: AGHT+IGdLeGONIs7F845XOWHNTzI5KK9bNltWIUcbWbeIyhjIScRgujk4YF77nhFrcYY3T/XezYbRVoQw/mLnV1uEiSZUwN6cKez
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1521:b0:363:8f06:80b7 with SMTP id
 i1-20020a056e02152100b003638f0680b7mr24487ilu.2.1707512244450; Fri, 09 Feb
 2024 12:57:24 -0800 (PST)
Date: Fri, 09 Feb 2024 12:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7be4b0610f92ce9@google.com>
Subject: [syzbot] Monthly ext4 report (Feb 2024)
From: syzbot <syzbot+listd3850c3d2bbdc5fbcb45@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 4 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 122 have been fixed so far.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7985    Yes   WARNING: locking bug in ext4_move_extents
                  https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
<2> 664     Yes   WARNING: locking bug in __ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<3> 346     Yes   WARNING: locking bug in ext4_ioctl
                  https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<4> 166     No    possible deadlock in evict (3)
                  https://syzkaller.appspot.com/bug?extid=dd426ae4af71f1e74729
<5> 148     Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<6> 69      No    WARNING in ext4_write_inode (2)
                  https://syzkaller.appspot.com/bug?extid=748cc361874fca7d33cc
<7> 19      No    possible deadlock in start_this_handle (4)
                  https://syzkaller.appspot.com/bug?extid=cf0b4280f19be4031cf2
<8> 18      No    possible deadlock in ext4_da_get_block_prep
                  https://syzkaller.appspot.com/bug?extid=a86b193140e10df1aff2
<9> 1       Yes   kernel BUG in set_blocksize
                  https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

