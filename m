Return-Path: <linux-fsdevel+bounces-11019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3584FE00
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 21:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B44A1C226E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641C8F78;
	Fri,  9 Feb 2024 20:57:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3519CA66
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512246; cv=none; b=AHeRI0jqFAPmJ4lM2HJf2mzk3I0XjQX8rWLmWlI1B6EaDluRLBttX3Zyp9DY3BJeP/Jt4zcbRub2orgPAcUSAWt4X17x0oIuKqq+lTQfiUsyPl+Xadzv7HxJ16FSYwjKaBHiNEiF7/72dL52msuTWTQlDK8hF71sN3RQI4UBjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512246; c=relaxed/simple;
	bh=2w6GPo/MTWtYBaOW/OWgRMg+89zVZ8DGTLxVESk9BN4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZMliAnJQ24u10PX87C2pKkyjWTp+LqbxbLFP/s2GlWAPUlIOcQ58q9EvOKrvs+/BiX+89M7Hd5fqk+TwI2EdgOcbwJWN0Vs7hez46p62ELbkcO3PUqmDCi+ayhlMtiJ8CmazxopoM0xIQtOoOR6YWptuO7Uc41mrH+67Z3z9JOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c0252f7749so110230539f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 12:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512244; x=1708117044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UD6d8u16W8tj+JTdP/So40uF8slaf+OtKrk0cEJJ/h0=;
        b=DhQBDqMdCXdCHWPyMRnzhnGWdez/w4oatXZXF3eeqjwnWqBOmtd7JQBQz9R+gN5GIO
         fZCA1N7dykMAoYeVB8kpBTSqlP5Efg0KqN9lVD9zD3h1rxtWm9esyWf5koDPOPW+2Hhs
         uKqvRqwpiiQr+ZLLSa6V8d6OHta1uI3ESfqZ7XssAaj8u/6hkyjv3I7Urk3C75jyYsYe
         iV82RgBl+Ox8pn4/Q5K7OcPPFP7hfg01cv4h0KtZxzRxlxBe817LmMYFW8fjPMI0FYfx
         eBLo2gYE5eTeoqhq0W9jTpDiqmV1eyVD97TXXLEIePFxelITgqAWx0jWRXDCz6f6qbVH
         vbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9QSfjWZYGzbAUJuHQBcTYonVfCqmFywOI0U9m2ty4AiyJadzmpUt8WM6dDzmzIplUeohMBD2cOzHD25mimprAu9DLvIAGzgXBeuc2A==
X-Gm-Message-State: AOJu0YxKB3WzIV4ic5T1Ub43IVwlC3YbM34D6QXDxw0kqM6jhpH1FOYx
	lZHHJqvVnuUIR3Ut5m1DDC8rHTcMKKAXD2dPSfqQpbxbwYAwph4I6b2Zz7dqM5C3BcK15DKFnGh
	ALvhSOh+kvE/sTD8n345q/paH+/gdrnI88B655zI1JkUfoyDelyv06FY=
X-Google-Smtp-Source: AGHT+IHWrWtwWypyOdoWhS7xlxZMM/q4FtOhWX580rydd3l3k2GZjuwTfOQlG++evGa5EXtX0Av/lBczvNhbkaOJdzRBiWVAg6tR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:363:9d58:8052 with SMTP id
 d13-20020a056e02214d00b003639d588052mr27117ilv.2.1707512244237; Fri, 09 Feb
 2024 12:57:24 -0800 (PST)
Date: Fri, 09 Feb 2024 12:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c47db50610f92cf9@google.com>
Subject: [syzbot] Monthly btrfs report (Feb 2024)
From: syzbot <syzbot+listad2f01a497df9ab5d719@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 43 issues are still open and 51 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5804    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2636    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  251     Yes   INFO: task hung in lock_extent
                   https://syzkaller.appspot.com/bug?extid=eaa05fbc7563874b7ad2
<4>  245     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<5>  224     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  125     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<7>  99      Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<8>  88      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<9>  79      Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<10> 74      Yes   WARNING in btrfs_put_transaction
                   https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

