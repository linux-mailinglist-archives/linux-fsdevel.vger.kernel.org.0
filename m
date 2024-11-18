Return-Path: <linux-fsdevel+bounces-35078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7159D0F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D4BB295C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 10:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4F194C62;
	Mon, 18 Nov 2024 10:47:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427517C98
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926848; cv=none; b=PZ9IYLgZxzE74Kuc+evJrspTW0/isOhOTEp+7hBhOCGS88gPtk98+dvHxYKxizcKidTv3+HDsnq3iGCauW/WkczwFFDESYwI0L0gvJfBIpFJD5L2gGBDNXtuSa3OBFuv0aRSTX82SOhT5abfOxgtovZu7LWnqtlUVrjUvd4vFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926848; c=relaxed/simple;
	bh=Gf8eEWVvFhUCKkLtiXICZZ+u2faMFGrYc8gSrJ/uBFw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hKEaVc1zuyGDj+GMwDLzq5YzkFH9rZUxPUDFJEs1CKKWojnTUrjxvvHJNB6NA8GlRvPWFdQ4nhrbTdxY3HLXJIb4J3Q7PkJcrKFyLjB5QfPIw1rJ2SHGI2OIGg1S4YlCV8b7Pp4F+NaMFiEOz1/+izPIW3B3zHDR8QdXhShlM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa904b231so292340139f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926846; x=1732531646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSjCy1ZybpwZB7K4sbkHiQc0pzvKqHISOttFeMm25xw=;
        b=EXwq5NjkMBQMtsCKv9Fl42Vb7m+Xtj0munFvTRxqE6z5ZYIOqq4IkFuWxUNlEgGAk4
         T4f5N9xXVquXZEiAFnYVGpelIupf+bqhDGEJpZxuLxasG+MyXy1S++vFcEgtW0Qa7rFY
         BRXFsmNCDoN2dWlOvVAp2sYOYhXOsV5vl/nkCozAUugMKEzxoBb9zLkz+7cCj3PAFHD6
         9eaziN5tfRiPbcOxygaaF1FaGuOvTM/TBZtmJBtllTo07vkbDnEddN5qmxXCWCYqT62Z
         xS/Fv4trMHiMgY+iM9AC/hhVcyMojsrFM/pPCCupny5G4M71aMclGK3SrI7+W8vArzpL
         CA+w==
X-Gm-Message-State: AOJu0Yy6Y1OWKAkZ5hdSAxq4J/Qivz9GvY6GrwqZlnF42KASRsqhv8s9
	jx48mjQ0RDAWOlMLcDWVlgyZb9R8V1is25UgxCXLWVCKcYbvv/4mXoIdTHl1hTheFXBeCyX0/FU
	oiyKwk6+dFUo4IObVaoVKYVIQukGVH50lpArqZmbxSKHkBax3Xdn5kCw=
X-Google-Smtp-Source: AGHT+IEZdBRTVR7//FElZJfqdMZHC4QFr9tf01rseNOPrLDoDkviicBCePTCWZWfr5rxqwMyXmp6UgURL3y8tmz75KD82wcGbH58
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4a:b0:3a7:629a:8bf3 with SMTP id
 e9e14a558f8ab-3a7629a8d52mr38986535ab.2.1731926846390; Mon, 18 Nov 2024
 02:47:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:47:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1b3e.050a0220.87769.0030.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Nov 2024)
From: syzbot <syzbot+list633574df4e9b6c4a50f7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  29630   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  11478   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  10079   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<4>  3712    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<5>  2602    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<6>  2241    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  2069    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  1926    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  1728    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 1721    Yes   KMSAN: uninit-value in hfsplus_lookup
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

