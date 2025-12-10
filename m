Return-Path: <linux-fsdevel+bounces-71083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D36CB4204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 23:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1349930314B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD032DC787;
	Wed, 10 Dec 2025 22:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356827A10F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765404545; cv=none; b=j65BqYe4gupNDTrB0PURIqVLLHkgfVa1CrHmcxYJ0SqbOK3xwb9G7Yhij0Lk85RsoMSE6ZxAyZXygyVVyy2l9oesDDPvxcHCDvQj7+1bcBkyHQ+XRbh42buXa3UcZxARtbMQd3pHVrZlI7yGdO8+UPG7mnGwRxCSn9D/o9yCq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765404545; c=relaxed/simple;
	bh=dhhrwqNZRrmj9MOsCMnRPTKmFi18x0wS5ZnKE4M8YXI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W1Mr6wO1jv81GrtOes+yF3HAeW8NU89B0uDtMHb5HUJ5l8P6ReiCs+ZMQK2NvyyB1h2y8+YFjC8wuRHAUxngPJS9dUR3th8ZBnNFXMwg3KD8iVUAj0z3YkTBug8CUFXYfeZ7oPfkVBogQdBj/IvtVjBZJMUbpSQfFCeaLbPAyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-656c35cd5b4so290473eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 14:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765404543; x=1766009343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnyjkAnu1mfzQ7qGVEqb+KdCLKNOw5J/zzC2jGNJLs0=;
        b=FbYUH9bhaCr1LB3xnQWFEFdSwDqwjZ1xxQBL2G9TFe/HtW1E57dEgBfGSPTjuah/s2
         DiCi12ogCzSnEpoA2wfnwf5sXvxVWHGcZyhSecEShybJLkX7zsz3OnqvR026dN6yXGdh
         cmibnRPlpj29NwgdJKxS1DJNXUO4sBrqFZiR/GlxvQOvft7CRtB8cFk6JLti65cs9Pfv
         JTNFg4Yoe/VzWIKTKYxBF4P4uxdHXCQmesQ/lJCca7dwvCn3Si7SSB5eY5PqXpGssiMO
         53C13RiFMV8e5eJJxntJSD8mATDnD43QPCjdSV2mJQAPekfB3vmE6jKRlCQ0DyYGBMYR
         R4ug==
X-Forwarded-Encrypted: i=1; AJvYcCU/WVFks8Na/Gy1f7eJBeRMm2DhGKVfebJ2w6be2f9tDZwkOfoqN5gjCq4POsr9LK+N1+xEmSfApz/lXW5d@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaXcG1weyrvDzUbG9y2yz5XgM4TkpfH3dlord+E5ti4VivdQo
	wOVOMcBUuXFhc1hD4luaBHGWMjQvxLM+X600SRbwanaHCB+MMOKeSC13VsGjidUUzguGxaeevLh
	lrV/CtSwFqTz+xCIzyJ4L3r7NAFYd5aSEl1aMgK7wixNBF090uQy5/tg9rZ4=
X-Google-Smtp-Source: AGHT+IE/bY9J2o57OlEmWFwHjxOgrBtmeBXF4Bup+F4cMm+mfaSCAdkAtoXwDBKOMWkEviyGjQOZ/myiqRoAJK8TdnIJFpOnd4Jk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d04:b0:659:9a49:8e11 with SMTP id
 006d021491bc7-65b2ad28611mr2431714eaf.83.1765404543206; Wed, 10 Dec 2025
 14:09:03 -0800 (PST)
Date: Wed, 10 Dec 2025 14:09:03 -0800
In-Reply-To: <20251210214730.GC1712166@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6939ef7f.a70a0220.33cd7b.001b.GAE@google.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
From: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mjguzik@gmail.com, ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
Tested-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com

Tested on:

commit:         0048fbb4 Merge tag 'locking-futex-2025-12-10' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107c7992580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de48dccdf203ea90
dashboard link: https://syzkaller.appspot.com/bug?extid=d222f4b7129379c3d5bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c51a1a580000

Note: testing is done by a robot and is best-effort only.

