Return-Path: <linux-fsdevel+bounces-18834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242E8BCED0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AC81C210E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B378C68;
	Mon,  6 May 2024 13:18:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B20763F8
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001515; cv=none; b=t1IyEW2JQ1bLg9MYCl1/EDe6Fc/2T2M8fAc65cl0R5ilW3GGdGtFpO/+y0//nN/JPaKcNrYzXd79KVcxMmhKL+gL1Sbz2Cht3DZWDrnME23vMSCeasgTAwQvLQiSr3O+6JM+qIk3nZs//SJ28fdfGgSIUc8h4CaYqXW0zVjOcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001515; c=relaxed/simple;
	bh=xMKAHgLWffPEg/68jPEYeY/o4qLcUtR75HNtHwrSP5s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U59h+S9HhBwZYRVCT3Xn9E8QkoLMSaLnTJ3wkEUDARegQNo+ckMvML+2uB3IMmTyRrdxBfC/ZmJGLBrlZu5LqFM1aSrUtxGH2VYsVtT47knVkPTYMNBUh6wUyNLUHi5p4+1D17YLoR+P4OeWi6it33AS3ySUAbBMo0WjGbmWddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ded1e919d2so140393639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001513; x=1715606313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TxmHB0vl67W1+zyEJ27WmnVys+63ysAGw/jZhHVYa4=;
        b=YG6pgoBuwqb0idjB2eJw1DWceT+9CzPzpqv43Dsy1goeC/LMZBe+CBbFEY1JTV8ko5
         dFtkji9LthVgYwZ6ZI9azwx6OeWvWQUWPttbsGDzA2Y+PBqmxoKJ771Z+E81Fbsg8Eho
         aNNER+V3HbIdz2qX/doBd3QrUv9SQNAoPbGER4deKpSSln3NqcI7DEM6F/FWH0Mcwr1J
         MjC2lmcRzdGykSZV+pYEWl9WDpJZn9+Mggt75KmKvca5Av/cQE/NGbzo8pkS1xPzfhO1
         EDSHY220r7swhtJCbgKVcHflnLSBeQEtHppdjleuJeQ+OK6pEkH/R2XCLST3PRAxsDWn
         tfkw==
X-Forwarded-Encrypted: i=1; AJvYcCUWfe4oS+UyWDR2ziDFxAbcPcsYbeHo95cJW4srvjvaoigDRlrqQXD26PMRwMMh+mqAHVRcYJZoOJ/lF8RAMhcyKLGtaekZf7CLLeqG8g==
X-Gm-Message-State: AOJu0Yz6UlAwzWt4ELwjVaF4HRAzxuX5z4yONAysWD0SJEYBN86muT7F
	UKcWnhEJg/MNUnkfaFLpXsLB424KMsr0FqTAmTD//9EJZmY79hKkmYNiaKuA8SQcj/RsuGALHky
	vLcoVFjdWddTrQVjGZHu6QEoshSmVydOk3VolvLoTUGHNINOmRHzWr/0=
X-Google-Smtp-Source: AGHT+IHGkWCaHpJLl9dzq0QN3kR9qdOorczrF9G3kwxMgooiBGozHiWJRAmpHqOhax011rNPJQiAoVBofoiRpuhW7X96ozD4h239
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8516:b0:488:8715:313 with SMTP id
 is22-20020a056638851600b0048887150313mr249593jab.0.1715001513193; Mon, 06 May
 2024 06:18:33 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbc4600617c8e744@google.com>
Subject: [syzbot] Monthly nilfs report (May 2024)
From: syzbot <syzbot+listf1bffba7342098843795@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 3 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 127     Yes   KMSAN: uninit-value in nilfs_add_checksums_on_logs (2)
                  https://syzkaller.appspot.com/bug?extid=47a017c46edb25eff048
<2> 3       No    INFO: task hung in nilfs_segctor_thread (2)
                  https://syzkaller.appspot.com/bug?extid=c8166c541d3971bf6c87
<3> 1       No    possible deadlock in nilfs_dirty_inode (3)
                  https://syzkaller.appspot.com/bug?extid=ca73f5a22aec76875d85

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

