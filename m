Return-Path: <linux-fsdevel+bounces-18718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3B8BBA5D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6294F1F21FF6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F96017996;
	Sat,  4 May 2024 09:48:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898641AACA
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 May 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714816085; cv=none; b=PCuHIadxOoqQ5KfKlG+F0g6cZalz04tKLMKChIy8aZm8FGQIAJiq94H4Bht0I1m0Sj6bQ7EYbJrudA5YjqNHvTiMkrfkSZ/GMcxo87OMG73s2Zmn4MjM3sd+8hDlK/XzKs7N0ACZaJQ3HCs1D5+209MdLp8Iw3xr5NDp4mETKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714816085; c=relaxed/simple;
	bh=mhuJM+GfCQH5IMMrJMXVP9OBz/wYR8fa+oIkbwJ0sFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJjNgJiOUUgWXm6egkD8TTSVq2OWMNafIIGYecUjqyaEJNb/isErowWtqUFM2rph1Iy6yPqK5o7KkOqAUBCbeeMm7Bf6J90uoE7DTw16QTJmEBUNl0C1oe7NVl8fK7PMOFn1YgaX8Mj7dShRdyetu06RX38e6qzWIc4CxRvI7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dda529a35cso56193739f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 02:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714816084; x=1715420884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vMfvjlUyZ95gb2Bl4Phjw9KVzOE/POZUXc/tMc9CNs=;
        b=XPjkA5DlLGCeSjUPrVpufEybtsQoVsOlHXuMZQ5s/b+GB5cZzp9pwTQmrVqn7tdSZ+
         5TVj4zp+L6pPzdenwEJ0dAQUsNu6xfLzEUg7D+/GKyDLbwwvMA3YryYUaXk3bsVuMVfW
         gvvBX9i7QzYJWe6d8jnzHnNGWil7p+kRfqWAG8mekFDUsuGld6aIUtU4Lu8pHvRxbecg
         wjsFYwWUM8LxBSGN6UYKBD6WSH7y5trOrfzWKA6/Xn5Ona4OsenfCpqMs+3mYYvgPAke
         2KaeMGMingWzyz/+9MUgcoC9GGIOGgaukYLlzjf6jb+WbdAwRRRJqKIvBcLix6JVSHp+
         XsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdd2GQV26PsR1CkAHs1tjkvMjmwGmBJJ8qlylPgfBAGqGLvmDJHsgDMGSyNKqmiZeC82lBosGWYn/Y9Yt26EP/hAg4Nwj5pxaN6anncQ==
X-Gm-Message-State: AOJu0YxepRru9Wpcgw96Jo2owMqpDnpZdMOiROBR1XsDLIcBTuJRLfCy
	YutZfpKaNx/qypJu4RrWuBVo2JNjF8BdGezrSMB09QJ1P3jWs62sdwDvcOph32VUJxo80XXbnMv
	U7oOR9J3ORj91PJpdcjdshDDbyRHpoYUj76yH9HRHoBVL5upv79/YnJ8=
X-Google-Smtp-Source: AGHT+IHQXiciJ6Z11FdD4VBp4JCah2SN9/cx2OFqZQ7b69cg3huTCXgpZXSYi/CyAHP6kwLDQ3n7Nn+vJOJX7J3D0KyvntiXiiQT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:a58a:b0:488:59cc:eb41 with SMTP id
 kd10-20020a056638a58a00b0048859cceb41mr36069jab.3.1714816083873; Sat, 04 May
 2024 02:48:03 -0700 (PDT)
Date: Sat, 04 May 2024 02:48:03 -0700
In-Reply-To: <00000000000078baec06178e6601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088e7bf06179dbbe8@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_trans_srcu_unlock
From: syzbot <syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147f3908980000
start commit:   f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167f3908980000
console output: https://syzkaller.appspot.com/x/log.txt?x=127f3908980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d42c70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ce8250980000

Reported-by: syzbot+1e515cab343dbe5aa38a@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

