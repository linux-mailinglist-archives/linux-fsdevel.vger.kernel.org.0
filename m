Return-Path: <linux-fsdevel+bounces-12256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C884685D6A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB81B21373
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB33FE2A;
	Wed, 21 Feb 2024 11:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2763F8C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708514346; cv=none; b=rlp8rLGK5d4YkaL2IJ2GNk+J2gxCH620OtlaYM4/6GXJW6npWn/elz3x9omsOa9Oo3GsnTa8qiK6rz1e7aJWmOnr+x/Pu9mxsOmVu9gdmFyoVizQHxpxRkUzYPMa4eKeeP7V668jojIIjqW4xkFoHvImSwL5tYMGxMhHd2vASY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708514346; c=relaxed/simple;
	bh=WbsYXi0sQoeBrRtG8LEEJMDbRHe4pCcXkoVQe+o9P9E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iGSBJQaB9kCjp6MDu/N76MzQmLcaX8Vxj5qhUS4KF9VSwk9ktHCm8zIQTYa89v6UnM+YRSx3hO1V8TXSPclj3Jm8fgm2f2jQwK2oJ0Eq1ii3qG8WXrXR1yx95Qx73b0Qyp9UdWulbHyf/MseurRHC/BDwa4TM3MLYkbUmhrehVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c42b7ee0a5so484094739f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 03:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708514344; x=1709119144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbrdijXox5ooEuf5BBf2QH/64bIqY05Q5+fqoucIHj0=;
        b=jA8367rScyPv1LfOOsZ2dskkrGMjCRYbBk7x7TDLMiVArJRQ5gbFwf1qtlZ5/t4HM7
         jbkEQo40ukwYBURsZwOg2nWgiDxkly+KoM2ZPGw9tkIpBGjUPzbEI6NNrfvxPsww9HZ7
         5x9p7G5P/pf53MpR7v21XyMTSPcjCcDuBBM1BczN1zMWCfG/FKJOloSRGqSzaWWj2wej
         4eXUBMFgw5FWMsGJMK3sNg9+24wWZST+tp6YiJ28jw/Nn53nZ/D5ZH6X/YhS7Ey22Lnj
         C1ow2w9Hh1PCkV3IP32XSHJ761kwJgaWQjymPhOBb2VlS/EbEE4mQIU8MxjbMlgqV8jD
         6tbA==
X-Forwarded-Encrypted: i=1; AJvYcCXyOFdL1c5iJBpGR/K8ev4xWl2HAtPYzjNhxmeFizNcfCa+eW+kk8j2AuHYqNmDcaTGGkFJYtarLndX9Tse6a9dKhRSFF1PVsetR39q7w==
X-Gm-Message-State: AOJu0YxVs6IOvRV+DkQ69p3U1WwOf/2MEJPDmiIMGH4iUogTO930myFL
	4aH8kwxdYsx2R99NEKIHR8B4zViI0k7bR8MdF6PuRRt0d3pk0jjxpGN2tRH6JBB+i4eOwCIu6yU
	/Ma+G0C4F7wLLUpRCT1FLvT8jstqRWkpzvv29G6ZIpoOqkY9yQfJpWHI=
X-Google-Smtp-Source: AGHT+IEl2nnn5rgcwKGL3uoX7Dr4oceo7ZARM8R7Lygmjhdlvvn+iSGgsYQHQQtIaZhPPEWYhr8xQqcGAI67BDH4Z4TfKB6yAFu4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4124:b0:474:3790:dc68 with SMTP id
 ay36-20020a056638412400b004743790dc68mr291903jab.3.1708514343811; Wed, 21 Feb
 2024 03:19:03 -0800 (PST)
Date: Wed, 21 Feb 2024 03:19:03 -0800
In-Reply-To: <00000000000081f1a405f05f111f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e7fab0611e27e8f@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_update_sd_size
From: syzbot <syzbot+7d78ccda251bc1bdbaed@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yijiangshan@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d8b4f8180000
start commit:   4bbdb725a36b Merge tag 'iommu-updates-v6.7' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=7d78ccda251bc1bdbaed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1284ed04e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590870f680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

