Return-Path: <linux-fsdevel+bounces-74026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9490D2942D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5573F3043139
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C8C330B39;
	Thu, 15 Jan 2026 23:32:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D4246788
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519927; cv=none; b=kHKduD4Lug2L9N2sUVbkv20lmXQMn+PS6c6+2DNWzn1t9an1GcopuBgG8JiImGjSgRNjTR4PcR+pBav1bDo0qNd57iUltFAJIMs/WQVtuUOPvdpannpm5dc6ZnElRaQd/x16Dw5FYzsrRvpm2Gy70ZF6kYMIRBAXjqmpLGQ9/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519927; c=relaxed/simple;
	bh=P/v0iQODbENxZ+IU0S9qzJ7x5dRTcX8H0zRGHcekz0U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QNt9qNbSYwYT5Duaxff7XuXzXmkGivyafdA2GH8B5lJm81IxoQkrQdWpi6RFAQDsvEVgTqRb+SqndGLay3Wky3jopL/FjLBetuvE3kwoW63wN7CBbOksE1Pp4CRXMTkjrbciIPDlF1Eg2SNbHc8mGhgqPoF3QH7wlxtlymh+q8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-661024254c8so4430109eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 15:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519925; x=1769124725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfA6BIjQ70CyAKBrgdN+IDy6ooAoTbvTAzbTxfm5ZTs=;
        b=GSr2wd9WaVSBrgJGdit6tFsVJYydZXJEOHe4JNUdyvn3rGi7Ou/DDY7ydVCDEjjf+m
         3k0MXHLnCWECr5PkUQBVs8+2CWWB7YronGybHAxdMU3amr1W+Fuu2y++PoKolkkOY2UR
         Oz7M4xp+tNooNjTbEWVJ8qhZW+f0nF57nm5jVb2LO1E11+Yqkt9j6WVlVL591KxStN+x
         WvhLFbgTPowF6o+sVBQ2lGkHYbaW0iNgSSDvhed8TNQMjkXChpV312Gr1f7sFRQqJCaA
         LiYRvXKg0flJ0GDVUVlIWYuE20wucQoTxdyEeEevH/qY5uCJfTLynFI2Hq0LdhGm//Ft
         nzyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNP4l2b1MygPC/WpRNzvbiDkem7ieOwVFzWyE8dIGWijaLp3YRP03AsmFLfkoMtxvWDvJtM50MXyquImdc@vger.kernel.org
X-Gm-Message-State: AOJu0YylUZh8fkZE2iypj/JzcRepwwZzyk0bDfE4RCDpmqA0KiMeLMG/
	Qjg/IX/YEyKgmhzdklrnnsqWgq0OqUKOPz5yhYr7oG8CxCtjn2gWTVoQTFL1ZsiDcNybhXuHn3l
	91eXtiv6Cx2rKqj6YROKAWwGrCTr9Klns/wzgn8ZdOix/5G4Ycr3QiL93WH0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:450f:b0:65f:6c62:eef9 with SMTP id
 006d021491bc7-661188cd343mr334000eaf.3.1768519925128; Thu, 15 Jan 2026
 15:32:05 -0800 (PST)
Date: Thu, 15 Jan 2026 15:32:05 -0800
In-Reply-To: <67917ed8.050a0220.15cac.02eb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696978f5.050a0220.58bed.0030.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: corrupted list in remove_wait_queue (2)
From: syzbot <syzbot+4e21d5f67b886a692b55@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, axboe@kernel.dk, brauner@kernel.org, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, lizhi.xu@windriver.com, mchehab@kernel.org, 
	standback@126.com, superman.xpt@gmail.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 35b6fc51c666fc96355be5cd633ed0fe4ccf68b2
Author: Ian Abbott <abbotti@mev.co.uk>
Date:   Tue Jul 22 15:53:16 2025 +0000

    comedi: fix race between polling and detaching

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d49dfc580000
start commit:   038d61fd6422 Linux 6.16
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=515ec0b49771bcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=4e21d5f67b886a692b55
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbbcf0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11034aa2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: comedi: fix race between polling and detaching

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

