Return-Path: <linux-fsdevel+bounces-9196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF483EC3B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE501F23A56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F91EA7A;
	Sat, 27 Jan 2024 09:05:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD981E86C
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706346309; cv=none; b=M94fMsZeFpKVsRbCaHINOxgZmnUubZ6eBLm+rjwuHH69iWNGs8jOtqS8sqeaJm2ZeH5qg2jgnMhMvC/F9O76OfmvQaSRt1g0HFA1QeHpEk1AWaEYhVAjzelMv1Dfp9w5U9tqJNOfCNYqyMdojOITErLTPZSKiCwFke8af0qPEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706346309; c=relaxed/simple;
	bh=ns7XcGUGA6EXzw9WjRju1sbQES5lkWOliR3cZs0XBLM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WnnhKRoiKzgwVxatrsQDCxB1+PYn6B9g6UBBT/VBrJ5PDTtQ2ye3ufbHs9Z7zZeBNd7mtmEMKCULd06MfH2gekY9VNnLqqf51d/zwHfT3zR6u6xoaxBHRuLsqHK0h/rSOL/WK5OESbOdoqjeriUS1HFaWRwC3+gW8INInABufzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-361917dccfbso6529025ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 01:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706346307; x=1706951107;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r07qcjZtk/1Kh0i0MS4Bc56d9Yw9HmQpMjUB3qESI2w=;
        b=INYpB8Ll/BnupPefnnbEZr6IUGzuXXWyxI3UjIofh344C1wEkRIgZmxV2D/vXCqgRi
         snHZcrXTj0/UnaUbuNygVAjKHoOYSZknLvgvQoSsdFsYKBZaGVXdkLa5KWAazmiP4nM3
         NgSIELLyNkD8W7xvdBqoBBhXhhzw9LCE4MZ/2Q2r6r9+X3fOZyZmgRsb+Pw+GcFC/+mp
         fve4ET/EOnoCA8SgxESEyTeNhdYsGzkswhEvbYgq7398GSVByoxOOJRZs+F+9O/XB8t0
         JbYP0/RJMkqyZdq2K01YEmCfij2jqw+d8xvKGDZZ4Q0CuaD9Q6S6A0APoNw0B3vjR6Kw
         +pUw==
X-Gm-Message-State: AOJu0YxxqFCq1+K8N9wdWKd+oeN1RbGE+FEW8rwZJj7hRuAkJV4r8JCE
	IA5tMCH4Wh4PC8WUHhpt9oXFQk6qbtlYzdDbBzmtef0BlOD8izNlzZAWziIEiUpOGArFAFeyi9V
	N3vbEUsj2c/6YmLn31uJ9BDgVbym9/TR1E5cFodztOlMopARxAVrVFsk=
X-Google-Smtp-Source: AGHT+IHvq6oghf9D1tVy/Q1TIUTPUfvvY/I50fF3yj9XD1Ne0UfhLLjH39DdxYrYMn9IskGwwMbQzZhGEjiao+RdXb3YIM3mTPfH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:361:aae3:4ee0 with SMTP id
 h25-20020a056e021d9900b00361aae34ee0mr142037ila.1.1706346305289; Sat, 27 Jan
 2024 01:05:05 -0800 (PST)
Date: Sat, 27 Jan 2024 01:05:05 -0800
In-Reply-To: <000000000000c7970f05ff1ecb4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064064a060fe9b55a@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_find_extent (3)
From: syzbot <syzbot+7ec4ebe875a7076ebb31@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b36eefe80000
start commit:   c42d9eeef8e5 Merge tag 'hardening-v6.7-rc2' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec4ebe875a7076ebb31
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585ea50e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ef53f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

