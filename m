Return-Path: <linux-fsdevel+bounces-48006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15396AA8596
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7413E176199
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B373F1A0712;
	Sun,  4 May 2025 09:52:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE519DF4A
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 May 2025 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352326; cv=none; b=tBmdMhCyRoxepvY1cgar/N4mZayyJioaa8SARiWj+MwpcyE5XjbkoMvDLVoazM7e4WAZlNoiRax+n+S32+5/l6z6aNLmZm9GOZh+RN4cJRm5gFh/7QT0rF+O+NRLFqnTRWyFf6dqqGN0UJb/ubtD+Jli9SoGyQYhrtNKTkZOts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352326; c=relaxed/simple;
	bh=u3ZllCEErUzXM10HEe/yG0/k1hIxUJeRwUILm7bFe6g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m0BCCLSnA3cCAosxpf9Nx6Dm9ruQ4fPTTYoGfXT89I5v5GPHYFoT5e25LyDYffH3Kg7gtaG299Hm4JNmLvdzUrO0GDWyG97RD3ZnYDKIrSNCXijVPq2ZGBJqAFHbMdWqbYSzishTIIl0vN/CRCHK1ZT1QIGmXZ85VYsF4jEAIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d8a9b1c84eso45265675ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 May 2025 02:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352324; x=1746957124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqB0ylLnisnS82w2E9eqZPt6lMbQjhiPur1Ic1Rq3Q=;
        b=jKP8XiZGYV2uqxDFy5H+wLqUbUQJp4ibc6psaj9O+Ch01BgEHVGFGMKcolOz/OK3/M
         Fpu8x6FGehg/E/c1qRtheGwwJjup3vDT1W3MYl2SHPqmsmzCnZJnblbWCvncsEzRK0D5
         tp9YDe8k8x+jjRwpDTVNe62ZJvvMa0R+/QCQJy9cgiX6572ZHlUqLl5owJ0n5c/BXUx9
         0cILQWUerqCgukX8HzXzH9F+RNmPzTRguWjtCohUN+7HqyD5WbvhNsFu0RoDnVu/Y/TK
         qz4K7534ZpiAOXQwhdQn5BOaqKP2wMQsv8w8c361UMrKJEZglXOsZ/hqP6XjvNVZTzgw
         dTXg==
X-Forwarded-Encrypted: i=1; AJvYcCWIGQzUB2+a8RlrgSg/4qizK8ppaph4+xHrXkAjFYl0WD3z9L1PYc3mbv8tclGKB2ucWamJwByscdMQIWnJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jKgJqpABJ52LDyA/DIZE3uDA+ucRef7uHkOcdolpJQ8afZ+N
	xb7mQCOM0D4d5GqEKav5/SAFNKFUXIvlnVu4B0GSf0aTJomWpw/rwK0qF1uYZfkhi81QsnmvOhX
	bWNJprvhFLCf8MjgeiJS4e8aJE0NxA9KiBDOMhfKoU3rfk3JRI9/KSk4=
X-Google-Smtp-Source: AGHT+IEgwdAkhvFU8+ZwR1aaoOoFlKOilkqvB6dUsIJVl883e58EoTxNMDwQLKpYrPh6rhIqv3SrF33drLa9mDdl2mjxUSVH08Dv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:3d6:cbed:3305 with SMTP id
 e9e14a558f8ab-3da5b27501cmr27271795ab.10.1746352323999; Sun, 04 May 2025
 02:52:03 -0700 (PDT)
Date: Sun, 04 May 2025 02:52:03 -0700
In-Reply-To: <000000000000820e380606161640@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681738c3.050a0220.11da1b.002e.GAE@google.com>
Subject: Re: [syzbot] [hfs?] [mm?] KASAN: slab-out-of-bounds Read in generic_perform_write
From: syzbot <syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	dvyukov@google.com, eadavis@sina.com, hughd@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	tintinm2017@gmail.com, twuufnxlz@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit b432163ebd15a0fb74051949cb61456d6c55ccbd
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Jan 30 14:03:41 2025 +0000

    fs/ntfs3: Update inode->i_mapping->a_ops on compression state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=115c5b68580000
start commit:   fc033cf25e61 Linux 6.13-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7cde9482d6bb6
dashboard link: https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1654aac4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ff26df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Update inode->i_mapping->a_ops on compression state

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

