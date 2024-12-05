Return-Path: <linux-fsdevel+bounces-36523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E689E51EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 11:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F37318827A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B56207DFF;
	Thu,  5 Dec 2024 09:59:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB02207DF7
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392747; cv=none; b=RQ2s89c5lfH13oZG1uDgdzEGjm83al3iPXd2CkJ3xaVatLTpfSxAmIAh1x+j5b5PYJA7VSkhk6tcHxjqG0QyQnfoiN2JttUMhT1cCwCQrZy7V8Vfsrdy7G2f4GdxDfvzJmNNWAF4SN/VwxthjrUg+X1zdM4AKy/2jYz+d4znksE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392747; c=relaxed/simple;
	bh=SgIHS645a0AYFH1ctRSGEAJTKS9pLtbEIGoGYT5Xrx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pkym66i2DTufpwawhQOIjtwvqSfUtRxYzGwOlPgCYwIOW5KIryed9UU0iZlxKoQ5iISGle75S31VG+xcnUkERKgTeKRSJpoPU63NJio1spfb9jpt3rwBu2pSSseDBp4gmTw2WdMR4ggiNUQcjc7H2bQm0hRfMGKX2aiAuMzliCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8418f68672eso64486539f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 01:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392743; x=1733997543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lNUCqqMwNBH1sfFW4omgrn6scda2dAGbmRIbTAv4L0=;
        b=qB8jtvcQjPayrvIDJVsiqWgcMVyWdtx6uDSZ3oZGzaDD9ANF3M0AVOiBMmXmq0sHyp
         Need3gfCUcLJIZmO/P0QOQ8tQs8JbNoFtJSqILC0WAuWw3WU1k4+VyZY6P709iBy3Rmi
         kkKNnuUyOhvgxd0O6K1tmn41M3Dm/XGvMePEBKFhXYcshVSe302jL4WKJPg9EyoL5cYo
         t1CbDJeXPUdllH96ug7T3u4oEHczUVGUSRJkqljJl3xRA81XjrsMzXOPhSrewoyDFz5y
         CuEle4O/YlJUiiKIwRweDlbmlyAaGBO37c641MGUz7NEr0rGJgVdM8Ei8NJlXQg+u3HZ
         s0fg==
X-Forwarded-Encrypted: i=1; AJvYcCXUfDLVWz9ZNJJT8aP/ahi81qPOfPaQSYFyN20pA44agN3QlQHvkZzRgQmkKki2BBIP2UDQxmB6TxtRIWfW@vger.kernel.org
X-Gm-Message-State: AOJu0YyaomVR0+lsUWBcgfyHdqat7EnIwUxp00J6c0IBBWshiZpwZmVA
	g6rPLgFkNj/4b6gXQ/7nsGGqwkxo5rzyXdB2/uCEqgtSkBcfuFh42fSYlQI6KFGu1Eg+ZbtWIQF
	r2MNvP1d5k2TApU+XDOXR8er5r37bPY46P0yw7h8Y2TufZpnbnoqrLng=
X-Google-Smtp-Source: AGHT+IFavLHBVe3EenRxLgzvIaeEkVCw6c2tXhFegXn7cdD53cnvfTiRuE/EybIckxER921OESEtcxvmumxOeN/nu4vsVhRDpbeN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a7f9a36198mr111101565ab.1.1733392743713; Thu, 05 Dec 2024
 01:59:03 -0800 (PST)
Date: Thu, 05 Dec 2024 01:59:03 -0800
In-Reply-To: <1757419.1733391531@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67517967.050a0220.17bd51.0099.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dhowells@redhat.com, jlayton@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         c018ec9d block: rnull: Initialize the module in place
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=159ca8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b910f8580000

Note: testing is done by a robot and is best-effort only.

