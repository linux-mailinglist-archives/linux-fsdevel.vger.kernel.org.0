Return-Path: <linux-fsdevel+bounces-10364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C984A87F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FBE1F2CB73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA44D59C;
	Mon,  5 Feb 2024 21:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FE64CDF8
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707167586; cv=none; b=cCVuSaGGTO4QcfiU6YqkjupgoanOS25bvBN9hQ0rRpKcnPYRC6ohC1prTdsNOnVlD9YojqSaDgz2PdYwYHEJ7IuQe+oLrJMhWUZplHB0PiydsMD6cVbxIWBQyLucL42tpTUScnJHylu7j4pVyG74kg13h1fQ33yIHH1cYjrLCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707167586; c=relaxed/simple;
	bh=RERVg0NCmBPsnzb6n/jjfpC8aRmrtHhD3ZlQlxIVfBs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=swonWZ/K+B7c0snD43NuwWzkgt2DGI5DLH0ww57FzfYctZoG/4HyXr+W6gIrITdA8p8C8iyDyBYO5dbaqzK0e65nvIN7MeB6FKIeANj4588CYz5zT9H57oO2ujBUYo0+HC1+riMf6mPyruLrLMLPMcoSxgCOHztM/b0SX2gt/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc6976630so43698765ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 13:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707167584; x=1707772384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Z0ihoDKUQq9Uqt/80kKGIwkNWhhfnyox0+aJomGQ+c=;
        b=gxCH9h6qCpXDwkQpfjPM4gD7YNdMAPKKsxU5h8XRa36ByVCp4bU5YBwxLmor9RO2Ui
         L0qHzel3YKwuCVYotU8/szM0DtlO7iIxz2ocSU1LFNw8x0lXHeqbRUZOmtFRt+zPkKtg
         RiMTP0Op+TEAMQ7HAoUcIEVmdGimDBlDIbY7oFntEmmGVtIKVoSWQhHGxowLfsrzKZs1
         A8c3P2JcioWLReKx62F9P53n6TiFXuLEbYiSJlAGpjOJ/Svd2cx8SbCUGjxAq6IgmwmP
         d9BGZOtFI+cKX5EWN02L7ucZYqcVumnXeq6u/2bYgJ+5aBhSaWrDaggBPAogphkGqYrh
         6PNA==
X-Gm-Message-State: AOJu0Yx/7c37Brtl9cHniqBTDuNESLtEZAtmixOn4yaRWqGtfu5tasH4
	14JZBuHmQS1DhcKZPiBTH1IYdPnETBQO66RdwpjfFCOTJkQkLgDOVmN9KxMFZ7ScGHt+weX8eQF
	680/Vg6xbobEQFG+EStc1nVl2aE3kOEUnfowJSMkHtMH9HPDcNZENBjo=
X-Google-Smtp-Source: AGHT+IEUIJq4+NI9WY9amk5S6XGpR/DU60PskU08/wZ5acN0mwT02+7/lbDHKIoPrXocNN1g8Li8iF6NRBWd9DCQRYIGP5il6yiN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9e:b0:363:ca05:c856 with SMTP id
 h30-20020a056e021d9e00b00363ca05c856mr55769ila.6.1707167584313; Mon, 05 Feb
 2024 13:13:04 -0800 (PST)
Date: Mon, 05 Feb 2024 13:13:04 -0800
In-Reply-To: <0000000000009c7eb105f5b88b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f69c90610a8edb3@google.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_buf_item_unpin
From: syzbot <syzbot+3f083e9e08b726fcfba2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176f2d7be80000
start commit:   d2980d8d8265 Merge tag 'mm-nonmm-stable-2023-02-20-15-29' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=471a946f0dd5764c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f083e9e08b726fcfba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a077d8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d91c74c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

