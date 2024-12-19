Return-Path: <linux-fsdevel+bounces-37787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D749F7A7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 12:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3300E169A11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66486223C6B;
	Thu, 19 Dec 2024 11:38:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A021661D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608284; cv=none; b=OsM0QmU3avFJCK4W9jdFG6zwfLoQr6qpaU4dqV5IZdzbZC2ck253be0I6/b3I85/633z71gzLcydvin+V3Y3bqY+9AWfCdIbgghKpFFS44K82mJ7P4dmVCmtR2OQ4QUbfsbhPJiHN5pjTM6QDPdII8g0ZQ17pW0QNl82ySHYYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608284; c=relaxed/simple;
	bh=2Yu/b0fUjHdpCL51upFxNncYYiFRez/NHuteOge5uRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vFF7nhtkDdL5R9vBlfVa+2f4eR3h292xnqf1Kt3NHIRvwufQf+Mrq/kK2XqGCm7jaqfPZ1KwWMiWn3PU75JJdw/TEjZnC0fB6vnZhpdWTEwhNDNlg/ZAh+Deo/R/wO2V41dsM5P+XVUSMF7cFDe+tqr1DLfJE3RJ8gLRvp3pba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso15588575ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 03:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608282; x=1735213082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5AhmibNV7+VhVLJRbpswViHF4wllq1oqP/2KyD7Y20=;
        b=WC6Y3/E7QyDTmTAUvKvlhvyfTKN1b6HoSZG0e7slbMDsAD3zwHYCu3RReNDi6GWeRw
         dUCBC/aZaNfGe8w3inpKbWJbrVBNvZIelMaTMn/flPjlw1IauBSUBa5XoWX3RAAIC+R0
         UBYYOCHddBC4vrWuAAt0yIOeoNI/DHO3D5OGkuBCimHYlsk8g+Qpqkr+LBNwdts7kcAI
         GVZQVYV3zX8p5LAYrcvUNi3iT9BHwP8IeH1pBr0uXa+FJGQcX9KK20os5YppuZlbNwnn
         FAXJ7C3k4OUAp9HCHqYEALSAyRFOR92eDu9MW6UpWVfs4WZFW3geyiXqPnivzLXR6k7e
         dPRg==
X-Forwarded-Encrypted: i=1; AJvYcCV6DQOkTs1y03h0vb1jhw8SeAeHqkuGsIFwtfx4GBzYMtboh4NtHUAA5h/+eaXWGkxAKNIViWdK6LeKylZH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiggq+R1KvButCcLQBdLOaeNPxHI4Selzeyr1VNriD3wXpK3yR
	NHShICe89TUoLmIKo4DljKtZL9dSmlcFoGPN1bXxSu09vO2L78P8zQQrYF5cqMN5dsa4AchGo9v
	LehLopEbgecBZRjkehohZ3D56uSJdqzYKcZ3kO5MAm7B88nr6q47nL6I=
X-Google-Smtp-Source: AGHT+IFQqJkJ+KObl60GH8Y1NG6T7FNcxOcunSiI+iFzHwP/ZJKXWLSI4a3ujjMUSwAh2afOG4fgjLMwzm0aYdANPIM7drWJC8Aj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:3ab:8f76:bcfd with SMTP id
 e9e14a558f8ab-3bdc4f18011mr69391195ab.20.1734608281803; Thu, 19 Dec 2024
 03:38:01 -0800 (PST)
Date: Thu, 19 Dec 2024 03:38:01 -0800
In-Reply-To: <CAOQ4uxg36w5rE6RgOCLBqbPsmytJ24cXhhahuQE0H8pqSZ_FJg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67640599.050a0220.15da49.000f.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_encode_real_fh
From: syzbot <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com

Tested on:

commit:         e42bb34c fs: relax assertions on failure to encode fil..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=10674cf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9e486c6802437cf
dashboard link: https://syzkaller.appspot.com/bug?extid=ec07f6f5ce62b858579f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

