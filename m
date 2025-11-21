Return-Path: <linux-fsdevel+bounces-69339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32322C76F4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 03:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 15E082C9B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711B2797AE;
	Fri, 21 Nov 2025 02:06:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F825392D
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690766; cv=none; b=ABbxyETzpAaCKmAVk/IyRVM6B3Ywfp9/ZA7cFuogsYqMhbRlyUHSm45ujv8mln8Twrp7zZJmMpS6Zdx2Ct88xPfYUBGrUAho73CdzUy314VK/GPZjkTdxRHeFmu9fWScNUiUt65su2/mG7g1f8OqFY2FSgbG/Yn7jArHSa/BLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690766; c=relaxed/simple;
	bh=azUHn8dtfFGhxqfQS4aiOeFgrew8OKR7BcKO4T0X8fo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=twDVED5ASi4Sow0C//IhKlkHwXCnCsIimJWgWUbvRkBxhTxNfNrh017C+CkoOB2gaJ9tyQy9O+6VWA7TS378QjUbf0CkKjKwCQqebXCBfnqdqCHCpnx916GXKQICKbjHQDMPeh/ssz9H6s06421DYa03k4y+4ZFPMK/ZwLP9Cx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4337853ffbbso16127495ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 18:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690763; x=1764295563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OCdpbCt3wNjnRexiXCbilmmMxUr0JfnovhkDRuiHMw=;
        b=TJoxuKFhR/ZQdn0xYGLWmrIuCYZq5vkOJER+4Mdw5fo5JMtUiHtjjJ7jWh1ztJ+yJf
         wwyVvPJga2h2Ffjr8qRrm5R8VuFy8Tc2p5pAg0aZkXCyC5ZCy12LwUl+bNvM/9OsPlIz
         2jMqnLPlspn1mBj8NQL1mChJkzQY8Qah2SrOq6WvqMvMTaWpsblbBq7c3QIl6OxgFuzq
         1x2L0/IktaIWAuHzGryFtHxrSzScXnrN/pUsNe6ksIqy9PBRGYdVaSZfr1dnerD7TmMd
         MfJWhlUtB01h/iHTAHfPmhd3wmaCHdmvFpVq4LAqTyp+JCDFrfjLYsBo1zuZv/xAK3wa
         7lPw==
X-Forwarded-Encrypted: i=1; AJvYcCWl60/17zS51fL9q/nD1TRobU53NE86bvHBXEFXwNX9VtIPZyLPXtu7nhTY1MyG73RtQSAX5jAFA2dW0YZp@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvo4vhY1Pr5sIHDsZZzU/Ps/CWvKPGopjoOEHRAN1Tx6xhs8WE
	ed2Qk+xsCh5gYtqt9tSalgDh7KtNSI8so6GwchM0jtncU7vg2HSCY/yOFfvrpdrIiweBxIM6KNH
	+juGlNCieym5eZd+M4ZcsF0CX59oYtLlSB2H1ShLsvDy+/QzQm7GGk/FWycs=
X-Google-Smtp-Source: AGHT+IERcIc1Yb4CzJivjqJVbeE9z0kQcPZljxjvjHd8lnfDE2lKDDAofdZeFq+S7IKH5Uleere/h9iRDE6DhenRM1S2gF2TBV8M
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c3:b0:434:767d:8a4a with SMTP id
 e9e14a558f8ab-435b8c43cecmr7815205ab.18.1763690763609; Thu, 20 Nov 2025
 18:06:03 -0800 (PST)
Date: Thu, 20 Nov 2025 18:06:03 -0800
In-Reply-To: <1939a99d-c1d2-4b98-93c3-1951db367b3f@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691fc90b.a70a0220.d98e3.003a.GAE@google.com>
Subject: Re: [syzbot] [erofs?] WARNING in get_next_unlocked_entry
From: syzbot <syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com
Tested-by: syzbot+31b8fb02cb8a25bd5e78@syzkaller.appspotmail.com

Tested on:

commit:         3027b141 erofs: correct FSDAX detection
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16e2597c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=31b8fb02cb8a25bd5e78
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

