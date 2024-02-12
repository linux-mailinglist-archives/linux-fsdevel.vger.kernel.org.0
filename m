Return-Path: <linux-fsdevel+bounces-11168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D5851AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154E51C223B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC2C40BE0;
	Mon, 12 Feb 2024 17:10:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513D405CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757804; cv=none; b=Wb1A4DuTz2nWlJ29jR6jBgcQtklAnMF2l9+pDJ2ns91mYDS7ing/+6+a+doJ4BctpqXLerTiDzYrbdHiBkoQ/UAuSxsY7hYf4JETP/QByyPjvnR0DsVFWxe5JikKP2bbBwBZOIEzHL5Z9AY/yjyx2OpN3GDvp4/iDKl8DPwOAhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757804; c=relaxed/simple;
	bh=dhs5X453QuebkxZokUrCXDu80prHk7y1bR8rbGRUZR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j29ObNVabsMSYhwq4SYf4XfsQpWhM13YQb8tjsL9MybF1AUx0bnXVJ3N7nHa1mkYzeNRZt4mu3k6JVYHAsDCkYwwXUKYewQ4QnkD2TTc34ZMYuP0yZGUrf3iLfLEbGga2hdprtOxQeoIUna3L7eygnz1rkMQpO7Drtt7GwK+fjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c00a1374ecso271328639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757802; x=1708362602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syTmq/2+cHOps7ocoSA0QeSIKj9tzYgPgaLcLXmYLsE=;
        b=XOBQoaoV56X7acNTe1qGQmu3p0d59Lc8zcfKgmOVyxD+VDZ4m3aXKdlgAsYAHbF+ih
         zvVExk6iraMqkaGdlPag/RlYkETjYpXw1Hf20j3MDTf099+Dy4a6g61PABUT/C+CfMus
         eWPgJe6XQF+S9M/A7kxM0WzuhccMKklQXdqeRS8WlpfW9bSVELvywNQ3Vyl2m2/VzASS
         SP5MAyASkzOd/PwlIjVyUiHkg7afcYYWvq63Bhy3iUb9+6TzcUE9g7tr1x4V/55WBkDa
         fVqyvzQofZ3QoROa2XzU5hGgAT8xOttvGrrYdJd5U957ebJIB2RuVouX9uyBM2vxEL1x
         pXyw==
X-Gm-Message-State: AOJu0YwZg1CRrgE4r9ZHMOX3bgor5G4L3+F2nr9B6xpf3kuabZ98kwEK
	fLaHNW5cMZ4oNAm2ndAryNmiXPHUaGvV5C0qbtbMJpJ1wrlmvAZQvlpspWORVSQSHvcKiobjSRw
	Bk7sva/mKMihXif0fTpdw9zvLge+X6CuTQNg7DU6OIRbOYD5BdsCi1AE=
X-Google-Smtp-Source: AGHT+IFh4xAKDFcF47AC6TVZkIoj6iiFG392km/BapfaiHws2vqiNSlClhwZVgg+/uCSguLJAtaKS6ls2o03UbZ7vB36MylGOvZS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:7108:0:b0:7c4:6e52:ec1 with SMTP id
 q8-20020a6b7108000000b007c46e520ec1mr7560iog.2.1707757802567; Mon, 12 Feb
 2024 09:10:02 -0800 (PST)
Date: Mon, 12 Feb 2024 09:10:02 -0800
In-Reply-To: <0000000000006bf22a060e117a8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f3fba0611325902@google.com>
Subject: Re: [syzbot] [fs?] [trace?] BUG: unable to handle kernel paging
 request in tracefs_apply_options
From: syzbot <syzbot+f8a023e0c6beabe2371a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ad579864637af46447208254719943179b69d41a
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Tue Jan 2 20:12:49 2024 +0000

    tracefs: Check for dentry->d_inode exists in set_gid()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17659d24180000
start commit:   453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=f8a023e0c6beabe2371a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1414af31e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e52409e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tracefs: Check for dentry->d_inode exists in set_gid()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

