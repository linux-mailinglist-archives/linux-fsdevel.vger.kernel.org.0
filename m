Return-Path: <linux-fsdevel+bounces-11190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C486851F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB061C225B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7074CDEB;
	Mon, 12 Feb 2024 21:31:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686594CB4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773480; cv=none; b=B2ILGN9c6FSLnNUieA3S5iRgT4GvAJ1JWsJw//RtsCx9/vytEov3vAYKzZFI3QtsUMoW4JeL93PSr8G4JbZzH4CzBYDw/yqlVS0NAWNODGyw8PYfUqqnPe4Bvo5OjJ1B8bhdDA6+GS1xDYZIN8K/mcug+zsbuvqSdgnqeZsm/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773480; c=relaxed/simple;
	bh=UQhOjUdw/dNaYTHglly9JvhE3kjY99zNLtVVdnQ0dvg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OhFNcK2SDx+BuJQ6chfr7Ixtg6A55IDQ0df/HW9RiktdOr5AvZ6Nl58zsGaPNUIg+gy8wqaKHpkWMLZnhFoPYuqc8gqnvZeeXHR6GVC//VRvTmn1D7IOlir/MPAzt3gdqnx1DGMtWQQ2PTRxIlWi5pUdID43Urql4So7Q24ReJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363e7f0c9daso23339825ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 13:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773478; x=1708378278;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtmheStau3mxfam7XQ+ryyvhH3Em590sLVEpsnXD67c=;
        b=QxyOSlwZBBVKIEJ/GHFGHu4nrT7NIJK6Ur5nzhDBHfvmvxj59SRDn3Li5mnOUazm3i
         7+NAhpWznnNmlTfxXk4Xg8aoYLCOHtUhKkb6+FqzJdVgYAjBRs1I4nYiGRguC+W2w9U5
         gRpRjkrkbgPQlTuzwAxKremVX6JDpQOxFIOMqdYGRLND9UK3+5ZyBLNZynkEyTk9qTGv
         I9RPPCc0ij4YIFu2X/BhW25MgGTL5z1E9HpTj/cuUpcZtzth7ePA9LabJ/YZp5jNrsn+
         SK/ivqiGH7Sg8QGn6nLQI1mfcQFKuZXsiSn+BNWYDAs3ROQA8wOdrIWGalHLgDLrY61P
         3cmA==
X-Gm-Message-State: AOJu0Yzbl0jJZs9vmUn7IwcLZ1m/AeGPa6Jg/eT5jUQMBB9Mxzmq8sRs
	cOx8tNIqh6uOeRga8En25JhY7pwGgZm0cYbB3GyZNohkm0a56EPp2nKr9vuRQ/+39RR69HCyZQ8
	kFoa0ar1c/6EmpNHLcjoj3xt1LNJuULXml6XU+kc4PBVl7BUCKXJn4fz09w==
X-Google-Smtp-Source: AGHT+IEH6UT8andQy2alHnOHYSMdxEM0YRZG5dn+PzYHsOp7m+bGo8lI7FpcJITDJtjKw3aXxp0I5EHa+9TsxKZmfUZFD3JCLnuV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:360:134:535e with SMTP id
 m15-20020a056e021c2f00b003600134535emr47776ilh.1.1707773478642; Mon, 12 Feb
 2024 13:31:18 -0800 (PST)
Date: Mon, 12 Feb 2024 13:31:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d2ab7061135ffe6@google.com>
Subject: [syzbot] Monthly fs report (Feb 2024)
From: syzbot <syzbot+list814f946788f272e19d6d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 5 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 338 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1114    Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<2>  231     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<3>  203     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<4>  92      Yes   WARNING in do_mkdirat
                   https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201
<5>  67      Yes   INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<6>  61      Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<7>  60      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<8>  34      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<9>  20      Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<10> 8       Yes   INFO: task hung in truncate_inode_pages_final
                   https://syzkaller.appspot.com/bug?extid=b6973d2babdaf51385eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

