Return-Path: <linux-fsdevel+bounces-58232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E12B2B6AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 04:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21E918A4522
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870662868B7;
	Tue, 19 Aug 2025 02:06:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758B35947
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755569166; cv=none; b=SBRUIt71Skfbs7a55yus3edbgqb5BPcmzLpaJOEueqrQIJLNrZfhDV4vRy6VGKBCIOHQJXB0GI3fVeskLFjiQttVgi1FXc6TLzNEy12cMTzAyVL7DQud3OaLQnMvpvAQDLLi86ooAwRLVMmRtnfaZ9ruEy5TsFvxPkeE3sZwpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755569166; c=relaxed/simple;
	bh=lh8jOzNpHCI/nH1BvzANTbsWlc6+7mgRM2GYOA97cSA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d7uuSkwtDHTH8WHS9reXxeT9XHO3g5gNnPAT2Et5qj+5KwIdKpGx2ch93nObHXfs8BkdLuTDpEZIxhP4hK+07P1Ms5JSS29TUHhB9mSSaJAajK0q7VUtNCVVn6fWfslut/QfByFmJC77rNgxzY3sHiVXe2fo7HW1p74sUv9ufCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e1630fso485763539f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 19:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755569164; x=1756173964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hySzSrwJgHRDd/NJGNmhoyuoY2oYZl87dUt+SZaU3Vw=;
        b=ikPCWep+/fib5fK1I2ljlWed/heoNpEda04ZIS2jUQA9gR1vHXYxF8fxcg4Lp2qSGT
         Vxz+xI+zEahLm83hwXH24210dLFqCg3Cb0QPbtYOztWcvTG8LYooLlEkY101tIH98NEF
         XnkQDUFXo/V+U+BFdemQJ2EeFMs2PuHLH0Iq3LdwwLCo37w3KM7hYLymTR3yAd66SW1d
         CS4mXiwgw4bxXxQYNVxaEZirATavbJA4Tz72fwejoNb3P8I+LLHuFdnk6Ulk/7Vg0QgQ
         R0MDqBjvguUNkJQztyNT6u4div/D/BLuNweAcU6vfegqORqm45IKMxfQhRsU/FP/x4/T
         kYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQPQO/6Dsp07GQNnHewD5osmjIrzCzkwj4ZSv2FX98n8nDDldamcDLtjVsXg/Mt3gFdr5adB7I8mXz8WB7@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLqO6cab+sABdnEqsaUQYaOaSB5r4mhjTaZC8W0M8wU2F9MA5
	1GkGXZgjTvO6qW8FZYN6fnvoUx7YOp4+w1X6qIMv35QR+X3D6HJGQ6KfmrbzaqTbAP8gMxPYo+d
	FWSijOz/t6WKH0LIjPuVlHQxtJeWsMElslW8mP2G9+U6HKWMgglYKphzoQDY=
X-Google-Smtp-Source: AGHT+IFPWh8hcC83DbPI8nICzmLysNTfx2q+c/0s8wrbCup6BnbcNXZPJvKrIZJUb8a8Xcrui31+7W5+TV2ecOdqs7Cjr/Yx04cl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc3:b0:884:476b:352b with SMTP id
 ca18e2360f4ac-88467f641a9mr183004739f.9.1755569163936; Mon, 18 Aug 2025
 19:06:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:06:03 -0700
In-Reply-To: <20250818222718.5061-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a3dc0b.050a0220.e29e5.00b8.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Tested-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com

Tested on:

commit:         cda250b0 change_mnt_propagation(): calculate propagati..
git tree:       vfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb7ba2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e92a122a0cf6f2a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

