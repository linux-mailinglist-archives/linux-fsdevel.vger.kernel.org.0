Return-Path: <linux-fsdevel+bounces-33590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CB9BAAA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 02:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C06284381
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823671632D7;
	Mon,  4 Nov 2024 01:56:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0204757EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685365; cv=none; b=NIn1iHYGgU3kEaUki8LXJLdoahK4/hfR8hRAZjxNwAVBlvai9vMqaOjRNe2WbdQACpbAzfTJmha531ObSavWiI5PsWyX31HfOpV4MHupZhNYyUFlRI6smK1jP59Y9WhgkZSYIWFbMALXPBsl/RSw7FUEWCpCwABzaIve6l0YSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685365; c=relaxed/simple;
	bh=LgWScZ8vi4mYIge2r6YS520vHhCGF7Tdgn4xyr89GDI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mzwFSRKVsnx0IlbWTyHy1IxUKWgeK2AjNDfu1o3gt8P6mqtZx2tvwpYovy0s544yvnF+zVOKqoJSTI16BQNkkZB7YOCOdWMntNOOCTX7wrLTOHEVUzDjDtUgadk8UbP7r+GgZDYsESy9QKpXGSYMNoOEFjn5yBrWLTHf9NWTbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ae0af926dso381742839f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2024 17:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730685363; x=1731290163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8QBo4Ps22SljwE9WLuUl7wap+qWl1oPiHeQAgIKD1+o=;
        b=FBveK0pJF64YaCCvCUMioWeOjPwPMRLlvBe8aie7Fr776rK40Oi/wYKdvPKYfya2xX
         aetHt4ZbKWHy66W+HxzPPctE/8mQygmUMfF05bP5ehCvYevBBpQb4xK81R+QVdEcfG6+
         LE8TAALZv0/5NMifGW1cYMfEbt/cVKEfzY1C2GqTVySvcL9clpP9WYKlfTefxpy+nl6K
         p+G369LAuh1e06jegaQAmCGuAWjUrk8DaQ508W3fqQVuLK3QhVlJdydSmiiipKiwlEcT
         +74DoRhIw8aQVSvxS1kW+XFcee5HAw99kj7oGUH42Ow9+47qHEIeK71hURgF7sq8zC4n
         zsrw==
X-Gm-Message-State: AOJu0Yx8G8IYQxLimpE3Pr0ncY9uDNKgmzv5Oby3VqPJ0LMy/kK2ugEs
	DI4UvU3dVXpTU1h7wsWblBiivEW8VDJDlE2WoYQNw0km/Vkn6di4GDJgBRX3mCHfAiZ73DOAjk1
	6giLm8E9h5KViuVmxrEv9E4zrSCioJH1aXTBqCQKxNAKMWzR43T+fduo=
X-Google-Smtp-Source: AGHT+IFSXqYhyKTjlCVZsuUDtm8eJoN+X8QF6bMX5/KbzOkqgwuEE/r1u5wZ5zSxOchdFagGlxUS21uBScoAF4wUE+4MTHUSNrkv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a6b031a257mr105648955ab.16.1730685362826; Sun, 03 Nov 2024
 17:56:02 -0800 (PST)
Date: Sun, 03 Nov 2024 17:56:02 -0800
In-Reply-To: <20241104013708.3134548-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672829b2.050a0220.3c8d68.0ad2.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Tested on:

commit:         59b723cd Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15127630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10827630580000

Note: testing is done by a robot and is best-effort only.

