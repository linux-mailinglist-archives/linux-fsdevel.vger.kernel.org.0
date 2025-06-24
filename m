Return-Path: <linux-fsdevel+bounces-52745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64634AE62E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D699192534C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00928689C;
	Tue, 24 Jun 2025 10:52:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE6218ABA
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762325; cv=none; b=W0uyLkvyQrpLGd8G2ZjL/M1pKpjsJe2814khwEd9xFJa7SW8AD2iRHWWmBR0wZf0n8Jg4xBXDUMLo+eyZEphDnWCZW8y9YXqspKgFXG+MgdcIgMtMH/BrENp8aIHHGasvfUKfJWvc689pBy9qpIxz1gb4nxWL0tmKCsjKMZNEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762325; c=relaxed/simple;
	bh=xz2FcCbqKQpb4wRLyUb3vG/DM8KMx1BRzJ5zE06uJUY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DQWRRAxI0jM4BWn/mdiFiILKtWZuG7Y6e03fWoytS5QrCTa+iqveuYu1n/9WO2bo97bonHH8BWEWMVqq3zDEPm9HFx6bI/c1CxHP8bX4Y2yjPXPvAIgOLiK+4ZJwshBEVpK42jFK0outarK7CaoMiMz0tdCyHYwtpcXukLotpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86cfccca327so53844939f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 03:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750762323; x=1751367123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlaYw6XY5Li8iYKoNYzrCYXZhCg3kq4FGwbRLUVSAvc=;
        b=qFgYCCslOITdyp3/oGC5Dt5Yr8srnVDHgFhfrJOlawcJHUvKmagE407YZxln9FbIPr
         V31M/q2dekVeMv1EX6v7uCaCo1JQC6++/XtbeA48jORGUbwGV2fF7NDtqcU8ot5m8FnY
         0kYrqLHqNcmQNGAtm83ursi1qJbreFiGpsj5jOHxifd/ncyvXJhgaeJ/fpO+oIgIuxE4
         aDnOWqOQ2Wsea0cwV1oMptrOWxIGCSnUB6oA7/yMJjrCF5Wn5x305NVCYpISSpfEdxPv
         T9NwlMvvYAKVH+m6VP4OQ7Z6v7n5baUpHbitoaJwjf/DnETW0oGQCMySRtCfJAfT71I7
         jepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRjMNRcFNHKycODXVomYFCFOQV6kBiPD6BjbRKYVdA+QrTJ6DRrgya3bLto9QiSPx+mb4YTx3lKbrozvw+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe35yxp4jqk6NwUGDFvqJWDBYuYtKLn4ls/CIej7z6Fwy1vuVL
	r0vicPN8s7wce/aEo8MGnIrdAbXHBAqJjvy6mY12wS4roUL1t5QMK1Gda3M1+p4QDcM2vrGx/Jd
	6xjhPxUM0JHnqSHeIVczGGJOf4kmeACwuNCMGhx5Ls958MysOt8pOMYv73Y0=
X-Google-Smtp-Source: AGHT+IGmPi4FO3SB03l8RAQeWG+/Aha+MmcwtsxA0LQVqy06ZqxdYVjs8V3H58euhuDVIIMecMwE7RamCReQeleCzAwVoN9jG+YA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174d:b0:3db:754c:63b with SMTP id
 e9e14a558f8ab-3de38ca55cbmr169552035ab.12.1750762322711; Tue, 24 Jun 2025
 03:52:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 03:52:02 -0700
In-Reply-To: <20250624-serienweise-bezeugen-0f2a5ecd5d76@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685a8352.a00a0220.34b642.0016.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
From: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
Tested-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com

Tested on:

commit:         f077638b pidfs: fix pidfs_free_pid()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs
console output: https://syzkaller.appspot.com/x/log.txt?x=103efb0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a936e3316f9e2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

