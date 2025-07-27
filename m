Return-Path: <linux-fsdevel+bounces-56108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9611B13159
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E011896DF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544A1B21BD;
	Sun, 27 Jul 2025 18:52:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB91A5BBC
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Jul 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753642325; cv=none; b=Xl3dYLxJu4ohXhsqrs2fF+JLZzinrYrn3OFP0oLGv7yyr46v2EOoc8u4hatPIbnoQi8fxApWl9wLfMM2rMrPjnYbAjXNAzXXXD0sO5iCuKrgWo4vtSfQulL7ZDfusG3Kx4HIFqILyq7gVR8Yp+X1IwwxWi6t+tP9ZjrgXHUe/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753642325; c=relaxed/simple;
	bh=wPyWClpHEu0OkKIvF3c8ykkyc6ltSV+aokH2fEs9wP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rYP3hXRBbUz5848iHEw4sv0Gu3W+kV3JtOR28D5wZTz/cnOmjHde3RjAUK+G9x3IJbg5cL18oZRf5Kb1MWj9KHBUjvxVFoYz/2HNyqVWPgYnlU/DYcX0oPJIMYSoBEca//IVLQDfe10UIfYO3klQaamZmJ8KSDU9y1GWf/EDiZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c73351935so347485039f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Jul 2025 11:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753642323; x=1754247123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQIF7n64tjh9Q5g0TH3duRoUX54nPd3qDr+PnCdDjvg=;
        b=Cn54993Tyf4s6SNxD2VGlWKVhVEz5X0fYr2O7d+uQtCkQ7UjlkX+/U/mx7nrZaxpSv
         2FdT33glst4V2zcyS3qeqHwt0A1JzIygmVI6kZLI2znYPORA8+qlcApNmMHxAeB6govk
         9ZtiNUoSyQkfD1qVTdBljZE0uNaq+ShluaPzIynj5Nuvxscc7FrwdDF1wGLBf7xz6Ht7
         NLdNgm13en7WFLPhsnWe5/zY0lWFyTSiMmpZ73v/4AqJS09zynSND0ZkbRVNpKt6i222
         iVqcjNNwQJg5GzKXEHh2l8pOvNaea5eN2SR1vu91F9SwiYIccrdDzj7IpJr3uKFr6Jw2
         VbPA==
X-Forwarded-Encrypted: i=1; AJvYcCUh0svKkFbcpblInbuAvjnkB2W1YbxkkjTSJoFLLYxAK10MqMcSlOJ79jRMevxeAM8qUW1gMw3xU75nZcqx@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRJk/9dtd3JOVW20D8UGRvj6ZNR4MCRCo43lirIyeeUhqG56J
	5GjTUr59Sod3j5x6+3bwgy8qJtijAKCrInrSTblV+vG9JbvM+IV3f8euJs4qqeaRLIPMVsQg026
	/E7U9HN7bpWe4QEXjoqVZmatJOgSI0AGto1WlZ/vPRiNebTwbBUktOr/M0CY=
X-Google-Smtp-Source: AGHT+IHVRTEjBDlMupAstPpa2zGsYrw+8yW4/QJTLbpGwPZM/e6XyhgeaDLq3N1SFma0Xjxf1AF4wxEFSezw8sTXRADWn6amR1Ws
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2490:b0:3e2:9f5c:520f with SMTP id
 e9e14a558f8ab-3e3c45fb852mr156493585ab.3.1753642322888; Sun, 27 Jul 2025
 11:52:02 -0700 (PDT)
Date: Sun, 27 Jul 2025 11:52:02 -0700
In-Reply-To: <20250727181702.32633-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68867552.a00a0220.b12ec.0068.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfsplus_bnode_move
From: syzbot <syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com

Tested on:

commit:         b711733e Merge tag 'timers-urgent-2025-07-27' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165a98a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77f37fce3464f63d
dashboard link: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119298a2580000

Note: testing is done by a robot and is best-effort only.

