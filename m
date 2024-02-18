Return-Path: <linux-fsdevel+bounces-11959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69024859876
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82ACB211D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F676F080;
	Sun, 18 Feb 2024 18:20:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D891E534
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280406; cv=none; b=l7t/1RLIsFfPwq3NfM5NeAGZj8BsVcSqo6vZ3AQuJJOcbaxpgqdkeXiYVf1o4wXvzD6Ngx1LhByeefCOts7VVElGddggdQ5zimy7fAQoR/we0vVu17mC9hWaU/ylRLfaGH3kUK2bDnxw9rPzueQNKE+XTiPLRwvIJY4eS1oLkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280406; c=relaxed/simple;
	bh=OjZOhk1V36DUvjvKyFQZuCTHYsyk52FnsJ6tpim6bu0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i0Pm5/LJKxjYeqhXb7edPM5yVwh3G2YOu/FVKuSWAtSirq4FsTg5MCHzzrwzjlgWdSgOfKRrbWXWE80KIAP0XGfdCsvH1uetUtkDGg683GupC0kH5/UQT1VXn/V3NyYiEmflIk6HnXwofDKyBkcXuGjvFTr3Nhj60zfJxTCpk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-365256f2efcso9649005ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 10:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280404; x=1708885204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag1C/pfftsxznqlU7qI7nLJfRxsAdzy+OeJxgj8iLpk=;
        b=AACMfieeOz0ktFvr8UimINlJTHvJEmFbgmjiwob/Th8RwEeCnWh3gPS9/vqds0oNY7
         o6ojJjBVLo5F3wFYTcTk4Oio8dXVsUz6/pkJc5nBbDMRnpDjK9c6PVcXGAlBCcVFmz2L
         Lu1siqRWdo7/BcuxNknjxbnwg8cLv45XC97rFyAquv3zbr0yRVHCKjzpPq9ski9jkNRh
         Cn8vyn+8q06LZjO9fPMuJU4J280ANWOHpB9aFzO0bNFopSr/gdUczmwCAuhh76r60OOT
         2qt9ax/WPvQDAfNgNnwlqCrTaavhN31UcVMogiFrQCgMP/Gsy4Fg4oQ/uiiMexIjfcyc
         c11w==
X-Forwarded-Encrypted: i=1; AJvYcCVZaa4zCi8Inz5d+Si/ZUUkyUf/sHu1k3/Om2yG4hwqF8Gqf1dsRmh63y6cepA92I8jQdo7PF4RuZ5SORbm6nr0jariC5F1lVnueyFfVg==
X-Gm-Message-State: AOJu0YxiwIge7cR2SE9UPuuC72wHFeV4RU8d8kKl4BhTkgEqRbE2mXIY
	9WvzUSLS0qXZqIsLqqwYOPd5lqJSpfslA1vnigRM2SJ8DNJbG28kX6d22+J/shPmAHV2CoIbS35
	SNVNzalGbrr1UQsQIB17iNCgpoOtAH6NF0Ze1ZnBAut3dYPSXMvD/+Dg=
X-Google-Smtp-Source: AGHT+IFnDU07sQlq4O12VDuAhS+4piwxVJQKUAR3f4kON13CbyGVPuv0aaJ/5vl8jzwTrJ7Q9uOPC1OLLEvLWeIlnjJyQg1dKDm1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:365:21f4:7008 with SMTP id
 q13-20020a92ca4d000000b0036521f47008mr336981ilo.4.1708280404175; Sun, 18 Feb
 2024 10:20:04 -0800 (PST)
Date: Sun, 18 Feb 2024 10:20:04 -0800
In-Reply-To: <00000000000056e02f05dfb6e11a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaf29f0611ac0603@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Write in udf_close_lvid
From: syzbot <syzbot+60864ed35b1073540d57@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, alden.tondettar@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, dvyukov@google.com, hch@infradead.org, hdanton@sina.com, 
	jack@suse.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pali@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c941c2180000
start commit:   f016f7547aee Merge tag 'gpio-fixes-for-v6.7-rc8' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c2caf9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f518f9e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

