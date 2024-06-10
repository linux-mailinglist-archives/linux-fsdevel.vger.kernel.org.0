Return-Path: <linux-fsdevel+bounces-21312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B720901B5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9FB2815EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1707A1C694;
	Mon, 10 Jun 2024 06:41:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5477A1171D
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001665; cv=none; b=d4U+i2oL3lqIe1/Eq+6vkwkSMPsD25nCSGm0RWP7DkO1Zrncm7zMEwmAWEySIwgLE3zLUkN8XdusRm6YTuNvD2Vk7UmFH9Ubj9jnv8sqHiFC5SjRnTI5kn4/k4YLK+k12g3IJ4UaeRBKVwRE58QVc+TmcdEdKa24krHcjwyW3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001665; c=relaxed/simple;
	bh=98ieg/cde//OTWMmliLOuelMNzAd4GX0SgVonSrQHeQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cunbFiG8lF77qA5A3q9TyYM/QJHSvprOZfCv+WBcId2f2Nszohqvx+XftbIkqXVdD6Qa/fZxC1x7XyXIuu+SY1toqlLvTknrwD6pThEZO5qJ+sBTajlprbTDjWHisPeyrk5NElhVTjl0wihG0hpbqs7Q3kkJHuPM1ps45XmGON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb9739b79dso18716339f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Jun 2024 23:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718001663; x=1718606463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQsBqkk32ikBJNFCWFdQbHJ972MB7cWh+PL5hVVVQwo=;
        b=FOCjXmPzQu2DfKSoa3YLkes1EZKM9Y3WN1CpboXvnIe/vWUIzVtS0Xn7GQy705eB7K
         WaOWWUdJRaH25hAtNMRmQUUdXHmrxj0XxWpnxFbPQdV7Ep5ZbCtZ7s41x/JRuQlZXzgN
         XP0DEIff+N3KMtLzvz1D1ONWNOIIAAU0doPrGXC8/MQugiluBJVv8VKDuV6fWdMY739U
         rt4lAxJW5HI72h5quzOMzfDdj1nIAjoNpWFmMVLcGBC5uQDOQqKJ7SG2KhpH5GuDkRXH
         x7Raom2FvQcTh85Q8FtENwYWZAjKzULPswovid4VpmPcPhLbBUaOGAK7OKlglFPJTHPx
         JJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE5uZRpFNX1FMAtfHUbNxWsLL2pCWmyyB5kdzSnHItwp1TzZL2Neq7jilNtKKDp7WTSLT1P1dbxgMgfLAxy7Cme3LJhBGdvYUCIaXngA==
X-Gm-Message-State: AOJu0YyfAhZEFrVHtn6OaXAFREeO6lZSzDs9dSClX7PtH70aoEM/F1I1
	mXZ7TRKpGxbZMqqK4uUoBdeHwEGdcQaJvzXeyi2y6owL3uKyJekhhzpqP0P50fx1hQ7lmo/1ehr
	CA5rlPrp6qR5MbZBKc6+YpArx24E54MLWUFu2nk8vW/Jl4GtDxFtBChM=
X-Google-Smtp-Source: AGHT+IFkNdIwSPeERkP6c3etIHOS/lMPBlpCPwSSt9/oGMTtFUpU5IGfqAqpJUspbuH+/XwJ41jkOcor7hXs3bJkm5Krjk3AGG/E
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:b0:374:9c67:1dea with SMTP id
 e9e14a558f8ab-375804362c3mr4249895ab.5.1718001663484; Sun, 09 Jun 2024
 23:41:03 -0700 (PDT)
Date: Sun, 09 Jun 2024 23:41:03 -0700
In-Reply-To: <000000000000e5738d05f0f46309@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e034e7061a836eb4@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in __unmap_and_move (4)
From: syzbot <syzbot+b7ad168b779385f8cd58@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liushixin2@huawei.com, syzkaller-bugs@googlegroups.com, 
	tujinjiang@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0fd44ab213bcfb26c47eedaa0985e4b5dbf0a494
Author: Liu Shixin <liushixin2@huawei.com>
Date:   Fri Mar 22 09:35:54 2024 +0000

    mm/readahead: break read-ahead loop if filemap_add_folio return -ENOMEM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fabe96980000
start commit:   72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4db06888b17328d6
dashboard link: https://syzkaller.appspot.com/bug?extid=b7ad168b779385f8cd58
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143d0688480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154e3cac480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm/readahead: break read-ahead loop if filemap_add_folio return -ENOMEM

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

