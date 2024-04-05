Return-Path: <linux-fsdevel+bounces-16191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5358899D29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 14:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4680B1F23316
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACD16ABDE;
	Fri,  5 Apr 2024 12:38:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB258137916
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320703; cv=none; b=AZ23I0cHqUvCNZ5/mIuk3BAW427u9DwIkZnalrLyhHdSNcbrBTiRMBxD8QY1Kd/jO6KwgIZtiSP67XfjlKjueOxVL2hfxo5Jw3QUD4Hl/Hy//ptMtRuQw3qj6rhRzDmRsAkc3ncinc1SaTefKqGvfxR1PGPs7dZV2W8AQTfPbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320703; c=relaxed/simple;
	bh=VJy2fQXp4bH5ajdBVi8OcRqcvqGxk/2k8jyUc+7+TNY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Gs9Pzufo1DPhhT2aDdxzrxTiQzzjyHp26niU36UxDzOMZ3Fn8CkTIP7T4SMVphKyIyX1O4Qw4hCHLMOul42qDdr3Mdw2+BTDgi2r9/w2wBSJmHSaTj7QzhJVMOiBYvDBrOOelihMGaVv6H1k5PW+VyjNRenZuVGVlOpAMuCuAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso207319139f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 05:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712320701; x=1712925501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2am2W/k9n1yloAByRyhVWfNC7/CvDaDawdSDOV1DGqU=;
        b=rl45p5bUkUw4wW2yehWNqQJlscsF4jO4+mz1zSUJylzXXkYJXm8NdV0g3/6IxuQ3/h
         RVsr0dZY03yvV6gmqKf/KQIUbI1wv9wKezPPM5vvocdffbr+SuAxfce85eaCw89T5ye2
         HmKRS/82qJ9F7W6OsYNp1UApiyZRKQqPruHj6m0h9Mjcw97HOVOuvpgWWCfllASuMiYs
         CFjFRHvRlFub5xdAT24RdzSHmg2W1h1xlYqlJw/8r0AqUmQMFQDyMBZpeSZTdQ6ureYc
         RqXPyqaUN5l272Astq6nnXujFJMZulAMl0fitnqEn/JCchyYBxshFr0GttOBIn4Oz5rh
         Yu9g==
X-Forwarded-Encrypted: i=1; AJvYcCVOkqSQNt9o2GZ6HW77PLKumdi9o1B8QsgDVIZgwST5I1CFMxBE+PqUAbXSC7/5gU4eZ6/HC+5rJmghrCHjA09ttNmX88xZilPh6JzUKw==
X-Gm-Message-State: AOJu0YxxVL3rxo5CZCBT8p9ZZ32YfbnqwdXB7MzFRjUFsV+brYtm0kpg
	DCp/yzO7oR90OCvjtp4g7JCXcYdTwXQO5tzE0QvBfnkyHAZJwzTKT6kfRtrs9u6+1HAKpHBJnOj
	gdz1wznsCPGGSL4LngDOxV9DKRI7fWeb2aZvV569oksgvbxVOAgDr5qM=
X-Google-Smtp-Source: AGHT+IEvPfoUMU6ehf1Inypureina91/Rf8s4280mhBuoEkxeX3LsAafB10gx47dLxjpUneLjq3x2vXzGjACyv9wBkvtb+nBgTfT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d0b:b0:47e:db91:dd2a with SMTP id
 he11-20020a0566386d0b00b0047edb91dd2amr69173jab.3.1712320700928; Fri, 05 Apr
 2024 05:38:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ee4d3061558bb8d@google.com>
Subject: [syzbot] Monthly ntfs3 report (Apr 2024)
From: syzbot <syzbot+listb6eea14750ad5e9c17ba@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 2 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 48 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5493    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<2>  3886    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  2812    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<4>  2647    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<5>  2282    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<6>  1837    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<7>  1331    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<8>  669     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<9>  507     Yes   KASAN: slab-out-of-bounds Read in ntfs_readdir
                   https://syzkaller.appspot.com/bug?extid=d36761079ac1b585a6df
<10> 318     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

