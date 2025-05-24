Return-Path: <linux-fsdevel+bounces-49808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 819EFAC2EC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 12:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073DB1BC12C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 10:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25811B5EA4;
	Sat, 24 May 2025 10:05:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645819D8B2
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081137; cv=none; b=OE+KGl620CI4wr7qbC9X/nwoZR481cGwJtI6nWkveTKBKejlw6qTwHyFxbOd4mcqXnpWvcJ41t7GZyYsqXycrRGciN04n0EP/XzGUltDL45ELQVfkzcn7wcoO/g2eLV+SUptgDr1JP7sxvcgrU2eBLHV1d9t6EWJhxXeRarWp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081137; c=relaxed/simple;
	bh=5Dho/UhyNhw8Xndxbgw5Ks5g3QE7trd4nZhV1x2fZMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=synx/VH43JPTfMHOISxZ2O/f9pCNj+ppraFHMPQ3y1IE07juvMPvO0GOWWRzTB3DKo7wqxaW8GS5rmf4ZOAMFS7qX1mpULCv6IqRS4YPLRcR2Ng6HTW/u1I6SfcYS8ChakilUc9ZnO0WATR9LY2dX5MaRXMfdUspVZNZr4ekSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86195b64df7so117905439f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 May 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081134; x=1748685934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RD2cV1CO1dNEpaup5SvqkbO53KQufDr6yCliucKyjDk=;
        b=asuo69a8eeEi20b01BKVWEdxr/Zx62ohi4gWIOQgWFlyxU0x+9gzfZ07OeAsC9TZbl
         hX+V9U/aqrlotGn60vQwV37Y/P+66vFECL+F8ssDfthDTUHvF9djikVOg0rPBqn6fLZB
         QwlDBijWnKU/7EBZx9Dsb0HttYiVhgXjpppK5XpGFw85nTi3BR0RtRTJkhSb8SsqdT+n
         Dfo0+ckkRN9SFQDB8IBABYkb6DMzFysbuL8WW5ME73nO4o4E3cADwk02iV8F9enJyj4I
         l73MRtWN7uFmpSugUKyLQ4vf30ZmGnKjrhKYLCwp/NU8EfTRY+k8vFwyL+5CcXogHJaD
         Eibw==
X-Gm-Message-State: AOJu0YyIXkC3/2aFGLd9muytXxO8yF6Wo3XyYQn2BsnHipxuNFPIst8t
	IT7VZApAoX4p6uqysizUX0LQC7LIp18aFczFWdwkdiIMgrnMO0Ow5VMLdQ3Uc8/cRId9vrbHgP4
	d+6yujEY6+k14ZBVvU1JUUt+lgP4a2RXTzMGqLOrSwdhgPumBoyDfJdJsTy8=
X-Google-Smtp-Source: AGHT+IE56ITQSR7t/xGPzhiObRt51qFb/wjZMl6ZpVRw288eRFFCX2f6FHydabgtfUXFrTQ+cEWS57Coa/uo0cxRHL6dBlphRXMX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a87:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-86cbb7fc708mr255484939f.8.1748081134606; Sat, 24 May 2025
 03:05:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:05:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199ee.a70a0220.29d4a0.07fa.GAE@google.com>
Subject: [syzbot] Monthly hfs report (May 2025)
From: syzbot <syzbot+listdc2978c83beda70d5e82@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  82181   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  16625   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<3>  13051   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  7316    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<5>  4019    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  3876    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3686    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<8>  3653    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  3080    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 2849    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

