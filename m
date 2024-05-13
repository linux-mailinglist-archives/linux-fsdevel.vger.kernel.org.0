Return-Path: <linux-fsdevel+bounces-19396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72428C48A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3B21F24E0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 21:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDF3839F5;
	Mon, 13 May 2024 21:13:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D0823CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634805; cv=none; b=FJPY0HMIqP5d9Xz9XlGapJatM4QVLTusT0BxPAemVxqHYbkfZWmJxy4rwEfFHwCyspFLr2cxXXFA20SQRMCHSAVuzjA6Q1/Wy5kRXJjpfcZpgK2cgMX/d9MI8t403ctrnv/36cE2TVNkyahipE/TZPSpqmU/lhbeWmjKUtQ8EDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634805; c=relaxed/simple;
	bh=pFlsgEtkxebVYmtKlEJmcV0IrVkDH0P8Uv4Th3tWUpk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uwwFINwj0BPPKSW7N8nku7KCpnePz/nXOHI886NRWRhCASxUPhwpPpQbyIliOSnIlFChR5Y3j75xaOq9aWeOMSoSufb0QLlPHMVJ1fTkrfU/EUd/4FQTnv1/fu4ux93vRRlq8upzMgQk9ub4XOOgdFtPCIQN5LfpfanGbldxCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1d6c70aeaso249873039f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 14:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634803; x=1716239603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdtdrmA2G6hjK/rRAiC82SJBeEiZjj4UCnN5IPNI4mU=;
        b=fxrtYD2cxsnEzhZL/1Sqs9KgrvPkj7DpjUemvcJq+5dZMgPaTSk+qVisYyGockl5Sb
         OVyKwcz4aa5nQpKAJnA3U6o9VtnZTGjsbcxVosf4xKVndXe+XKq9hEk9sPdCr9CU/xy4
         X0IHbBLRU+xU42nYTDs5vlp0mXx5hbRBtbbI+lqERp3mJRNLepij7Pcrw2bLks2bOQPf
         WH90yvgnCnsrH3B7Kot27Vu8gAoAUzKogb6vqDb3NAZv2YqTYn7ao2kaawQ/N1UoHIuM
         Z4m6LGGVqzjMWEHZpaooZGs/EsA/2WfO9s3TWnjH4M606Edk7PM1SrwP5eVDAy7owHAZ
         Mi/A==
X-Gm-Message-State: AOJu0Yw7r04Q05GWL0ILomK2qeg447Fj1Dvf0z3l6Tl2dQJwYHZutSiB
	5y2ay838f+FoOwrIswf+ZwLT4YgatWu0RLcx3dPJhPLJVOrioJxLMim5qrnzog1wxbPNUovMBhr
	nksh0mGBulmvBMCHVQmOluLET59MN7H6tmZmotBBvm9+pZ93xEdpuWOs=
X-Google-Smtp-Source: AGHT+IGUO1tlVmHMRGj8XmZ7tfFDNnl5w++6kWNmi5IEW2QehDwfnU3LKf6sAJE+bTz63sIL2SFXqIBT6d/EP7FgarJIHGW6ab4r
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1609:b0:7e1:b4b2:3664 with SMTP id
 ca18e2360f4ac-7e1b52014bemr48594739f.2.1715634802896; Mon, 13 May 2024
 14:13:22 -0700 (PDT)
Date: Mon, 13 May 2024 14:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdbce606185c5a83@google.com>
Subject: [syzbot] Monthly hfs report (May 2024)
From: syzbot <syzbot+list1c844d77bd05e3197946@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  35302   Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  23022   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  10227   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<4>  8676    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  6584    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  4613    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  2337    Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<8>  1254    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<9>  1102    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 877     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

