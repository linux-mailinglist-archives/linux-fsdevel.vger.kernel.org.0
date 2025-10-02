Return-Path: <linux-fsdevel+bounces-63287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60243BB40FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 15:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F116D734
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67532311C3F;
	Thu,  2 Oct 2025 13:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85869C8E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412107; cv=none; b=VTF0klGe52xQE+zuKeVoVbd9twhovq8HTAIAjfYLZycyze+bsIEsI4dh1/Fpq/z79WvVUMxWvZlJ7ceZgLbstAjHz7aNUlOJ1EF4A/9wa7YvTDrr9jxOEwzP9YpkY/YBpaGmR8kF0J88aZqBdz6o0+NoCpXhIh/EYvvyil3gCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412107; c=relaxed/simple;
	bh=nawsYGieFIT9F5gaofrxj9YLOzYeIyfDFWO/gGppFPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LbbFOTNqUelZbKXj63FeQXubUdeIcXYefqpFYnqDezGbS6qkIQ507Pb+RXyqW7/xpopFfst6Beqh8wTWZU/Dx3tbTWATBFbtLE75pHQRUot13dhL9oAvXIYbMBbyDYZY1un/dreRNvdzRD6cAuDv6zCC5uGwcoAXl39nPsnfNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so122457539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 06:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412103; x=1760016903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2bZMOz+oKVSx+PlpEBINf9QeMZAUdNl6Bv+63J9ZJc=;
        b=s4nuyNK7m5hwa9Fjm1/mR2fGMKdPbe+5M9bDu9iGQCIy/DUEADiroxc/yltUke1JmE
         rlNhN/KcXMQlm5B8RqN2mINIkzmvoT+tarQDbZLp+zL5Nxz640eKyPpmUTLy+Se6Cshu
         xF6/psQGJDknBV8jLhmh/wKpOmLsbAW5jxFbr5PBAKCrogjra6lYT+1MFkWV8HfDGPMb
         gMoSgs73glfzlKZ2dp2DizxLfP/uCGk6Hvpdy3UbhIUz/FgLCu2/rC7gcDnqx9qqLqxj
         UI5iGqN+28zqiKgY8Tzawrd9/EcZ8wUOtPZ7TkBmJSrHtb26PxNhxPce4iLXzluoq0Xm
         rh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzosgJQ7qIjw0exOgpRGLMn6VKYen15ubAwlUQ29qwMXHpHa3zG1uOT2hVGuDaH2cPEw4fQ6AMS11z/Sw+@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJB+EAEV4+gV+AMuX2YDqtfBDAEUpWzuTvniWliosXVhNzdTI
	Y7ECDoJ+5VeDch/NRRNEA659YOeajBPv7A012JdIQOXiTs7NTqGj6LKDM0vqoE9YrNrmueQAA76
	Plc3OgdEb8djod4J8Qiqf+bUzekKmmHpk3uAXMW55nacF/56DvjGsy/79S+Y=
X-Google-Smtp-Source: AGHT+IEQRq/93P1vlQQW6gk27vSZbUYibORnozKjfZjrhOWDxoyWlapnF/W8MSX0jIwjw9gXTkTNpSFyTUz+21o3FyrLcLLpbSex
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c8:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-42d81687a6fmr82693985ab.22.1759412103562; Thu, 02 Oct 2025
 06:35:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 06:35:03 -0700
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de7f87.a00a0220.102ee.00a5.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, brauner@kernel.org, 
	cgroups@vger.kernel.org, cminyard@mvista.com, cyphar@cyphar.com, 
	davem@davemloft.net, djwong@kernel.org, edumazet@google.com, 
	frederic@kernel.org, hannes@cmpxchg.org, hdanton@sina.com, horms@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, joel.granados@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mawupeng1@huawei.com, mkoutny@suse.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	viro@zeniv.linux.org.uk, wei.liu@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit be5f21d3985f00827e09b798f7a07ebd6dd7f54a
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Sep 17 10:28:08 2025 +0000

    ns: add ns_common_free()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124fb6e2580000
start commit:   50c19e20ed2e Merge tag 'nolibc-20250928-for-6.18-1' of git..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=114fb6e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=164fb6e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f1ac8502efee0ee
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15842092580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132946e2580000

Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Fixes: be5f21d3985f ("ns: add ns_common_free()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

