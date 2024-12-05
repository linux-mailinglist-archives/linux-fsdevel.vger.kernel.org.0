Return-Path: <linux-fsdevel+bounces-36571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CF19E5F7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0D0281C67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA3B1BD012;
	Thu,  5 Dec 2024 20:34:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496F1B4132
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430845; cv=none; b=GpdQVFm3HiU+xjzipIwohJ67Ca3IoS4MNVcAFSnZrDVJaZgZn6Qv0x1QJRZQZtL0FOCa5w65l9HTx2WUlSEA6lXWr72nng/CsBttcwtPDeaW0bavXZN1+3Qd7BOkA5lA0BjQjIeFV8HzKCu2lpLS4ZP2dYZ8u+6Pchx41XfVpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430845; c=relaxed/simple;
	bh=wPZ6h1zzkZIYT0COhyDx8uGGQnXmxoEjeu+H34L5ssY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LLDt18pd3TAzZHG4KSK5mKRwObL1YORjkjvPJIJls93n9+j/2c5OO3XnseE1wJFA5EC/40lBFyekfRThFdmE7hNUqjiD5QuEo1XCoOGYVcslDnkRSV1Gcxs9WqLWFBs9mD6wCANbGh8oeEoJ7wm0HbfFNifmQYs60HYFZgw2YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7d87dfd9bso16847375ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 12:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733430843; x=1734035643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MluN6+HqbQdo3ZFrbzEMTv0gA+HotOipTOtjXn1gAx0=;
        b=Soiy82zb8UsoNs8LzDfAMoLAehOgupXlTGm4cuUOur9T9sUizzvHeKnfhvS36kaEjC
         5B8GnZV0A4n0GLH0YYT2d0TSvEgE/1HcFApRSW1H/4HqTGm9j99+/uO9qulhvgFgNA1D
         xGrbDRfdD/3E2BF+qMKDhZkag/N1Hf1iI6X2eSefwODFVlSLZd+P6iKk9d6imiUk081d
         Bc9g+3wCkQ69GxYbBkzfj5gdV6GbXwB/Aq3xdrIsfRR44ra7ovYCofX4JyfDHrFZD32m
         DWo30rod5KmhTYEBS5zJL9xX+H1Z40jysnN+YkVlCJnsEG6SzVIJTx5PkO5CfKgdjYIQ
         zmxg==
X-Forwarded-Encrypted: i=1; AJvYcCUHq1ttDytrQTaoSw+1BG/LmxJyTeijA6mv6lDl3BZcR0Iyl9e03XsyBCDdOjb5NmIvpLFImRj8XZCCRtsR@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7qvQQfEJJf+u9WcGELiNF5EmQW25rmnF3RtxbHccb/zgAyJN
	I6OUVRmmEmQIMt3xpZJiXUtqcGBhlCrszzArCTmr6D8GMvKYVZUGMlR+GJjFBm9WvOQNzdx8vNc
	aqrhhEq5hNojM6kCNwtw16F/SV+3t2VE3MV8agXu0L15TayNq+xC0fcQ=
X-Google-Smtp-Source: AGHT+IH/TYc3uoyEtAeNUTNgFFu9sxhUR8Vtq6aOSXipwFIsPMiILBXStDoohsQLd+uY3SGbIhfqqLOvb4et53ZqibPhmvZ27xA0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a811d7812cmr9580205ab.9.1733430843089; Thu, 05 Dec 2024
 12:34:03 -0800 (PST)
Date: Thu, 05 Dec 2024 12:34:03 -0800
In-Reply-To: <67372c5c.050a0220.1324f8.00aa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67520e3b.050a0220.b4160.01e6.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: use-after-free Read in bch2_check_dirents
From: syzbot <syzbot+fea0322882c0cba65f11@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d97de0d017cde0d442c3d144b4f969f43064cc0f
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Aug 13 01:31:25 2024 +0000

    bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a09330580000
start commit:   cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a09330580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a09330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=fea0322882c0cba65f11
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b1130580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1256ab5f980000

Reported-by: syzbot+fea0322882c0cba65f11@syzkaller.appspotmail.com
Fixes: d97de0d017cd ("bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

