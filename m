Return-Path: <linux-fsdevel+bounces-31958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580C99E375
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF821C222F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68F1E32D0;
	Tue, 15 Oct 2024 10:09:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B99219F132
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986945; cv=none; b=EEqO1BmmsHMMdk4v4PONQhxyGF0fzr6jG0ZOgBmf5KuxFSlSzsfpQLp2ke3KRrBzh2zWrt2FCZzgO6d7h66JJad5g4qCZnBx8TS3sdxaTFBVY5ZkMARNc+Zo9WPTeCG2SsuCidQSoQ0JDe5zXfiqjhczhv6zpJtKmaIKrAOk6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986945; c=relaxed/simple;
	bh=IWiPpCQxMvLF+uRCz+z9yoECRgrW+yEQRXfRrZIKtVY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sGp4wmHpc8rflzyIsKOQTLaiH0kDRvYIHsu0la0feQDojUB4q1wYaWtP2mia+xrcuYETJtvbEOY06wEi9i0bm5skAP8bYPkDty/TEIGOaM4tQmjb/94oVv4DJiPsXqekdlZXO1r1rFfR00zpCcM+kkKklnkFPar75S72rBV+G/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so20685755ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 03:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986943; x=1729591743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1XgZLD06jZgmdfCG0BxwXZqAtgXOjAbyLjBcsgS6M=;
        b=KvKRwPTaCBrduXO8NAjZRFdB5Nu6TMPeAkNVZ8m/X2yMycnebpOT/wIyvEu8kF/xFF
         4qSGymqL2P08Cb1u2AVPJtcKZzt8afmI6EW63oMd52fJoWA2TOT4IcQdHyrsd3z1OZ2e
         8ha7WN//kx7eMmqB1Ix/oSZD6AkxDejet/HBgmAGRUVmTDHWqVbShhX3EgyLvoUmSXLu
         sQod5Pf3HjYv6XS+f0BAgp+oQ+G2jBg183t2VQOwkrG88Ro2+tdit62/WRLa6frIjN1h
         0f8z5lMkKSwXZ2x758hJYm/Ce/GgSKEXbaA6Ne+bOySAKMy21AdVoF8FdDJiPyBKnvZt
         FUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1jup7MKh8H9QHgRtvZt2AakL4E418xkNLAG7067d3irt5dWnN5DT7rDLkBDot1bKoUFsKc/aiWCV6GYuN@vger.kernel.org
X-Gm-Message-State: AOJu0YwH3l8+Nn6j63WivfVf6klvWy5dwRSDckPLUcwUDFcQiE9Z7vfP
	CTRgSAEZPndmpkMkckL5ehdYnvzudHR6O3P4PpfsPjvwpqq1FbQx02WHRNKQ93vNZs91J6B8BPU
	zHVpsIK7/YR0lxTUgR4bQJ7YWcTAZhBSjmHUpt4hhjbUHYenkMoULruY=
X-Google-Smtp-Source: AGHT+IF1ACL8+aT3InlSzj0jgkv7uhzXC6SoU1xoFZig0zYBBt1vpWJKJJP0NyURctI+RjUawz8qZZtyWUOP4xk2iAc+NLmKXANC
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3dc2:b0:39d:3c87:1435 with SMTP id
 e9e14a558f8ab-3a3a709de06mr122817055ab.1.1728986943585; Tue, 15 Oct 2024
 03:09:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 03:09:03 -0700
In-Reply-To: <120ff6bf-3607-4f6b-9ec4-f1af9bdbdbd0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e3f3f.050a0220.f16b.000b.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         ae54567e erofs: get rid of kaddr in `struct z_erofs_ma..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git erofs-for-6.12-rc4-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17bac030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

