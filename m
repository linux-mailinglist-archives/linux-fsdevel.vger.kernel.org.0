Return-Path: <linux-fsdevel+bounces-32287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6A9A31D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 02:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE44CB219B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59547A5C;
	Fri, 18 Oct 2024 00:57:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3983BBC1
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213025; cv=none; b=MFfBZf8LV0/mYmDp/SwphVHjlDM55LGLRn3+8ro2+OX9zivjd0G58mHFjc85deKFWvRMPPuOOtH+NEg9bjUkQOXNjlHL6oM0Q1MElrNlPHCmER98sCksdz8qjFZDuK9UDkVbYwt0NIpYXt4QrgOUNS0pOSYRjYw/sKkWJGNq9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213025; c=relaxed/simple;
	bh=gCfZCa3eCO/ImdtfrgayImJe3Jk4aFQ+KvM1j0hJ13Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5E75jiXpoZ1Ic+Ymn0SA2EJUA+QBJBlKBK7ifTAKSJTtIGDC6UkWWAYLcWPEO1Ir3TfAAnkQ6R1ulz2HaxQdbHcVoGjop7ArNn9962JFGIedRLtqW6OIdFmHjEEbihHuAL3TNT1tHdCHhKxVxghcCvGLlBCGDmfL3aw/aDMVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae775193so18130055ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 17:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213023; x=1729817823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqeLqdi4VZTQWUI7otEtoyavMb4hyb3TjNvZ1DOSFB4=;
        b=hnDFZ2h9N1CFfUDJgwB07gN3KUWxxklPck3zH+27ftvfwT9LElfmKMA3KeE4BWcVYQ
         Y/aR1esCBDP/1ED3DDdG5OtQU8B1GO5EsX5XfG7tsOyJgZHkz96q1zDtIXzTVoHmyXGI
         kaUsZ+hhvNSPlKEo+Vq6Oa/U68rKIHxooIka1cUXl+SJfbiD7/57y3anb1t3bpHDsKa0
         o9e1xc5vJCmkt/JA4get5IK7i7XPlYGEDYdgaVaRhTFwVd/wuJkH0uWMMtgZO2AQmy9R
         aAnfyRa36RK3/33+z0RXUEKpjg/Fg2FoBxzdqblkvBsPRGL2ckHQ1D5qrYVpUFzpqr8j
         UBrw==
X-Forwarded-Encrypted: i=1; AJvYcCXca8Vb39x4z5wFwdaWBIz8AAzRYJG0Ref2gN1XXJQNksd/B4e4tPuaCX2OC8Yu4jMcNDn0JLuzD3FKIW/s@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwuf9IJVVE9iNMk4PrRrcoVoCF3etHmWH6vmHcGccODvYxSjb
	/Nt4UK3nlouDJDlcY6MEzAZyxTOGe/xdtksxSzN/xzFhzkkKHJFNQUdAxayBw8YYv7ypgBg7XZg
	t1Sf0FGDsEpbNknUL3GPzubW4TdbNUPnrV8DCEgALcNQGOfx2gIAZGr4=
X-Google-Smtp-Source: AGHT+IF2l/I5CwjB4QRbjF8KLulqSx+JqIfNHnjpBOSO5ETpL1Yv+UJRRdeB0PbR1ueuLAyjYo8Gc0436YSDNNO0EuMsJR0ZOblI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3f40b531fmr6352115ab.21.1729213023103; Thu, 17 Oct 2024
 17:57:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:57:03 -0700
In-Reply-To: <ZxGkuaVUl8KRPAxO@Boquns-Mac-mini.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711b25f.050a0220.1e4b4d.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From: syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com
Tested-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

Tested on:

commit:         117ea4db locking/pvqspinlock: Convert fields of 'enum ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep-for-tip
console output: https://syzkaller.appspot.com/x/log.txt?x=14229830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de68ea2a11cb537b
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

