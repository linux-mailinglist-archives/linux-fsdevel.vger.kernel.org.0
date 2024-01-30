Return-Path: <linux-fsdevel+bounces-9561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92252842BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 19:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC79B1C24D59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216DA157E74;
	Tue, 30 Jan 2024 18:24:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF3157E61
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639049; cv=none; b=kh4RfsKskdHjKJIc40etAe6HP8PTZ05RQR2EVVH+tuRnhnMXo9eLI+11KBJDzFr9ae5FEGG+Nyl/55fQfCTvx554asRfKnN2J38D0ISvKjDCj12EA74WvRyUATuPBLKVPOHxuXKQ+qNVPwusPkTrshn1eb1fjbV9wrA3WZg0xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639049; c=relaxed/simple;
	bh=uoKI6RDYxfXNZxHDf7INMQiHroMYFz/pgjAqVLrTRsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uSVjgSpJHm0l+sseTlqXvofqyt+m7mxV7WQrR4tP53272U9nQLTpb+f4Pg+pzL+Q+DW9yhs4BsrtmyTwmkDeOZvp+wj2Bfj36Tz+2H8QrZz3QyCx/2tej/DPSNlrxaX8W2QjGd24hocLNFuDuLwIXf5IvVDWXObitqqiNXkX4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363779f3989so20381955ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jan 2024 10:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706639047; x=1707243847;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CV5aSs+6xluhqn1Lle8bIA3VgXMJZ5IHasZ7SG6Dftg=;
        b=cKT7y1XLgYmwSVrWH8DgJAeSj/eHlpso9p8gXfGcZI96WmhVP9oLf1zfbKS28WD5X9
         ZqkdcG9pUpxddjnkHApU4FxFDAwMtR2XOjdh7QTDeFYLHGC39gPTPLVkqz6m6Tc5kbZh
         jeRAjog1PcvRJ3bjKFRJXz6Pgi3gWUiC9OY2kErBAmGMejCtlYIqPSHO50reI4QvXCp0
         JrJdVu1Cdbvi1zmwzMRW1g49qBwQsCvjjpy7tjoko/AHVD0CAymol+l5xF4eRJvdG0yn
         l0xGgsuJ5ZtzqKtE7RNqthHVy6tPtvoK0n1yyil7O6zmA6ijohLGwH0nd1q87Ko7XkeH
         z2/Q==
X-Gm-Message-State: AOJu0YyOuE8+GNiB950f4A43+4+SrVjXFUWAohLgeGvww71QwsQ7vrm5
	cxYkuKrHNKnYkOn3BEQta/ujr9j599oPOhH8UIcj8Q4xvCc0sh38mkxMdRNvft7c5cbY/ss0/xP
	/wTGFvMsy/D9jD0Yf9qcpnin/AY4E5q/R/AySFIRkLYKVnnoeMPthvEQ=
X-Google-Smtp-Source: AGHT+IGqPlnfA0jiwGiQvSw21UNGIJNql4jllxn8DVhRbkrpiczcaQWyBvCfi/ZU+uSb6Zzyo1VSLAsavb7KAC9C/I/4wKiYZO18
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:361:a961:b31a with SMTP id
 h21-20020a056e021d9500b00361a961b31amr855839ila.5.1706639047616; Tue, 30 Jan
 2024 10:24:07 -0800 (PST)
Date: Tue, 30 Jan 2024 10:24:07 -0800
In-Reply-To: <00000000000014b32705fa5f3585@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003172ac06102dde5b@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_orphan_cleanup
From: syzbot <syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103f19fde80000
start commit:   1ae78a14516b Merge tag '6.4-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=50dff7d7b2557ef1
dashboard link: https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255f594280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b28f8280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

