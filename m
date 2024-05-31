Return-Path: <linux-fsdevel+bounces-20598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8618D5872
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 03:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01042839C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 01:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38087537E9;
	Fri, 31 May 2024 01:58:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700152F6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120683; cv=none; b=IM6hQA50SunMUmRgytk5MIa8+qeTKZjlpD7/OZjorqTBVztqDcVR0Ftv6VP5QEVoHzzYhQMshP5d1GmnGRJ7PbXbIrZZ9UEoA5fBNe/AFiv+wrYKqQcTNqaYtwQgF6ndttqff1T7JKxeEM0t/EGwISlbqqgT3abbCDzynM8rnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120683; c=relaxed/simple;
	bh=oKdqIgYYeqTIjJ/EBn/tOFlsj3rG4uVjeVE3gLanJIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p71M5Vdj9gh00zagry0YULTSqoa4mGwGurzMYghdx+DHFOJD8EOzH3uVSTp4zEzXbJpEZEmMzneHLjEVcBUdweMHjp7c0kRYGBbNXqvBhb7SgHD59SikgXTYUHxOoxFAw9JX0qcX/VSmRD4QoN+mWvl0PHOd8gmG1E5SOq396pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3748cab6364so1068345ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 18:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717120681; x=1717725481;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVF5fLhrIMnfDIaeb9o1U/wk5sbSqoaeBs5jwtIDr+g=;
        b=Y5Bdbju9m2Hs80ACefGoHqmoVy0uA44bVDuq8W8QC6rqQsF+gYbwfdwbH/OQacxzE3
         +FykInBLYMDr9GoKr5TsKdFpspm4iQtE42XnYkR7tCR2P+JivtTSVGOBY5E7eMAF2G1c
         gu4aQNXZDIs0FiMwpgduIArIcCZ9pdXMkfITMVFIo4hpff0Hu7jIfNve0XxXVdJx+845
         sCBLFI1UEUFNztH+wkgp2r9kUHWtoh4smjkCA9ByefUcAo1MXV5v0oTmZsW5uWwAgkBX
         7128g6vHt3tezSGZ5EahoUpqCy/2NovQvjmj/DJa9eEj/DFk7YPv7MkzMNadFfmA/HlV
         b1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXJtkuiC7dm17j6jt2biIbGJGePB0062x6vD9uFQIiQKgOJPVhEmLuuBcSlzZEgwT55mg4ob0TI+P3+r2/uw4Xe17+ty8B/0OQoerXr7A==
X-Gm-Message-State: AOJu0YxyBTOAeC0WhPddZrBSIeOWiYUcrFtWMtETss/WWtEKMP1rV3W7
	ROWFVWOIvkASLk4GK/4DwwsshTbG6TDsY0P629V4q3KegTKlRzuZb082bH/9aNicVfXP9rmstqN
	KQsHzVHjdRx2TY8C+yC/eySo7oGcYqtbbHmTkSQ3HRokDN9YlO+QhxBE=
X-Google-Smtp-Source: AGHT+IGrEt4nUHDcF3e9MOXXksrBLXmItYeZQKlTA/4sBECgJXxoMv/I84e0RWwwD6fDhWGo1aIlMPvg8kADYAiMA0xzhn5JIBFm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:374:5eee:dc2f with SMTP id
 e9e14a558f8ab-3748b8f23b6mr480465ab.0.1717120681793; Thu, 30 May 2024
 18:58:01 -0700 (PDT)
Date: Thu, 30 May 2024 18:58:01 -0700
In-Reply-To: <cdac627f-7d25-49d6-abf5-c9f9723f0dcc@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000466c600619b650a2@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in sanity_check_extent_cache
From: syzbot <syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com

Tested on:

commit:         b022159f f2fs: fix to truncate preallocated blocks in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=10811664980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=74ebe2104433e9dc610d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

