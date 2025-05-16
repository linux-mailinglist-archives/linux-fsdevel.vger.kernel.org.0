Return-Path: <linux-fsdevel+bounces-49309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C82BABA61D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 00:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108B74E7472
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AED28003B;
	Fri, 16 May 2025 22:58:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2023099C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747436284; cv=none; b=U6j3cS6O3r+mZuTHPV3fLNXNjFyY35Ecvz9o/AuVTCnxTlUBBkb+R9FVi8EtEaSsz8cveVy5RDpz7OkGjEFKQ8FLnUbMnvjYKhCJ09r1xD/IunnijfFjSPuvkWEwhJTE+9r8yyWELRU2COfgJndYG/b2VqYGMM/zIDnktqLxn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747436284; c=relaxed/simple;
	bh=crlD6hcYkgqUk2VnsMTk6TwuNBRLpWcxydDqwkXANwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=USo/FXlDhidTBYCnJMeuwlWbgYeQpCjzRhuLG3jnwC5baZOteQgRO84xTh89R3/z9fg+7rvO0lGTlQK77ywvx1Ee5f+UJvBJKkYIaQ9pzKCtQ7U/NuBfwWjAmwFeN0MVFHg+JGeCfHFvPT28N8Rf3TGRYCKfu6yXTg3D8huAtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da6fe2a552so43180455ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 15:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747436282; x=1748041082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkCZy4oAbX25iBvlsArzBe31f3vDYggxaZVFFGZRboo=;
        b=qhbz2sbuRTYDXeir+M+NRR/cXXbGRjOcm9PTW62plTolQFXH28TfE5GO8NLzFtYaa/
         CBbNngOGLWFPynhQ2ag6q7smYhdrgFmK5hHTX2KX7Un2wjyODQ1HbfSek6wbXwTWGbzf
         GmWjz5BXYEmBY9L8cXPRa89iNChKBl3DmebYOgdpUEhFYdWC7iv1nGXvIzbCsy/lzWt+
         p6xZFFDJnKsuWjQFAL4MPsglhFr6i4/bLZnbNW3ErS6q/KfKnjH9SiKcpAKBs5HcX7jI
         oOJrRaib+2DJD44iz65k1qfYq1FHkfByaTxLpY4HXIrE4WnCHvS3/2paOEl1Dq1dN/UU
         kZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVPQNRFCOvcJrQwWeiToxvvsAdU5jtiGQWusPPixpG6D0xP2fTfu2IZDHqT/r6pck9xJNkJ7x9fC0xrkcQd@vger.kernel.org
X-Gm-Message-State: AOJu0YywtRaU42LMCQ2W4JV60Gr0o0sUJoOz3HNJRFWYmOey1HWvP8ya
	WDGCiKEsBwAGp29v7XtPZGYq3ytbl0ul+sponSezkjdzOJ+AYJDVoDDGyIq75l22r6FLDMENPwq
	6yX5MEv3BmpGG3UgTskpbnp4XMTfhdnDwoEzNs23Ogv9ZZZV2U0RXNeiEteY=
X-Google-Smtp-Source: AGHT+IGV5LT0uR5Nz7086K5O0wYaH1Zid4vNGxPgFcsJzGd4vSmYuvN7DSZEaJBn3/LkPva3IQ+yfOoGMSc7h1yuY3/yKzxpCgmy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f87:b0:3d1:a75e:65f6 with SMTP id
 e9e14a558f8ab-3db84324635mr82117385ab.18.1747436282520; Fri, 16 May 2025
 15:58:02 -0700 (PDT)
Date: Fri, 16 May 2025 15:58:02 -0700
In-Reply-To: <2705414.1747435079@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6827c2fa.a70a0220.38f255.000a.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-out-of-bounds Read in iov_iter_revert
From: syzbot <syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com
Tested-by: syzbot+25b83a6f2c702075fcbc@syzkaller.appspotmail.com

Tested on:

commit:         82f2b0b9 Linux 6.15-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.15-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=11960ef4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=753a0ce88f56915c
dashboard link: https://syzkaller.appspot.com/bug?extid=25b83a6f2c702075fcbc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174022d4580000

Note: testing is done by a robot and is best-effort only.

