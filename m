Return-Path: <linux-fsdevel+bounces-24331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB57093D5FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43488B236C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8288E17BB03;
	Fri, 26 Jul 2024 15:23:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1161EB31
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007384; cv=none; b=EKRu+meX7+nvb3ml1e1FOhsrMIdNgHH+8MXVdA2og7PaynTM/a73kE/OjqPT7fpTGr2n+aec46e57c2JtHf3NHYVxlgI1juYOWTQYCNc9gtu0u5xvyftEiT2cXgCdWe8lCvZpXon0O0RlyU0fwBK2FZ1/LqmUKwi6icyt2unn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007384; c=relaxed/simple;
	bh=qlp7+7AcQXwJaqTb943IHxf/RFYYalN4M2URRp77+tE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=exqRZDSCPhJtoK60qCWItglmhZH7/ttLydyqOk5IIYlDo6Oy8IMvv7AXiCVmzjqKpqxwrRUzyXjHF2qp/AJsG7S780TAt58IgfGPU14hNiivQpK5Z6JBf7Ws9K259dnHVY6kX/oH8PGLBJf7EuvpjG1sdnqQOA11VB3mulOX6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso68206439f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 08:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007382; x=1722612182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrSzqyiMZx4ozjypR+uiSnGPSDS1DfBLU8iYnkXnm8o=;
        b=ELmC3ymkLDGrSEy7ZYnEBO+ofg5R84SXTQLphRFzjzlTl9XXP2tXqOF1j9meabKzBB
         WtfYdGi4cPxwVuBoviAIHtip5sMi5XKHj+cOo5VEHpW4gqq6uGKW836l9vq2MnqFvgri
         4r5RPvE/epgf5/jxCYL5Uwk9+2Oy5Cehaid/NuPUJim0kob3rlClrm1YegvvKFpCUjZ3
         9gsVCCkiq3elKlQ3tLjGEd0OTLLXerZJsaQvr7vP2nbrfKMVp5zaU7vSUxilkvUB3i0W
         BVqVyIWTTofN0mfKCVJfEbzkE9oYJleYw89KG0R6kB0MiHRazfsLSLqX8nWX68+IeUdV
         4i1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVc38W2LH2CiRe1csQjhpuIPYoSCT9/n+eBrzBrYE1LmK4fydbudhlIS4TZgnWr5wdFtHO9NGcuEDoMu91+7XGD3sgqQtvuWuNpalpDCQ==
X-Gm-Message-State: AOJu0YwfjttyDb8hXcAnQBIbD5OrU6TtBFSNCFx9IRk1gxhxaY3VJsEf
	3va/lJ0oQjOPeP7Rw2rJMsal9za8m3rwHU7hCcImLzpTchduhHKJVbGIUJ1uv2Z+EX75HF//XyP
	yuleIDXT13RrbswD6xzvJpOj1f9od77rFEcE5szt7GlRZc+OgMo2JpdY=
X-Google-Smtp-Source: AGHT+IEitdjrvQfgUSlHI9A5b/o7wbVGbHXJfvr5OeY9BfiBEWaDu7+L2Zu4oFY+y+iyX8y9suRRcOHcvVDTWq93/LtY+DN37WYn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4120:b0:4c0:9a3e:c24d with SMTP id
 8926c6da1cb9f-4c29b6da7acmr341864173.0.1722007382122; Fri, 26 Jul 2024
 08:23:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:23:02 -0700
In-Reply-To: <000000000000b90a8e061e21d12f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ff2dc061e281637@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, frank.li@vivo.com, jack@suse.cz, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
Author: Chao Yu <chao@kernel.org>
Date:   Sun Apr 23 15:49:15 2023 +0000

    f2fs: support errors=remount-ro|continue|panic mountoption

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119745f1980000
start commit:   1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139745f1980000
console output: https://syzkaller.appspot.com/x/log.txt?x=159745f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000

Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

