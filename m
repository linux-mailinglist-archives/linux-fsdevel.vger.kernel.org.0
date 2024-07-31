Return-Path: <linux-fsdevel+bounces-24681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE6942D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4141F248AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBDE1AED27;
	Wed, 31 Jul 2024 11:57:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B441AE869
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427025; cv=none; b=pl8jgDyT3EEshiCteumODUDURvoW4HqmD6NnN/JTLJ7PKFAV54ecNfsu41Y8Ie3xUQdQAg4/AOzYVX6o8e5GjBf2jJxkQLswn2mJqVMwXRKYscJa2Ij0NLl97KGUp9DiczYQNqEZ5a/DcalsYIUeOhRS/VUcDslJtbLDXeOdS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427025; c=relaxed/simple;
	bh=hQUoUT6P370vSdku525I9ZyIqVpjyDqZTAwNNZoSxuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=abygAunUy/MzjcISS/UL9bh8hcxCgK+ir4udD7XBaHEOO9VeWtRbsXUg9t0AR+M03KTVpBYvn998rymzOpRgRZhoN1TcfUSLuqBlFhwIheoIly8j2NrBEe9fA3xesMvMQH9XHoUCB8Cn6xKaQJtj6oX8D21DTpoAZp3QSj6MgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-804888d4610so114400839f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427022; x=1723031822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSrgeN+yuzirQre8G4sG5Sw6kVPo4mH3hIOR53sJbwQ=;
        b=A40EJfZkRdBLHAe4srq+xq8ABQCnkaoHN9o5HA64v97SpDN0NX2G23e32pByQaRIt1
         KaGX0kW1YSkYOzngRX/0Ch/7QFGZezy/9tAIoIc57OG3zvblXODpUNjrKIeJNgYRO6TV
         OGivIWNjvGRlKI6cxwRzI9NiOH5h3kTYLppZ7TAs1sSTRLKkcm45dwvPRKG05ODkNYHW
         kbuCfLs5ZxufcM0RBrOQ73Vmg5rF2bXdeeJkH2YB9RNesKo4SVuHuPLJ4teFp1YOauPf
         LkHd0sKGwbUIgR4eumW1cPwaEnnwqmyGI1/dRe+o0erqInyIlC6VonTXIumsY4CRnRBX
         5FCA==
X-Forwarded-Encrypted: i=1; AJvYcCV771cS065L8+wQoxvJB/gwGuFbuZ8fNcbD0iSh9C+sAtb47NnRZn7QYnSGyAvHP2pIH8a6zNygWp5lPO+kdK84aMteDkttBb/8nSfYpg==
X-Gm-Message-State: AOJu0Yyx312cjMs1EHi/tQiLhKh7rXk2/zH7VduXX+9Tv33S+YJx276N
	5kC/Z917kE4Fs/5wfWM8fHZJIVbRC349zpQ5drT7F6WY/sHhgcksz89day8eVwxYgoenKZQY0xz
	GeOmhy909jKkugF+u6odV+FGirpRGkGu4O2N9zY/28udi+hRjfVIn7BA=
X-Google-Smtp-Source: AGHT+IG6yJHm71PfnjSzpzV2tajfrhXIQF3DZ9LmFmTF0gSF9zc7EprT5Loy3CMpp2Oq1hqsKdRV7a+B3kc8FcJHdRu9wenzlL2s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39b06af47damr3064295ab.2.1722427022641; Wed, 31 Jul 2024
 04:57:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:57:02 -0700
In-Reply-To: <00000000000022a23c061604edb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d61bb8061e89caa5@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, davem@davemloft.net, 
	dvyukov@google.com, elver@google.com, glider@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jhs@mojatatu.com, 
	kasan-dev@googlegroups.com, keescook@chromium.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, luyun@kylinos.cn, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	victor@mojatatu.com, vinicius.gomes@intel.com, viro@zeniv.linux.org.uk, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 22f00812862564b314784167a89f27b444f82a46
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jun 14 01:30:43 2024 +0000

    USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f906bd980000
start commit:   89be4025b0db Merge tag '6.10-rc1-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ed3fc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c1541c980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

