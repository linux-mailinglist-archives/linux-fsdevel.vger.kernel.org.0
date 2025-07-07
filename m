Return-Path: <linux-fsdevel+bounces-54094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6C7AFB2F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81A64A2106
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86DA29AB10;
	Mon,  7 Jul 2025 12:10:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57029AAF9
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890205; cv=none; b=udvq1gXQfpTrN5XR7tmeHu+0QOmMQvDMZ32+Zu1s+Xckk2uxzRh5ih/gPg6MiarG3zC7XWhE6fj62xq2KJQg/8yNt9QTH1RFcgcrNYe8J/imvMU/irtmgtCKUlo7RGQ1pgRWFJn1ERNAfgzW12JixYcg+h1GzMh7jOntiehU8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890205; c=relaxed/simple;
	bh=08taAm5wdRzJvzZ1AMVpIBoq9T7ah67A9asFKZwviIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KQvNE5Xz0Bouu+eCzbDvUnPkTK1vz6mO/TCc8ar5PaJAKeN4e1dwNAaFCT2CrLb7QZSUePDCtU3FKmUyF9PnzKvJinYdvwvdNbUQlKQmIH2pNQZrRAAHAFKkZWq9iojQSaxL5rbtJ+U9YFDw5TiJN6g7LLbHe6tqF5LPDMdz6mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df33d97436so35699315ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 05:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751890203; x=1752495003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPP2c1LwMb3yWT4w/jL//ontQJHJPGGYwvjC1SZODwU=;
        b=XeTjG4CX3P79dr+DIhHWz+gOcuVu6WkBA6zd+KsZvmmMFROcGjQeRchqZ42ON1lcwO
         8pKBSWutNZrtcYPUpLNIQUJS/s9yaJ5FU4BnbueZ+nD5ryJ/RgyxUqn0ZkKmC/EUiUxl
         UOeqB0o7a7RZb22Tjss+PJ03VjcQlbM5AjUrS9dik+ekxF0ja+fi/uQvU15UOEr0/q6z
         0gL/mjkyBrTAG9WdPkOly2j6KnbShV4UXPlkXSMtDgtOU5QToU3ATNowj3MPkIaPV1i1
         u7scN+GI4f0OCd05qEPccGgBG8dXe8P3WMwXQxPuZiG5ciZC+4D/cFAdsANNdpzctxF9
         O5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUJLbXQ+ud8MkICE2NWJ5myaA3fQaZt5iFglmAdT6Ru+4MGzvxphipxWS1FPsv/GD91cBQkuh9NZFxZqu5x@vger.kernel.org
X-Gm-Message-State: AOJu0YwCUK+PbuK/b29/EUBtxzAZ3ALMPBh4Xbj/4xH6EIICnrTMHrPF
	7jcWVv8TliE3z+UNM8p8YQ96XAHOAMw2ZcD126+Yyrfn4KV8uqCCNaFv5ALYU2OjA+NZMzkEIet
	/zS8/fdm5nlmVrF7Ktw8DKBdTo+G5QZFUkcRbitXEsz1+vSd5UguhLUEDR/s=
X-Google-Smtp-Source: AGHT+IHPfuuPr2g7bXzQ/IR0eDbNW3RhV9MhLxKAEJGqruOSFC1E/JO6xQ5Q30gHorRadYI+mH5lHBOzx/FO88c1JqfYl+xQmV37
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2613:b0:3dd:bb60:4600 with SMTP id
 e9e14a558f8ab-3e1347d85c7mr116006125ab.5.1751890203055; Mon, 07 Jul 2025
 05:10:03 -0700 (PDT)
Date: Mon, 07 Jul 2025 05:10:03 -0700
In-Reply-To: <20250707-tusche-umlaufen-6e96566552d6@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686bb91b.a00a0220.c7b3.0085.GAE@google.com>
Subject: Re: [syzbot] [mm?] [fs?] WARNING in path_noexec
From: syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com
Tested-by: syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com

Tested on:

commit:         98f99394 secretmem: use SB_I_NOEXEC
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13829f70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8211a357c817ddc6
dashboard link: https://syzkaller.appspot.com/bug?extid=3de83a9efcca3f0412ee
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

