Return-Path: <linux-fsdevel+bounces-38426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B8A0248A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCAB164A37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80091DC9A3;
	Mon,  6 Jan 2025 11:49:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA31A76C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736164145; cv=none; b=Qf8RjdSPAohUE1SuCxOc0blEp5cE1mnZf+gJqz4EHnHES7Hor+MJjZ6re4ZXnKRMfRG2+/oPInzfzozVLsWoMNRgRzV+7d/5LhoG+3ZJ1zWSxCjAMzHmvkLAaECGqmnzXKpTQ2knCxrGsQ0Pt58mgWzAeEYbwrmID1KwYzIvLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736164145; c=relaxed/simple;
	bh=FzkEN3po3MF5kXxLK9tfx35wrpsTEZGzg1w8lpdIZSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eivde7moZjtmwLB0PHVPaVss3+IPbS8Om7Mqz0HbpFpr7WBiNjYyCPaqootL03mFyEnJrTBquktz6NX3HC+XwtKrdrYEnuWGupvFB5pd4OfDVJxdTq9dD6hU0NfE7GmiA+YGLi1NCpkJasnGslVJJ4SnsdGOsM21SA8pE6enOVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ab68717b73so139405025ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 03:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736164143; x=1736768943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P4yUyExVDMlqyEBo1OdBOBUW91y7nuRSUnX3E8iDEw=;
        b=nxAmZ/9STKpJ1T/0QAMTaOe1nWPS61rvzqF+0Wb525XID60YX5lUM4WSPqrR6gTzcB
         vL80wF9ztfWb68DLeVKNv48KZO99Mh29X7W+3lF3pUJtAchHA8qb5e2xlqmhAFScsAf1
         a1dQg9i+yTFejw1TMR6piGa/ep2Ur7EyKukmbJ059Z8mbCMRi5nXb9oLENNsbBwya9yx
         ju3622KTdROMgMn5WLxrc6N/WQFIHlhLdI1i1NuPYloVzaXP4r/R5LuXAwnKRgpsvD0Q
         KHeKlJk9penHPU6VdUno9Ygd8LJtElhN5QyuFEliE5xFYlFRhNt35+4pXI/Ab2qo5GMb
         iZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwVwwjd7I2smoizKIo0/fE/ozzS1PsHxd7FSrvhh8337T6kd8MR19Q8rJSSGzTP+tLvHruPGk7I0YKjkQ/@vger.kernel.org
X-Gm-Message-State: AOJu0YxmK+kiLFgaGd8/DoF7aS7TAZEsoOQMpRaQLAn316yczikd/coG
	iv5UlaZswEeDPlVoiGX1QE/HxPJVzfHPdUxyC/H+fugXZ0ekta0+F7n6zHQqE7fG07yWi3eprc6
	jco+VYoE2ScQTHgx3eWkaMWf58QwdBWTgjRRKdUSTNNVjZj/LodVHpxs=
X-Google-Smtp-Source: AGHT+IFCnn5Ib/0LAJngy5tc/taCRAjqly5qH8isgx8HgN0UrV2GfMnnrRFhv9Hxq2au4a35NECkC5AqHWll84PSwoD6/HEeQ3Iv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a8:1195:f1f9 with SMTP id
 e9e14a558f8ab-3c2d2564124mr561384215ab.6.1736164143046; Mon, 06 Jan 2025
 03:49:03 -0800 (PST)
Date: Mon, 06 Jan 2025 03:49:03 -0800
In-Reply-To: <dlkmio7icps3j2l7iz5g7d2patw2ivssiaus7jzucbrqd4jaq5@w3rekecxeeka>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677bc32f.050a0220.3b3668.000a.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
From: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, repnop@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com
Tested-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com

Tested on:

commit:         94dfee45 Merge fix for access beyond end of bitmap in ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_next
console output: https://syzkaller.appspot.com/x/log.txt?x=13473418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16a6f811a8c2a826
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

