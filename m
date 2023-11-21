Return-Path: <linux-fsdevel+bounces-3321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D87F32E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA263282E6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05059143;
	Tue, 21 Nov 2023 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AF3D45
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:05 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6bd5730bef9so6811306b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 07:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582285; x=1701187085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtd40gvVZOgliZlu2JdNIeTyUfDE7Z/9wGS/OB7/wxc=;
        b=Ag5gbnS3kJuaPeclYc6u6pP0C4AJs+i+j3DX1REZ+V+otnfa8qSjBVinyn+zdXy5lt
         pTWmUE0mLwyu9SsvPKliWWUemEOhjv/eXIKIABZJQSy3KHYhGAuKdPflxd5Kjjdl4qiq
         dutTMOoSX6zmOhyKQqPOk820vkg2Yz7BubGzozUtHD8XRAjOcU/XOj9wHqcXjnzvR4C4
         NrALQO/biqOT9IleN9cV3c8ju15ZvSJR/uROAG7glAbQY0H8VILA/yXRrACt0FK1TA6P
         lsstFFV7zu+Dqiv+UUoIzH8i317BmbjeUFy4BOPRWN5wIDqAm7HNnGS77wMasg45uES4
         fWEg==
X-Gm-Message-State: AOJu0YzIev/uRZE3GjmRjfEyzOK5yIbNLp21qgE7sp0GM2uu5RnUn5JY
	MPZn2wWq6Vc68HVy62r+t1519ysPTwieUAJvChSvzNwqCchq
X-Google-Smtp-Source: AGHT+IHELjvdHTY2zj4TwvzBjmYjsWI+xOBCOLYeJxvpvDnYxDNJqankuMtl8QGZRNJdh1bCLF9cVLeOAEq8HhRNWKvvoyLJKEAC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:10c1:b0:690:bc3f:4fe2 with SMTP id
 d1-20020a056a0010c100b00690bc3f4fe2mr1005253pfu.1.1700582285241; Tue, 21 Nov
 2023 07:58:05 -0800 (PST)
Date: Tue, 21 Nov 2023 07:58:05 -0800
In-Reply-To: <000000000000b0cabf05f90bcb15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005f3f6060aabab28@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in ni_readpage_cmpr
From: syzbot <syzbot+af224b63e76b2d869bc3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 013ff63b649475f0ee134e2c8d0c8e65284ede50
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:17:02 2023 +0000

    fs/ntfs3: Add more attributes checks in mi_enum_attr()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b8bcbf680000
start commit:   1b29d271614a Merge tag 'staging-6.4-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=af224b63e76b2d869bc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1241fd03280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1476e8f3280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add more attributes checks in mi_enum_attr()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

