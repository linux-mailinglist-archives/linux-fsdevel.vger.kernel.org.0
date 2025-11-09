Return-Path: <linux-fsdevel+bounces-67589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E74C43FB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 15:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F94E65AD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C102FC013;
	Sun,  9 Nov 2025 14:11:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA2FB0AE
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697464; cv=none; b=pUhM9XKe2Z1IWatTBFhypDE2EVEoMZzeggnYRAJvD+kxoBTHH7Qs3/3bXBFQZYY3mfa56b74fRB0Nv3PdLQzSvLCBRea2+h8i71i9x+0Ok+A0dT8GBI4e7MxgbzwsLN+ts6CccJS+ZxnBCw8J/8WQJ6r7gkydsS7m320mRs5Kps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697464; c=relaxed/simple;
	bh=y6Dy/w1K3XpX2uFUEe+rBJFRb32lSDcExJhalbXQ5aU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rKW72P7BUeF5iSvHfbFumOOALrmlY97VyhoM7XHQAy8vYq2VhXBQPv/tHRwdfW3wnHu+PKWd636pb5r7F93CpFy4cRRBSNADXcT/ywOGf6V33iURbM0rnsV2BdvjYHDl2dQAQZfaIrpVlZVb4P0NnvCTX5OBMdZzTuxojKGBfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9487904aeccso135320539f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 06:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697462; x=1763302262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m02kWE5lhyrzZgApWthbB6kQBtAUB+gmZPn3Dt1ZsD4=;
        b=V+EUXZ/thYAZVD4Fl1uhVINnoLDf9mE5AA7uSAtruSWFDn0gLHPjYSlAfJeMUvyrEj
         LeJdTLo8TZoXc4ofCykv6u2CFCFk2x4yaASGT68pXbLxt7Ymv8qXFSl9rmdjyzsvENe+
         3WgzNXX5yd36CMFOqmqQ/4onJSTkPXJF5gT1Vr7v0cO32UrhzksVV5oW/4mNxlzZuOqf
         pdp33PntYbFWg/uelewk+cjjRIkO/VBLxFwlt73x6MU6aCcZcp7BVuT/M3p0hbgQMX3o
         438tbU4Dk/2bCZPWG6EfD9YsklyjDmFAdvWyZCrWMtYqMLBgqW40mkqANqxjDJR87ZiF
         bSEA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Nku2B+vMH5vnlO5JlFgw8Ks74/IbED/sWTHD+6742zUIGz2zvlm3jKb8FAINvXL/Isa5/maIqelPLpcx@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJT5n8zcCkOYGjOePrQE/ZvwUcjm5C1o7jtE1e4f3MLmd/L/s
	qgZHx+xTBmwMgQu2YpIJKRbAFQ8fe62el7dV8tQboNX2earCy7mKW0GR1dtv8nZWf7xWxjBALTm
	vvPh1/uXfAgafEnXru88vIornDHC01WzyMFk8HJopSwoLflB+1OLspr7Moqw=
X-Google-Smtp-Source: AGHT+IEw+SyBMcsmvsru2ydmWiAer57ckBKlQAwl2f1WWyRnepHiN7uVkkXdan4vghsxm/ZOPYzm213l8SerzWDt7Il3Poc2ozLJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4417:20b0:433:7d0b:b377 with SMTP id
 e9e14a558f8ab-4337d0bb530mr14752975ab.15.1762697462239; Sun, 09 Nov 2025
 06:11:02 -0800 (PST)
Date: Sun, 09 Nov 2025 06:11:02 -0800
In-Reply-To: <20251109-lesung-erkaufen-476f6fb00b1b@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6910a0f6.a70a0220.22f260.00b8.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, anna-maria@linutronix.de, bpf@vger.kernel.org, 
	brauner@kernel.org, bsegall@google.com, cgroups@vger.kernel.org, 
	david@redhat.com, dietmar.eggemann@arm.com, frederic@kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, jsavitz@redhat.com, juri.lelli@redhat.com, 
	kees@kernel.org, liam.howlett@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, mjguzik@gmail.com, 
	mkoutny@suse.com, oleg@redhat.com, paul@paul-moore.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	vbabka@suse.cz, vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, 
	vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
Tested-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com

Tested on:

commit:         241462cd ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1517c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b1a45727d1f117
dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

