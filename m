Return-Path: <linux-fsdevel+bounces-69638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52997C7F6FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B9B79346572
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BF2EFDBF;
	Mon, 24 Nov 2025 08:57:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5342EFDB5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974627; cv=none; b=Y/CSp1UaCiRGUA+3xaGtwGAEnWJfVFLOBmRLKD1lu+1sxCqJkAhFL/k8XJADrOkJwLrewi1BtDQUXZDlUxpaHtRxrJPlEYyXbGDtO9pmIjRs/WuYmCjT6rAn5k0QzB7kP7kuPEMDTq1jH2NQvOOyI9cSMZroRs+2GbqDfk7a6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974627; c=relaxed/simple;
	bh=77x9AyTB64fyj0fw+VLfJeSJSvnY2GAQ67S5hveEqao=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2G0Qcl4xx+r76RVgRsB7rDw3RbyuRA8fEOS1P8d3v4mcv4sp230RSWTZE78QWb1QLgkJnfzWRlcVfuGq190vfmj3c1C4/UsmrEAo1AnAEQ0NKta/qw/yZ8ufsmS/s0H4uoYD+oe/VqIMgpXEHB7NBGhumTAR7zoqUTDB3Hspi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-435a04dace1so41404215ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974625; x=1764579425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgpdXraqge1crgzutbhxY1FweyGIh99mqt/ID7C9uWY=;
        b=qPKahc/PF7OJkcoweKWLBl9HNuzENDUNaC9e8W3NoQbQeiqXtdmxcCxgDeyne/5HxP
         b68rxUYMjAmEhoevZHLdxt/jqoCzcrJ1wqtp/9DK0I8xRsucbvXSu9CLjUJ3nSzUlElZ
         TxS7xXY2/5j46TMPHmTVnIVOCsEGy9r3eHN2gO5cKuHb+shs30lKwzlbzfp7l9ZGkhi/
         /DLeqDeR027mEi/DZuHgPyIpiannEj4fNWaslTmJQ3nenX0wtyF/wi7W4ySg3NuhdPBo
         OQyTk2WoM/ZA6Ga8prjI2QI3IBcJhSi7Aa4clhJIWgIVleaOqNHULl0gzmn5MBgC+cco
         a9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR8g1DfpW4ruLVvvBrS/U/5592pjKMwy9FS3c3+hmJysGlz93ClyNT8hzNevIiKd/w0i13+mw3rjCkMlXL@vger.kernel.org
X-Gm-Message-State: AOJu0YwkX2tuoHell0SBo6sJmbdylEDgE8+pT/GYxpTgWN1AbKKgH0wy
	X5zbQQyxGAQdOwyUykJCGMyFO7sc9Fohjyxzq7ZfX0IzMvXKImzcTyE9DuyTHulbsnHzBp8nD3C
	dUrKwUvcDtrVOLFyz9mSRXWK1iZx2ckooo2BUWliNeoQ6JQatUTylHxi7oz0=
X-Google-Smtp-Source: AGHT+IF9rF0JDF4x3w0a1F2G7uPBAzeg5qEtEj7GcsQo4Lsq+x808f/YwHriczCx8EfwVCOiVfp0zi7ct6BY2GDotXbx7xMmDMdz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:435:a148:d2c with SMTP id
 e9e14a558f8ab-435b9ae62b5mr86289295ab.41.1763974625536; Mon, 24 Nov 2025
 00:57:05 -0800 (PST)
Date: Mon, 24 Nov 2025 00:57:05 -0800
In-Reply-To: <v6f6kfeeur7hhpj74za4larguj2jdhz652cwvmxu5o32ivkuso@cdpkqhx5gt7j>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69241de1.a70a0220.d98e3.0082.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Tested-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com

Tested on:

commit:         523ac768 Merge patch series "Create and use APIs to ce..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.19.directory.locking
console output: https://syzkaller.appspot.com/x/log.txt?x=168a38b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4d8bca00359e65f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

