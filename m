Return-Path: <linux-fsdevel+bounces-7903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2982CA46
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 07:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968F6B23405
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4F18E0F;
	Sat, 13 Jan 2024 06:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52E15487
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jan 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bc3dd97ddaso646058439f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 22:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705127884; x=1705732684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/sGOHyENyQ7i0bMTzfDcnKoPl21TmOJ32DC/X68Sl4=;
        b=qVACSiPvSgLXYt6kf9b5D8mWhXcEfv8+ojsRaPhhe8GoqQCjGnhG8GjnouyzD8tcx4
         Az7ByDMdj6x/CRRBqlYtVrK2AAof4guPRoSxa5y+MTpbkwEW2faNszvmuzM8vX9sqjtr
         wybYOGA65ysR8M/FfpMlLsUMNZCJjTfKtu/vj+dqh7XAA3BkCAlB2pAc/0Ar1ArbWhG+
         NUMyOl3dx1bJIT55jdK7r13KKjEfppSOhc2/8rKjw7KiBK9H3Bek+QhPiu9gzZpkqo/M
         Tc3kiwSz1sLzfDcdNhzG4+uoMPqeh0RcRGFIMYFcNFiKeWlxGj+0MCGcTuAcQcN3+VSM
         eDfw==
X-Gm-Message-State: AOJu0YxB9Pksvt/DC2mdZC2APzk/QztGMi0r7BRQVNxCLuk3AaYF6mSS
	3iaWdW9sYE21/0Tmps+ni0RlMpJNG4QwXdGLVWmSIcPK75cK
X-Google-Smtp-Source: AGHT+IGNM+FdG1AbyUYcw6kxC9URY0S3T+KJqSYkHLA8+jx0v5cOSRLiGSC4NszsTS++2Ts56IlniAXgBLCjDqqD3qjYpWr6CSAN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130a:b0:46d:1c7:3b12 with SMTP id
 r10-20020a056638130a00b0046d01c73b12mr146543jad.5.1705127884248; Fri, 12 Jan
 2024 22:38:04 -0800 (PST)
Date: Fri, 12 Jan 2024 22:38:04 -0800
In-Reply-To: <0000000000006cb174060ec34502@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d65af9060ece0537@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in kill_f2fs_super
From: syzbot <syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com>
To: chao@kernel.org, ebiggers@google.com, ebiggers@kernel.org, 
	hdanton@sina.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 275dca4630c165edea9abe27113766bc1173f878
Author: Eric Biggers <ebiggers@google.com>
Date:   Wed Dec 27 17:14:28 2023 +0000

    f2fs: move release of block devices to after kill_block_super()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16071613e80000
start commit:   70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15071613e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11071613e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4607bc15d1c4bb90
dashboard link: https://syzkaller.appspot.com/bug?extid=8f477ac014ff5b32d81f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b660be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c1df5de80000

Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

