Return-Path: <linux-fsdevel+bounces-53227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8C0AECB5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 07:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE87176717
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 05:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE71DC997;
	Sun, 29 Jun 2025 05:10:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675C19A297
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173804; cv=none; b=V7WkhkhsyI5G4My9O7T0yJ7e1asyl7sidSzcmF+8+7hi0Njyu+kObukAJxUIuEou4quS0OToCfzYBbDblaxr8PmvUv3e3SbCNMfdWnt5Ru5V2MAWz88ad8B+6d8fBC9Tp6l/1mStW9bGXvkqphRa0Emj+S5X1uPoNRGOa6ku8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173804; c=relaxed/simple;
	bh=aNiR3Lw9MNDSlRocyMPoiz+Do8n0Kkd/i/v0ChqN9+Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YRukpj9Mjl8xufJljALtwdkljvRWXzbCldRNM693yCmdxY8y93fyMLswcfAdjqhAPfy+VIttiUudZiFp92oBKIJCM8ffRK1iGBxkXZCYqPJ4eca4afWMQ6Jx1DWDVKesxPx8q5iSeNcMSMIUpWDHdgOVvKcTfMFQrRXFUtChD3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-875bd5522e9so82624239f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 22:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751173802; x=1751778602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfAPSBFodS1baEzZSVSrOtDU6GtBDxIYvoZte8GGu3Q=;
        b=gnzVf4qxgICgoZe3fhx7m9ZKF52Iv1Yg1OOpcsk1Kls47KWjIROlGZQL6fwmC3iy+3
         iOiAIM0UwLk/huaTPn9/peIviYitv/uKr34J+b9VlFdjHHF/N750T8kFgcg9eg1Icwas
         eUpha/8yZCdAhTMMgn3WMeA8lzLz8fBFStUSWdSbYy26lrTEAEVqDjGEa5Xl4vuG+Iuf
         n4D1K7kbh5lw5fAl1AwTeaHvJLUTWpMdpNwCI3fe+aPdqemEyDvwPPMcOJOCEj/auqpP
         aOqCIEDKXmRejl2bDUMXZVrZIEoQYUuVxwFseWeNRb70NUxwsV+cm64L6EohH6vfUIKv
         a9nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqkvhMSWTzltgePgzil44vS401CIdMOKaFk+YYcf45tkwr9x0IhvD+lA/AH/qABBWwo4n+Ay8ntTeW8Dqj@vger.kernel.org
X-Gm-Message-State: AOJu0YxSsqXUbk+I9DwZpKeOtwYmvOq+udNTcAIL4udpUE/NwGOauDj6
	QoUKv+69a+6o40eIJlHSbjpsl7wFL34O1go+N7Oj9tDbSjMUh1EnQgZXRPUHxRATi+BfBYay3H1
	DbksZOJPM474Do2C8bzTwg1eFFDIAdWDvNn0QsRafRsNtEh3nM9GPkcdRvPs=
X-Google-Smtp-Source: AGHT+IF3m9bBlVsKZz0AGHRHyIYQ9S4LRZ3vx30SyuVPQlv33/rFHSqNg/KF/RT1LyGjClooUbalVUkAYG+XvFvDhpNolEOHgkDw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d85:b0:3df:2a58:381a with SMTP id
 e9e14a558f8ab-3df4ab2c75dmr115400835ab.3.1751173802056; Sat, 28 Jun 2025
 22:10:02 -0700 (PDT)
Date: Sat, 28 Jun 2025 22:10:02 -0700
In-Reply-To: <67f94057.050a0220.2c5fcf.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6860caaa.a00a0220.274b5f.000d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_ext_insert_extent (2)
From: syzbot <syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 665575cff098b696995ddaddf4646a4099941f5e
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri Feb 28 20:37:22 2025 +0000

    filemap: move prefaulting out of hot write path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1434a3d4580000
start commit:   739a6c93cc75 Merge tag 'nfsd-6.16-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1634a3d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1234a3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=ad86dcdffd6785f56e03
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fb2b0c580000

Reported-by: syzbot+ad86dcdffd6785f56e03@syzkaller.appspotmail.com
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

