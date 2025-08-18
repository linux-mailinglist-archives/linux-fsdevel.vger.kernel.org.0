Return-Path: <linux-fsdevel+bounces-58153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBEB2A201
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB83E2A5D92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8533218C9;
	Mon, 18 Aug 2025 12:36:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287DB3218B2
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520569; cv=none; b=SS5DEF1eilDqBr34DH74EyyomfT2jiaHiPA1ri6FH2nBzp24SqelzarfnjBvPfzaS78jl86vgNaDphVSiacUJs8yyb9Xhs8rl7uRWevWzYPnPiPCeGq4vW81XaOowSasO0qC74/wnDypn9K2rAiN0VJCtsryW/vSVOYmWFJFtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520569; c=relaxed/simple;
	bh=IVEgPeYZwTHQRqRfdzE44P/8pF6Lbxbhl3j3kbvQfHY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SLCkFRLrSP+6e7ZhpGPHf7MP/rD0SguuJ4emAAHfHsgk/h/+LKO2u667PD0miZTBDrsSM3J2DqbXGH88C6hO1tx3D/R9nqzKbsVrwpI0It2Ix8r573slaKau6AgaXlhwPrYZ7zXCeuNITSDto84JUiR6M9gCyWkH0SoQhnXUXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e671c9e964so4326775ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 05:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520567; x=1756125367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIg2ZRIh/jXrnDPxRoTtBuI34awvrkZLEoipYY5Cc1U=;
        b=LdaVWFw8iQMkjVZMo7/gQ4QJarlX9VHxvVIaQXklr0AC7BiBrsF2OmHPHNbeUC5QEB
         fT59zZ9rXkXeIKeEOTygKOY+nh+BdFt8kgB++z+KGZilVdn8+ZaPqSpYMnkqHMjRDQAg
         fzKK68Id8tPPe/305smIIDf/vJlVHHWsZDA9e1rs9TBxf02qlqbaNnNbPnV+/3m1ru7+
         FPb+/Y9BbxFG9UwqVolGS8KTd9/csmnc5qR14cLFTrBjpW33XHFHc7T+98QLW6t9ysEn
         6TRsNisv7wHKyYd+LG8JBTBegNBzAQvkLm1arlUKhxSYhWQMoK3ZPA0OhFf2xfeEk5XE
         iWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTYNvkZOINTCPshYLq/SqDKZ+KxWpwx6JLWCwPCl/9Wl+32HMW6lLcNMcIZuIV7n5HCCQM4atdNQDL1Szw@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdIGhZ9r65YgcIP3dvds/8KEqqwpKctNp5fz78puOsmm1IrP/
	wkPVA6JwB0/hrZHNk78JBoif/AiNYE0E+CjxDPJG+7PfYUM52F+QPDtn8critlPzEtqB9fS/rXq
	Mp4SiYNqS5qcN4bdbJI8ggtfghwTP6e5+RML+2mMVlq6+CFGOCDgb2ti4v3w=
X-Google-Smtp-Source: AGHT+IHEWQDJKEutDrIYMvemuvoFRWNRe97U3MfGE8nq68PKZaijn8SILyAsae9poPv+3/Gxxp+LI5jH72HpL/liU4yd50YkUwMj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3e5:5081:eb8f with SMTP id
 e9e14a558f8ab-3e57e9a83cfmr202742425ab.11.1755520563926; Mon, 18 Aug 2025
 05:36:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 05:36:03 -0700
In-Reply-To: <20250818114404.GA18626@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a31e33.050a0220.e29e5.00a6.GAE@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in v9fs_file_fsync
From: syzbot <syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, dvyukov@google.com, 
	elver@google.com, glider@google.com, jack@suse.cz, kasan-dev@googlegroups.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, oleg@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com
Tested-by: syzbot+d1b5dace43896bc386c3@syzkaller.appspotmail.com

Tested on:

commit:         038d61fd Linux 6.16
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1317eba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=515ec0b49771bcd1
dashboard link: https://syzkaller.appspot.com/bug?extid=d1b5dace43896bc386c3
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15806442580000

Note: testing is done by a robot and is best-effort only.

