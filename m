Return-Path: <linux-fsdevel+bounces-10542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC684C156
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 01:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C87B1F25496
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC41DAD5F;
	Wed,  7 Feb 2024 00:24:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85318F55
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265446; cv=none; b=CvbKvUuLEwG57U+w8k02KeSMUF/0RcB8DU7AyQ4rSjAf58ESFqs91WRqAKcLJWgEXSbbFFYnZ9OUuZ+rdHQtByxJZIht3+qlNksElBfH2Z/mn/NRzKZIBZV8Mc2yoZlAL+dbWmv+4tdAr8GSQ4z1mzx2zoj4Pt+pe06mTmZe8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265446; c=relaxed/simple;
	bh=FvGwLh3a2Cxs8K8H1nUa9MNxFNq9OpjLnn9QY7wF60c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aNNmwv5gjWe2Y9hYKq5fjb2ncT9ID6zY04Pn6Ksbui5wcm69ZbzTV1y2wxZB//HWxPBKR2xGghOxmcpLQK2893r7iZ6KBTA/+7XFWvwPJImQdt+Fk14jxP/G/T/3bYcg2BU9Om+YOQoCl/SkLRKdZfNky7m47NBGISOlr+nllpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363c88eff5aso467195ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 16:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707265444; x=1707870244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t82BCGkmVQ9OM0x5g9ohFaasHwdqLaYvJRRmgTlXJ0w=;
        b=o1PA6QIu+R/kRudFUZCk8VejTrdTcTccUHXueAo+mAedIbMnSno58779fU0WR+xylA
         nhgYf/eB2wQ400PEbTwSZYQBxpWPl0tVYhO3UnjxIogfXGUeqi2lnFmFaqK/0oWn48T1
         O1uvgMBlVo6zLpq8SnqpeTkepBFg1fySCFes4s8TeMH4vcf6T2NTUs+h91VMHGuoaVgK
         M5z1HQ/eD4chKOc2B9mQ5i9afI9LGrL4HyEvmgWOLvH/UqP0qGr5RN838oLb/qhTuhXi
         a5eIdY4TnS4d8G/WDks3aIAKcCKH5W2LOLUrFKGT8ocUmiXiGGHpf8tYePzd2SXOh5+Q
         vRGQ==
X-Gm-Message-State: AOJu0YxN9lwmKk3JDarmuz9ME6PE1WvJ/px4IodwToM3TPU5K+offaV7
	ISrOugSgHDjvmYNe4LRRKfGDDryUHcF+acHYURwhGDy5ASTuojUjBvSCtkYtoT624Wn34xVFcha
	6W4RV7s5N27L7ZIq0kVXAe5EdVR9q4AIQlC6n6LhTjZKGCUJnW9ZmbJo=
X-Google-Smtp-Source: AGHT+IGruLywxe70WptZVf6C5ihVm9XYYIv1NvmVukssSd+6s3ITylJhlf/9TmGmL8HB1YPW0wgOOD5Mz6wXVEVNOOqJiBnJIJs4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:363:ba7e:ddc0 with SMTP id
 x1-20020a056e021ca100b00363ba7eddc0mr225431ill.0.1707265444013; Tue, 06 Feb
 2024 16:24:04 -0800 (PST)
Date: Tue, 06 Feb 2024 16:24:04 -0800
In-Reply-To: <000000000000ffcb2e05fe9a445c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053ecb50610bfb6f0@google.com>
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
From: syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com, 
	david@fromorbit.com, dchinner@redhat.com, djwong@kernel.org, 
	ebiggers@kernel.org, hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, sandeen@sandeen.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1110ad7be80000
start commit:   40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

