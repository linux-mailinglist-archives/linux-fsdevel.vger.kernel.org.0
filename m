Return-Path: <linux-fsdevel+bounces-67575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B340AC43A27
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 09:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CE403474D3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40738274B29;
	Sun,  9 Nov 2025 08:24:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79518FDDB
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762676644; cv=none; b=RH7KPCcnwEZgab6uoGDkwFDwnzUGNIBXN+QcVLXzGAhc4JpllduZBB6UVZr1hKFhTawpOjeu5IAmbo1V9p9y07LWb+o4tpbk8ByHg713/TOT2WQ+3I8I4meVhfqEVtdyG+Mc1zoB3qvMX+3rQ000l12Uxc7rf4x76MkY5bt76gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762676644; c=relaxed/simple;
	bh=/wa1QJzC1lG4pLKjSXBlRzkDHnFybIm8qOXkdf+F1xo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jOg2mL186jvkTGC4Exzxhv4Ce3SffzcvFiFekzdN44uHO5o6l2cSf8rVUrHMWqUBiHAkPtDxhX/g3j6emvEMFZvwTCH26FddAHQrkzMxCVCAS6q181hUItbd8ZIUmdxmN6+1bFSL4cqD/aRWpDLBhoVVvWI+lNHlofA3YEQ0+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940d395fd10so75820439f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 00:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762676642; x=1763281442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL3FxTXejtzhr5abhLD58XcrwrPM61KGMnvXhlFjr4E=;
        b=RyKsF/HTrqwr5zFjYlz8jS3BLIkfu44f6NVd72TQP7WZ/wz72Totwz5OOaHivbJnYw
         /6J2GJWrl4JkgiNgXfndjiLHvCJepwpwlj29ZRGQomwRxCdej9bsgpel01yRt1+2ZTRw
         tf8UCrswsEgV3a6d9RpgYpfrMctjni510oxxe8ZD5j1MtN0QUXwfCOUesyb0DlX02+Gq
         7Ivw8GwuOcw+UqmgXU3i2v0lywGVUgEa0lGTPbrb9lOENiX9tUVWSaWEB3yAxiepkp5o
         I25+VybFcwNet94vdEA8XjhEegfUDsRYbckKCKJOih8rinFA+DSkin9xRs5NUtbpJlJm
         LKDg==
X-Forwarded-Encrypted: i=1; AJvYcCXo+TWCgi/eoBIlROZLDN4X9DPEIcr1rS6ghQ8B9Mueqx+0s93uXDkwtSIPX4HsvesMlR+gtXw1cM6nlsc1@vger.kernel.org
X-Gm-Message-State: AOJu0YxPHlCtVCbc361C+iICrHZFx8ep6YWASd2VGXrDc7kz3pLhckov
	p1b8dC0hbX+3QNcfCqpdfqJzqD6cLE3O63D8Hk4VwJLzcHyvSgf/2YJU8VBrIokk/MmwmLtbpYQ
	ARTQedCxE9q8FKSCI87xV6KR1pbVXO8+KQWf4rdrpG79ksiNrVIXlnACrNF0=
X-Google-Smtp-Source: AGHT+IHOqUl2FIWzqMdoU47l5Gxi7c0kUdVzP4da94Ci7TzBLeLq0JKA4Ol0t1W4WTRGmKRyGXfPx3vt9pTfOQ1/fi74ObEhuKjW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2388:b0:433:7728:b17e with SMTP id
 e9e14a558f8ab-4337728b3damr42151785ab.17.1762676642611; Sun, 09 Nov 2025
 00:24:02 -0800 (PST)
Date: Sun, 09 Nov 2025 00:24:02 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69104fa2.a70a0220.22f260.00a5.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: Liam.Howlett@Oracle.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, bpf@vger.kernel.org, brauner@kernel.org, 
	bsegall@google.com, david@redhat.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jsavitz@redhat.com, juri.lelli@redhat.com, kartikey406@gmail.com, 
	kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mgorman@suse.de, mhocko@suse.com, 
	mingo@redhat.com, mjguzik@gmail.com, oleg@redhat.com, paul@paul-moore.com, 
	peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org, sergeh@kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	vincent.guittot@linaro.org, viro@zeniv.linux.org.uk, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3a18f809184bc5a1cfad7cde5b8b026e2ff61587
Author: Christian Brauner <brauner@kernel.org>
Date:   Wed Oct 29 12:20:24 2025 +0000

    ns: add active reference count

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a350b4580000
start commit:   9c0826a5d9aa Add linux-next specific files for 20251107
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a350b4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a350b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2ebeee52bf052b8
dashboard link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1639d084580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1625aa92580000

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Fixes: 3a18f809184b ("ns: add active reference count")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

