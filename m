Return-Path: <linux-fsdevel+bounces-46739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D848A949AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB8B170679
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Apr 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71491DA63D;
	Sun, 20 Apr 2025 21:12:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562C1D5ADC
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Apr 2025 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745183525; cv=none; b=cAEqy90v2DzGKoUAYdrkZ8vgzxwY6bVDmYIBsE1VnyHGgPXPHukaU/PRYnFouCNnOgYqxWm5/3tLc9C/O7hs67l3mEHhkBIz3FX0Jthci3o3u+1kcQ8c+ZVbeaL4AIPJN03n98vJAVekGibe4ee0ZJALk7z/tTCobnRO93Qj2E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745183525; c=relaxed/simple;
	bh=Oy7p0SvJVxWWBdWFXxaoejLgcwVs0CiPvUYylgN4b/s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tiBgmlxDMgTnSrV1ofvZTQaQ+ErOi44r9E2b0cmt9hqv9HuZm01zYenebyOb9PmDzvuLb+GTP30GG1ZEZmTqdQ8HLh2HPi3+dr3bDmMWTnsqJc2gtTRFZjZhC08CtSkX4BKIgBPS5DffAXs1bPJYgE9TQxWcyBYcZzZP8txNbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d8f1c1ce45so44390555ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Apr 2025 14:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745183523; x=1745788323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Boq0bHHkT/TbtNYDBfgrkhUfQSJrgaxu+wkx0giGmz8=;
        b=Y5fmDJd5aMjPg4nbYt1XuhtQ8Wd7INztqdqheIdxAzTEOZRPoWSMl+pz1H5Lev25pF
         7C4LS6b+5lLIRiUieoeUm6zlG32tASvkQCBDrTSFJ+Kj5YMyDFsQM797Qwk+DNtnalf2
         KXaebCE+sG+rAQuFTODKau6fncdClWTvK5oQHDK1ONjkrHq1INneID7IZrKKHuPosGYS
         0t3zBBbgZ+EQRo96ZHraMfZ7rFBASxKbDlGM+znmsScw/uAWnSegGKx/0LiL3XQqgfa0
         TwZPIdHsy8/S+YJVMx7DCAe2o+m/1QkKXIj3kh0VG7twmea/GkSk0TzmAg9g2wy/5m6I
         3Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCWno0BlOgfJd3Nx+VsKGwYr2fz5nRzww+mVF+uPFiMKVDqUUvnqgqQ6gzd90F1uu6RYTKgEtr2Ck4NWGndT@vger.kernel.org
X-Gm-Message-State: AOJu0YweOsovKI3n1OXDBX854ArqKweSzxzpFcvXOy7SnN4WFw5Ef50H
	E916JKDnauDjcrh0fSzPh42ObsSjaJwRJegVjuKakA52QYMQx6bI9M/AlRHmkfbDSkVoSJvhI01
	qZbxhfsPMBhNLkHGgfizhP4PyqLk2eNmM8BWcSxV2mKRyxb7FY8K6D0M=
X-Google-Smtp-Source: AGHT+IF/Q0jeoIU2yFclqVgUPetb93xeYLEU8M2AtbZSVWEoNFaSOCCmRbLLRrtMtx5NOXf5MGHLZ0gkeRaYuH3/Hgy8JvbcvQXm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d88ed7c3e6mr100403115ab.5.1745183523234; Sun, 20 Apr 2025
 14:12:03 -0700 (PDT)
Date: Sun, 20 Apr 2025 14:12:03 -0700
In-Reply-To: <674db1c7.050a0220.ad585.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68056323.050a0220.243d89.0036.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in vfs_unlink (5)
From: syzbot <syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	kent.overstreet@linux.dev, linkinjeon@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, 
	wataru.aoyama@sony.com, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b0522303f67255926b946aa66885a0104d1b2980
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Mar 17 02:53:10 2025 +0000

    exfat: fix the infinite loop in exfat_find_last_cluster()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155b4c70580000
start commit:   bb2281fb05e5 Merge tag 'x86_microcode_for_v6.14_rc6' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cf7078580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10197da8580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: fix the infinite loop in exfat_find_last_cluster()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

