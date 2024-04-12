Return-Path: <linux-fsdevel+bounces-16801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E58A2F2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EA0283C2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2EB8249E;
	Fri, 12 Apr 2024 13:18:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029381AB2
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927903; cv=none; b=r79mPkzyiEM5HuJreb7U5fQ9u7eFY6UroEiWPsp283b0neEPTUIZxwG/aVuGqVaGv9SF8/aZ26vMHeOfCdqFSW5+DN9V9+cd/qOjQFN8FETG4dtbTr2rJWbqquj01iuD8+pQgSVGEC9XtQSXXDo/wVIW8LW8MweSCQn5fLfT00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927903; c=relaxed/simple;
	bh=LOlcsAozrpqY1R4Gnr2nIii01BvzRpDB4f46SGyxYS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bwy+LdNRoj487lvxunlAdycXd1gikqQVYRhTJWvA/IJYG/JKLNebObdtJi1gHIEhuie8RszBiWop0/cfl+swJ+VpG+ytn4Tt4eN8q0hw5+UOvLkAZpJK+a/Vjt8M9gkW1fFVUXYYIU2rompDGfOk+0PhXzXwdou/8YS7rxNV1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d676654767so96778239f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aiyLXarLheqfs18atX92Uaw+JpTAPzZE9ydCb489Tp0=;
        b=O0pcN9j2YbK8SbfM4u99MZICNISPRHcFQE5rpGpk///SX4lij7mz27T6iuoH1O6E5V
         KupF5vyr1RuO/uNdWPSInaWqLGPLpzuccM7ibUlrzUfXL3mD5gExCeZEjTVQ+p/oaVfm
         L/SccHk49sfVmrEl8lDR+hKqoOPBWomw6KFgWCQgRDijF73HDM18X/DwVoUQq1Qv91Kt
         CmSdN34nZ3XnZxD7zXy2IPEqiAWFicqUhl5pFOtl1cNCEfZjW1HBu24z5yjfX3HdGh3x
         W4GUManZJC50vOk/GhVmERMNovVbKEowTJq1rWP7ByuW8B6iVyx+SgInEaKmsEW4cmAE
         TUiA==
X-Forwarded-Encrypted: i=1; AJvYcCVWSJZWyV5nWtNOeJlp+3a68RtAR/2EuGgnodv0QCEB9Gql69fI3f0n66PQOL4Vs5rxPUAu+JuYj93wpQCxNRGmnb0cZ9Dr6pHP2pNLlw==
X-Gm-Message-State: AOJu0Yw3KgipD3lVeS8pK0SqYUMCJJlKE2j2yPMU1K8Gn2nrxI688lGB
	6TX/gPoATcYVtCgYL4Qwe/Oj8pkkLRNVhRJXE7FR7hwHE/u1f0Ml/aNwa1x2A6rXHAPoWu4Fvpg
	4wtT1m1HGq5FtrGl8Gz9k/B6MrF2d3aISsQJM4mM+L0CeXqtgNV87Joo=
X-Google-Smtp-Source: AGHT+IHXIu6NwWci9zom6N4eiW2fjXBzE04Zf7uKZhSOplonqE3U7BYli4WivT3eszji4i8jTkWHNbXw98uTfjscsTRmBDy9YA8Z
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164a:b0:7d0:903f:e15c with SMTP id
 y10-20020a056602164a00b007d0903fe15cmr102674iow.4.1712927901087; Fri, 12 Apr
 2024 06:18:21 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001209810615e61b19@google.com>
Subject: [syzbot] Monthly btrfs report (Apr 2024)
From: syzbot <syzbot+list4a1556abd8e1efb58018@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5833    Yes   kernel BUG in close_ctree
                  https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2> 318     Yes   kernel BUG at fs/inode.c:LINE! (2)
                  https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<3> 117     Yes   WARNING in __btrfs_free_extent
                  https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
<4> 106     Yes   kernel BUG in btrfs_free_tree_block
                  https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<5> 86      Yes   WARNING in btrfs_commit_transaction (2)
                  https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<6> 8       Yes   WARNING in btrfs_finish_one_ordered
                  https://syzkaller.appspot.com/bug?extid=6e54e639e7b934d64304
<7> 7       Yes   kernel BUG in insert_state (2)
                  https://syzkaller.appspot.com/bug?extid=d21c74a99c319e88007a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

