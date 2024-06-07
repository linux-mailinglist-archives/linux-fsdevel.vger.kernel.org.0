Return-Path: <linux-fsdevel+bounces-21204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EF89005DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D9BB23A36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380B8DDA3;
	Fri,  7 Jun 2024 14:03:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A7194AD6
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768983; cv=none; b=WOYvySo7jhP6u/wVz9nuKaBnd/DQ13robF6mi410PHYExwezwNUpEXvlJYmI/6oaRaZZUrzTg0JBf0mINuHnuqT9Hz5qwlf823WoZGYF0mZXcfS9AYEWzaGP1Q/JFyz75aMcTehhjpwbTpNvsSZ9ireY+0wlkQxhQ07Od6sYk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768983; c=relaxed/simple;
	bh=CKgfhw6/ZDdh9Blfmp4KBhEsk4kfyKIKVpJC2foBoYY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bCCeZph39NF6F0VsJaMJoGwJmJ38ieXMnmaTWjAqUhc4tpZo2g51GmgFNNc3yNi610fJGCiaJj0qT7OhA4EHeehKnh872vxFrEbDCo5v2i16Ukpp7QJn3DFHVq1t1ImFeZCWpzpr3JHkvbF/kooB1pGriuEL16yqW4Kz7SwqVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3748d50473cso18647355ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jun 2024 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768981; x=1718373781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbtXZuGOkAcxtxulfmJ5MU//nTfP0FkKxWMYN+3H4OE=;
        b=T+uK3yW0+/HOGQ/9pw/fpsYM6/I6r69GTqCJxrgYY2jV7bZkdrKJDrGzh6ac4O9v+Y
         4cI8ueFw2AJwlucZ8J/imWMIRPqbu8RybpkPRlhG6+IxlnPYlAmHbH+6GRsSwkPIieR4
         dFuNwyhD4uppY2vHdgk6MvTuhovXu55rGiGkONVuYJF211//s1+PS/uNurFs9bhlWUd7
         2NJ6x98WJK6EVrkmSQ09LU09izA+faZBNDWsfdy1CKyUmRi2COk2i1ZA5QxHr+duP44Q
         bTUVlRAN5NYxvC7yDNXOtzMuTHH9COGNi1xoSD0AmbyWmuh+nBw46s4zn8+zbkQWJM0w
         hKGg==
X-Forwarded-Encrypted: i=1; AJvYcCXTGZemviH47ua1S8ZnkAQGwqumEfl4TsHu0rg3Uh87ODgB8V6dVNtiNzI1AEkGK9Brp5YMjzta5Yk7FOKhM1ByPi4JY281mSFt9Sgk6g==
X-Gm-Message-State: AOJu0YytQpsd8uYT45DwOy+tp1BowLQ33h4rCJPXhO6V/QDIuk8PD7zC
	twYrr6TQ6fVFB1/x3KtbsfYKJkskNA7Tc/NOYI5RJrgPl6LZ3iPGO4IJcEZMLjQT2S67e7aCngw
	+pRueGUyUnnKidd8qkWNtB2wqzOV4FekbLnxNZ7DUEpRp0PxXs/BtOec=
X-Google-Smtp-Source: AGHT+IGPtkfHB2j08ccIIGTls6mKFZGDEUhUOGubAHeTHT5GL0sQHydt3JOQAJ0BpSab1m7DBzRN7TBaozD6R7z5V0dedkX+P3O/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:374:b6d5:aecf with SMTP id
 e9e14a558f8ab-375803a79a5mr2138935ab.3.1717768981640; Fri, 07 Jun 2024
 07:03:01 -0700 (PDT)
Date: Fri, 07 Jun 2024 07:03:01 -0700
In-Reply-To: <1047e6db-0a9e-4e9e-a39b-e1bb55984f4e@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f50aaa061a4d41a6@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_truncate
From: syzbot <syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com>
To: chao@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com

Tested on:

commit:         9012da7c hfsplus: fix to avoid false alarm of circular..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git misc
console output: https://syzkaller.appspot.com/x/log.txt?x=17244a6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

