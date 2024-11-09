Return-Path: <linux-fsdevel+bounces-34141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F19C2B48
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 09:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0505FB2182F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DFE1411EE;
	Sat,  9 Nov 2024 08:31:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778453FB8B
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731141064; cv=none; b=UBEb1T7zcEhnBW3M4dWf0TkinrB4CqYwnMAVM63H93MTwiHt9obYueJX84BYG+9Q32Xm5ngWvzxyOBwTv1kyjwcYaKlzLpeUrUmbEmYQgr9LPKYQsghJC9a7y8Hfxs5bm1sJ0W/WxHCXrhQgnZ7DTiCUCpnZfF8ghTemirP6144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731141064; c=relaxed/simple;
	bh=1D1xovnM0EMAFcuSF0pmt+0U7XeGSOPxADpUIgdsIQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HAQe85jFWUhbWRNHPfwGIMRqrwzCDZsb7Opehh6uGIjQumfF6Qk+bznMdQfC03mgx066wiC5NVd3KMGDwXkK2ScCWQ999oUh71WaDR2VBnN4QINXYI4ykfhtJZrwf54A5R5QyE+P6jZTZ7kmNrN05wwG3Fb+Ced0CBH8HCDqQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so36631065ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Nov 2024 00:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731141062; x=1731745862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYVFRLpr35Jnu0CNYH9eEEbObvwHw3Y0l7EYQ4KbDpQ=;
        b=ZDuwLUVmlXkkqqf+coI4G5cZRA+39J4CpPOlzmGZAvPKCiuo1xtAUmbsfCWXQK1Lah
         Osuqntgk0mn962kc0/hv/rlDW+hf7s3xtZGZ16UhW1zcFLMSSwuedq6+D03paxN67Jeh
         Vxh54hvlIObr6KQfI7Nq+eU2BafuQRIRPgTJELrOic9ivgyRhWUbefpqoq6NOQe34tD1
         d2ohFrkvvSvfhady79oH+NmJmmzsH5Eb1nHTw5bsVt9O0y+TGQkach9GVJ1BtHnhdCa+
         Nhgo1cPHsv0oz4/Bh8nSjhaISsE+Ear/QK/do/X589hCv9JzggANlnw0IiDjOXPCrY0o
         2VTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/vYkcRL+puhN+oEadnYOsxRyfDDAkVxUguDiPfqserYS0iVuS8izeLUIE/HrXcgQlwOpx4jUhxHjImImh@vger.kernel.org
X-Gm-Message-State: AOJu0YzsrIStoQUe7tWH0IwLQrdjtpN327coDwjCdxwDgtsdrlwahFKv
	wCu0iezDUmInkF74L/tlaiHEaaGRnNwmAr8RbrrA00U8m3A17q81D3P0ceX+bC7sP5JOVaJhj6B
	Art4adLKOwIIvHWoro9IlAfVS4eJgxfEmJz7FkfyMzUjFfm6Btmt3+tI=
X-Google-Smtp-Source: AGHT+IGumaAxr12HSrk3WMZeIvTdg85QNwAfY38l9VuHuXPLH3cBOYaCgbCt/TfwXfpZvNPy4DGVNbYZjn1IQ9TcG/OTI+wS0IlM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a3:b4ec:b400 with SMTP id
 e9e14a558f8ab-3a6f1a48d05mr63137605ab.17.1731141062618; Sat, 09 Nov 2024
 00:31:02 -0800 (PST)
Date: Sat, 09 Nov 2024 00:31:02 -0800
In-Reply-To: <0000000000001a94c3061747fabd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f1dc6.050a0220.138bd5.003b.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5b2db723455a89dc96743d34d8bdaa23a402db2f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Aug 19 13:26:22 2024 +0000

    fs/ntfs3: Fix warning possible deadlock in ntfs_set_state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a67d87980000
start commit:   ea5f6ad9ad96 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59c50304274d557
dashboard link: https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133fa268980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142cb182980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Fix warning possible deadlock in ntfs_set_state

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

