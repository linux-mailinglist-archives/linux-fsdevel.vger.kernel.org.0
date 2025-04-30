Return-Path: <linux-fsdevel+bounces-47760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFCAA559A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4163D7B2A06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B32C0326;
	Wed, 30 Apr 2025 20:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2866299A90
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045307; cv=none; b=DaR/a14t1PSXAujDnasyrax9/YOX39xni5GIwO+5Bjt3hikH8A8Ga/3N5PpghII+2jY+hvZAjy4Weu7cX9pUEWErWOQdGVFbfptuOLXjC9ewe8ZWNMlC2I1uVqVymL50/A8LSS1mIY5ZLLdZetgwrSq+Adn+d+JnlYk4fEPIwjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045307; c=relaxed/simple;
	bh=4/XsuOC0IPr5wwJxQNqjW0/dFud1iOENDHvvrETODY4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hmK/1oL8PWyjdSsMbvWVlRNTDsLjoPO4G74vPlS5Ys4VayI/Ki3sabu/1PXzs6VFBCiIr55MXKj1HshZK5dksNBpA87dEECVhtkLWz10s3/M8wHyvfOaUbY/AXr+0+qbv6Mu4xXt6jD7ugafx6n2q+Z8c2gM1kRUqdH5dKKeTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d94fe1037cso4491815ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 13:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746045305; x=1746650105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e32cUp/b3R++mkuBmGQFgYOpYmO4M0/4mpbcHu13CvM=;
        b=nfezOTFTX3UNewahydzFK8YpLAnBMGcOpGIGTfLjhy0vsD/Yl7Bp3rjVr9Li4JSPEb
         oQaBgzfUjMtu5sc6mYNqyPOjdXjr29xjnfJBR3+mHROsas3BOLMdQ7crd4ijRd2nHXmY
         GyQWWYXXDLBRL4Gp+3ttt+eAirMpexlM2LHIMy/FjJ1Is9dYcC7q0B1J+6WjBulMz9fr
         ESyz//22Nqj7KPzgRlUP2jcFye14vNg1FiOBrte5V8/JFb1ewUr0moVEWUTijRLQ4tDZ
         tILxNWs80NHcW0o+ol8MbI6e9j/qy6fOuzXAC8xWit4MOAnDLycY/yPGeXSZBcR3pEBX
         PLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX40xcV9R7GVhKxXQH1ZJoJi3SZ0GYdXvqSziiyPb04hAWcsEfNwcl42BjU0fpqhR6/2dD3LG4R+UVDLrAi@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVY+51t1rupBYsw6EtluurzIkgHXe1k3RwjVOVAkzicVTrHUF
	e0u9Ah4K2Dwgk1fvhq0i9HWo4A0ugSzrqb0iH5wIega+m+d+8h6R9Tmh7jB/mGOzr2Aez6nzbXU
	vMNXsVESDqNsak0aYrMJBTaY99Isl1LKEiOvanZO01k4RAJ0WrxglbhA=
X-Google-Smtp-Source: AGHT+IEBSWGzoRlHuLR+qdi2Ai+Wn5WkkdIy2n2sXyISJxwgZlUJfE+Jc92i1axHYa26ZBE0+rhXJtskgAwVShWtbKXhIN+Iz6ix
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3309:b0:3d3:fdcc:8fb8 with SMTP id
 e9e14a558f8ab-3d967fad850mr45222025ab.10.1746045304833; Wed, 30 Apr 2025
 13:35:04 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:35:04 -0700
In-Reply-To: <0000000000003392c606179ddd1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68128978.050a0220.3a872c.0008.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in scatterwalk_copychunks
From: syzbot <syzbot+8c4acf719c3fc41e8439@syzkaller.appspotmail.com>
To: bfoster@redhat.com, davem@davemloft.net, herbert@gondor.apana.org.au, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit bcf77a05fb3d6210026483703bcacb22ed961c99
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Nov 8 05:25:18 2024 +0000

    bcachefs: Fix hidden btree errors when reading roots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dab1b3980000
start commit:   da4373fbcf00 Merge tag 'thermal-6.12-rc7' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4acf719c3fc41e8439
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1579235f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1379235f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix hidden btree errors when reading roots

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

