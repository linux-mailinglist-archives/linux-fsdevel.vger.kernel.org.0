Return-Path: <linux-fsdevel+bounces-11950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD428596BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D3B21F9E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392C634E3;
	Sun, 18 Feb 2024 11:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FF6313A
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257185; cv=none; b=LJN+ek7BJHXe+gD+iI2tGzYGIQJqDQ6MbEJl+lf4NoUu5MiPqLsFi4VRT9M1JzOoyj8DgWOF2c+Nsb+RWfMG6wgyfg4ctHllYgo1XAFSWYk01JOLCxA8jQ0b1YZClF1g+EVmNt5kcoH6RIsj1dWU7hmfMsRbXp5+a/7MrOWwI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257185; c=relaxed/simple;
	bh=6+hmd+W4BV+dvIrq+c8lyx1zUvi2WhOlm4Y9/3qs7UE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSSUlIfVDZx5CAtsQJdx2+dxGvqDw2df/g3PWutxv4Wq9zjaADEOFmBWS29QkaESfpv5IJ/vIzZpzCQ88FVz4J31BeHxSYz0uM+g0Q/8/mLwzRZZ+/6qPaXSyZPQMmYDCxgtOpdq/DMvOyBACGM1SZJ3SyUGlNL2nT8rlVC1We4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36516bed7c3so6567775ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 03:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708257183; x=1708861983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWsbO4aSSs4DO+xVFIe6sZD6wCzyO5IWX6HRTcWueSM=;
        b=aCBYQKmBkTH8td47GSS+ZF8x366ysYNAQfAUBP88YoRXj6psYit7RmrAnMacKtQYbA
         zcQgEEM1pAkZjYCX3K66DhTKZPpf+OM+l7jKVs3Cfr3Rzh0lZ2Eu7meJpaiy2wdBo9Q1
         lcSpyDsU917vnQ4f56LyfkFXbFhnazxiDR6vkV0+G4sexjWDLMTdLZQZLpjRL9qy28Fn
         N+OUV4VemI+YhgQUDbcG3GliVGG6y3UBnMoepg+C+0oqfP1zMcAlfFwzltBvDNMKoUmd
         kEhIlhg7nr42/Vr57CsLwB+5I41erwHjIGumZ3oMErVanU7ldagrA9y1qOw79E3c7ZTN
         noBw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSbpn2vFKpca8POA03pkcQrDIFbZnv4x2Gjyl/fln3P3VpI7SBaTVNn83opoFkHNTi8JTBU4u2SGm1hoMxsE4X1qi3igNWfwePC1RBg==
X-Gm-Message-State: AOJu0YzJxK548VDQOD9e4WqigOzPcuyB4cdN61bPPCiAiNd79pl8SSW8
	4XJDDuAvIMgeO1B6dkxi5+kfwxKCbvv3muTi9GtE81OJRqqGt9AJe4xLPcnkNyHXFhrKwqMRFSR
	Whl+O5mVBxkQTv1HR4sQABenzcjnnfPbhy3anL0OdMSkxcmX90pAydTI=
X-Google-Smtp-Source: AGHT+IFIXT3OhUsCbMVjYYsUWl3l9wpox5NiVMHC1HP2UXvlCL7fbuxvKuCnoQpKXDGz68p2pMLDaqBASQ70HUFhk4Qbd0wtQ812
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c568:0:b0:363:8b04:6df7 with SMTP id
 b8-20020a92c568000000b003638b046df7mr783797ilj.0.1708257183250; Sun, 18 Feb
 2024 03:53:03 -0800 (PST)
Date: Sun, 18 Feb 2024 03:53:03 -0800
In-Reply-To: <0000000000004b7b3a05f0bc25f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c4480611a69ec8@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in
 __lock_acquire (5)
From: syzbot <syzbot+0bc4c0668351ce1cab8f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1301e1d0180000
start commit:   ce9ecca0238b Linux 6.6-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc4c0668351ce1cab8f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11814954680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103bc138680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

