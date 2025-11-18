Return-Path: <linux-fsdevel+bounces-69018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC6C6BA23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E0383481D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3513702F7;
	Tue, 18 Nov 2025 20:32:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08133702FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497927; cv=none; b=J6Dr4RcksWjoIwL7kfFNoM9cEHxUUHF3vDMm84Qwbtkg6uHKNtJaNn+GH1vJHGIwomLg0JkwmzuStiVb/atZjt2kafyeHUyTJ/s2AXSKxTAyQaTlopKDlJewLuX6EKk1QrDkliU3Ga7nXz+wRqM+2f9iLzR1jyl+Iyhk5dyoWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497927; c=relaxed/simple;
	bh=0AF9di9miGJ2A5oj3dC7bq+9dUM6dyiMoDe7nbrfE6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SbSyPI857yInLiP5ynnzRBFoOLFNYZMezo/DxrmP+qL900ywbPLH6yYCZ6I+dBZn3vbPotCQBLcd3PRlE/x5XUifsNilc5qH1ItWcc6CjG0pxgeON+jHgVmQw/R4k+r9ULGCj6z+SzByY90WJmSv76Lemo0fBM/wGulcj5Ckwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433689014feso69344625ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 12:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497924; x=1764102724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbpsJ8rc0RyY6FkORfpujRUVVOShHr6Sf/DjYcM7em8=;
        b=OgihDvyVdRKTlVBldpg+9ViT8u8O2i4A1Q2g9sdlc9Wr2OhNKPAeAZbMa8B5BKX3vg
         tNjc2WMPmRtrLayC77u7nFZXJQx+fTFiM715QnMlQmqxj+xphdoreqLfS/Jjs8igp/OD
         tYQTDeloLR7rQhZ7h9j2UioUW/WjuVd4GGYZ/ADmM2z2p1nortYVV4/ULDKliD9ryME9
         /zQ8nLm6nNYXGVpa0NhaPHzPDtsKceFH5M5ziPSv0WWPHNNO5Gz8wJQDAycIx5/zMUNe
         WP+SbLyJmDWlEnJrdaUVTl+rbXmIyIq5LARPEGk/GFeip9oVfcE9p6OGtdl4dq5N97ly
         iK9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdYoU5jCEF/LKiIJK/XMXPBXZFxgNGW/a696fd0Cma/lvUojHL7nJpvC7B5gWuMZ5I1g2PdPZurBG6Qz7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiqNYDQDNaxBe5eg/yCEOg5r+B+pNXnBqZozLT2sLgKGri+oX
	V+//X10BAy5a6zmHr3cLWR/gvDdMyX55IvaAhhxx3yi7kKEfiB8gb3IIrUzaq7NahJEc3ZDLQ9n
	ZfENQujGAmKgLUnPAn7TyDJWl01T8FXR+gGuVJWaxOFV/6fXK9W8W94G7HDQ=
X-Google-Smtp-Source: AGHT+IETGuDbeP3ODl68DGUXNvx4+B/hhHGxtJ2apjRAGMOFBXBiypRgOiShwIuBNGN12etH/ee5Imfw+h7nncGquyN46NcR5n6s
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2501:b0:430:aea6:833f with SMTP id
 e9e14a558f8ab-4348c8b63fdmr191710525ab.8.1763497923922; Tue, 18 Nov 2025
 12:32:03 -0800 (PST)
Date: Tue, 18 Nov 2025 12:32:03 -0800
In-Reply-To: <20251118182710.51972-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691cd7c3.050a0220.2ffa18.0002.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

Tested on:

commit:         8b690556 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ca7884580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e328b4580000

Note: testing is done by a robot and is best-effort only.

