Return-Path: <linux-fsdevel+bounces-73214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D1D11EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 11:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5061730275F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4792D0601;
	Mon, 12 Jan 2026 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM/m6tz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D980280324
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214169; cv=none; b=MbjxlHZtbPPtIp2+9rXEamwEH3i+KmVvFW0+OVi+oL/f69bgypPKugRL80Bw2OVq4cJz5NklekIiKQrXx6iELAaHCp87GnGIiww8T2mCv30lVaMJByFyQ0jHMnu5Ibn7hdOHCCqK6yqww62VM26N+kkQ6uWxefBsPrnjW+NNB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214169; c=relaxed/simple;
	bh=08fVCfD27wb2gv7kYIAWxqwADxfvdczIM3K1eeFUe4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWTvuisM6AexUgC6k1SFpBpGjNmCKoCziNPKrFl1Dj1J3ilw+bHD+jEhlkxExuGfrk63G9rb/IpUElrHBMeJ32vxVIh5PWd+ooYfLtJ8z5IIXrzwHkBqxkT3G5D6h38VkgkWumLwRIvFD5pZllw0UHT4FfhnfgeyqvmOgRHNgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VM/m6tz5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b73193dc8so5345721e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 02:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768214166; x=1768818966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E65pqvH3RBSICovHRJtJSxtsNLFlojoZ0JyripJP1Hw=;
        b=VM/m6tz5jU992areZ+JOu1Da2c7xHGG4qXIOwqXGQ8wDBgALN6mllnb+3TWpAvLfHm
         rxHBKBm4vNcBFkUoWuO42dXanr1tw5/vNTjoIN42P67hbqqtAxc0/YhFWZWiTsK2O2Ub
         hFDaLPs+G9Q76zy0pqV3J2HdNMzXIQYBOpNC584EKbHNlH2l8JWlE1CGd1ChbABEm5oe
         4SsyXCLaTsvQ//Gs6o/mriCzyIRIguGPyPDTk8iYz5p1y37TZ1BWYX3rtqSPfsY1E1lA
         Su6MTSRX54cP//rhJSxRSTztFQdizvfun99mrfum6Rzwo6w0DhMCm5lOFfxju+2B2y9S
         9twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214166; x=1768818966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E65pqvH3RBSICovHRJtJSxtsNLFlojoZ0JyripJP1Hw=;
        b=gu9ojblQS0p8PmDhhN7JaHiTVklaJlHRA2OqrFwEgo29EWVHy1LXQYaYBtGysAOop5
         qnXe7mP15N9L0CX0nyCN8+RBmW7tjvCLqAFO//43v5/VCufHDPgGWvYBbGWjoQqoonc6
         aJSpCYiB+i8n0b47NQVrHtPHuO8CTI8k+RypbPlMI8t1EJjf3XO4rBCAdbtFkkAkxifB
         vxWfqkIYcsbAfwSHoYKSkoIIOl553mLRsOeoRsG0iwqaS9o5GS1pzw4tGoXPkJlVhzSX
         n3u8YMNiQdUPbNNFm0jgyAjgcoK6wBDvHiR+kX+DZC1cEslGAWeYDMLbtP+Sm3YRk/yt
         961Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrp5c5/J/LSwIJhvMBYZF+fsTvyt4TU8SCRNjFcjWRg56h3s83qt/FnkzgmjirFcqVCdfTtQo1fTzEp/SZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yztm98qFUUCUfkA4q8GyO1bFmyPuZ1CB9k3QTAcnTXhyQFdUGNS
	SGrrJKA4tJVZRhnfEWFAGwUdLnlCO9fwk0CZJEG2T4DKa3Us8D2c0sPb1Ff9RXtp1V/1IB5UFMr
	KxrakejLieR828rfmwz2z5i8A2ftr54PG4pdgshSg
X-Gm-Gg: AY/fxX6Xqty2Eif5qZx9Lh/xImA32PfjC5BAkIDd2Zh1GqQTuOBp/TjrnYWGvX8HW5Q
	gA3UpqMqokTMrbQjBoG+fwA9/8DlKYcvNke7cXn9lv8vnTiyrLjjkwj2W7wvXbiC0dWw9eU6BqZ
	ZThFtgtMLqmtvcEKG+nMKuGOLMy2TYqUeGSMUggiUq65kGTzLc9A47VoqZq9H4h0WwJD2zR9R2S
	nFHCuJvMnUALxe3VVs5ajq/LjZmdwRE4NYXUw5lgCgcnVDhvmk1hV3reoZcJnGwXKZ8c2mIy9X7
	3XAiXjPkmE63A8DAlBFB2iV46QvD
X-Google-Smtp-Source: AGHT+IG5WFUI1z4EpjbAKdvnP0SVDGmadJAgHopk+zs57ZuOQyKnAxhf0wW2Usa18n0QWsGMcf813docrewKeItgPnw=
X-Received: by 2002:ac2:46fc:0:b0:59b:72fe:39f2 with SMTP id
 2adb3069b0e04-59b72fe3b54mr3050926e87.29.1768214166038; Mon, 12 Jan 2026
 02:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6964b615.050a0220.eaf7.0093.GAE@google.com> <20260112-apokalypse-sachte-846a6175c176@brauner>
In-Reply-To: <20260112-apokalypse-sachte-846a6175c176@brauner>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 12 Jan 2026 11:35:54 +0100
X-Gm-Features: AZwV_Qig2JiiLt4MuQ4DSLQh0ravf6Iyx15gQ4WWL_xnfLTcayYwtl8U2YX7rT0
Message-ID: <CACT4Y+Zv5wo29AYH26UtyH2JrYgLBR04KM8APR_HrF__fCqqOA@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in may_open (3)
To: Christian Brauner <brauner@kernel.org>, Viacheslav Dubeyko <slava@dubeyko.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 10:27, 'Christian Brauner' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, Jan 12, 2026 at 12:51:33AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    b6151c4e60e5 Merge tag 'erofs-for-6.19-rc5-fixes' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15d45922580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a7d19a580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2f19a580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/6eb5179ada01/disk-b6151c4e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/bc48d1a68ed0/vmlinux-b6151c4e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/061d4fb696a7/bzImage-b6151c4e.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/df739de73585/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com
> >
> > loop0: detected capacity change from 0 to 1024
> > VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)) encountered for inode ffff8880384b01e0
> > fs hfsplus mode 0 opflags 0x4 flags 0x0 state 0x70 count 2
>
> This is hfsplus adding inodes with a non-valid mode.

+hfsplus maintainers

#syz set subsystems: hfs

