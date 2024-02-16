Return-Path: <linux-fsdevel+bounces-11899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED90858927
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49428B22641
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B96148FE5;
	Fri, 16 Feb 2024 22:48:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5E1487C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123685; cv=none; b=psbQX+EfFrCp3mTEO0F/CWylYvm3OpZ9dWxzcsXyRiTDrH/b/2cILT4GsdmVMjizZHGDk0dospJjO+tfwfux+hTFov5SAKjoYUGZmNypH+hGwon5UzJUhalozkqdlhFmR/AL/Tw4XL9To4tH8nyPKTiCCkT0mtvJ1S7QltCQNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123685; c=relaxed/simple;
	bh=Oc8/VVHL3mJzxSm9wwcBnL/NkDYsxziPs924FwSBpcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gmlHHFemdRXd7JxMJpcR7I6QdXfkmZ4bSY4NvrZx4eIp/bArSNvQsn7czELOtFeMhQv0YQpdBYaYXbBNpPbHp0R/LwwgS2S/Xd/iMi7m86O9ow94IUOOkwGfCMR0P48UyU0gsGz6OH9YTtYfhN2i9DprZj7EHVZ0GVqhbrz1p4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36516d55c5fso3311215ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 14:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708123683; x=1708728483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgA0grvx/iurskLb7osrvJiMpOml1Vk2dU3E8tYqYNQ=;
        b=VzE4SGaEAoMeodf3heDQ0dejKcBtKm6Nmib3kXT5D+qo+POvQeRAWuT8APvi2dUv8J
         Mn45mu2HRXvRduaZ4aj0yMguxricyGyHnLrbKblCTAw2al4BN0certtJqHjPSdCPh5hk
         P1nav/WOdKTE7yqcb1kdOtuyJh2zI51crJnjaozhVJglqBMvTpQunR6aRx4DviKVm2o/
         +k3cNFAzC81tYAFk6ViYa2wAnTJAU2Ws+VocvAnfYfYSnBFuX9z3vCgViF1U0tVjdmnu
         F3s2hLReDFjNlTkl9UR2BBx4uRDO4rIz4AxdzNUIELb2mh2peOM7EvtL6KPHKzl1dwmu
         wgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSvovygPqIuCaYhKdsDe3RC5Gvoa5fxjCO+WODSTwtxUf62D+fFONwapNYH/0RRDGK8kKUk1ocW6HXvDMCIy7pqfBeFaARzAzVMHQxuw==
X-Gm-Message-State: AOJu0YwBrNMs3pzFgz7TLOxdjgg7fk7Gd4xvvvGPW574++3yW/nfLIIL
	hmpqipFBunCEHgdz1ToDkkBX1jsGUaOxZ7G6dazlQwthwGIbluqQAiuIhJX2VOPZa/9U+4ZIN1P
	iTrAl71Q4QZuY0JegyDvLfy59L449NlPAQO2a8xp8wiOsV6rNBaz5myM=
X-Google-Smtp-Source: AGHT+IG7sgyLqJEM4CdSPqmCU6u6X75Kn3VHzvRg1bqrsbQgtfcdDFL24k1piEhpu3S3maBCtZ+28CkM1eb1SnD5QQSXMiwAp8np
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:363:c25b:75e4 with SMTP id
 i30-20020a056e021d1e00b00363c25b75e4mr545125ila.5.1708123683116; Fri, 16 Feb
 2024 14:48:03 -0800 (PST)
Date: Fri, 16 Feb 2024 14:48:03 -0800
In-Reply-To: <000000000000520d3405f075a026@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d6c8106118789ea@google.com>
Subject: Re: [syzbot] [reiserfs?] divide error in do_journal_end (3)
From: syzbot <syzbot+74b838cfa47fc9554471@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org, jack@suse.cz, 
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15009b1c180000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=74b838cfa47fc9554471
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f6ca1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e6349ae80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

