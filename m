Return-Path: <linux-fsdevel+bounces-63330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64529BB5A9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 02:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18DED343842
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 00:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470073AC15;
	Fri,  3 Oct 2025 00:18:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB02AE8E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450689; cv=none; b=dHXmwikZ4OZx8gY9STne3FQDNSe8/RwjcyOdpjqjhcI2ynO3bs+JqBbAWaoWKIdhs1mwfWgPtfw86JZ6mHBhJCPNV654bwklqi/RVot7KhXpKuLrNtUGeZcCAScDbzXkjxl/EejeWRFWwpza85l9wQJ4xebyWy8tCjLuFVA5T4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450689; c=relaxed/simple;
	bh=2cbF7kt/xV2a6bi1CmKNjeapIMJABjccozJwKy2CFH0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqDH0O39WZxi+YqP4NQHqhdSQ2dr+AazfnX5q54vJo3hCOUIV3vkelZZepXR6U8zZJ0cm78XP9bxagMZQzY4eHFkYmy1pfVsQ4GaiIWNM1Rr/jDdjyNOnbKz31l8EkQuMHVHNL4NTBTws1glyRJFWXZBxIpvP2gacJPITBDS5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42721b7023eso18882935ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 17:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450684; x=1760055484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6I/tsMURAhmMAcvWuQOFYWCU5p9EUObCHssy986mSE=;
        b=EOlq71FfNZtxRK9D7Jk0GQfv636kK+Y3J7CU48qgQK6Yn0t9eHE/tLHQnArajvuWPQ
         kHm5hdHMBLZDDxgHr1wCTMPxIF9R4vbvGspy2DHKxPf2lXXIso59aJjm53oJnqPpSLm9
         Pp4RQMzUBRrRg8aNeIuzeok9TAyxhmgbjgOmdxu1H2VY0ATv8OiHRkSUa5DEb4LD0x8s
         I4d8MLazGdrD5jNr54XVSHvBCAsI8qba0vHsvhbiF3EHFX2cNzw/xboHoWp5VkGDmLqU
         szzejVwznwrSsZ/HH7RxVraGYODAAJ2XBd4KUaewSpA/rbWd7B3zsXXhopYz9T7CGgV6
         uUQw==
X-Forwarded-Encrypted: i=1; AJvYcCXjqQZOUqcm5+Jo+3vLMl9LaEQhXkSA8mODtXQkkqGGQEdzbmUWpNeKXYBNjrpPVESL1VdWD7JhuMBf8S6o@vger.kernel.org
X-Gm-Message-State: AOJu0YxPl26WdKb+85fJagd5YecYxKQ5NVOr//zGVTPZ0sVhksxvJYIe
	LxRog6SWc8DXMyxfUqXdo4KTANWsO2MQ1WpW3XKH8wzHHN6JlYYJrh5oWbFQAxbLn7i0oG396K9
	KiyUzOd/O5rqTV6PiIWxKv9HDp44rLU55JVisyggbJafFJVMuLwM2xIC3xDs=
X-Google-Smtp-Source: AGHT+IH3sa8X+CWAZcaHp0HgbhrZEuHb0j0EjNdc2qqKGrOLF424eCAj+H6p1bBfwpr9n9Afgi+lJ+tANfnQpdMgTKJHfau/tmII
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:425:7526:7f56 with SMTP id
 e9e14a558f8ab-42e7aced705mr16035795ab.5.1759450683955; Thu, 02 Oct 2025
 17:18:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:18:03 -0700
In-Reply-To: <aN8RBYdn6lxRz6Wl@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df163b.050a0220.2c17c1.000a.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, damien.lemoal@opensource.wdc.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         e5f0a698 Linux 6.17
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17
console output: https://syzkaller.appspot.com/x/log.txt?x=160acee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11089334580000

Note: testing is done by a robot and is best-effort only.

