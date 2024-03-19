Return-Path: <linux-fsdevel+bounces-14810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914C987FC80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 12:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35211C2145F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7637E572;
	Tue, 19 Mar 2024 11:03:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2A2C857
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846185; cv=none; b=nJJ2B7IlMsRuK+xN0PO2S5uqj5mjD3QjVHIvdRb4g5CgWqB3ZTq/CcqMWPBaJGv/0DKOHwRStSiCuIzrbAF7Q1aAloRwICpFNplygR0XwtSImmAr0GDF48tJu+m1+mLtYASy8jPV6d03khPbAZEm7zLnXpO3A+AahpltAQ+1Epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846185; c=relaxed/simple;
	bh=slKjRaMkRRkHh/39qn7hwcXp2X2erWHCbqhQGdEu/ow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sKVCXD2PqNeeepZVpO4iN959wVf6acDbkaatbkArvQ7lXSwsHg2emxBalXkyPM6ewC2patfwta+kUQEeB9Y62n1kyfwyurCszZU+gs9CahjG8pLw37lLewqc2eEaJNrZJduUxUsLJTZHGou8iV3O9hl+G3mhUIgsEn1J3q54v14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-366b97b571cso23768785ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 04:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846183; x=1711450983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NS31IZUVISj+9f5GH0XsvKxqqRb+tl8wJ9ZGlJagits=;
        b=dxIp3sY48VUQp3rYZzfurA9O54M+771rAT3SlhI66HNXbatN5mIXXr+tMh54U86kGT
         BNNMTrnDvroxGBoz7yz51QUt8QYtqw7Ed+IdFlx7rqgrisUEtPMudcwNFx5DeLZoCGNl
         UfYZ4W6eesPPTNFCEQZd4jLSFZfxedxDr811sfXYUO0VC+O9jfaVLjMLwm4obeL3Gqx1
         sU92KF7+b8bWLjIGU7RiQ7y7qXBE+8vV6tDWUCTMcK8uaoFPWZHMaK/4p5e5EviXTp+R
         kCZ1I6X3K6XqlK6aTCbj0AgdhzgX83/KJpx07pKW8z66J+34msmqLyT6hMoWhvfnfj5m
         NAhw==
X-Forwarded-Encrypted: i=1; AJvYcCVG875darUfjUBf0csfWhOI0PrWx/lovW0V4JqLrsO2fkl+RB+uZMaRkJTkxnmSe81M8Wbw1RRwZB1WOI1scpiU/FIJggBa+ovzBs0R5Q==
X-Gm-Message-State: AOJu0YxISbpOjVHV1Ikz++SSQNlofvBZlQNDZgvy7MlATg5bpcvJ9RY2
	D/WxOrfHCz6UHAP/EH9G/jpi4gSNuXTKYFmQzfcv7vA0MIL/8nyD0haFNUReNospYtR6CFpv4ze
	K4fDUcplycIU0aQDhEq28jUYw8Ssh9fPTTDuzgu+WZcDFsoCfMpVtJ9o=
X-Google-Smtp-Source: AGHT+IFiDK1WT/n8TCOKAH5CGiH/AJ5QTidJfxOX7D2n/lTfWZAch3GSOQ51Bj+zC4HRoLqpgpszLLuCibMY38T8UfSWzD9bvdOO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c02:b0:366:c200:a9fa with SMTP id
 l2-20020a056e021c0200b00366c200a9famr121313ilh.1.1710846183604; Tue, 19 Mar
 2024 04:03:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:03:03 -0700
In-Reply-To: <000000000000aefc5005f5df169b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a1c180614016bc9@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_attr_find (2)
From: syzbot <syzbot+ef50f8eb00b54feb7ba2@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	brauner@kernel.org, david@fromorbit.com, ghandatmanas@gmail.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7ffa8f3d30236e0ab897c30bdb01224ff1fe1c89
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Mon Jan 15 07:20:25 2024 +0000

    fs: Remove NTFS classic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fafac9180000
start commit:   9d64bf433c53 Merge tag 'perf-tools-for-v6.8-1-2024-01-09' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a6ff9d9d5d2dc4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d79fbde80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14be4a73e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Remove NTFS classic

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

