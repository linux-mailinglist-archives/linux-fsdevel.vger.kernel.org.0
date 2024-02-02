Return-Path: <linux-fsdevel+bounces-10109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF99F847B50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831D71F20EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A49283A11;
	Fri,  2 Feb 2024 21:04:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9513839E0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907871; cv=none; b=lFIz/jLmOzZq1rEc9c4GRBAjQMQ++ySPy5NcmJnjsgj6kF3w67+CD4HaFlcepizoCXybHLlhEIhx9i+Nxwt0AkLP+bkk7n83vvNFr9UPm/+4Y5eKbRACypN1Py1ePeJeYHMC/p/PVyt0MyatQ6VZgx/p+wd8lujLQyTykFTyb3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907871; c=relaxed/simple;
	bh=tq9OBZTgQyCH87t/qDarpMTGB6eSBXlRhY5JUdRvsvw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FAH3s22lppVS1kpL2zA7h3OWxBRSq0vkS2u3mMIUYVW5FwyT8ODq9JS/XVYkX0lTPzhnCT2RxxspkBaRPo6G/lUe0VO2m01M3VkmyvBiRUOnX0tnYb/lj2chpSBTp5a3XagkyRFp62ckpJsqVTFPksRMBLIz+b7C8/W1AIattQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf356bdc2fso261429139f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 13:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907868; x=1707512668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI/w2TtwDGoScLVEviG8NmZ2V+Vz0pKlR5tZrWiwpvw=;
        b=sa+lEzm9tBK0YM3ZTSqBAL3CAKzpqdzchJB427F6/9maZKWv9qba6tDjg/YlBQjZCe
         /JMFdkFZJmEZjU8+lqzRmx8uD9t/j7F5DGdLVBePiyKJXrN8mI55hWJLkWac8VFrkt2n
         OYtUgckg4w+Ii4a/ClcnHTraxpZdlTug8amDMYKKw2M7/ccNzC/foGrmN26HkkTPnxeF
         zh/iBJGtWzPUZq2FNDba33w8Ct2oT4MSeF5CfyYFPAtDK1gz4AziREoqYatUcRMPz94l
         vfV/nbwMKLzbdLw/JD4Asu2bliR4tKCl/YbiUyhvrQpfvmIdw2BBpwVPR0i+Qu0r/sFh
         x6vA==
X-Gm-Message-State: AOJu0YwGAc/1q9sivC4amrUMXhsGCRr4k6ufqnPvkA/NP+0BMjuYW4cq
	JDRAODe/d0QM6d7a+6u80099i0mOj6oRElrFgdkd70NOBIugx6yJFGJt0OUVtcA9Pi0hCAXBpdZ
	P6zhVlF4jEGty8Kd25Xq2XAHdtWW1zKIDJ8AIqh6NQSmoEXCTbdxQeYo=
X-Google-Smtp-Source: AGHT+IGCtU+yrWKPk7kGGb9ww36wfLIcEkDHTPAbbFRyz29mLOaOgoBOKnbZZl9RtvScjBKvjbW1T193Azl07ex2OJnyt8A7mVxH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:8790:0:b0:46e:c3d9:8636 with SMTP id
 t16-20020a028790000000b0046ec3d98636mr27380jai.5.1706907867972; Fri, 02 Feb
 2024 13:04:27 -0800 (PST)
Date: Fri, 02 Feb 2024 13:04:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022908006106c7537@google.com>
Subject: [syzbot] Monthly ntfs3 report (Feb 2024)
From: syzbot <syzbot+lista12ac4cc66e9ef5cbe7d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 37 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11637   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  5481    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<3>  3804    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<4>  2434    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<5>  2032    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<6>  1926    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<7>  1668    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<8>  1289    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<9>  936     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<10> 845     Yes   possible deadlock in map_mft_record
                   https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

