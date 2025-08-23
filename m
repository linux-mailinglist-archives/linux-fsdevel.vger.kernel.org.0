Return-Path: <linux-fsdevel+bounces-58871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901DB3262B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 03:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24E4B63B58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E290190664;
	Sat, 23 Aug 2025 01:15:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E62190472
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911708; cv=none; b=BIdEXryn0m+TPd59Xeaq86i31S6zXMF/UQTZnPeg5gewCn5VY0eb2kCrGZGbM9Yvh+3jZ0Qa5cHQoH62NIiMmFYUdPBenLhi3Zbgxb37X1JQItDJaPWdJ0F6KZ7mG1js3VUZREs+ahubhE84D5y3+dP855RncehT1cuyw40rBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911708; c=relaxed/simple;
	bh=WIpmha6yRgyzZP/XXUhbXg/SZnSd3Df6L1V2A7dvw2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RS5yA6w879Cbx3AhoBg5aWzVxtZxBaDmZ4H6ZW/KWNpIaPECKh/Vf1NY5a5kDa1aV9VYrD/TJGaA4RTgFgCSVwlLr19XCOicT6mCEIFM2Vx/V+Xh0+q8HarszymKxNc3/qT1tsAXotNq6hdp6883X5L6jx4tnsdb0J20/MnCvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e7172deaedso28635585ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 18:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911705; x=1756516505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqUXO+FOaOrb+XauyDwN5HD/zcxSWBI9Ntihmw2iN+8=;
        b=Y2Di924Rrohac1cLl9gIljN7HogxkJGrXqq8Dh2NcfDHblkYvTeQ0fmxsfrLxBZZ4B
         3JhA/PgaSFJJCCZKJGol8W2QwG0jmQQEiwNvlnw9QL31tmwbzuUYrpHoYRUcuET9wLYL
         o/WLNkBvCxF6gZbcmdYs5b9P8F/FjdCWA1xhSfWO3m+3NB2TWHVIvFKQlaRFIszr9Uoi
         B7Tf1XsFx7N2NLXD0qc0lh2ZM1+mAYaiz9F23NZB4iNeFz50UnHAUlqm+JYwV2hw9k7o
         hStBddX4tVOTlJA5zQSkTf39E4RIPo6SF615t+H0CwSjb1jK8LCwbh4MHD9Y08bADPTY
         3DNw==
X-Forwarded-Encrypted: i=1; AJvYcCUcapRVUaQWypyDkOBY5yZ/5/g4AChwEyzpnKM31qjgIHgb8kPYACkjjNk5jfmkj5M7eLAkIlFmtkredbs4@vger.kernel.org
X-Gm-Message-State: AOJu0YwAODRDhcNLT4zchGcPe/5xtUzqLKdPB/xWECY357DUIt861XDt
	+k9UmL4MHFXEvW93pgAAiLNW11zUlbIJLIm6uzprWbojBPfET+Bo98QJAK1wkKpg3fpK0WtxKmz
	A3DLl+1DMDtaw2Pao4LqMtl5S6vVXEzDLhvS4MRumxi9H0oQufxb17zH+dv0=
X-Google-Smtp-Source: AGHT+IG0QAWYiXBjMJfzTwoFkjQtMiqtXumBdeXTiefK1lehTc8/t3Be6xv20/K3TfVkkqj9LCRKxjbMAoKWWJA+XKCTeiyD11K6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2187:b0:3e5:4fee:75e7 with SMTP id
 e9e14a558f8ab-3e921c4db98mr68836805ab.17.1755911705506; Fri, 22 Aug 2025
 18:15:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 18:15:05 -0700
In-Reply-To: <CAJnrk1Y1UJ54+4kjHvfJvjh2Dp1J_vVJVGmqfh04zoRFDQy04w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a91619.050a0220.37038e.005f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/fuse/dev.c
patch: **** unexpected end of file in patch



Tested on:

commit:         cf6fc5ee Merge tag 's390-6.17-3' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12393fa2580000


