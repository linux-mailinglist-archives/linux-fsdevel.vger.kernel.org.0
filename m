Return-Path: <linux-fsdevel+bounces-50261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C999AC9D57
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 01:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5911894ED6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 May 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDCC1EF08F;
	Sat, 31 May 2025 23:20:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4711A238E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748733605; cv=none; b=tj9YAJaWfwL8bFRrR6izm7m9NhaX3SGIoT33EXEydyZ2UAMY5ciliSrgnDhWKbDhQDiUiN1M9N6j5CC4CqJmIKcFDBK89G1pK0QbeCaBGpxsS3a1swdM8qcTfUIQ1EFB2kmlFjkNVgiRiGIQtReJqPk4WmKNf+SPU49/YpAhniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748733605; c=relaxed/simple;
	bh=KDGKspSNKQHNNPjKszU2Jv76s0xm+qLt2JhjIGoqvvA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rek6xPXtE0+7oz52PEH2M/BnKIaKtvnn/V2jeA4oYqFjgkLtq7S10ozM/J3byFx0BExYuc9o/DjxfPyQgepP73M/iWl+5C5S/57xQwHMCVll68wltNryqyYFW0h42shwdzqxs4TYyGTfFDOGKmmiC1qP1nNXY1ckb41U6hoNUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3dc7f233258so39028225ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 May 2025 16:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748733602; x=1749338402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZhhLbnZ0PG4eSSt9FnuW1K8TROo5OM3uq9fTUJ0/Ws=;
        b=EcrZewUxexjg75mWxy0I+mGYy3zRLFX9vLiuHAiX4wWyd4fZoxvodjzTMar0u2hPET
         LzPGeP73Q1Tk7P1/fnRG2/dQ2SlZ5GBMceOb9zzF6dJ6I/Xi+xQRvn1uNIFEnoTnLQwP
         xt4tS45/p/oJ9N7a7JnA2NudoV/K5Wpw9ZtEeFWSl6St+AdW4RzdahNa9+BMO9TZUXbA
         GWdSrAAdqZ9cDaP0siVFAwyFiE3zQvr2z8MxCM7HrPBRhRDIJJnPXiqqh6f7i2cfWmgd
         r3+sfAuT0F6ZTJOmIY3yiHXRfvJAtLf31o4XiCpE5hTXhFl60bE9nMS3xQNkT7XBmj43
         iv1w==
X-Forwarded-Encrypted: i=1; AJvYcCVHRTwi8Hauz2AHTo38DkAV0b+IJXwo4cuxHDLLNp5lJ/Yz0eNDjUHOdVJih2mvOVL+1hAKD4nDO8KI/eHS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HvWbR0XokAKlxmd/VLF1ikiN4+jK754GX3xd7Y0RK30/9emx
	5em1cOBcZHesaScqs9OrFSOJEesq81MeM/yeC65hgkqgBGNitvJdAR6OPJjCWn2c3VNC+GT/l3d
	AEy36xTYIRW0hurPjux8kU8/FyUciCsZmSxgqWjZ7joeuZVUlWrl9YYT2bRY=
X-Google-Smtp-Source: AGHT+IGCxD3oAG4WtemqwxCGWKeXMSIRReB1CBwta6mTh7ppTS3JkVTjOWgbuFnoIN0s/mgfSawICbO9dqqQBziJHDaLHyOxRUdu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2287:b0:3dc:8a53:c9c4 with SMTP id
 e9e14a558f8ab-3dda3342b6cmr26765825ab.6.1748733602686; Sat, 31 May 2025
 16:20:02 -0700 (PDT)
Date: Sat, 31 May 2025 16:20:02 -0700
In-Reply-To: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683b8ea2.a00a0220.d8eae.0020.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
From: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, chao@kernel.org, dhowells@redhat.com, hch@lst.de, 
	hdanton@sina.com, jaegeuk@kernel.org, jlayton@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 80f31d2a7e5f4efa7150c951268236c670bcb068
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu May 8 05:14:32 2025 +0000

    f2fs: return bool from __write_node_folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1129d00c580000
start commit:   0f70f5b08a47 Merge tag 'pull-automount' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1329d00c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1529d00c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22765942f2e2ebcf
dashboard link: https://syzkaller.appspot.com/bug?extid=c0dc46208750f063d0e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bfe970580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13bfe970580000

Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Fixes: 80f31d2a7e5f ("f2fs: return bool from __write_node_folio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

