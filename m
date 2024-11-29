Return-Path: <linux-fsdevel+bounces-36123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856589DBF97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 08:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 121D3B211ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 07:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511C15853A;
	Fri, 29 Nov 2024 07:00:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089C158520
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732863605; cv=none; b=DgXAnlQRriPE5Uk5GAXjfg8EXHSobVTnqXL6fgdasVH78yxscTSRqtTaA4ThUKUObYrORufzZJ9ueGi89avWdZ/itYOMFp6tJcZqkajCn7q45FS9cOgLUjnIAaj95h9jela7dYWg2Zz0XeuN4ndfjW+BkFfXenZe5yGrGBeFpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732863605; c=relaxed/simple;
	bh=OTnsXcTFOSk4pX6ATOXr/FBbB1ZGPiO0Bg7kRdMMFOk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SajYO9hBLWRrpTN/pHDXtqEDk/AVreJLBM9pRFxtYZ1EMWUdaq0zu5AqWQmce7BzS4o8tjTkFBztDKvWrGmhccEQpKK4Vi4XCa/nqJfx8/L3fiyC8Gwt8s161wWsezb1xc34+3bxH7/mgNiICUqJzEZplLxFgWOci830HSGuoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7ace5dd02so18224305ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 23:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732863603; x=1733468403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uFra0YN+yna+dFAYGRTHBlUgOuZ/rd2jDdrEmkswmo=;
        b=wNUhJVLre5dH92fYef2uYQmYdYeaFeBqjrDMPHBrP2+pKbn0gr1RJQo+B77S2hr5lS
         Fuzz74y2A+RS8ZHvppT3bVm2IPXRHwy9gVOVriaQO3Bg8alE4RVWPwj8WfPbimK2VbhG
         OCee0aAqUk1bCDGPWNYQciPXj+krpGYGKGI+LNKcIvzS6pfq+varc5iZroL6VgHJJr3R
         eB01Jo5CS777EfZcR9vNHL3JumkZWmcfAvwcZNVfifeD8uxZFrhTSvXuii34RXwHdpIG
         8b6OdGiD/bYlmCWqTLXWSVUNT0Di1Xl8XMFHUbglsaXaEjS7O45bUW53k+fK8m5mt5Mb
         Z+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVinISZzFsD1FhrYFIreHHlYK4RIY/6ppDxFKtODaGR5qhvU2I+CnvmgLKAEo2Ffh8FeUpsxTdEm8o9k0FG@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgqKEoNuSJ/lNepSwlKDpOVUwN7OW2OqsCXwPrvZVNdeMTZxz
	7SYhd8J6GhM8QBoziaX3Xc7voydanIvBPG+j8vvefr6uD/ZETp1mzVcJihIKyC7pYdGCdSYKxTV
	OwFx8fJADCym/53ING3xM2QcnnNoMkDx2Us+H6Q7FH5NjY8HaW+5VA9E=
X-Google-Smtp-Source: AGHT+IFdiUwM6usNyDCkLi/if2XisD6w3B0PUJMgYfQwjzXBmtMFTye+l/jlLwYTFAMwLA9+B7LxNQeBaYvKgU653zSV2doKUl21
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b05:b0:3a7:8270:4050 with SMTP id
 e9e14a558f8ab-3a7c55d49dcmr113095305ab.18.1732863603171; Thu, 28 Nov 2024
 23:00:03 -0800 (PST)
Date: Thu, 28 Nov 2024 23:00:03 -0800
In-Reply-To: <67475f25.050a0220.253251.005b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67496673.050a0220.253251.00a4.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: null-ptr-deref Read in fuse_copy_do
From: syzbot <syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mszeredi@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1648df5f980000
start commit:   445d9f05fa14 Merge tag 'nfsd-6.13' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1548df5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1148df5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fd43c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cf2f5f980000

Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

