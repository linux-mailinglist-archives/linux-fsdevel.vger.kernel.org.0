Return-Path: <linux-fsdevel+bounces-68036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A19C51A24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BD53ABB6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722932FFF9B;
	Wed, 12 Nov 2025 10:18:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832820FAAB
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942688; cv=none; b=ObmaloMkEqDUs+K9USdqso0AxPzvTxqrrbwC62+EESr+9qmRDtp7BJXGgrCVT1ySe9wR+1OxmmTf4akxQUvDVkfM/FC/WgUkD4EwDwjkRs6sCf49m+ewMUtLemn3/+eHiKr7j5wxoVKVagi9QPW2PzX88nL9RmY9xCPXdyNvRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942688; c=relaxed/simple;
	bh=j6zU9E8/y0C65fl0xXr+Lxr++CUVJidoLOO92dvmDk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gd/AD4aexUq4688H1PjyARKmik+d1pXvhynaSbxQbSn6L2aDQ51x/kareV2YlP6NIB/Kfr0Nqvc5HN13PoRymYCtkodZwzM5iKI5nbXZAqmR39q0jG7Mp3aKis891tD6nCAujGraDvyA9YHp8/AkKZscMS8p39tITbJLk473rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337e3aca0cso6124135ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 02:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942686; x=1763547486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ydwsIp/N1SK5PZm+wrWCTPbimcP98aU1H27UJH0frI=;
        b=hBe8ipi2Kns1M5SQwIVNrE96pFxYGPLwf8NYICFqzHbZBPqX7ybooMXGcnHu5CaBDw
         vb2o+UdN/FKDZn+uV9Pt+mJQ5/I8qRPP5LiEMpqMlwyYidKbzFKLDmIRVM3QWsAjmXWU
         Omq1+Zi9YsHqCGfreaejLgrCqm3FAOsTHE0lO8aWLKi0W3GUrqSXDTSwiuaQYseUY5Tt
         WAdcX2a51V64BuWqdzcVqb8gFKLzM3MNA2f7W/cUJGHU4Dz8iaV169ZNhVG0UnjjAAk+
         na1KZySLjwNYncH7X06E3tW1OyD+PZC1LVh7mTIxbJAVyhiA5QbF6vpy4mX7XSGucxIN
         8Dow==
X-Forwarded-Encrypted: i=1; AJvYcCWU/av6voCfY/AYqyDGt15uiOK0oDbeu0JP8TBg+OdwnaoKU2zdr7rcukAOGR85wrD0ytO1vlaI1Wv94D7m@vger.kernel.org
X-Gm-Message-State: AOJu0YySQspqh6RMnQPAjB2UzJlkFqbjfdNk0l54EO2EJ51Alc7UA2Bt
	RE8mo+73pUKQBFwAV0lZqKsmbWncz5A1mX1RACbDqKGYkJ1xS5I+JRPmGq0v/Vrf/AzWuJjVqPZ
	8kH1HZa2ajNekP60KFr0SlY2F8qwxBgLlI1X6+wDTpCUyGw5911FGhFHTTeo=
X-Google-Smtp-Source: AGHT+IEwCOorlomunj5Yu48khKiNlihTq+cCIdqellMLyEdeTyySXda6PUSFEaJFZ+u8spiTznag8gxrG9VrgRzdhpaci7YlA6iC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:433:1b32:2a6a with SMTP id
 e9e14a558f8ab-43473c56168mr33335085ab.0.1762942685755; Wed, 12 Nov 2025
 02:18:05 -0800 (PST)
Date: Wed, 12 Nov 2025 02:18:05 -0800
In-Reply-To: <20251112-ferien-trott-4d99d59d676d@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69145edd.a70a0220.22f260.015b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
From: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Tested-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com

Tested on:

commit:         53974b87 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=143dec12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

