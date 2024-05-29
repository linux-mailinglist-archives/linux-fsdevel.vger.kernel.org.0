Return-Path: <linux-fsdevel+bounces-20434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA08D3761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 15:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31ABC1C23AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208C12E6D;
	Wed, 29 May 2024 13:17:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4911CBD
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716988626; cv=none; b=kr2zJ2QKf7yIFnMU/ogz57s6HVHoAquKoF4s86KmBG13852pOZ+B4ycsOqqKRXUdxN5+KJN0xey+zAXoD4mtIm8+SuguqzMC4BBfYTvHDBN0qSm7HEWO/QlMp2Cuq2NLly49cFI9O3JCdm26Ogf45B1SmH/c1VbuNU8VrxAQs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716988626; c=relaxed/simple;
	bh=mHkHq3jMKH06n9vgAf2jzhRfI22gJrW6gclhd19+eaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WA85KxhzXDEa7j6jHbc9y4Z5wQ5TRypa4eFdGDAP3iRelKkwf30FLVW2IoPeiBuX2G8NhtIbbtBavtQPkq1kd58Ue6WyovnDNM7DbNa0Zpqz8YU5luQRxuYJfTDpEAMvBIuiFSbsNwVwHQl3o0vzn48DltE1sGweZYUZFfbRevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3746d2ce7e8so15177875ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716988624; x=1717593424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfO/SB2UFfHt97a87aSQyblLMjrNQ0YH7sS6OSZhUIE=;
        b=YLyZav8viR/A9AbP+eP+GT5j5eXOoIbp6QmohloqoAomQjvyKyEwtjEqlKIJVbKabQ
         agqQcCkdUFVKOzTs28LRJopOineoH3wqp0ODAuRpMrVsXmgcEPNvW8qcTQK1UXiLhx/H
         w8JR2Elz/4QdRMiMKGOnbl/hvw3IXe5R2S/cazqzj5K7u0yrlW2BpxyUTsy01cWFm9CM
         oik0C+qO1DkS9um/qPNUAJeDppuFkbSE9nlHjGMOV2tXG7oU7EOPvRg9D40w33m2+NWo
         BTzicGXE6XkirgLhHQN+wKFDms6JNijI8tzdAvdfp7yItTid3+L3cQ67uIN2TeIhM0VF
         ex9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZH1I4O+u+18Z1kwhYe841NkCSgrOy/xbO3qQ9GUgKsd6lQhmOyGYy+sqPt+Ok47flq6X/xEVwsb9TK48zX3+HBpokNuTxJLggn0vrxQ==
X-Gm-Message-State: AOJu0YxRE7HSf8SZyZuYRPA8nOeSpJ2NInpGb9KiwzZ27QPH/9PvVV7H
	PZUeTPE8G/+1IpRta17xiKj6vxh+wqWoHJ/TiNXYP4rf/B732VCSvx73JwIedlw+GxRTbVRZrIy
	FkaS3SF3JaA90ggNBwmcaWsYE/fDZJjA8uSfVmPdbS+mQLXKpsJL9KHM=
X-Google-Smtp-Source: AGHT+IH69uuYJoSGUbkjmQu3luLjcHAK2G1MSD5e3SByJKKkardLk9TaBJEgPDSfC7inxTgZ8mfcbypAYmshT3hu8NG6Y+ek5OgY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:374:5d81:9136 with SMTP id
 e9e14a558f8ab-3745d8193d4mr4771605ab.0.1716988624612; Wed, 29 May 2024
 06:17:04 -0700 (PDT)
Date: Wed, 29 May 2024 06:17:04 -0700
In-Reply-To: <000000000000849b0606179c33b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dc0d10619979126@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bchfs_truncate
From: syzbot <syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1077cf8a980000
start commit:   b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1277cf8a980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1477cf8a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=247ac87eabcb1f8fa990
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c61a0c980000

Reported-by: syzbot+247ac87eabcb1f8fa990@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

