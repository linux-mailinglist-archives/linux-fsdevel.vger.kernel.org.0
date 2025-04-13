Return-Path: <linux-fsdevel+bounces-46330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E0DA87052
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 03:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D45C7A8B0E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 01:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158F2940D;
	Sun, 13 Apr 2025 01:08:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91C1862A
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Apr 2025 01:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744506488; cv=none; b=cY3cawUmiw8PRevgUTrbUtjNEeSS83rQycmZWOPQ9dQnJyurDk3qlpQ5GkO6PWT9c7eLJldxZxyPUIe3uyiZgu96cjoOPM0r04+9KLxczihLiVGFtmi+F2uGh10svqmFfEw3o0ucAyIzE7ZNnCeN0Sb9xjCFiY3Prv622lDbvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744506488; c=relaxed/simple;
	bh=nW/7oOXCkdahYMAKjxfYrdJZmavvEz4wd4QSveg9lVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uzO4zs5h5M3LnDoTopDIZHh4bY38ahXBUMe0b3aa1FHCc4Omd1pGxGEsLkZSkd8Gpdwvdm+4+7MDAV5NrKGUtTt2IiMMLvlgIoAMaisaV8qs9JwztCyBK0I/R6tOR74JE0V0G9COgFhJx9kNtBsXEMdwhakbu2t/cpAUpTSapO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85dcaf42b61so699129139f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 18:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744506486; x=1745111286;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dk7Gzu8+LwjcWpBxuLapWkABnm0wRCyVK7vl3Dvxi4=;
        b=SkTkBHQ4KnN+NZovIzBGB0NI5Q5mhbLCGRB6yH63IUL0Vy5Az+lXAxk2oln/j4ikEG
         QUX+bbAxUEsOg7brah/aQlNFYJgOL/hN2yT1lFi6ZGgiTDWBI/lUtDDGIJ9gLPhOfVIl
         HNmDg3snu5lGijT0aOPTRAnGcE/S5B57xVSl0rtWcjP/ZUFs3L/TCEcahpqRil3wffMY
         beXW8Kf4S1xxZrQNe/LNoZ75+8GcwFOQVhM2ypsIp7LB47BWdDLG7FHAaWyV0Fz/5zYe
         Xn9K05FGklyklf9boqXsBnuMd5fXEat5KdxG3MJuMch5APGxtSeUceobLlRUwmLK2xhz
         zdww==
X-Forwarded-Encrypted: i=1; AJvYcCUlLZ1aso6vnKpMlaoWl0aw2IkSG/LYpcpMDMXVoH86tTFuOYf0ofJun7nZis6ST4n5CYYw+QPdpm5Wq75o@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUphxN4SZlkFVOL91oNgJCgDpgES5ewf7jlZ7/zV72tQw6p4+
	OGmn9KKwkSf56uBXNLqt1rBNy3zY+XS6fXekRoxRg3ATVmxksSadPTi9uNc9Epzrqsj6uBV2mEr
	ie3qSzSL4i5GX2ZVOx0NjVgPTTR6fGAXZ6oprU1i0JvZmP6lsEcyzZAc=
X-Google-Smtp-Source: AGHT+IFkv4xfABylcvNKDZI45sqvgHacviJhIvdkoy8b0aCrQptBuNJRamxG+NdQI0+OhYk98KQ7revj9PXcRAOglKUbouG7MIQ9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:338f:b0:3d4:3fbf:966e with SMTP id
 e9e14a558f8ab-3d7ec265c39mr79513085ab.14.1744506485793; Sat, 12 Apr 2025
 18:08:05 -0700 (PDT)
Date: Sat, 12 Apr 2025 18:08:05 -0700
In-Reply-To: <67777f13.050a0220.11076.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fb0e75.050a0220.378c5e.0007.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in __generic_file_fsync (5)
From: syzbot <syzbot+d11add3a08fc150ce457@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sandeen@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 00dac020ca2a2d82c3e4057a930794cca593ea77
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Wed Feb 5 22:30:09 2025 +0000

    sysv: convert sysv to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b380cc580000
start commit:   ab75170520d4 Merge tag 'linux-watchdog-6.13-rc6' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=d11add3a08fc150ce457
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1558f8b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16612edf980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sysv: convert sysv to use the new mount api

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

