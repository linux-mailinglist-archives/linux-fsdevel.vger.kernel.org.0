Return-Path: <linux-fsdevel+bounces-45239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D9A75082
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 19:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DF61894896
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93A1DED59;
	Fri, 28 Mar 2025 18:44:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087B1E04B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187445; cv=none; b=XRHBrepjDUuBvBx3MAX7vYVGbEtcyQWUzogpWM4+WcYqSZCT7nUARTUiPmp1VRWCqwi5yKRWAO7HPYYnxKrx5NJRLqJrPGgpyPqjMDZI4d0yNlzGZBcFlakZkkO2VYa5shCkGCF1dxH8TGoLXpXs8u+zLY82USjIMp5hY8/CeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187445; c=relaxed/simple;
	bh=SPecG2wm/IQkCzIGqgAZ0mzsyrh+xZVxCElSIKvubL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EwMhFZI7i4H04NJ2w14shJHs8qB+WDu33vUTK5T3O55IijGNhm/tF+lX7hDLFZxlTk7i5yzcr3tz5nUClfuxMWM9SK2H0sVFutfGzZ1LuTaucvTTb3DTa9KC6p8zoeOkdX5C6giu/9HtOMjosi6r5Tu9wPFcIy+WiDKo7nKxLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85e7f5129d5so231318039f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Mar 2025 11:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187443; x=1743792243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g90s5dJ2ezUv0GG4ZLhmkiZnYoiDPKfC/SO52fRsdOI=;
        b=LR/fYACxMZ9idrEKFGj+ovoSChTBfvh/xjP/mxjMgVEKbQnQ3VDUmyFyZEmBrGA+5h
         GMKkMAi6YQ6WBErX6PFqo0lxzqRc2w2NBOH8VQi8fweQ4fEWo3Uwrch4mSSQEirqTQTI
         h7MpejjEK8Zmxa8rFi4LRwxn2eKwjeRQ/MYIhARpQIujOnBc37xPpLQVc90PRtaBHha0
         HfNzA/Fn6YhbsNCt2ClO6XsOv1Ih8Qkh+r5Kl3A3VBMSD8A4gTbfybqPGOl/g4zpYmHD
         k5lkE0qXqTFvj5aIh7xoj9eG8MptvKhs172mgmvLbXOEymmfy9SnRYVm/C2bxxZMgct1
         kj9A==
X-Forwarded-Encrypted: i=1; AJvYcCUc7s0bYawgEhe/FucjT0JodH50yF4vQuHa3l7L0tkEfAbZK/8e7L5DOqiwmn9tRftfYIKEPSMkHi7ScM1N@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41Bs/4w6syCriYFXh+FsLYbcnSPCw3bOi6WpW8fSILdegubb0
	/ipB+5XYAlw3UKwPxyhj6gxBnhHKcOBAFLCMSdfiOgWxz0p2LM2KbeOJc1gWjDnISEv/eVvGnTn
	o0m+q21FJ8OUXc4J6biEKYPXxB4sO+29VZ6MyS+RMhtADEihyMrgWiHw=
X-Google-Smtp-Source: AGHT+IFoCoAM7/Lk0qcdsfAroXF0YLd4ElkidSn67MaROgoMFIwZfHRztGnsixG0Ujvg5uJ9HvohZsxiNtg+jm1cnjPcDCASg0Tz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3d4:3a45:d889 with SMTP id
 e9e14a558f8ab-3d5e09cdb6amr5254815ab.14.1743187442778; Fri, 28 Mar 2025
 11:44:02 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:44:02 -0700
In-Reply-To: <86991.1743185694@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6edf2.050a0220.2f20fe.0002.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
From: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	kprateek.nayak@amd.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, netfs@lists.linux.dev, 
	oleg@redhat.com, swapnil.sapkal@amd.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         c7fffb8c netfs: Fix wait/wake to be consistent about t..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=15722a4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=62262fdc0e01d99573fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

