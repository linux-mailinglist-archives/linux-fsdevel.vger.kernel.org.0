Return-Path: <linux-fsdevel+bounces-38344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3D9FFFE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D138F162D0D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47101B6D08;
	Thu,  2 Jan 2025 20:18:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072D188904
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849099; cv=none; b=rHaDEPtzTO487BhDJ6u5YOaXU7yjTFsh1sayRhPFg5nR+eAu37GcGFPKtfFitOFdw/CXEr87V+tNqyq6iNLtYLVJqhk9MpVGGAXU22+Hr/XJyugF37btP+RZxPH5XwDhzrpUgKGSIIyZKsfoHcsLGhNFtfUat8KdWwcVVliMbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849099; c=relaxed/simple;
	bh=u0ftigakl3TTVR2gSv10Aaoafz338ii3ic3mzHJiFUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=J5uzclJrDWJsMUhqsyxVs/WvdlasM1iVsQ8NsIs0yzr9oLvFQLPrEp0WMEoHrOQ19h/6cfZ6CAvsGFKwrhZqJcw+QpPQGEtCj/nlcMc9syu1T6kQv4YCIDawl9FQjPjdNNhKDRPwpRCyBuTcTSmoRh8j/ZXGivab4/xkNm/Umk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so208624055ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 12:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849097; x=1736453897;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zyt1KqLVc0pramu9rGXFNwVyDBSM+pe2+vkEywK1yrE=;
        b=xUsCHnq2P/VQtS5KM1oAVGIvHy/VjX+mOunEDgg4DPtC1iHp7pTC5PSLRMmZUKBozp
         Auc8kVp+QwBN09cBYCLcZGAqIVfOEExzlsKBLgvg9qVSL5FKfB5G5/5QdD6Ydb3Uqxo2
         TWMca2CuKFFPGUKK8Xu2EZOTJhD8+WBmEedLgDAat/aCvpYema8tboQIk31iR1lUb/TP
         UF3CyRLNjp+csZP+3MwfzBKg236e4wfLez9nj+5+WqG6T973IMHtJVFbkMSCgQIS2y5d
         lBllh9uAoAuGGU/lexL6kd8bnwjxSP+jku1hPG1IbxUe4QX/C571RJihE0oCGTGNKd0G
         zdqA==
X-Forwarded-Encrypted: i=1; AJvYcCX9nisuatQ4hYgJo7sohIt3EMoAixEKmt5sBnT/5ckSCLtnHAfgp2imFb25/1EzTu4+xZQC89RJNbCwtqSE@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXOQblb/TI8uUC1O1FPgxqHYW5BsN4ilOEwziEzXuHifD9hDS
	eyPfftUqiHPredtDLsp5Prb49PYSHJWOstOKnjZTIvpbu8Za0hDou+zDooNmbYN4ZHest8q55/O
	1Nq5uP6chpgOtOXzyBczUvGbwXRg+zbQNN9fzMHLXkJQJ0VmETfwSOok=
X-Google-Smtp-Source: AGHT+IEow5vVrCoxJ0lCGkXlgJXpV+283139zHLDUjFC2pU4oYrUWU9RnAjC1G0X2pUKH78cVkuwEuG0RlLVFSgN4co8u8E0DJ47
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2684:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3c2d1f7576amr381704985ab.7.1735849097221; Thu, 02 Jan 2025
 12:18:17 -0800 (PST)
Date: Thu, 02 Jan 2025 12:18:17 -0800
In-Reply-To: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6776f489.050a0220.3a8527.004f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Sat, 30 Nov 2024 at 01:21, syzbot
> <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this issue to:
>>
>> commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
>> Author: Joanne Koong <joannelkoong@gmail.com>
>> Date:   Thu Oct 24 17:18:08 2024 +0000
>>
>>     fuse: convert direct io to use folios
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
>> start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
>> git tree:       upstream
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000
>>
>> Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
>> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> 7a4f541873734f41f9645ec147cfae72ef3ffd00

