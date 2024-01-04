Return-Path: <linux-fsdevel+bounces-7333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B6823A6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 03:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6D4288073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE146B3;
	Thu,  4 Jan 2024 02:02:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C51FB3
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7fdde8b58so2606339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 18:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704333727; x=1704938527;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkBZt+cJe9CSsbLvp8nYImZh+jjmiG7w16VVgl/Z6io=;
        b=A95Yf+emF03XiO2PcNrxMHg8cdpE+YmWMDXJJqNdgJXWDgeVUaiE52jRIvhbS1e3Cj
         ttTXRrcZerEdnjNya9DNnNchWTen8FgcQDsz5m4G6IKQ8iDyNuPfymwXvlCncKnTa1Qi
         AWb+aORTqOerIQepARsaiKMDG0r8GZUvh9pn6xxMAMQGqy0skct63e55KiWz7kAB9oMB
         V4Enuc1wyM4DxpH6loPzfuixIcindz2SJux+JzOp5MnxFiGUBxJ1m0yk6Nf1rIRnb5Pc
         BGbHU5aofikD3Us9Pzs0R5UmxQbUOlZ3kb8DFWIvZYx3IGN9hY71VOD2XIDHN02CYhur
         T7vg==
X-Gm-Message-State: AOJu0YxkwoOhRzuDbriEkNRNXU0F600WFSE3NFKkPldZQ4aNBgBp6nG/
	3lv3Rk2cq33SijH93ziWk0dRYMNu/y1ButfO2NIhAVfEqQxZ
X-Google-Smtp-Source: AGHT+IFfv6RdAzd8APK4ZvQJnNCX1qY/ZFYz1XbmG/kEkEPVEKsRMAzfwiIH49DuVoTIzElQLvykLZ2Jq46DQqj2RviGrtInflI0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:35f:ebc7:6065 with SMTP id
 j10-20020a056e02218a00b0035febc76065mr3325495ila.1.1704333726999; Wed, 03 Jan
 2024 18:02:06 -0800 (PST)
Date: Wed, 03 Jan 2024 18:02:06 -0800
In-Reply-To: <0000000000008aa01105ec98487b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000606eb4060e151e5f@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in filemap_fault
From: syzbot <syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ad26a9c84510af7252e582e811de970433a9758f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Oct 7 17:08:06 2022 +0000

    fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152a3829e80000
start commit:   610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172a3829e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=132a3829e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11013129e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c68929e80000

Reported-by: syzbot+7736960b837908f3a81d@syzkaller.appspotmail.com
Fixes: ad26a9c84510 ("fs/ntfs3: Fixing wrong logic in attr_set_size and ntfs_fallocate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

