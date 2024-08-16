Return-Path: <linux-fsdevel+bounces-26148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621B9550C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004531F23786
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 18:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC71C3F1A;
	Fri, 16 Aug 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mn08UjU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2A1C2338
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832627; cv=none; b=NI9vv/30g4bg3mx+z6fTaGn5hkbJuTcrFRFP0dM8JWCu9IQsvVSr2L1/jEkgdiLv1utF2Wlovxb4zrvjwM3XYX9qrcDbS5gTcFcYLCpjyGUJzdnMGUmZEle4LPIjVqATj7Mcn/Fcryz3uKQIhrKKo2WRlvfKkAQa1nKQdZOCGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832627; c=relaxed/simple;
	bh=kQ1Uus7lOLPKfEI1znCUipAS8W09PYgHvRFbSeVUxQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lfJbgduUGIPQXaVcGz/MD84mlE/Z4X1T6E6c8ntwenGVrp5dMNKG5UGCUqvg67MRPM7joXDK4mBfljJez6oLiXVzzfjTronszP8yuB7Jr7+Eb1UBYaLp8Hw5mlXspzEEZuqtRqE1uqzCh5YmyBSPRkWZ6F7y1GNUh30EEyHfaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mn08UjU6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7a28217cfecso1758383a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723832625; x=1724437425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=05nSFmbx6P/1DfD7+boXGyw0DEDSw8F82FYswNLhYr4=;
        b=mn08UjU6r9hN08F6IrD7U5clqCKPyp8RdHTmwIQ3pL/A9tFeDMXujYEeg2V+sgRNzx
         C3W/NWYzd0uM9KWAU6//GF77JB2B+vmD3Lpn/m7M7RKQ76HCbEoQWZ/9GdXVd3cUqu14
         FCPqrnDwxmjnHhHtGYKjD/TdnIdwU7rs58pFSFxvBOBO/rU3muyj1biA/tPlydnZoxuJ
         xqwGPKPXuVcm1aD7/ADXSmlEJhawZVm8fAyoei95QyqHy0VvZfGq7ch5dIFkVRjx638K
         WbDxmdztga5VOVk84l9GhW0nWX1ZEaKOXs+CeyXrUeLv+7Ge1ynmO3evbAm7PVL5Ig1+
         eCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832625; x=1724437425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05nSFmbx6P/1DfD7+boXGyw0DEDSw8F82FYswNLhYr4=;
        b=RIcPGsh7ULxNoQIlzaaQn0EHdAwuLO0592VoJynFtcdmxSnFPpC8JsmFb15KCmsJpA
         dCqhhkrmBgjWd76iif73+cB1DEsjjXwL3YqabbjBbVJ6PUGxVGQ2uZBmXnHhqEnyzbDp
         zir1ZXouN7ZEXE0L5q5s9JvZKpEW86Bt0atAjyaHBRE1ZpcByF01daS2awfx0v0AASfa
         OtxZ45PQ3ep5uM9sDSUcKGBc7RRjuu/6EGtuwoEUYBeUn2BU0QGJAuqDMibE/NM93EYm
         oH9rbePbojUIl4ITuqepG2RoE/8sOfWaOZZPzeNQdJPbM0DJVgaW93B9FWHJQg6DTLaY
         1qJg==
X-Forwarded-Encrypted: i=1; AJvYcCW9uajPMNN4TdnbC37voMI/JXoWhh9mw9FOvXHaor+FkCfuS1+vWGIBzSi0JUgR2oEn3J39yKqMY/5O9pKTYBKyg2ad40qPTH80WWl12Q==
X-Gm-Message-State: AOJu0YxGdRceyFn4Ax/g9OehOuagTAvlbFVgjYLQYsiLx3KLdag70ghX
	Mz1qBVvlxkMCoiczxi1+4tBAkc7wAVf2DTEh3uoaYPP4vN91FY+6hwe2g2FgP1mwxObn2KBP/Is
	4vg==
X-Google-Smtp-Source: AGHT+IE9H5LQQCH68NcdXMmYnIevmE/u5gJozQKiFZVITwrrnrd7MOM5/NVJLVxUdZgmbRbmnPYElRigQGc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:60e:b0:75d:16f9:c075 with SMTP id
 41be03b00d2f7-7c97b8222femr5928a12.9.1723832624835; Fri, 16 Aug 2024 11:23:44
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:23:43 -0700
In-Reply-To: <000000000000d258a006179e07df@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000d258a006179e07df@google.com>
Message-ID: <Zr-ZL9X87N6XhE60@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in srcu_check_nmi_safety
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+62be362ff074b84ca393@syzkaller.appspotmail.com>
Cc: kent.overstreet@linux.dev, kvm@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Sat, May 04, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1143ae60980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45d8db3acdc1ccc6
> dashboard link: https://syzkaller.appspot.com/bug?extid=62be362ff074b84ca393
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-3d25a941.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/49d9f26b0beb/vmlinux-3d25a941.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d2c424c14fff/bzImage-3d25a941.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+62be362ff074b84ca393@syzkaller.appspotmail.com

See https://lore.kernel.org/all/Zr-Ydj8FBpiqmY_c@google.com for an explanation.

#syz invalid

