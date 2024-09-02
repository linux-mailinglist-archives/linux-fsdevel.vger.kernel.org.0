Return-Path: <linux-fsdevel+bounces-28199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB47967EC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5773A1F22275
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E2914D6EE;
	Mon,  2 Sep 2024 05:28:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9C179AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254884; cv=none; b=C4LPTnaqXAmhIYMhH4DJ8qCAE38YkdbkqofPIpE4weADKKXLZ0UIMDjjU1f9Lp/Uzv6tqfx+TOjN8feub0knCfgbnzNZpqcBqYHJthXqwo0kh1M/ZpzVsjRYA8uEBoiP4zwiYVWT0wd3Vm1+7TX4tZRyNlLAz4/AIMVEhlHHwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254884; c=relaxed/simple;
	bh=PIWg1kV2O8zg6jx9p3Pbr33e5KlEZhEQxtJASrgjHpk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HpDb3fAUUOgoW2QKkx86lnYGB6aE3BZiWomW+sCPAz7A/kITgDjCB1pgrOAI6INAJsUBGsyoSNHn16Z2QQZSwoSHx6YgpTr1Z635bcs1QHojGbHKvjYkvlZuJohtRUfrfA2ezh3g8LHf2RYv8bWqmGnf23a0tiKfm8by/UB55Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so185342639f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2024 22:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725254882; x=1725859682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6/R7U0VqDiPHR7JhVGpk+mBdbkz6KtFGSnvxfDuXFI=;
        b=bYFzSfX1l/Zoy7QH3+/aJCanvcW36kIvBmluKo3k+DssL59mCDlMzu7zwdMizAmmt9
         UEBSLtUnO0CJQ2ORooAUKPzZHD9N0hEzUijGdrPgqIOUsazZL/ZwYsXGGjQdsy65lk53
         HwcULA1Ulb8E2aPoBErWkPh/IECKo53T5xnwrwD19p/thhCucCp5liZFt3ElCjHS2+oh
         qUH01nA8cJ6VEF0fPFqbnGcOkQsQH/wC6FgyhKRJhHtNCv4tiCB0SWRCL7elLpK9zPae
         WIeOPueIyZNpWvCh6OeKTvKTLD5by0M428xQR88QwnlMNp+lkhn67yzbgLJUSkuWSwlf
         ioYg==
X-Forwarded-Encrypted: i=1; AJvYcCW3f2/VMYme5dRJiecoshhavBOoe59jpS45Wu0GivJfUn6IzJUM95q1ZSjFtIpUajs93CREI7rj+q7v3p7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyxIyxX4XIs0Cb/0cq9PEhIHYCnGguvtr7Kk+o250b9Mu3jVISB
	M9wXwTlExOg+xkUBiUMEnmGI3k7rjjHqmhIcfWphJoXnOb5D+cK5IWAdN3JqF7fhyA12gTZTpuf
	xmGk6KuuFagwDLQxma7fq8LJEOu6+8YhWiUgMwz7i81dkLzeVO3U1Bwc=
X-Google-Smtp-Source: AGHT+IEGJzdjUqwdJUazymn+LrA+gjDAEdrAgDe9ts5jMjlBpRNDON9BwywuQpAbcrk21B2MMgOldPJZdwVKYwxr8wfyfW8BymTa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4d017f12e62mr647003173.6.1725254881854; Sun, 01 Sep 2024
 22:28:01 -0700 (PDT)
Date: Sun, 01 Sep 2024 22:28:01 -0700
In-Reply-To: <20240902050455.474396-1-sunjunchao2870@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006156d606211c3444@google.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, sunjunchao2870@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com

Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1710c453980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f2e529980000

Note: testing is done by a robot and is best-effort only.

