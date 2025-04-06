Return-Path: <linux-fsdevel+bounces-45827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95924A7D120
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 01:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDE93A6797
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Apr 2025 23:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DD221563;
	Sun,  6 Apr 2025 23:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0E2FC23
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Apr 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743980945; cv=none; b=KNLZbHAD6d+3l2dl+uSEUsFirIS3NWKoIzeFzSk8hhjmTNK/DyH9XSzdNiT1aagCPkISGGcdsWicaInfarcceWsNQYNm5zSRccb4Lg0BkzkKZpS/95xw8nADxfdfsnFLTYJ4Ps1xhB2uFWrECe6fi3VnRpP5j+AMg2gt32sJMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743980945; c=relaxed/simple;
	bh=nBx/MltWEgayUVotVSMqrSbGCkiOHklfegQP9SnZgEk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gSdIhpnul5aXDgy3YXu26u/yd1GyMmzigjuA4Ud3bxn1xK6uwBl20ZjaLLSkFyMuQM4mRGdWAqRd3tjyJBScTNFuSS4nMnHcVd0o8jDjCkskYRIY1ZlDZ9rEfB3csNpPXFoDZysP2S9lxTP4dneAJ/jTVOgMSmCl0TFAzetD+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d585d76b79so34324545ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Apr 2025 16:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743980942; x=1744585742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u0rYlPftXycLzardq4cSj1OE2iCZVoLU6ei3WvPyKI=;
        b=fGkYglPJECTtjGC/R5jJLTSy9hc7Ib0N6UjCIJVzm/pA5xxiJkXaf8rZ3/sE+qC3Bj
         I9LvWE6eJP/P43pHtfe2LkXvKnvxJg46SrBRNxKEtsubO69h3Tk69vWfcVl3OO8L8saq
         0ENJvnO5AoA0BdAk1Xb1AuEK8kdO4++1VdHiSlAv2t5FlCk0Vb1pk66/fgif5nE0IfwB
         fZprgnJ6ShMJrTVp0ywWy+lY7grgMenO7MV3vhNPLdDNBaMWb/iY4f7ziFMBZfVxrGny
         0vgWIibYS7raBAyR2Zmsokqy+/Rn11ba7S1r7MIZ+KaZSPp70dnUwAAk81CsAiZo+6Aa
         VY/A==
X-Forwarded-Encrypted: i=1; AJvYcCXB2GrO+GdIGMVq7uliudZbeL8gBSTFwW8UDJ7eHKs4qz2HdgAYzmQxx5TqZN1ITnYmaky24IbUPGeHpQnp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94I1rEh2vOjjf9K7YzTc9PjYsbrvKfi9LDLZoxfkAVwp3whhl
	vlRNEEWJfI7t0WJVgmDM3ERON/GDHohz7BsBBB7GBY2Rfx0dqCBoY+QgubUxlwfFR/h+FOpXP5d
	Z+2yxwZA47ZtejxUjp9JyznuiUHOf6o9SpsmTRIKyJMbzWPYUJTcb1C0=
X-Google-Smtp-Source: AGHT+IHjPiOtD6eAAG4bJPmJWU+QCxmzHHl5XoGkvHZoAkjEA/DriSDK+8t1FrVUZldbqmOOLwht++CJOZIuegiF+zEKCHLUSsG7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:3d3:fdb8:1799 with SMTP id
 e9e14a558f8ab-3d6ec590c21mr75697825ab.22.1743980942635; Sun, 06 Apr 2025
 16:09:02 -0700 (PDT)
Date: Sun, 06 Apr 2025 16:09:02 -0700
In-Reply-To: <67392d6d.050a0220.e1c64.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3098e.050a0220.0a13.0276.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (4)
From: syzbot <syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	eddyz87@gmail.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ad41251c290dfe3c01472c94d2439a59de23fe97
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Aug 29 17:42:28 2024 +0000

    lib/buildid: implement sleepable build_id_parse() API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1601923f980000
start commit:   a2cc6ff5ec8f Merge tag 'firewire-updates-6.15' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1501923f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1101923f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe3b5e6a2cb1cc2
dashboard link: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15743998580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10143404580000

Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

